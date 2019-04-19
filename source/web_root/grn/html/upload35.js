//Flashプラグインが存在すればFlashコンテンツを表示、
//そうでなければ通常のファイル選択フォームを表示
function upload_init(id)
{
    if(grn.browser.isSupportHTML5)
    {
        document.getElementById("html5_content_" + id).style.display = "";
        jQuery("#not_support_html5_content_" + id).remove();
    }
    else
    {
        document.getElementById("not_support_html5_content_" + id).style.display = "";
        jQuery("#html5_content_" + id).remove();
    }
}

//戻るボタンなどでページを移動した際に、既にアップしたファイルを取得する
function getUploadedTempFiles(id)
{
    jQuery.ajax(
        __af[id].upload_files_url,
        {
            type: "post",
            data: "upload_ticket="+__af[id].upload_ticket,
            success: function (data, textStatus, request)
            {
                //tableのinnerHTMLを直接変更できないためdivエレメント作成
                var uploadTable = document.getElementById('upload_table_' + id);
                var tableHTML = "<table><tbody><tr><td></td></tr></tbody></table>";
                if (request.responseText != undefined && request.responseText.length > 0 )
                {
                    tableHTML = "<table>"+request.responseText+"</table>";
                }
                var divElem = document.createElement('div');
                divElem.innerHTML = tableHTML;
                var tableElem = divElem.firstChild;
                var childElem;

                //clear table
                while( childElem = uploadTable.firstChild )
                    uploadTable.removeChild( childElem );

                //append attached files
                while( childElem = tableElem.firstChild )
                    uploadTable.appendChild( childElem );
            },
            error: function(request)
            {
            }
        }
        );
}

//非選択のファイルはグレーアウト
function onChangeCheckBox(fileid)
{
    if(document.getElementById(fileid+"_checkbox").checked)
        enableFile(fileid);
    else
        disableFile(fileid);
}

function enableFile(fileid)
{
    document.getElementById(fileid+"_filename").style.color = 'black';
}
function disableFile(fileid)
{
    document.getElementById(fileid+"_filename").style.color = 'gray';
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
            jQuery('div.drop').each(function(idx, e){
                jQuery(e).removeClass("over_space");
            });
            jQuery('div.file_input_div').each(function(idx, e){
                jQuery(e).removeClass("drag_in");
            });
            isCheck = false;
            count = 0;
            valid = 0;
            clearTimeout(t);
            return;
        }

        if(type == "dragover") {

            for(var i=array_list.length-1; i>=0; i--)
            {
                var drop_area_space = array_list[i];
                if(array_list[i].toString().indexOf('reply') >= 0)
                {
                    drop_area_space = 'reply';
                }

                if(i>0)
                {
                    if(document.getElementById(drop_area_space+ '_dialog'))
                    {
                        if(document.getElementById(drop_area_space+ '_dialog').style.display != 'none')
                        {
                            jQuery('#'+'drop_'+array_list[i]).addClass("over_space");
                            jQuery('#'+'file_input_div_'+array_list[i]).addClass("drag_in");
                            break;
                        }
                    }
                }
                else
                {
                    jQuery('#'+'drop_'+array_list[i]).addClass("over_space");
                    jQuery('#'+'file_input_div_'+array_list[i]).addClass("drag_in");
                }
            }
            
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
            jQuery('div.drop').each(function(idx, e){
                jQuery(e).removeClass("over_space");
            });
            jQuery('div.file_input_div').each(function(idx, e){
                jQuery(e).removeClass("drag_in");
            });
            isCheck = false;
            count = 0;
            valid = 0;
            clearTimeout(t);
        }
    }
    
    window.addEventListener("dragover",handleDrag, false);
    window.addEventListener("drop",handleDrag, false);

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
            jQuery('div.drop').each(function(idx, e){
                jQuery(e).removeClass("over_space");
            });
            jQuery('div.file_input_div').each(function(idx, e){
                jQuery(e).removeClass("drag_in");
            });
            traverseFiles(evt.dataTransfer.files,self.id);
            evt.preventDefault();
            evt.stopPropagation();
        }, false);
    };
    
    // ************ Object FileUpload ***************** //
    var FileUpload = function(file,id_input_upload){
        this.file = file;
        this.xhr = null;
        this.responseText = '';
        this.fid = null;
        this.started = false;
        this.uploadStatuses = new Object();
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

        jQuery("#"+"row_"+fileid).remove();
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
                var t = setTimeout(jQuery.proxy(self.checkRequest,self),600000);
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
        data.append('file',this.file);
        this.xhr.open("POST", __upload_url,true);
        
        this.xhr.setRequestHeader("X-File-Name", escape(this.file.name));
        this.xhr.setRequestHeader("X-File-Type", this.file.type);
        this.xhr.setRequestHeader("X-File-Size", this.file.size);
        this.xhr.setRequestHeader("X-File-Id", fid);
        this.xhr.setRequestHeader("X-File-Upload-Ticket", __af[this.id_input_upload].upload_ticket);

        this.xhr.send(data);
    };

    FileUpload.prototype.updateProgress = function(e,fid) {
        this.started = true;
        if (e.lengthComputable)
        {
            document.getElementById(fid+"_percent").innerHTML = ((e.loaded / e.total)*100 ).toFixed() +"%";
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
                    jQuery("#"+this.fid+"_progressItem").remove();
                    jQuery("#"+this.fid+"_percent").remove();
                    jQuery("#"+this.fid+"_message").remove();

                    //アップするかどうかのチェックボックスを作成
                    document.getElementById(this.fid+"_check").innerHTML = '<input type="checkbox" class="upload_checkbox" id="'+this.fid+'_checkbox" name="upload_fileids[]" value="'+this.fid+'" checked />';
                    var self = this;
                    document.getElementById(this.fid+"_check").addEventListener('click', function(e){ self.onChangeCheckBox(self.fid);}, false);

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
        filename = filename.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');

        var row = document.getElementById('upload_table_'+this.id_input_upload).insertRow(-1);
        row.id = 'row_'+fileid;

        var cell1 = row.insertCell(-1);
        cell1.id = fileid+"_check";

        var cell2 = row.insertCell(-1);
        cell2.id = fileid+"_filename";
        var innner;
        var width = '';
        if (__af[this.id_input_upload].filename_width)
        {
            width = 'width:' + __af[this.id_input_upload].filename_width + 'px;';
        }

        inner = '<div id="' + fileid + '_filename_inner" style="white-space:nowrap;overflow:hidden;' + width + '">'
            + this._getStringShow(filename+' ('+this._getSizeString(size)+')') +'</div>';
        cell2.innerHTML = inner;
        
        var cell3 = row.insertCell(-1);
        cell3.id  = fileid+"_percent";
        
        var cell4 = row.insertCell(-1);
        cell4.id = fileid+"_progressItem";
        cell4.innerHTML = this._getProgressItem(fileid);
        
        var cell5 = row.insertCell(-1);
        cell5.id = fileid+"_message";
        cell5.style.whiteSpace = "nowrap";
        cell5.innerHTML = '<a href="#">'+__upload_msg_cancel+'</a>';
        cell5.addEventListener('click', function(e){ self.cancelUpload(e,self.fid);}, false);
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
        var wd = __af[this.id_input_upload].progressbar_width + "px";
        return  '<div style="border: 1px solid rgb(176, 176, 176); padding: 0px; width: ' + wd + '; height: 10px;" id="div_'+fileid+'">'
                    +'<div id="'+fileid+'_progress" style="width:0%;background-color:lightgreen;height:100%;margin:0;"></div>'
                +'</div>';
    };

    FileUpload.prototype._getSizeString = function (size)
    {
        suffix = new Array("B","KB","MB","GB","TB","PB","EB","ZB","YB");
        idx = parseInt((String(size).length - 1)/3);
        ret = (size / Math.pow(1024,idx)).toFixed(1) + suffix[idx];
        return ret.replace("\.0","");
    };
    
    FileUpload.prototype._getStringShow = function (filename)
    {
        if(filename.length > 25)
        {
            return filename.substr(0,22) + "...";
        }
        return filename;
    };

    //エラーが発生した場合に呼び出される
    FileUpload.prototype.onUploadError = function (fileid, errorcode)
    {
        isExistFailedFile = true;
        if(errorcode == "ZEROBYTE_FILE")
            document.getElementById(fileid + "_progressItem").innerHTML = this.createErrorMessageTag( __upload_msg_zerobyte_file );
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

        jQuery("#" + fileid + "_percent").remove();
        jQuery("#" + fileid + "_message").remove();
        this.completeUpload(fileid);
    };

    FileUpload.prototype.createErrorMessageTag = function createErrorMessageTag(message)
    {
        return '<span style="color:red; font-weight:bold;">'+message+'</span>';
    };

    //非選択のファイルはグレーアウト
    FileUpload.prototype.onChangeCheckBox = function (fileid)
    {
        if(document.getElementById(fileid+"_checkbox").checked)
            this.enableFile(fileid);
        else
            this.disableFile(fileid);
    };
    
    FileUpload.prototype.enableFile = function (fileid)
    {
        document.getElementById(fileid+"_filename").style.color = 'black';
    };

    FileUpload.prototype.disableFile = function (fileid)
    {
        document.getElementById(fileid+"_filename").style.color = 'gray';
    };

    FileUpload.prototype.startUpload = function (fileid)
    {
        __af[this.id_input_upload].upload_status[fileid] = true;
        
        if (__af[this.id_input_upload].filename_width)
        {
            for(var i in __af[this.id_input_upload].upload_status)
            {
                var fileName = document.getElementById(i + '_filename_inner');
                if (fileName)
                {
                    fileName.style.width = __af[this.id_input_upload].filename_width;
                }
            }
        }
        
        //全ての submit ボタンを disable
        for(var i in document.forms)
        {
            this.toggleButtons(true);
        }
    };

    FileUpload.prototype.completeUpload = function (fileid)
    {
        __af[this.id_input_upload].upload_status[fileid] = false;

        var uploadingFlag = false;
        for(var i in __af[this.id_input_upload].upload_status)
        {
            uploadingFlag |= __af[this.id_input_upload].upload_status[i];
        }

        //全てアップロードし終えてる
        if(!uploadingFlag)
        {
            if (__af[this.id_input_upload].filename_width)
            {
                for(var i in __af[this.id_input_upload].upload_status)
                {
                    var fileName = document.getElementById(i + '_filename_inner');
                    if (fileName)
                    {
                        fileName.style.width = document.getElementById('upload_table_' + this.id_input_upload).offsetWidth - 240;
                    }
                }
            }
            
            this.toggleButtons(false);
        }
    };

    FileUpload.prototype.toggleButtons = function (disable)
    {
        for(var i = 0; i < document.forms.length; i++)
        {
            var form = document.forms[i];
            
            //submit ボタン
            jQuery(form).find(':submit').each(
                function (idx, node)
                {
                    node.disabled = disable;
                }
            );
            
            //通常のボタンで、onclick に submit と入っているもの
            jQuery(form).find(':button').each(
                function (idx, node)
                {
                    try
                    {
                        if((node.onclick != undefined && node.onclick.toString().indexOf('submit') > 0) || node.name == 'send')
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
