//報告書の絞り込み、詳細検索に関するJavascript.
//report.jsが既に読み込まれていることを前提としている。

//項目選択ウインドウ内でカテゴリを選択した際の処理
function onCategorySelect(id)
{
    jQuery('a.category_link').each(
            function(index,node){
                node.style.backgroundColor = '';
            });

    document.getElementById('link_'+id).style.backgroundColor = "#87cefa";
    document.getElementById('itemList').innerHTML = '';

    if(!jQuery("#category_content_"+id).is(":visible"))
    {
        //既にロードしているなら開くだけ
        if(childCategoryLoadFlag[id])
        {
            if(document.getElementById('category_'+id+'_child').childNodes.length > 0)
                jQuery("#category_content_" + id).show();
            jQuery("#category_folder_status_"+id).attr("src",minusImage);
        }
        else
        {
            jQuery("#loading_" + id).show();
            jQuery.ajax(
                    categoryListUrl,
                    {
                        type : "post",
                        data : "cid="+id,
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
                        },
                        complete : function() {
                        },
                        error : function(request) {
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
    }
    else
    {
        jQuery("#formLoadingImage").show();
        jQuery.ajax(
                formListUrl,
                {
                    type: "post",
                    data : "cid="+id+"&from=filter",
                    success : function(data, textStatus, request){
                        var headers = request.getAllResponseHeaders();
                        if(headers.match(new RegExp( /X-Cybozu-Error/i )))
                        {
                            showErrorMessage(request);
                            return;
                        }

                        //キャッシュに入れる
                        formCache[id] = request.responseText;
                        jQuery("#formLoadingImage").hide();
                        document.getElementById('formList').innerHTML = request.responseText;
                    },
                    complete: function() {
                    },
                    error : function(jqXHR, textStatus, errorThrown) {
                        showErrorMessage(jqXHR);
                    }
                }
            );
    }
}

var currentItems;
//項目選択ウインドウ内でフォームを選択した際の処理
function onFormSelect(form_id, replaceOldItems)
{
    if(replaceOldItems == undefined)
    {
        replaceOldItems = true;
    }

    closeCategoryFormItemSelectWindow();
    
    if(document.getElementById('form_link_'+form_id))
        document.getElementById('selected_form_name').innerHTML = document.getElementById('form_link_'+form_id).innerHTML;
    document.getElementById('selected_form_id').value = form_id;

    var sendData = {};
    sendData["fid"] = form_id;
    //項目一覧を取得
    var ajaxRequest = new grn.component.ajax.request(
    {
        url: itemListUrl,
        method: "post",
        dataType: "json",
        grnRedirectOnLoginError: true,
        data: sendData
    });

    ajaxRequest.on("beforeShowError", function()
    {
        currentItems = null;
    });

    ajaxRequest.send().done(function(json_obj)
    {
        currentItems = json_obj;

        //既存の条件で「項目」を選択していたものには項目選択セレクトボックスを追加し、
        //既に項目選択セレクトボックスがある場合は新しいものに置き換える
        if(!replaceOldItems)
        {
            return;
        }

        removeItemSelectBoxes();

        jQuery('select.target_select').each(
            function ( index,node )
            {
                var sidx = node.selectedIndex;
                if(node.options[sidx].value == 4)
                {
                    index = node.id.split('_')[1];
                    jQuery("#condition_"+index).show();
                    jQuery('#condition_'+index).before(getItemSelectBox(index));

                    option = textOption.concat(numOption);
                    var target = document.getElementById('condition_'+index);
                    target.length = option.length;

                    for(i = 0; i < option.length; i++)
                    {
                        target[i].value = option[i].value;
                        target[i].text = option[i].label;
                    }
                }
            }
        );
    });
}

function onCheckboxChange(index, checkbox)
{
    document.getElementById('value_'+index).value = checkbox.checked ? 1 : 0;
}

function getCheckBoxItem(id)
{
    return '<input type="checkbox" onchange="onChangeCheckBox('+id+',this);" />';
}

function onChangeCheckBox(id, input)
{
    document.getElementById('value_'+id).value = input.value;
}

//datatypeに応じたselectボックスのオプションを返す
function getOptionsByDataType(type)
{
    //TODO 定数に置き換える
    switch(type)
    {
        case '':
            return textOption.concat(numOption);
        case 'grn.report.string_single':
        case 'grn.report.string_multiple':
        case 'grn.report.menu_string':
        case 'grn.report.radio':
            return textOption;
        case 'grn.report.numeric':
            return numOption;
        case 'grn.report.date':
            return dateOption;
        case 'grn.report.checkbox':
        case 'grn.report.file':
            return checkboxOption;
        case 'grn.report.time':
            return timeOption;
        default:
            return new Array();
    }
}

//文字列のByte数をカウント
function getByte(text)
{
    var count = 0;
    for (i=0; i<text.length; i++)
    {
        var n = escape(text.charAt(i));
        if (n.length < 4)
            count++;
        else
            count+=2;
    }
    return count;
}

//フォーム選択ダイアログを表示
function showCategoryFormListWindow()
{
    disableOnKeyDown( closeCategoryFormItemSelectWindow );
    formCache = new Array();
    childCategoryLoadFlag = new Array();

    coverBackground(true);

    var height = getWindowHeight() * 0.5;
    if( height < 300 )
        height = 300;
    document.getElementById('categoryFormListWindow').style.height = height + 'px';
    document.getElementById('tree_view').style.minHeight = 0;
    if(navigator.userAgent.indexOf('Gecko')>0)
    {
        document.getElementById('tree_part').style.height = (height - 70) + 'px';
        document.getElementById('view_part').style.height = (height - 70) + 'px';
    }

    var scroll_height = document.documentElement.scrollTop || document.body.scrollTop;
    var top = getWindowHeight() * 0.5  - height * 0.5 + scroll_height;
    if( top < 100 )
        top = 100;
    document.getElementById('categoryFormListWindow').style.top = top + "px";

    var width = getWindowWidth() * 0.5;
    if( width < 600 )
        width = 600;
    document.getElementById('categoryFormListWindow').style.width = width + 'px';
    document.getElementById('tree_part').style.width = ((width/2) - 30) + 'px';
    document.getElementById('view_part').style.width = ((width/2) - 30) + 'px';

    var scroll_width = document.documentElement.scrollLeft || document.body.scrollLeft;
    var left = getWindowWidth() * 0.5 - width * 0.5 + scroll_width;
    if( left < 100 )
        left = 100;
    document.getElementById('categoryFormListWindow').style.left = left + "px";

    jQuery("#categoryFormListWindow").show();
}

//フォーム項目選択ダイアログを閉じる
function closeCategoryFormItemSelectWindow()
{
    enableOnKeyDown();
    jQuery("#categoryFormListWindow").hide();
    coverBackground(false);
}

//日付フォームを取得
function getDateItem(id)
{
    var htmlsrc = __report_item_date;
    while ((htmlsrc.indexOf('%NUM%') != -1))
    {
        htmlsrc = htmlsrc.replace('%NUM%', id);
    }
    return '<span id="date_'+id+'">'+htmlsrc+'</span>';
}

//時刻フォームを取得
function getTimeItem(id, interval)
{
    var htmlsrc = __report_item_time;
    while ((htmlsrc.indexOf('%NUM%') != -1))
    {
        htmlsrc = htmlsrc.replace('%NUM%', id);
    }
    return '<span id="time_'+id+'">'+htmlsrc+'</span>';
}

//条件を追加
function addFilterItem()
{
    jQuery("#removeButton").show();
    var num = getCount();
    jQuery('#filter_item_'+(num-1)).after(jQuery(getForm(num)));
}

//条件を削除
function removeFilterItem(target_id)
{
    document.getElementById('filter_item_'+target_id).parentNode.removeChild(document.getElementById('filter_item_'+target_id));

    jQuery('div.filter_item').each(
        function(index,node)
        {
            var classnames = ['filter_item_even', 'filter_item_odd'];
            var position = index % 2;
            jQuery(node).removeClass(classnames[(position + 1) % 2]);
            jQuery(node).addClass(classnames[position]);
        }
    );

}

//現在の条件の個数を取得
function getCount()
{
    var items = jQuery('div.filter_item');
    var count = items.last().attr("id").split('_')[2];
    return parseInt(count)+1;
}

//条件を先頭の1件以外全て削除
function removeAllFilterItem()
{
    jQuery("#removeButton").hide();
    var items = jQuery('div.filter_item');
    for(i=1;i<items.length;i++)
    {
        items.eq(i).remove();
    }
}

//タイプを変更した際の処理
function onChangeType(item)
{
    var index = item.id.split('_')[1];
    if(document.getElementById('value_'+index))
        document.getElementById('value_'+index).value = '';
    jQuery("#condition_"+index).show();

    var option = null;
    var val = item[item.selectedIndex].value;

    jQuery('#condition_'+index).prop("disabled",false);
    if(document.getElementById('form_item_'+index))
        jQuery('#form_item_'+index).hide();
    if(document.getElementById('date_'+index))
        jQuery('#date_'+index).hide();
    if(document.getElementById('time_'+index))
        jQuery('#time_'+index).hide();
    if(document.getElementById('checkmsg_'+index))
        document.getElementById('checkmsg_'+index).parentNode.removeChild(document.getElementById('checkmsg_'+index));
    if(document.getElementById('item_'+index))
        document.getElementById('item_'+index).parentNode.removeChild(document.getElementById('item_'+index));
    if(document.getElementById('error_message_'+index))
        document.getElementById('error_message_'+index).innerHTML = '';

    document.getElementById('type_item_'+index).value = '';
        
    var datatype = item[item.selectedIndex].getAttribute("datatype");
    
    if(datatype != null)
    {
        onChangeTypeItem(item[item.selectedIndex],index);
    }
    else
    {
        switch(parseInt(val))
        {
            case 0:
            case 1:
            case 3:
            case 5:
                jQuery('#value_'+index).show();
                option = textOption;
                document.getElementById('item_id_'+index).value = "";
                break;
            case 2://作成日
                option = dateOption;
                if(document.getElementById('date_'+index))
                  jQuery('#date_'+index).show();
                else
                  jQuery('#value_'+index).after(getDateItem(index));
                document.getElementById('value_'+index).value = index;
                jQuery('#value_'+index).hide();
                document.getElementById('item_id_'+index).value = "";
                break;
            case 4:
                //項目を選択した場合は、特定のフォームを選択したかどうかで表示が変わる。
                
                //特定のフォームを選択している場合
                if(document.getElementById('select_form_type_2'))
                {
                    if( document.getElementById('select_form_type_2').checked && !isNaN(document.getElementById('selected_form_id').value) )
                    {
                        jQuery('#condition_'+index).before(getItemSelectBox(index));
                    }
                }

                jQuery('#value_'+index).show();
                option = textOption.concat(numOption);
                break;
            case 8:
                jQuery('#value_'+index).show();
                option = allOption;
                document.getElementById('item_id_'+index).value = "";
                break;
        }

        var target = document.getElementById('condition_'+index);
        target.length = option.length;

        for(i = 0; i < option.length; i++)
        {
            target[i].value = option[i].value;
            target[i].text = option[i].label;
        }
    }
}

function onChangeTypeItem(item,index)
{
    var datatype = item.getAttribute("datatype");
    var item_id  = item.value;
    var item_name = item.innerHTML;

    document.getElementById('item_type_'+index).value = datatype;
    document.getElementById('item_id_'+index).value = item_id;
    document.getElementById('type_item_'+index).value = 'item';
    var option = getOptionsByDataType(datatype);
    
    var target = document.getElementById('condition_'+index);
    target.length = 0;
    target.length = option.length;

    for(i = 0; i < option.length; i++)
    {
        target[i].value = option[i].value;
        target[i].text = option[i].label;
    }

    if(document.getElementById('date_'+index))
        jQuery('#date_'+index).hide();
    if(document.getElementById('time_'+index))
        jQuery('#time_'+index).hide();

    jQuery('#condition_'+index).show();

    if(document.getElementById('checkmsg_'+index))
        document.getElementById('checkmsg_'+index).parentNode.removeChild(document.getElementById('checkmsg_'+index));

    //datatypeが日付の場合は日付入力フォームを表示
    if(datatype == 'grn.report.date')
    {
        jQuery('#value_'+index).hide();
        document.getElementById('value_'+index).value = index;
        
        if(document.getElementById('date_'+index))
            jQuery('#date_'+index).show();
        else
            jQuery('#value_'+index).after(getDateItem(index));
    }
    else if(datatype == 'grn.report.checkbox')
    {
        document.getElementById('value_'+index).value = 0;
        jQuery('#value_'+index).hide();
        jQuery('#value_'+index).before('<span id="checkmsg_'+index+'" ><input type="checkbox" value="1" onchange="onCheckboxChange('+index+',this);" />' + item_name + '</span>');
    }
    else if(datatype == 'grn.report.file')
    {
        document.getElementById('value_'+index).value = 0;
        jQuery('#value_'+index).hide();
        jQuery('#condition_'+index).hide();
        jQuery('#value_'+index).before('<span id="checkmsg_'+index+'" ><input type="checkbox" value="1" onchange="onCheckboxChange('+index+',this);" />'+__msg_item_attachedfiles+'</span>');
    }
    else if(datatype == 'grn.report.time')
    {
        var interval = item.getAttribute("interval");
        jQuery('#value_'+index).hide();
        document.getElementById('value_'+index).value = index;
        
        if(document.getElementById('time_'+index))
            jQuery('#time_'+index).show();
        else
            jQuery('#value_'+index).after(getTimeItem(index, interval));
        GRN_ReportInitialMinute.changeInterval('time_value_'+index+'_minute', interval, false);
    }
    else
    {
        if(!jQuery('#value_'+index).is(":visible"))
        {
            document.getElementById('value_'+index).value = '';
            jQuery('#value_'+index).show();
        }
    }
}

function getItemSelectBox(index)
{
    if(currentItems == null)
        return "";

    var options = '<option value="-1" datatype="" selected="selected">--</option>';
    for(var i in currentItems)
    {
        intervalAttribute = '';
        if( currentItems[i].interval )
            intervalAttribute = ' interval="'+currentItems[i].interval.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;")+'"';

        options += '<option value="'+i.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;")+'" datatype="'
                    +currentItems[i].datatype.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;")+'"'+intervalAttribute+'>'
                    +currentItems[i].name+'</option>';
    }
    
    return '<select name="item_'+index+'" id="item_'+index+'" style="margin-right:10px;" class="select_item" onchange="onChangeItem('+index+')">'+options+'</select>';
}

function onChangeItem(index)
{
    if(!document.getElementById('item_'+index))
        return;

    var selectedIndex = document.getElementById('item_'+index).selectedIndex;
    var datatype = document.getElementById('item_'+index).options[selectedIndex].getAttribute("datatype");
    var item_id  = document.getElementById('item_'+index).options[selectedIndex].value;
    var item_name = document.getElementById('item_'+index).options[selectedIndex].innerHTML;

    document.getElementById('item_type_'+index).value = datatype;
    document.getElementById('item_id_'+index).value = item_id;
    var option = getOptionsByDataType(datatype);
    
    var target = document.getElementById('condition_'+index);
    target.length = 0;
    target.length = option.length;

    for(i = 0; i < option.length; i++)
    {
        target[i].value = option[i].value;
        target[i].text = option[i].label;
    }

    if(document.getElementById('date_'+index))
        jQuery('#date_'+index).hide();
    if(document.getElementById('time_'+index))
        jQuery('#time_'+index).hide();

    jQuery('#condition_'+index).show();

    if(document.getElementById('checkmsg_'+index))
        document.getElementById('checkmsg_'+index).parentNode.removeChild(document.getElementById('checkmsg_'+index));

    //datatypeが日付の場合は日付入力フォームを表示
    if(datatype == 'grn.report.date')
    {
        jQuery('#value_'+index).hide();
        document.getElementById('value_'+index).value = index;
        
        if(document.getElementById('date_'+index))
            jQuery('#date_'+index).show();
        else
            jQuery('#value_'+index).after(getDateItem(index));
    }
    else if(datatype == 'grn.report.checkbox')
    {
        document.getElementById('value_'+index).value = 0;
        jQuery('#value_'+index).hide();
        jQuery('#value_'+index).before('<span id="checkmsg_'+index+'" ><input type="checkbox" value="1" onchange="onCheckboxChange('+index+',this);" />' + item_name + '</span>');
    }
    else if(datatype == 'grn.report.file')
    {
        document.getElementById('value_'+index).value = 0;
        jQuery('#value_'+index).hide();
        jQuery('#condition_'+index).hide();
        jQuery('#value_'+index).before('<span id="checkmsg_'+index+'" ><input type="checkbox" value="1" onchange="onCheckboxChange('+index+',this);" />'+__msg_item_attachedfiles+'</span>');
    }
    else if(datatype == 'grn.report.time')
    {
        var interval = document.getElementById('item_'+index).options[selectedIndex].getAttribute("interval");
        jQuery('#value_'+index).hide();
        document.getElementById('value_'+index).value = index;
        
        if(document.getElementById('time_'+index))
            jQuery('#time_'+index).show();
        else
            jQuery('#value_'+index).after(getTimeItem(index, interval));
        GRN_ReportInitialMinute.changeInterval('time_value_'+index+'_minute', interval, false);
    }
    else
    {
        if(!jQuery('#value_'+index).is(":visible"))
        {
            document.getElementById('value_'+index).value = '';
            jQuery('#value_'+index).show();
        }
    }

}

//検索を行う
function searchReport(form, index, sort)
{
    if(!validateConditions())
        return;
    var body = jQuery(form).serialize();
    if(!isNaN(index))
        body += "&sp="+index;
    if(sort != null && sort.length > 0)
        body += "&sort="+sort;

    var ajaxRequest = new grn.component.ajax.request(
    {
        url: searchReportUrl,
        method: "post",
        data: body,
        grnLoadingIndicator: function (action) {
            if (action === 'show' && jQuery("#report_button_search").length === 0) {
                document.getElementById('result').innerHTML = '<img src="' + spinnerImage + '" />';
                return;
            }
            var button = grn.component.button("#report_button_search");
            if (action === 'show') {
                button.showSpinner();
            }
            else {
                button.hideSpinner();
            }
        }
    });

    ajaxRequest.send().done(function(data, textStatus, jqXHR )
    {
        document.getElementById('result').innerHTML = jqXHR.responseText;
    });
}

//ページングの際に呼ばれる
function pagingOnSearch(index)
{
    searchReport(document.getElementById('searchConditionForm'), index, document.getElementById('current_sort').value);
    
    //値を保持しておく
    document.getElementById('current_sp').value = index;
}

//ソート
function sortOnSearch(sort)
{
    searchReport(document.getElementById('searchConditionForm'), document.getElementById('current_sp').value, sort);
    document.getElementById('current_sort').value = sort;
}

//バリデーション
function validateConditions(checkTitle)
{
    var validate = true;

    //絞込み名のバリデーションも行う
    if(checkTitle)
    {
        document.getElementById('validate_message').innerHTML = '';
        if(document.getElementById('filter_name_input').value == '')
        {
            document.getElementById('validate_message').innerHTML = __validate_msg_no_title;
            validate = false;
        }
    }

    /* //フォーム選択部分のチェック
    var selectForm      = $('select_form_checkbox').checked;
    var selectFormType1 = $('select_form_type_1').checked;
    var selectFormType2 = $('select_form_type_2').checked;
    
    $('select_form_validate').innerHTML = '';
    $('select_form_name_input_validate').innerHTML = '';
    $('select_form_select_validate').innerHTML = '';
    
    //「対象フォームを選択する」のチェックがオンで、ラジオボタンを選択していない場合
    if(selectForm && !selectFormType1 && !selectFormType2)
    {
        $('select_form_validate').innerHTML = __validate_msg_select_form;
        validate = false;
    }
    
    //「フォーム名を入力(部分一致)」でテキストを入力していない場合
    if(selectFormType1 && $('select_form_name_input').value.length == 0)
    {
        $('select_form_name_input_validate').innerHTML = __validate_msg_empty_string;
        validate = false;
    }
    
    //「フォームを選択」で選択していない場合
    if(selectFormType2 && $('selected_form_id').value == '')
    {
        $('select_form_select_validate').innerHTML = __validate_msg_select_form;
        validate = false;
    } */

    //各条件のチェック
    jQuery('input.condition_value').each(
        function(i,node)
        {
            var index = node.id.split('_')[1];
            document.getElementById('error_message_'+index).innerHTML = '';
            
            //空白でないか？
            if(jQuery(node).is(":visible") && node.value == '')
            {
                document.getElementById('error_message_'+index).innerHTML = __validate_msg_empty_string;
                validate = false;
            }
            
            //条件が数値の場合、入力されている値は数値か？
            if( document.getElementById('condition_'+index).value == 6
             || document.getElementById('condition_'+index).value == 7
             || document.getElementById('condition_'+index).value == 8
             || document.getElementById('condition_'+index).value == 9)
             {
                if(!isNumber(document.getElementById('value_'+index).value))
                {
                    document.getElementById('error_message_'+index).innerHTML = __validate_msg_not_a_number;
                    validate = false;
                }
             }
        }
    );
    
    return validate;
}

function isNumber(value)
{
    if(value === null || value === undefined)
        return false;
    
    if(value instanceof Array)
        return false;
    
    //trim
    value = String(value).replace(/[ 　]/g, '');

    if(value.length == 0)
        return false;
        
    if(isNaN(value) || !isFinite(value))
        return false;
    
    return true;
}

function coverBackground(visible)
{
    var ifr_doc = document.getElementById('background_iframe').contentWindow.document;
    var b = document.documentElement;
    if(visible)
    {
        var window_width = document.documentElement.clientWidth || document.body.clientWidth || document.body.scrollWidth;
        var window_height = document.documentElement.clientHeight || document.body.clientHeight || document.body.scrollHeight;
        if( isSafari() )
        {
            window_width = window.innerWidth;
            window_height = window.innerHeight;
        }
        var document_width = document.documentElement.scrollWidth || document.body.scrollWidth;
        var document_height = document.documentElement.scrollHeight || document.body.scrollHeight;

        //ダイアログの表示によってスクロールバーが表示されないようにする
        //元々表示されている場合は表示する（window.scrollMaxはFirefox対策）
        if( window_width >= document_width && !window.scrollMaxX)
            document.body.style.overflowX = "hidden";
        if( window_height >= document_height && !window.scrollMaxY)
            document.body.style.overflowY = "hidden";

        with(document.getElementById('background_iframe').style)
        {
            display = 'block';
            width   = Math.max(b.clientWidth,  b.scrollWidth) + 'px';
            height  = Math.max(b.clientHeight, b.scrollHeight) + 'px';
        }
        
        if(grn.browser.msie)
        {
            var popup_bg = ifr_doc.createElement('div');
            with (popup_bg.style) {
                position = 'absolute';
                cursor = 'pointer';
                backgroundColor = '#000';
                opacity = 0.5;
                display = 'block';
                left = '0px';
                top = '0px';
                overflow = 'hidden';
                width   = Math.max(b.clientWidth,  b.scrollWidth) + 'px';
                height  = Math.max(b.clientHeight, b.scrollHeight) + 'px';
            }
            ifr_doc.body.style.overflow = 'hidden';
            ifr_doc.body.appendChild(popup_bg);
        }
    }
    else
    {
        document.body.style.overflowX = '';
        document.body.style.overflowY = '';
        with(document.getElementById('background_iframe').style)
        {
            display = 'none';
            width   = '1px';
            height  = '1px';
        }
        
        if(grn.browser.msie)
            ifr_doc.body.innerHTML = '';
    }
}

//「対象となるフォームを限定する」に変更が発生した際の処理
function onClickFormSelectCheckbox(checked)
{
    if(checked)
    {
        document.getElementById('select_form_name_div').style.opacity = 1;
        document.getElementById('select_form_select_div').style.opacity = 1;
        document.getElementById('select_form_type_1').disabled = false;
        document.getElementById('select_form_type_2').disabled = false;
    }
    else
    {
        document.getElementById('select_form_name_div').style.opacity = 0.5;
        document.getElementById('select_form_select_div').style.opacity = 0.5;
        document.getElementById('select_form_type_1').disabled = true;
        document.getElementById('select_form_type_2').disabled = true;
        document.getElementById('select_form_type_1').checked = false;
        document.getElementById('select_form_type_2').checked = false;
        document.getElementById('select_form_name_input').disabled = true;
        document.getElementById('select_form_button').disabled = true;
        
        removeItemSelectBoxes();
        document.getElementById('selected_form_name').innerHTML = '';
        document.getElementById('selected_form_id').value = '';
    }
}

function removeItemSelectBoxes()
{
    jQuery('select.select_item').each(
        function (i,node)
        {
            index = node.id.split('_')[1];
            node.parentNode.removeChild( node );
            
            if(document.getElementById('date_'+index))
                jQuery('#date_'+index).hide();

            if(document.getElementById('time_'+index))
                jQuery('#time_'+index).hide();
            if(document.getElementById('checkmsg_'+index))
                document.getElementById('checkmsg_'+index).parentNode.removeChild(document.getElementById('checkmsg_'+index));
            if(document.getElementById('error_message_'+index))
                document.getElementById('error_message_'+index).innerHTML = '';
            if('condition_'+index)
                jQuery('#condition_'+index).show();

            if(!jQuery('#value_'+index).is(":visible"))
            {
                document.getElementById('value_'+index).value = '';
                jQuery('#value_'+index).show();
            }
        }
    );
}

function onClickSelectFormRadio(type)
{
    if(type == 'name')
    {
        document.getElementById('select_form_name_input').disabled = false;
        document.getElementById('select_form_button').disabled = true;
        removeItemSelectBoxes();
        document.getElementById('selected_form_name').innerHTML = '';
        document.getElementById('selected_form_id').value = '';
    }
    else
    {
        document.getElementById('select_form_name_input').disabled = true;
        document.getElementById('select_form_button').disabled = false;
    }
}
