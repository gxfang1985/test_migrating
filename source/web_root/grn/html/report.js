/***    スケジュール連携用      ***/
var old_onkeydown_handler = null;

function redirectEnterkey(keyCode,target)
{
    if( keyCode == 13 )
    {
        jQuery("#" + target).click();
       return false;
    }
    
    return true;
}
function disableOnKeyDown( closeHandler )
{
    if( ! old_onkeydown_handler )
        old_onkeydown_handler = document.onkeydown;
    document.onkeydown = function(e){
        e = (e == undefined) ? event : e;
        if( GRN_Event.keyCode(e) == 27 ) //ESC key
            return closeHandler();
        return false;
    };
}

function enableOnKeyDown()
{
    document.onkeydown = old_onkeydown_handler;
    old_onkeydown_handler = null;
}

function updateDialogFocus(dialogId, closeHandler){
    var dialogItems = jQuery("input, div#"+dialogId+" input, div#"+dialogId+" label, div#"+dialogId+" a");
    dialogItems.each(function(index,i){
        i.onfocus = function(e){
            enableOnKeyDown();
        };
        i.onblur = function(e){
            if(!jQuery("#"+dialogId).is(':visible'))
                return false;
            disableOnKeyDown( closeHandler );
            return true;
        };
    });
}

function clearDialogFocus(dialogId){
    var dialogItems = jQuery("input, div#"+dialogId+" input, div#"+dialogId+" label, div#"+dialogId+" a");
    dialogItems.each(function(index,i){
        i.onfocus = function(){};
        i.onblur = function(){};
    });
}

//関連付ける報告書を表示
function showReportRelationWindow(index)
{
    if(!jQuery("#reportRelationWindow").is(':visible'))
    {
        coverBackground(true);
        jQuery("#reportRelationWindow").show();
        disableOnKeyDown( closeReportRelationWindow );
    }

    updateDialogFocus("reportRelationWindow", closeReportRelationWindow);

    var params = "sp="+index;
    if(jQuery("#searchReportText").val() != "")
    {
        params += "&keyword=" + encodeURIComponent( jQuery("#searchReportText").val() );
    }
    
    jQuery("#reportLoadingImage").show();
    grn.component.button("#reportRelationSubmit").disable();
    jQuery("#reportRelationContent").html("");
    jQuery.ajax(
        selectReportListUrl,
        {
            type: "post",
            data: params,
            success : function(data, textStatus, request){

                jQuery("#reportLoadingImage").hide();

                var headers = request.getAllResponseHeaders();
                if(headers.match(new RegExp( /X-Cybozu-Error/i )))
                    showErrorMessage(request);
                else
                    jQuery("#reportRelationContent").html(request.responseText);

                updateDialogFocus("reportRelationWindow", closeReportRelationWindow);
            },
            error : function(request){
                showErrorMessage(request);
            }
        });
}

//報告書関連付けウインドウを非表示にする
function closeReportRelationWindow()
{
    jQuery("#reportRelationWindow").hide();
    jQuery("#searchReportText").val("");
    coverBackground(false);
    jQuery("#reportRelationForm input:radio").each(
        function (index,node)
        {
            node.checked = false;
        }
    );
    clearDialogFocus('reportRelationWindow');
    enableOnKeyDown();
}


//報告書関連付けウインドウ内でページングリンクを
//クリックしたときに呼ばれるコールバック関数
function reportRelationNaviCallBack(index)
{
    showReportRelationWindow(index);
}

//カテゴリ・フォーム一覧ウインドウ表示
function showFormSelectWindow()
{
    disableOnKeyDown( closeFormSelectWindow );
    coverBackground(true);

    var height = getWindowHeight()/2;
    
    document.getElementById('categoryFormListWindow').style.height = height + 20 + 'px';
    document.getElementById('categoryFormListWindow_inner').style.height = 'auto';
    
    var width = getWindowWidth()/2;
    document.getElementById('categoryFormListWindow').style.width = width + 'px';
    var innerwidth = width - 40;
    document.getElementById('categoryFormListWindow_inner').style.width = innerwidth + 'px';

    document.getElementById('tree_part').style.width = (innerwidth/2 - 12) + 'px';
    document.getElementById('view_part').style.width = (innerwidth/2 - 12) + 'px';

    document.getElementById('tree_part').style.height = height - 70 + 'px';
    document.getElementById('view_part').style.height = height - 70 + 'px';

    jQuery('#categoryFormListWindow').show();
}

//カテゴリ・フォーム一覧ウインドウ非表示
function closeFormSelectWindow()
{
    enableOnKeyDown();
    jQuery('#categoryFormListWindow').hide();
    formCache = new Array();
    childCategoryLoadFlag = new Array();

    coverBackground(false);
}

//フォーム情報をキャッシュする
formCache = new Array();

//子カテゴリをロードしたかどうかを保持するフラグ
childCategoryLoadFlag = new Array();

//カテゴリ・フォーム一覧ウインドウ内でカテゴリを選択した際の処理
function onCategorySelect(id)
{
    jQuery('a.category_link').each(
            function(index,node){
                node.style.backgroundColor = '';
            });

    document.getElementById('link_'+id).style.backgroundColor = "#87cefa";

    if(!jQuery("#category_content_"+id).is(':visible'))
    {
        //既にロードしているなら開くだけ
        if(childCategoryLoadFlag[id])
        {
        
            if(document.getElementById('category_'+id+'_child').childNodes.length > 0)
                jQuery('#category_content_'+id).show();
            jQuery("#category_folder_status_"+id).attr("src",minusImage);
            resizeHeight();
        }
        else
        {

            jQuery("#loading_" + id).show();
            jQuery.ajax(
                    categoryListUrl,
                    {
                        type: "get",
                        data: "cid="+id,
                        success : function(data, textStatus, request) {
                                  childCategoryLoadFlag[id] = true;
                                  jQuery("#loading_" + id).hide();

                                  var headers = request.getAllResponseHeaders();
                                  if(headers.match(new RegExp( /X-Cybozu-Error/i )))
                                  {
                                      showErrorMessage(request);
                                      return;
                                  }

                                  if(request.responseText.strip().length > 0 )
                                  {
                                      jQuery("#category_" + id + "_child").html(request.responseText);
                                      jQuery("#category_content_" + id).show();
                                  }
                                  jQuery("#category_folder_status_"+id).attr("src",minusImage);
                                  resizeHeight();
                        },
                        complete: function(request) {
                        },
                        error: function(request) {
                            showErrorMessage(request);
                        }
                    }
                );
        }
    }

    document.getElementById('formList').innerHTML =  '';
    //キャッシュが存在するならそれを使う
    if(formCache[id])
    {
        document.getElementById('formList').innerHTML = formCache[id];
        resizeHeight();
    }
    else
    {
        jQuery("#formLoadingImage").show();
        jQuery.ajax(
                formListUrl,
                {
                    type: "get",
                    data: "cid="+id+"&eid="+eid+"&date="+date+"&from=schedule",
                    success: function(request) {
                        var headers = request.getAllResponseHeaders();
                        if(headers.match(new RegExp( /X-Cybozu-Error/i )))
                        {
                            showErrorMessage(request);
                            return;
                        }

                        //キャッシュに入れる
                        formCache[id] = request.responseText;
                        jQuery('#formLoadingImage').hide();
                        jQuery('#formList').html(request.responseText);
                        resizeHeight();
                    },
                    complete: function(request) {
                    },
                    error: function(request) {
                        showErrorMessage(request);
                    }
                }
            );
    }
}

function resizeHeight()
{
    var div = document.getElementById('categoryFormListWindow');
    var dialogHeight = document.layers ? div.clip.height:(div.offsetHeight||div.style.pixelHeight||0);
    var windowHeight = getWindowHeight();
    if(windowHeight/2 > dialogHeight)
        div.style.height = windowHeight*0.5 + 'px';
    
}
function coverBackground(visible)
{
    if(visible)
    {
        var b = document.body;
        document.getElementById('background').style.width = Math.max(getWindowWidth(), b.scrollWidth) + 'px';
        document.getElementById('background').style.height = Math.max(getWindowHeight(), b.scrollHeight) + 'px';
        document.getElementById('background').attributes.getNamedItem('class').nodeValue = 'cover';
        jQuery('#background').show();
    }
    else
    {
        document.getElementById('background').attributes.getNamedItem('class').nodeValue = '';
        document.getElementById('background').style.width = '0px';
        document.getElementById('background').style.height = '0px';
        jQuery('#background').hide();
    }
}
//子カテゴリを非表示にする
function closeChildCategories(id)
{
    if(!jQuery('#category_content_'+id).is(":visible"))
    {
        jQuery('#category_content_'+id).hide();
        jQuery("#category_folder_status_"+id).attr("src",plusImage);
    }
    else
    {
        onCategorySelect(id);
    }
}
function getWindowWidth(){
      if(window.innerWidth) return window.innerWidth; // Mozilla, Opera, NN4
      if(document.documentElement && document.documentElement.clientWidth){ // 以下 IE
       return document.documentElement.clientWidth;
      }
      else if(document.body && document.body.clientWidth){
       return document.body.clientWidth;
      }
      return 0;
}

function getWindowHeight(){
  if(window.innerHeight) return window.innerHeight; // Mozilla, Opera, NN4
  if(document.documentElement && document.documentElement.clientHeight){ // 以下 IE
   return document.documentElement.clientHeight;
  }
  else if(document.body && document.body.clientHeight){
   return document.body.clientHeight;
  }
  return 0;
}

/***    indexページ用      ***/

//受信、送信、下書き、全てのページにおいてページングが発生した際に呼び出される
function pagingCallBack(index)
{
    onSelect(getValue(location.hash,'type'),index,getValue(location.hash,'sort'));
}
//絞込み一覧ページにおいてページングが発生した際に呼び出される
function filterPagingCallBack(index)
{
    onSelectFilter(getValue(location.hash,'fid'),index,getValue(location.hash,'sort'));
}

//Sort
function onSort(sort)
{
    onSelect(getValue(location.hash,'type'), getValue(location.hash,'index'),sort);
}

function onFilterSort(sort)
{
    onSelectFilter(getValue(location.hash,'fid'),getValue(location.hash,'index'),sort);
}

//受信、送信、下書き、全てをクリックした際の処理
function onSelect(type,index,sort)
{
    var params = "type="+type;
    if(index != null)
        params += "&sp="+index;
    else
        params += "&sp=0";

    if(sort != null)
        params += "&sort="+sort;

    loadReportList(params);
}

//絞込みをクリックしたときの処理
function onSelectFilter(fid,index,sort)
{
    var params = "type=filter&fid="+fid;
    if(index != null)
        params += "&sp="+index;
    else
        params += "&sp=0";

    if(sort != null)
        params += "&sort="+sort;

    loadReportList(params);
}

function _onSelectCategory( tree, oid ){
    var root = tree._tree.getRoot();
    var dom = YAHOO.util.Dom;
    
    var top = jQuery('#'+tree._treeName+'_top a');
    if( oid == 'top' ){
        top.addClass('tree-select-current');
    }else{
        top.removeClass('tree-select-current');
    }
    
    _selectNode(root, oid);
    
    function _selectNode(node, oid){
        for (var i = 0; i < node.children.length; i++ ) {
            var child = node.children[i];
            var cnt = child.getContentEl();
            if( cnt ){
                var ele = cnt.firstChild;

                if( ele && ( ele.className == 'tree-node' || ele.className == 'tree-select-current' ) ){
                    if(child.oid == oid){
                        child.expand();
                        dom.removeClass(ele, 'tree-node');
                        dom.addClass(ele, 'tree-select-current');
                        child.selected = true;
                    }
                    else{
                        dom.addClass(ele, 'tree-node');
                        dom.removeClass(ele, 'tree-select-current');
                        child.selected = null;
                    }
                }
            }
            _selectNode(child, oid);
        }
    }
}

//カテゴリツリーのカテゴリをクリックした時の処理
formListDataCaches = new Array();
function onSelectCategory(cid)
{
    if( cid == 1 )
        cid = 'top';

    _onSelectCategory(obj_folder_tree, cid);
    obj_folder_tree._selectedOID = cid;

    var img_node = document.getElementById('reportLoadingImage').cloneNode(true);
    var view_part = document.getElementById('view_part');

    view_part.innerHTML = '';
    view_part.appendChild(img_node);
    jQuery(img_node).show();

    if( formListDataCaches[cid] )
    {
        jQuery(img_node).hide();
        view_part.innerHTML += formListDataCaches[cid];
    }
    else
    {
        var params = "cid="+cid+"&type="+userType+"&csrf_ticket="+csrf_ticket;
        if("eid" in window)
            params += "&eid="+eid+"&date="+date;
            
        if("from" in window)
            params += "&from="+from;
            
        jQuery.ajax(
            formListUrl,
            {
                type: "post",
                data: params,
                success : function(data, textStatus, request) {

                    jQuery(img_node).hide();
                    
                    var headers = request.getAllResponseHeaders();
                    if(headers.match(new RegExp( /X-Cybozu-Error/i )))
                        showErrorMessage(request);
                    else
                    {
                        formListDataCaches[cid] = request.responseText;
                        view_part.innerHTML += request.responseText;
                    }

                },
                error : function(request){
                    showErrorMessage(request);
                }
            });
    }
}

//hoge=huga&piyo=hogeなどのパラメータから値を取得
function getValue(hash,key)
{
    if(hash.indexOf('#') == 0)
        hash = hash.substring(1,hash.length);
    var params = hash.split("&");
    for(i = 0; i<params.length; i++)
    {
        var node = params[i];
        if(node.indexOf(key+"=") == 0)
        {
            return node.substring(key.length+1,node.length);
        }
    }
    return null;
}

//先頭の#を切り取る
function cutFirstSharp(hash)
{
    if(hash.indexOf('#') == 0)
        return hash.substring(1,hash.length);
    else
        return hash;
}
callback_history_obj = null;
isLoading = false;
current_hash = '';

//フラグメント(location.hash)を監視
function history_callback()
{
    //二重登録を防ぐ
    if(callback_history_obj != null)
        clearInterval(callback_history_obj);
    
    callback_history_obj = setInterval( function (){
        if(isLoading)
            return;

        // フラグメントに変更がなければ終了
        if (cutFirstSharp(location.hash) == cutFirstSharp(current_hash))
            return;

        current_hash = cutFirstSharp(location.hash);
        loadReportList(current_hash);
        },100);
}

//URLバーのhashを更新
function update_location_hash(hash)
{
    if(hash.length > 0)
    {
        location.hash = hash;
    }
}

//hashを元に選択されたリンクをハイライト
function setHilight(hash)
{
    //既存のハイライトを全て消す
    jQuery('span.hilight').each(
            function (index,node){
                node.attributes.getNamedItem('class').nodeValue = '';
            });

    var type = getValue(hash, 'type');
    var fid  = getValue(hash, 'fid');

    //タイプが存在する場合(受信、送信、下書き、全て、のいずれか)
    if(type != null && document.getElementById('span_'+type))
    {
        document.getElementById('span_'+type).attributes.getNamedItem('class').nodeValue = 'hilight bold';
    }
    //絞込みIDが指定されている場合
    else if(fid != null && fid.length > 0)
    {
        //最近使った絞込み
        if(document.getElementById('span_recent_'+fid))
            document.getElementById('span_recent_'+fid).attributes.getNamedItem('class').nodeValue = 'hilight bold';
        //優先絞込み
        if(document.getElementById('span_display_'+fid))
            document.getElementById('span_display_'+fid).attributes.getNamedItem('class').nodeValue = 'hilight bold';
        //個人絞込
        if(document.getElementById('span_personal_'+fid))
            document.getElementById('span_personal_'+fid).attributes.getNamedItem('class').nodeValue = 'hilight bold';
        //全ての絞込み
        if(document.getElementById('span_all_'+fid))
            document.getElementById('span_all_'+fid).attributes.getNamedItem('class').nodeValue = 'hilight bold';
    }
    //そうでない場合は受信一覧を取得するので受信一覧をハイライト
    else
    {
        document.getElementById('span_receive').attributes.getNamedItem('class').nodeValue = 'hilight bold';
    }
}

old_hash = null;
reportListDataCaches = new Array();
function loadReportList(hash)
{
    //先頭に#がついている場合があるので切り取る
    hash = cutFirstSharp(hash);

    //前回と同じhashの場合は受け付けない
    if(hash == old_hash)
        return;
    else
        old_hash = hash;

    //ハイライト設定
    setHilight(hash);

    isLoading = true;
    update_location_hash(hash);

    if(reportListDataCaches[hash] != undefined)
    {
          document.getElementById('search_result').innerHTML = reportListDataCaches[hash];

          isLoading = false;
          return;
    }

    //ローディング画像を表示
    document.getElementById('search_result').innerHTML = '<img src="'+spinnerImage+'" />';
    jQuery.ajax(reportListUrl, {
        type: "post",
        data: hash+'&pagingSize='+pagingSize,
        success :  function(data, textStatus, request) {
            history_callback();

            //返された画面がエラー画面でないかチェック
            headers = request.getAllResponseHeaders();
            if(headers.match(new RegExp( /X-Cybozu-Error/i )))
            {
                showErrorMessage(request);
            }
            //未ログインの場合
            else if(headers.match(new RegExp(/X-CybozuLogin/i))
                 || !headers.match(new RegExp(/X-Cybozu-User/i)))
            {
            }
            else
            {
                document.getElementById('search_result').innerHTML = request.responseText;
                reportListDataCaches[hash] = request.responseText;
                isLoading = false;
            }
        },
        error : function(request){
            showErrorMessage(request);
            isLoading = false;
        }
    });
    
}

function showErrorMessage(request)
{
    if(request.responseText != undefined)
        document.getElementById('body').innerHTML = request.responseText;
}

//絞込み一覧をトグルする
function toggleFilterView(id)
{
    if(jQuery("#" + id + 'Image').attr('src').indexOf('addressee_off20.gif') > 0)
        closeFilterView(id);
    else
        openFilterView(id);
}

//絞込み一覧が開いているなら閉じる
function closeFilterView(id)
{
    if(jQuery("#" + id + 'Image').attr('src').indexOf('addressee_on20.gif') > 0)
        return;

    document.getElementById(id+'Pain').style.overflow = 'hidden';

    jQuery("#"+id+"Image").attr("src",plusImage);

    //IEではheight:0pxはうまくいかないので1pxにする
    var height = grn.browser.msie ? 1 : 0;
    var myAnim = new YAHOO.util.Anim(id+'Pain', {height: { from:filterPainHeights[id],to:height } },0.1);
    myAnim.animate();

}

//絞込み一覧を開く
function openFilterView(id)
{
    if(jQuery("#" + id + 'Image').attr('src').indexOf('minus13.gif') > 0)
        return;
    
    switch(id)
    {
        case 'allFilters':
            closeFilterView('recentFilters');
            closeFilterView('displayFilters');
            break;
        case 'displayFilters':
            closeFilterView('recentFilters');
            closeFilterView('allFilters');
            break;
        case 'recentFilters':
            closeFilterView('displayFilters');
            closeFilterView('allFilters');
            break;
    }

    jQuery("#"+id+"Image").attr("src",minusImage);

    //IEではheight:0pxはうまくいかないので1pxにする
    var height = grn.browser.msie ? 1 : 0;

    var myAnim = new YAHOO.util.Anim(id+'Pain', {height: { from:height,to:filterPainHeights[id] } },0.1);

    //アニメーション終了時にオーバーフローの設定を行う。
    //終了時に行わなければ、開いている最中にスクロールバーが一瞬表示されてしまう
    myAnim.onComplete.subscribe(function(){
            document.getElementById(id+'Pain').style.overflow = 'auto';
        });
    myAnim.animate();
}

//報告書作成時のバリデーション
//必須ファイルが存在するかどうかのみ調べる
function report_file_validate(isDraft)
{
    if(isDraft)
        return true;
    
    //Flash有りの場合とそうでない場合で方法が変わる
    var vdata = new Object();
    
    if(grn.browser.isSupportHTML5)
    {
        jQuery("div.html5_content").each(
                function(index, node)
                {
                    var name = node.id.replace("html5_content_", "");
                    vdata[name] = false;
                    jQuery("input.upload_checkbox_" + name).each(
                            function(index2, node2)
                            {
                                vdata[name] |= node2.checked;
                            }
                    );
                }
        );
    }
    else
    {
        jQuery("div.not_support_html5_content").each(
                function(index, node)
                {
                    var name = node.id.replace("no_flash_plugin_content_", "");
                    vdata[name] = false;

                    if( jQuery("#attached_file_" + name).length > 0 )
                    {
                      vdata[name] = true;
                    }
                    else
                    {
                        jQuery("input.infile").each(
                                function(index2, node2)
                                {
                                    if(node2.name.indexOf(name, 0) == 0)
                                        vdata[name] |= (node2.value != null && node2.value.length > 0);
                                }
                        );
                    }
                }
        );
    }

    var validate = true;
    var scrollHeight = 0;
    var liteTop = jQuery(".cloudHeader-inner-grn").height();

    for(var i in vdata)
    {
        var require = eval('__upload_'+i+'_require');
        if(require && !vdata[i])
        {
            var msg = eval('__upload_msg_'+i+'_error');
            if (scrollHeight === 0)
            {
                scrollHeight = jQuery('#attention_'+i).offset().top-liteTop;
            }
            jQuery('#attention_'+i).html(msg);
            validate = false;
        }
        else
        {
            jQuery('#attention_'+i).html('');
        }
    }

    if (validate === false)
    {
        window.scrollTo(0,scrollHeight);
    }

    return validate;
}

function updateUnreadCount()
{
    jQuery.ajax(
        unreadCountUrl,
        {
            type: "post",
            success : function(data, textStatus, request) {
                var headers = request.getAllResponseHeaders();

                if(headers.match(new RegExp( /X-Cybozu-Error/i )))
                {
                    showErrorMessage(request);
                }
                else
                {
                    var unread_count = eval(request.responseText);
                    if( unread_count > 0 )
                    {
                        document.getElementById('unreadReceiveCount').innerHTML = '(' + eval(request.responseText) + ')';
                        document.getElementById('unreadReceiveCount').style.visibility = "visible";
                    }
                }
            },
            error : function(request){
                showErrorMessage(request);
            }
        });
}

function confirmIfExistFailedFile()
{
    if(window[ "isExistFailedFile" ])
        return confirm(__upload_msg_confirm1 + "\n" + __upload_msg_confirm2);
    else
        return true;
}

function grn_onsubmit_common(form) {
    var member_components = ["member_sUID", "notification_sUID", "sUID_o"];
    grn.component.member_add.prepareSubmit(member_components);

    if (typeof form.elements["partner_sUID[]"] === "undefined") return;
    var options = form.elements["partner_sUID[]"].options;
    if (options)
    {
        for ( var j = 0; j < options.length; j++ )
        {
            options[j].selected = options[j].value ? true : false;
        }
   }
}

