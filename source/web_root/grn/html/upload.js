//DOMツリーが構築し終えたときに発生するイベント
jQuery(
    function () {
        upload_init();
        getUploadedTempFiles();
        if (grn.browser.isSupportHTML5) {
            jQuery(".file_html5").each(function (index, e) {
                var id = e.id.split("file_upload_")[1];
                new DragDropFile(id);
            });

            jQuery(".file_input_div").each(function (index, f) {
                f.addEventListener("mouseover", function () {
                    jQuery(f).addClass("over");
                }, false);
                f.addEventListener("mouseout", function () {
                    jQuery(f).removeClass("over");
                }, false);
            });
        }
    }
);

//Flashプラグインが存在すればFlashコンテンツを表示、
//そうでなければ通常のファイル選択フォームを表示
function upload_init()
{
    if(grn.browser.isSupportHTML5)
    {
        jQuery("#html5_content").css("display", "");
        jQuery("#not_support_html5_content").remove();
    }
    else
    {
        jQuery("#not_support_html5_content").css("display", "");
        jQuery("#html5_content").remove();
        grn.component.button("#fileupload_button_upload").disable();
        grn.component.button("#btnUpdateAttachment").disable();
    }
}

//戻るボタンなどでページを移動した際に、既にアップしたファイルを取得する
function getUploadedTempFiles()
{
    var ajaxRequest = new grn.component.ajax.request(
        {
            url: __upload_files_url,
            data: "upload_ticket=" + __upload_ticket,
            method: "post",
            grnRedirectOnLoginError: true
        });
    ajaxRequest.send().done(function(data, textStatus, request)
    {
        var uploadTable = document.getElementById('upload_table');
        var tableHTML = "<table><tbody><tr><td></td></tr></tbody></table>";
        if (request.responseText != undefined && request.responseText.length > 0 )
        {
            tableHTML = "<table>"+request.responseText+"</table>";
        }
        var divElem = document.createElement('div');
        divElem.innerHTML = tableHTML;
        var tableElem = divElem.firstChild;
        var childElem;

        if (jQuery(uploadTable).length > 0)
        {
            //clear table
            while( childElem = uploadTable.firstChild )
                uploadTable.removeChild( childElem );
            //append attached files
            while( childElem = tableElem.firstChild )
                uploadTable.appendChild( childElem );
        }
    });
}

function _getSizeString(size)
{
    var suffix = new Array("B","KB","MB","GB","TB","PB","EB","ZB","YB");
    var idx = parseInt((String(size).length - 1)/3);
    var ret = (size / Math.pow(1024,idx)).toFixed(1) + suffix[idx];
    return ret.replace("\.0","");
}

//非選択のファイルはグレーアウト
function onChangeCheckBox(fileid)
{
    if(jQuery("#" +fileid+"_checkbox").is(":checked"))
        enableFile(fileid);
    else
        disableFile(fileid);
}

function enableFile(fileid)
{
    jQuery("#"+fileid+"_filename").css("color", "black");
}
function disableFile(fileid)
{
    jQuery("#"+fileid+"_filename").css("color", "gray");
}

function confirmIfExistFailedFile()
{
    if(window[ "isExistFailedFile" ])
        return confirm(__upload_msg_confirm1 + "\n" + __upload_msg_confirm2);
    else
        return true;
}

if(grn.browser.isSupportHTML5)
{
    var isCheck = false;
    var count = 0;
    var valid = 0;
    var t;

    function handleDrag(evt)
    {
        if(evt.dataTransfer.types[0].toString().indexOf('text') >= 0)
        {
            return;
        }

        evt.preventDefault();
        evt.stopPropagation();
        var type = evt.type;

        if(type == "drop") {
            jQuery("div.drop").each(function (index, e) {
                jQuery(e).removeClass("over");
            });
            jQuery("div.file_input_div").each(function (index, e) {
                jQuery(e).removeClass("drag_in");
            });
            isCheck = false;
            count = 0;
            valid = 0;
            clearTimeout(t);
            return;
        }

        if(type == "dragover") {
            jQuery("div.drop").each(function (index, e) {
                jQuery(e).addClass("over");
            });
            jQuery("div.file_input_div").each(function (index, e) {
                jQuery(e).addClass("drag_in");
            });
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
            jQuery("div.drop").each(function (index, e) {
                jQuery(e).removeClass("over");
            });
            jQuery("div.file_input_div").each(function (index, e) {
                jQuery(e).removeClass("drag_in");
            });
            isCheck = false;
            count = 0;
            valid = 0;
            clearTimeout(t);
        }
    }



    function traverseFiles (files,id_input_upload) {
        if (typeof files !== "undefined") {
            for (var i=0, l=files.length; i<l; i++) {
                fileUpload = new FileUpload(files[i],id_input_upload);
            }
        }
    }

    var DragDropFile = function(id)
    {
        this.filesUpload = document.getElementById("file_upload_"+id);
        this.dropArea = document.getElementById("drop_"+id);
        this.id = id;
        this.init();
    };

    DragDropFile.prototype.init = function(){
        window.addEventListener("dragover",handleDrag, false);
        window.addEventListener("drop",handleDrag, false);

        var self = this;
        this.filesUpload.addEventListener("change", function () {
            traverseFiles(this.files,self.id);
            self.filesUpload.value = "";
        }, false);

        this.dropArea.addEventListener("dragleave", function (evt) {
            evt.preventDefault();
            evt.stopPropagation();
        }, false);

        this.dropArea.addEventListener("dragenter", function (evt) {
            evt.preventDefault();
            evt.stopPropagation();
        }, false);

        this.dropArea.addEventListener("dragover", function (evt) {
            count++;
            evt.dataTransfer.dropEffect = "copy";
            evt.preventDefault();
            evt.stopPropagation();
        }, false);

        this.dropArea.addEventListener("drop", function (evt) {
            jQuery("div.drop").each(function (index, e) {
                jQuery(e).removeClass("over");
            });
            jQuery("div.file_input_div").each(function (index, e) {
                jQuery(e).removeClass("drag_in");
            });
            traverseFiles(evt.dataTransfer.files,self.id);
            evt.preventDefault();
            evt.stopPropagation();
        }, false);
    };

    // ************ Object FileUpload ***************** //
    html5_uploadStatuses = new Object();
    var FileUpload = function(file,id_input_upload){
        this.file = file;
        this.xhr = null;
        this.responseText = '';
        this.fid = null;
        this.started = false;
        this.id_input_upload = id_input_upload;
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
            this.xhr.upload.addEventListener("loadstart", function()
            {
                setTimeout(jQuery.proxy(self.checkRequest, self), 600000);
            }, false);
            this.xhr.upload.addEventListener("progress", function(e){ self.updateProgress(e,self.fid); }, false);
            this.xhr.upload.addEventListener("load", function(e){ self.endUpload(e,self.fid,self); }, false);
            this.xhr.upload.addEventListener("abort", function(){ self.closeXhr(self); }, false);
            this.xhr.upload.addEventListener("error", function(e){ self.errorUpload(e); }, false);
            this.xhr.ontimeout = function(){ alert('Request timed out.'); };

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
        data.append('file',this.file);
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
            jQuery("#"+fid+"_percent").html(((e.loaded / e.total)*100 ).toFixed() +"%");
            jQuery("#"+fid+"_progress").css("width", (e.loaded / e.total)*100 +"%");
        }
    };

    FileUpload.prototype.endUpload = function(){
        this.started = true;
    };

    FileUpload.prototype.endProcess = function() {
        if ( this.xhr )
        {
            if(this.xhr.responseText)
            {
                if(this.xhr.responseText == "COMPLETE")
                {
                    jQuery("#"+this.fid+"_progressItem").remove();
                    jQuery("#"+this.fid+"_percent").remove();
                    jQuery("#"+this.fid+"_message").remove();

                    //アップするかどうかのチェックボックスを作成
                    var self = this;
                    jQuery("#"+this.fid+"_check")
                        .html('<input type="checkbox" class="upload_checkbox" id="'+this.fid+'_checkbox" name="upload_fileids[]" value="'+this.fid+'" checked />')
                        .on('click', function(){ self.onChangeCheckBox(self.fid);});

                    //何故かChromeだとcheckedを付けていてもチェックがつかないことがあるので
                    //Javascriptで再度チェックをオンにする
                    jQuery("#"+this.fid+"_checkbox").prop("checked", true);

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

    FileUpload.prototype.onUploadOpen = function(fileid,filename,size){
        var self = this;
        filename = filename.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
        var row = document.getElementById('upload_table').insertRow(-1);
        row.id = "row_"+fileid;

        var cell1 = row.insertCell(-1);
        cell1.id = fileid+"_check";

        var cell2 = row.insertCell(-1);
        cell2.id = fileid+"_filename";
        cell2.innerHTML = filename+' ('+this._getSizeString(size)+')';

        var cell3 = row.insertCell(-1);
        cell3.id  = fileid+"_percent";

        var cell4 = row.insertCell(-1);
        cell4.id = fileid+"_progressItem";
        cell4.innerHTML = this._getProgressItem(fileid);

        var cell5 = row.insertCell(-1);
        cell5.id = fileid+"_message";
        cell5.style.whiteSpace = "nowrap";
        cell5.innerHTML = '<a href="#">'+__upload_msg_cancel+'</a>';
        cell5.addEventListener('click', function(e){ self.cancelUpload(e,fileid);}, false);

        //アップロード中であることをステータスに格納する
        this.startUpload(fileid);
    };

    FileUpload.prototype.onUploadComplete = function (fileid)
    {

    };

    FileUpload.prototype.randomString =function () {
        var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
        var string_length = 35;
        var randomstring = '';
        for (var i=0; i<string_length; i++) {
            var rnum = Math.floor(Math.random() * chars.length);
            randomstring += chars.substring(rnum,rnum+1);
        }
        if(this.id_input_upload)
        {
            randomstring = this.id_input_upload + '-' + randomstring;
        }
        return randomstring;
    };

    FileUpload.prototype._getProgressItem = function (fileid)
    {
        return  '<div style="border: 1px solid rgb(176, 176, 176); padding: 0; width: 300px; height: 10px;" id="div_'+fileid+'">'
            +'<div id="'+fileid+'_progress" style="width:0;background-color:lightgreen;height:100%;margin:0;"></div>'
            +'</div>';
    };

    FileUpload.prototype._getSizeString = function (size)
    {
        var suffix = new Array("B","KB","MB","GB","TB","PB","EB","ZB","YB");
        var idx = parseInt((String(size).length - 1)/3);
        var ret = (size / Math.pow(1024,idx)).toFixed(1) + suffix[idx];
        return ret.replace("\.0","");
    };

    //エラーが発生した場合に呼び出される
    FileUpload.prototype.onUploadError = function (fileid, errorcode)
    {
        isExistFailedFile = true;

        jQuery("#" + fileid + "_progressItem").html(this.createErrorMessageTag(
            this._createErrorMessageFromErrorCode(errorcode)
        ));

        jQuery("#" + fileid + "_percent").remove();
        jQuery("#" + fileid + "_message").remove();
        this.completeUpload(fileid);
    };

    FileUpload.prototype._createErrorMessageFromErrorCode = function (errorcode)
    {
        var message = "";
        if (errorcode == "ZEROBYTE_FILE") {
            message = __upload_msg_zerobyte_file;
        }
        else if (["INVALID_TICKET",
                "OVER_INI_SIZE",
                "OVER_FORM_SIZE",
                "NO_FILE"].indexOf(errorcode) !== -1) {
            message = __upload_msg_error + errorcode + __upload_msg_error_suffix;
        }
        else {
            message = __upload_msg_error + "PARTIAL" + __upload_msg_error_suffix;
        }

        return message;
    };

    FileUpload.prototype.createErrorMessageTag = function createErrorMessageTag(message)
    {
        return '<span style="color:red; font-weight:bold;">'+message+'</span>';
    };

    //非選択のファイルはグレーアウト
    FileUpload.prototype.onChangeCheckBox = function (fileid)
    {
        if(jQuery("#" +fileid+"_checkbox").is(":checked"))
            this.enableFile(fileid);
        else
            this.disableFile(fileid);
    };

    FileUpload.prototype.enableFile = function (fileid)
    {
        jQuery("#"+fileid+"_filename").css("color", "black");
    };

    FileUpload.prototype.disableFile = function (fileid)
    {
        jQuery("#"+fileid+"_filename").css("color", "gray");
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
            jQuery(form).find(":submit").each(
                function (index,node)
                {
                    node.disabled = disable;
                }
            );

            //通常のボタンで、onclick に submit と入っているもの
            jQuery(form).find(":button").each(
                function (index, node)
                {
                    try
                    {
                        if(node.onclick != undefined && node.onclick.toString().indexOf('submit') > 0)
                            node.disabled = disable;
                    }
                    catch(e)
                    {}
                }
            );
        }

        //GTM-1136
        jQuery("form span.aButtonSubmit-grn").each(
            function (index, node)
            {
                node_a = node.down('a');
                if(disable)
                {
                    var link_onclick = node_a.getAttribute('onclick');
                    if(link_onclick != '')
                    {
                        node_a.setAttribute('onclick_bk', link_onclick);
                        node_a.setAttribute('onclick', '');
                    }
                    jQuery(node).addClass('button_standard_disable_grn');
                    jQuery(node).removeClass('aButtonStandard-grn');
                }
                else
                {
                    var link_onclick_bk = node_a.getAttribute('onclick_bk');
                    if(link_onclick_bk != '')
                    {
                        node_a.setAttribute('onclick', link_onclick_bk);
                    }
                    jQuery(node).addClass('aButtonStandard-grn');
                    jQuery(node).removeClass('button_standard_disable_grn');
                }
            }
        );
        //End GTM-1136

        if (grn.component.button) {
            jQuery(".button1_main_grn, .button_submit_grn").each(
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