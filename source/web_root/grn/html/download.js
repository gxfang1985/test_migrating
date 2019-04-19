grn.base.namespace("grn.html.download");
(function ($) {

    var G = grn.html.download;

    G.old_onkeydown_handlar = null;

    //ファイル一括ダウンロードウインドウを開く
    G.showBundleDownloadWindow = function()
    {

        //disable onkeydown
        G.old_onkeydown_handlar = document.onkeydown;

        document.onkeydown = function(e){
            e = (e == undefined) ? event : e;
            if( GRN_Event.keyCode(e) == 27 ) //ESC key
            {
                return G.closeBundleDownloadWindow();
            }
            return false;
        };
    
        G.coverBackground(true);
        var bundleDownForm = $("#bundle_download_form :input[type='checkbox']");
        var bundleDownFormArray = bundleDownForm.toArray();
        $.each( bundleDownFormArray,function(key,value){
            $(value).prop("checked",false);
        });

        $("#assumed_progress").css( "width",0 );
        $("#inner_progress").css( "width",0 );

        grn.component.button("#bundleDownloadButton").disable();
        $("#bundleDownloadSize").html( "0B" );
        $("#bundleSizePercentage").html( "0%" );

        var elm = $("#bundleDownloadWindow");
        if( !!(window.attachEvent &&
            navigator.userAgent.indexOf("Opera") == -1))
        {
            elm.css("width", G.getDisplayWidth() * 0.70 + "px");
            elm.css("height", G.getDisplayHeight() * 0.65 + document.getElementById("bundleDownloadTitle").clientHeight + "px");
        }
        else if( (navigator.userAgent.indexOf("AppleWebKit/") > -1) || (navigator.userAgent.indexOf("Gecko") > -1 &&
            navigator.userAgent.indexOf("KHTML") == -1))
        {
            elm.css("width", G.getDisplayWidth() * 0.70 + "px");
            elm.css("height", G.getDisplayHeight() * 0.65 + 32 + "px");
            $("#bundle_download_form").css("height", G.getDisplayHeight() * 0.65 - 32 + "px");
        }
        $(elm).show();
    };

    //ファイル一括ダウンロードウインドウを閉じる
    G.closeBundleDownloadWindow = function()
    {
        //enable onkeydown
        document.onkeydown = G.old_onkeydown_handlar;
    
        G.coverBackground(false);
        $("#bundleDownloadWindow").hide();
    };

    //背景を黒で覆う
    G.coverBackground =function(visible)
    {
        var backgroundElement = $("#background");
        if(visible)
        {
            var body = ((document.documentElement.clientHeight == 0)?document.body:document.documentElement);
            var backgroundEW = Math.max(body.clientWidth,  body.scrollWidth) + "px";
            var backgroundEH = Math.max(body.clientHeight, body.scrollHeight) + "px";

            backgroundElement.css( {"width": backgroundEW , "height": backgroundEH} );
            backgroundElement.attr( {"class": "cover"});
            backgroundElement.show();
        }
        else
        {
            backgroundElement.attr( {"class": ""});
            backgroundElement.css( {"width": 0 , "height": 0} );
            backgroundElement.hide();
        }
    };

    G.filenameAdded = false;
    G.pre_submit = function()
    {
        if(G.filenameAdded)
        {
        return;
        }
        var form = $("#bundle_download_form");
        var url = form.attr("action").split("?");

        form.attr("action", url[0] + "/-/"+ G.filename+".zip");
        if(url.length >= 2)
        {
            var new_url = form.attr("action") + url[1];
            form.attr("action", new_url);
        }
        
        G.filenameAdded = true;
    };

    G.calcTotalFileSize = function(checkbox)
    {
        var total_size = 0;
        var is_exist_select = false;
        var bundle_download_form = $("#bundle_download_form :input[type='checkbox']");
        var download_Button = grn.component.button("#bundleDownloadButton");

        var hundleDownloadFormArray = bundle_download_form.toArray();
        $.each( hundleDownloadFormArray, function(key,value){
            if($(value).prop("checked"))
            {
                total_size = total_size  +  parseInt($(value).attr("size"));
                is_exist_select = true;
            }
        });

        if($(checkbox).prop("checked"))
        {
            document.getElementById("assumed_progress").style.width = 0;
        }

        //ダウンロード不可能なサイズならダウンロードボタンを disable にする
        if(G.isDownloadableSize(total_size) && is_exist_select)
        {
            download_Button.enable();
        }
        else
        {
            download_Button.disable();
        }
        //サイズを表すプログレスバーを表示
        var pct = G.getSizePercentage(total_size);
        $("#bundleSizePercentage").html( parseInt(pct)+"%" );
        if(parseInt(pct) > 100)
        {
            $("#inner_progress").css( "background", "red");
            $("#inner_progress").css( "width", "100%");
        }
        else
        {
            $("#inner_progress").css( "background", "lightgreen");
            $("#inner_progress").css( "width",  pct + "%");
        }
    
        //現在のダウンロードサイズを表示
        $("#bundleDownloadSize").html(G.getSizeString(total_size) );
    };

    //渡した値(Byte)を画面で表示する形式に直して返す
    //例) 1234 -> 123.4KB
    // 1234567 -> 1.1MB (1234567/(1024*1024) = 1.17MB)
    G.getSizeString = function(size)
    {
        var suffix = new Array("B","KB","MB","GB","TB","PB","EB","ZB","YB");
        var idx = parseInt((String(size).length - 1)/3);
        var ret = (size / Math.pow(1024,idx)).toFixed(1) + suffix[idx];
        return ret.replace("\.0","");
    };

    G.getSizePercentage = function(size)
    {
        if( G.max_download_size == 0)
        {
            return 0;
        }
        else
        {
            return parseInt(Math.ceil((size / G.max_download_size) * 100.0));
        }
    };
    G.isDownloadableSize =function(size)
    {
        if(G.max_download_size == 0)
        {
            return true;
        }
        else
        {
            return parseInt(size) <= G.max_download_size;
        }
    };

    G.getDisplayWidth = function()
    {
        if(document.all)
        {
            return document.body.clientWidth;
        }
        else if(document.layers || document.getElementById)
        {
            return window.innerWidth;
        }
        else
        {
            return 0;
        }
    };

    G.getDisplayHeight = function()
    {
        if(document.all)
        {
            return document.body.clientHeight;
        }
        else if(document.layers || document.getElementById)
        {
            return window.innerHeight;
        }
        else
        {
            return 0;
        }
    };

    G.getWindowWidth = function(){
        // Mozilla, Opera, NN4
        if(window.innerWidth)
        {
            return window.innerWidth;
        }

        // 以下 IE
        if(document.documentElement && document.documentElement.clientWidth)
        {
            return document.documentElement.clientWidth;
        }
        else if(document.body && document.body.clientWidth)
        {
            return document.body.clientWidth;
        }

        return 0;
    };

    G.getWindowHeight = function(){
        // Mozilla, Opera, NN4
        if(window.innerHeight)
        {
            return window.innerHeight;
        }

        // 以下 IE
        if(document.documentElement && document.documentElement.clientHeight)
        {
            return document.documentElement.clientHeight;
        }
        else if(document.body && document.body.clientHeight)
        {
            return document.body.clientHeight;
        }

        return 0;
    };

    G.setSelectableView = function(fileid)
    {
        var downloadFileElement = $("#download"+fileid);
        //現在選択しているファイルサイズをプログレスバーに反映させる
        if(! downloadFileElement.prop("checked"))
        {
            var size = downloadFileElement.attr("size");
            var assumed_pct = G.getSizePercentage(size);

            var current_pct = document.getElementById("inner_progress").style.width.replace("%","");
            if(isNaN(current_pct))
            {
                current_pct = 0;
            }

            if(parseInt(current_pct) + parseInt(assumed_pct) > 100)
            {
                $("#assumed_progress").css("background", "#FF8C00");
                $("#assumed_progress").css("width", (100 - current_pct)+"%");
            }
            else
            {
                $("#assumed_progress").css("background", "Yellow");
                $("#assumed_progress").css("width", assumed_pct+"%");
            }
        }
    };

    G.setUnselectableView = function(fileid)
    {
        $("#assumed_progress").css("width", 0);
    };

    //全てのファイルにチェックを入れる/外す
    G.check_download_files = function()
    {
        var checked = false;

        var e = $("#bundle_download_form :input[name='fid[]']");
        var eArray = e.toArray();
        $.each(eArray, function(key, value){
            if($(value).attr("name") == "fid[]" && !$(value).prop("checked"))
            {
                checked = true;
            }
        });
        $.each(eArray, function(key, value){
            if($(value).attr("name") == "fid[]")
            {
                $(value).prop("checked", checked);
            }
        });

        if(e.length > 0)
        {
            G.calcTotalFileSize(e[0]);
        }
    };

})(jQuery);
