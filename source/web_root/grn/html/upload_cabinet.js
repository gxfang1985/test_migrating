//DOMツリーが構築し終えたときに発生するイベント
jQuery(document).ready(function(){
    upload_init();
    if(grn.browser.isSupportHTML5)
    {
        jQuery.each( jQuery(".file_input_div").toArray(), function()
        {
            jQuery(this).mouseover(function() {
                jQuery(this).addClass("over");
            });

            jQuery(this).mouseout(function() {
                jQuery(this).removeClass("over");
            });
        });
    }
});

//Flashプラグインが存在すればFlashコンテンツを表示、
//そうでなければ通常のファイル選択フォームを表示
function upload_init()
{
    if(grn.browser.isSupportHTML5)
    {
        document.getElementById("html5_content").style.display = "";
        jQuery("#not_support_html5_content").remove();
    }
    else
    {
        document.getElementById("not_support_html5_content").style.display = "";
        jQuery("#html5_content").remove();
        grn.component.button("#cabinet_button_add").disable();
        grn.component.button("#memo_button_save").disable();
    }
}

//テキストエリアを拡大
function expandTextarea(textarea)
{
    if(textarea.rows < 5)
    {
        textarea.rows = 5;
    }
}

function confirmIfExistFailedFile()
{
    if(window[ "isExistFailedFile" ])
    {
        return confirm(__upload_msg_confirm1 + "\n" + __upload_msg_confirm2);
    }
    else
    {
        return true;
    }
}

if(grn.browser.isSupportHTML5)
{
    var filesUpload = document.getElementById("file_upload_"),
        dropArea = document.getElementById("drop_");

    var isCheck = false;
    var count = 0;
    var valid = 0;
    var t;

    function handleDrag(evt)
    {
        if(evt.dataTransfer.types[0].toString().indexOf("text") >= 0)
        {
            return;
        }

        evt.preventDefault();
        evt.stopPropagation();
        var type = evt.type;

        if(type == "drop") {
            jQuery(dropArea).removeClass("over");
            jQuery.each(
                jQuery(".file_input_div").toArray(),
                function(k,e){
                    jQuery(e).removeClass("drag_in");
                }
            );
            isCheck = false;
            count = 0;
            valid = 0;
            clearTimeout(t);
            return;
        }

        if(type == "dragover") {
            jQuery(dropArea).addClass("over");
            jQuery.each(
                jQuery(".file_input_div").toArray(),
                function(k,e){
                    jQuery(e).addClass("drag_in");
                }
            );
            evt.dataTransfer.dropEffect = "none";
         }

         count++;
        if(!isCheck)
        {
            checkDragging();
            isCheck = true;
        }
    }

    function checkDragging()
    {
        if(valid < count)
        {
            valid = count;
            t=setTimeout("checkDragging()",400);
        }
        else
        {
            jQuery(dropArea).removeClass("over");
            jQuery.each(
                jQuery(".file_input_div").toArray(),
                function(k,e){
                    jQuery(e).removeClass("drag_in");
                }
            );
            isCheck = false;
            count = 0;
            valid = 0;
            clearTimeout(t);
        }
    }

    window.addEventListener("dragover",handleDrag, false);
    window.addEventListener("drop",handleDrag, false);

    function traverseFiles (files) {
        if (typeof files !== "undefined") {
            for (var i=0, l=files.length; i<l; i++) {
                fileUpload = new FileUpload(files[i]);
            }
        }
    }

    filesUpload.addEventListener("change", function () {
        traverseFiles(this.files);
        self.filesUpload.value = "";
    }, false);

     dropArea.addEventListener("dragleave", function (evt) {
        evt.preventDefault();
        evt.stopPropagation();
    }, false);

    dropArea.addEventListener("dragenter", function (evt) {
        evt.preventDefault();
        evt.stopPropagation();
    }, false);

    dropArea.addEventListener("dragover", function (evt) {
        count++;
        evt.dataTransfer.dropEffect = "copy";
        evt.preventDefault();
        evt.stopPropagation();
    }, false);

    dropArea.addEventListener("drop", function (evt) {
        jQuery(dropArea).removeClass("over");
        jQuery.each(
            jQuery("file_input_div").toArray(),
            function(k,e){
                jQuery(e).removeClass("drag_in");
            }
        );
        traverseFiles(evt.dataTransfer.files);
        evt.preventDefault();
        evt.stopPropagation();
    }, false);


    // ************ Object FileUpload ***************** //
    html5_uploadStatuses = new Object();
    var FileUpload = function(file){
        this.file = file;
        this.xhr = null;
        this.responseText = "";
        this.fid = null;
        this.started = false;
        this.init();
    };

    FileUpload.prototype.init = function(){
        this.triggerUpload();
    };

    FileUpload.prototype.cancelUpload = function(e,fileid){
        e.preventDefault();
        if ( this.xhr ){
            this.endProcess(0);
        }

        jQuery("#row_"+fileid).remove();
        this.completeUpload(fileid);
    };

    FileUpload.prototype.triggerUpload = function(){
        this.sendDatas();
    };

    FileUpload.prototype.sendDatas = function() {
        var self = this;
        this.xhr = new XMLHttpRequest();
        this.fid = this.randomString();

        this.onUploadOpen(this.fid,this.file.name,this.file.size);
        if(this.file.size == 0)
        {
            this.onUploadError(this.fid,"ZEROBYTE_FILE");
            this.xhr = null;
            return;
        }

        if ( this.xhr ){
            this.xhr.upload.addEventListener("loadstart", function(e)
            {
                var t = setTimeout(self.checkRequest.bind(self),600000);
            }, false);
            this.xhr.upload.addEventListener("progress", function(e){ self.updateProgress(e,self.fid); }, false);
            this.xhr.upload.addEventListener("load", function(e){ self.endUpload(e,self.fid,self); }, false);
            this.xhr.upload.addEventListener("abort", function(){ self.closeXhr(self); }, false);
            this.xhr.upload.addEventListener("error", function(e){ self.errorUpload(e); }, false);
            this.xhr.ontimeout = function(e){ alert('Request timed out.'); };

            this.xhr.onreadystatechange=function(){
                if(this.readyState < 4 )
                {
                }
                if (this.readyState == 4)
                {
                   var status = this.status;

                   if (status == 200)
                   {
                     self.endProcess(1);
                   }
                   if (status == 404 || status == 500)
                   {
                      self.endProcess(0);
                   }
                }
            };
            this.processUpload(this.fid);
        }
    };

    FileUpload.prototype.processUpload = function(fid) {

        var data = new FormData();
        data.append("file",this.file);
        this.xhr.open("POST", __upload_url,true);

        this.xhr.setRequestHeader("X-File-Name", escape(this.file.name));
        this.xhr.setRequestHeader("X-File-Type", this.file.type);
        this.xhr.setRequestHeader("X-File-Size", this.file.size);
        this.xhr.setRequestHeader("X-File-Id", fid);
        this.xhr.setRequestHeader("X-File-Upload-Ticket", __upload_ticket);

        this.xhr.send(data);
    };

    FileUpload.prototype.updateProgress = function(e,fid) {
        this.started = true;
        if (e.lengthComputable)
        {
            document.getElementById(fid+"_progress").style.width = (e.loaded / e.total)*100 +"%";
        }
    };

    FileUpload.prototype.endUpload = function(e,fid,self){
        this.started = true;
    };

    FileUpload.prototype.endProcess = function(control) {
        if ( this.xhr )
        {
            if(this.xhr.responseText)
            {
                if(this.xhr.responseText == "COMPLETE")
                {
                    document.getElementById(this.fid+"_progressItem").innerHTML = "";
                    document.getElementById(this.fid+"_message").innerHTML = "";

                    //アップするかどうかのチェックボックスを作成
                    document.getElementById(this.fid+"_check").innerHTML = '<input type="checkbox" id="'+this.fid+'_checkbox" name="upload_fileids[]" value="'+this.fid+'" checked />';
                    var self = this;
                    document.getElementById(this.fid+"_check").addEventListener('click', function(e){ self.toggleRowView(self.fid);}, false);

                    //何故かChromeだとcheckedを付けていてもチェックがつかないことがあるので
                    //Javascriptで再度チェックをオンにする
                    document.getElementById(this.fid+"_checkbox").checked = true;

                    this.completeUpload(this.fid);
                }
                else
                {
                    this.onUploadError(this.fid,this.xhr.responseText);
                }
            }

            this.xhr.abort();
        }
    };

    FileUpload.prototype.errorUpload = function(e) {

    };
    FileUpload.prototype.closeXhr = function(){
        this.xhr = null;
    };

    FileUpload.prototype.checkRequest = function(){
        if(this.started == false)
        {
            if(this.xhr)
            {
                this.onUploadError(this.fid,"REQUEST_TIME_OUT");
                this.xhr.abort();
            }
        }
    };

    FileUpload.prototype.onUploadOpen = function(fileid,filename,size,e){
        var self = this;
        filename = filename.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;");
        var row = document.getElementById("fileTable").insertRow(-1);
        row.id = "row_"+fileid;

        var cell1 = row.insertCell(-1);
        cell1.id = fileid+"_check";
        cell1.vAlign = "middle";

        var cell2 = row.insertCell(-1);
        cell2.style.whiteSpace = "normal";
        cell2.innerHTML = filename;

        var cell3 = row.insertCell(-1);
        cell3.id = fileid+"_size";
        cell3.innerHTML = this._getSizeString(size);

        var cell4 = row.insertCell(-1);
        cell4.id = fileid+"_progressItem";
        cell4.innerHTML = this._getProgressItem(fileid);

        var cell8 = row.insertCell(-1);
        cell8.id = fileid+"_message";
        cell8.style.whiteSpace = "nowrap";
        cell8.innerHTML = '<a href="javascript:;">'+__upload_msg_cancel+'</a>';
        if(cell8.firstChild)
        {
            jQuery(cell8.firstChild).click(function(e){
                self.cancelUpload(e,self.fid);
            });
        }

        var cell5 = row.insertCell(-1);
        cell5.innerHTML = this._getTitleForm(fileid);

        var cell6 = row.insertCell(-1);
        cell6.style.whiteSpace = "nowrap";
        cell6.appendChild( this._getVersionSelectForm(fileid) );
        cell6.innerHTML += __upload_msg_version_suffix;

        var cell7 = row.insertCell(-1);
        cell7.id = fileid+"_descriptionItem";
        cell7.innerHTML = this._getDescriptionForm(fileid);

        this.startUpload(fileid);
    };

    FileUpload.prototype.onUploadComplete = function (fileid)
    {

    };

    FileUpload.prototype.randomString =function () {
        var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
        var string_length = 35;
        var randomstring = "";
        for (var i=0; i<string_length; i++) {
            var rnum = Math.floor(Math.random() * chars.length);
            randomstring += chars.substring(rnum,rnum+1);
        }
        return randomstring;
    };

    FileUpload.prototype._getProgressItem = function (fileid)
    {
        return  '<div style="border: 1px solid rgb(176, 176, 176); padding: 0px; width: 200px; height: 10px;" id="div_'+fileid+'">'
                    +'<div id="'+fileid+'_progress" style="width:0%;background-color:lightgreen;height:100%;"></div>'
                +'</div>';
    };

    FileUpload.prototype._getSizeString = function (size)
    {
        suffix = new Array("B","KB","MB","GB","TB","PB","EB","ZB","YB");
        idx = parseInt((String(size).length - 1)/3);
        ret = (size / Math.pow(1024,idx)).toFixed(1) + suffix[idx];
        return ret.replace("\.0","");
    };

    FileUpload.prototype._getVersionSelectForm = function (fileid)
    {
        var select = document.getElementById("version_select").cloneNode(true);
        if(!!(window.attachEvent && navigator.userAgent.indexOf("Opera") == -1))
        {
            var div = document.createElement("div");
            div.setAttribute("id", "div_version_"+fileid);
            div.id = "div_version_"+fileid;
            div.style.display = "inline";
            div.innerHTML = '<select id="version_'+fileid+'" name="max_version_'+fileid+'">'
                            + select.innerHTML
                            + '</select>';
            select = div;
        }
        else
        {
            select.name = "max_version_"+fileid;
            select.id = "version_"+fileid;
        }
        return select;
    };

    FileUpload.prototype._getDescriptionForm =function (fileid)
    {
        return '<textarea id="description_'+fileid+'" name="memo_'+fileid+'" class="autoexpand" wrap="virtual" style="width:100%;" rows="1" onfocus="expandTextarea(this);" ></textarea>';
    };

    FileUpload.prototype._getTitleForm = function (fileid)
    {
        return '<input type="text" style="width:100%;" name="title_'+fileid+'" />';
    };

    //エラーが発生した場合に呼び出される
    FileUpload.prototype.onUploadError = function (fileid, errorcode)
    {
        isExistFailedFile = true;
        document.getElementById("row_" + fileid).deleteCell(7);
        document.getElementById("row_" + fileid).deleteCell(6);
        document.getElementById("row_" + fileid).deleteCell(5);
        document.getElementById("row_" + fileid).deleteCell(4);
        document.getElementById(fileid + "_progressItem").colSpan = 5;

        if(errorcode == "ZEROBYTE_FILE")
        {
            document.getElementById(fileid + "_progressItem").innerHTML = this.createErrorMessageTag( __upload_msg_zerobyte_file );
        }
        else
        {
            if(errorcode == "INVALID_TICKET" || errorcode == "OVER_INI_SIZE" || errorcode == "OVER_FORM_SIZE" || errorcode == "NO_FILE")
            {
                document.getElementById(fileid + "_progressItem").innerHTML = this.createErrorMessageTag( __upload_msg_error + errorcode + __upload_msg_error_suffix );
            }
            else
            {
                document.getElementById(fileid + "_progressItem").innerHTML = this.createErrorMessageTag( __upload_msg_error + "PARTIAL" + __upload_msg_error_suffix );
            }
        }
        this.completeUpload(fileid);
    };

    FileUpload.prototype.createErrorMessageTag = function createErrorMessageTag(message)
    {
        return '<span style="color:red; font-weight:bold;">'+message+'</span>';
    };

    //非選択のファイルは半透明にする
    FileUpload.prototype.toggleRowView = function (fileid)
    {
        if(document.getElementById(fileid+"_checkbox").checked)
            this.enableFile(fileid);
        else
            this.disableFile(fileid);
    };

    FileUpload.prototype.enableFile = function (fileid)
    {
        if(!!(window.attachEvent && navigator.userAgent.indexOf("Opera") == -1))
        {
            for(var i=0; i < document.getElementById("row_"+fileid).childNodes.length; i++)
                document.getElementById("row_"+fileid).childNodes[i].style.filter = "";
        }
        else
        {
            document.getElementById("row_"+fileid).style.MozOpacity = 1;
            document.getElementById("row_"+fileid).style.opacity = 1;
        }
    };

    FileUpload.prototype.disableFile = function (fileid)
    {
        if(!!(window.attachEvent && navigator.userAgent.indexOf("Opera") == -1))
        {
            for(var i=0; i < document.getElementById("row_"+fileid).childNodes.length; i++)
                document.getElementById("row_"+fileid).childNodes[i].style.filter = "alpha(opacity=30)";
        }
        else
        {
            document.getElementById("row_"+fileid).style.MozOpacity = 0.3;
            document.getElementById("row_"+fileid).style.opacity = 0.3;
        }
    };

    FileUpload.prototype.startUpload = function (fileid)
    {
        html5_uploadStatuses[fileid] = true;

        //全ての submit ボタンを disable
        for(var i in document.forms)
        {
            this.toggleButtons(true);
        }
    };

    FileUpload.prototype.completeUpload = function (fileid)
    {
        html5_uploadStatuses[fileid] = false;

        var uploadingFlag = false;
        for(var i in html5_uploadStatuses)
            uploadingFlag |= html5_uploadStatuses[i];

        //全てアップロードし終えてる
        if(!uploadingFlag)
        {
            this.toggleButtons(false);
        }
    };

    FileUpload.prototype.toggleButtons = function (disable)
    {
        for(var i = 0; i < document.forms.length; i++)
        {
            var form = document.forms[i];

            //submit ボタン
            var inputSubArray = jQuery(form).find("input[type='submit']").toArray();
            jQuery.each(
                inputSubArray,
                function(k,node){
                    node.disabled = disable;
                }
            );

            //通常のボタンで、onclick に submit と入っているもの
            var inputBtnArray = jQuery(form).find("input[type='button']").toArray();
            jQuery.each(
                inputBtnArray,
                function(k,node){
                    try
                    {
                        if(node.onclick != undefined && node.onclick.toString().indexOf("submit") > 0)
                            node.disabled = disable;
                    }
                    catch(e)
                    {}
                }
            );
        }

        if (grn.component.button) {
            jQuery('.button1_main_grn, .button_submit_grn').each(
                function () {
                    if (disable) {
                        grn.component.button(this).disable();
                    } else {
                        grn.component.button(this).enable();
                    }
                }
            );
        }
    };
}

jQuery.each(
    jQuery(".file_input_div").toArray(),
    function(){
        jQuery(this).mouseover(function() {
            jQuery(this).addClass("over");
        });

        jQuery(this).mouseout(function() {
            jQuery(this).removeClass("over");
        });
    }
);
