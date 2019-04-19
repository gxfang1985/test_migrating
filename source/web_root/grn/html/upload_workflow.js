//upload.jsの一部の関数を上書きする

//Flashプラグインが存在すればFlashコンテンツを表示、
//そうでなければ通常のファイル選択フォームを表示
function upload_init()
{
    if(grn.browser.isSupportHTML5)
    {
        jQuery("div.not_support_html5_content").each(
            function ()
            {
                jQuery(this).html("");
            });
        jQuery("div.html5_content").each(
            function (index, node)
            {
                node.style.display = "";
            });
    }
    else
    {
        jQuery("div.not_support_html5_content").each(
            function (index, node)
            {
                node.style.display = "";
            });
        jQuery("div.html5_content").each(
            function ()
            {
                jQuery(this).html("");
            });
    }
}

function onChangeCheckBox(fileid)
{
    if(jQuery("#" + fileid+"_checkbox").prop("checked"))
        enableFile(fileid);
    else
        disableFile(fileid);
    
    name = getInputName(fileid);
    //選択しているファイルの個数が__upload_file_max_count個だったら
    //それ以上選択できないようにする。
    count = 0;
    jQuery('input.upload_checkbox_'+name).each(
        function(index,node)
        {
            if(node.checked)
                count++;
        });
    
    max = eval('__upload_max_file_count_'+name);
    if(count >= max)
    {
        jQuery('input.upload_checkbox_'+name).each(
            function(index,node)
            {
                if(!node.checked)
                    node.disabled = true;
            });
    }
    else
    {
        jQuery('input.upload_checkbox_'+name).each(
            function(index,node)
            {
                node.disabled = false;
            });
    }
}

function getInputName(fileid)
{
    //fileidの先頭から最初のハイフンまでがinput_nameを表す
    return fileid.split('-')[0];
}

if(grn.browser.isSupportHTML5)
{
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
            jQuery('div.drop').each(function(i,e){
                jQuery(e).removeClass("over");
            });
            isCheck = false;
            count = 0;
            valid = 0;
            clearTimeout(t);
            return;
        }

        if(type == "dragover") {
            jQuery('div.drop').each(function(i,e){
                jQuery(e).addClass("over");
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
            jQuery('div.drop').each(function(i,e){
                jQuery(e).removeClass("over");
            });
            isCheck = false;
            count = 0;
            valid = 0;
            clearTimeout(t);
        }
    }
    
    DragDropFile.prototype.init = function(){
        window.addEventListener("dragover",handleDrag, false);
        window.addEventListener("drop",handleDrag, false);
        
        var self = this;
        this.filesUpload.addEventListener("change", function () {
            traverseFiles(this.files,self.id);
            self.filesUpload.value = "";
        }, false);

        this.dropArea.addEventListener("dragleave", function (evt) {
            jQuery(self.dropArea).removeClass("drag_over");
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
            jQuery(self.dropArea).addClass("drag_over");
            evt.preventDefault();
            evt.stopPropagation();
        }, false);

        this.dropArea.addEventListener("drop", function (evt) {
            jQuery('div.drop').each(function(i,e){
                jQuery(e).removeClass("over");
                jQuery(e).removeClass("drag_over");
            });
            traverseFiles(evt.dataTransfer.files,self.id);
            evt.preventDefault();
            evt.stopPropagation();
        }, false);
    };
    
    FileUpload.prototype.onUploadOpen = function(fileid,filename,size,e){
        var self = this;
        filename = filename.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;");

        var row = document.getElementById('upload_table_'+this.id_input_upload).insertRow(-1);
        row.id = 'row_'+fileid;

        var cell1 = row.insertCell(-1);
        cell1.style.width = 1;
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
        cell5.addEventListener('click', function(e){ self.cancelUpload(e,self.fid);}, false);
        this.startUpload(fileid);
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
                    document.getElementById(this.fid+"_check").innerHTML = '<input type="checkbox" class="upload_checkbox_'+this.id_input_upload+'" id="'+this.fid+'_checkbox" name="upload_fileids[]" value="'+this.fid+'"/>';
                    var self = this;
                    document.getElementById(this.fid+"_check").addEventListener('click', function(e){ self.onChangeCheckBox(self.fid);}, false);
                    
                    //選択しているファイルの個数が__upload_file_max_count個だったら
                    //それ以上選択できないようにする。
                    count = 0;
                    jQuery('input.upload_checkbox_'+this.id_input_upload).each(
                        function(index,node)
                        {
                            if(node.checked)
                            {
                                count++;
                                self.enableFile(self.fid);
                            }
                        });

                    max = eval('__upload_max_file_count_'+this.id_input_upload);
                    if(count < max)
                    {
                        jQuery("#"+this.fid+"_checkbox").prop("checked", true);
                        
                        if(count+1 == max)
                        {
                            jQuery('input.upload_checkbox_'+this.id_input_upload).each(
                                function(index,node)
                                {
                                    if(!node.checked)
                                    {
                                        node.disabled = true;
                                        var fileid = node.id.replace('_checkbox', '');
                                        self.disableFile(fileid);
                                    }
                                });
                        }
                    }
                    else
                    {
                        jQuery("#"+this.fid+"_checkbox").prop("disabled",true);
                        this.disableFile(this.fid);
                    }

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
    
    FileUpload.prototype.onChangeCheckBox = function (fileid)
    {
        if(jQuery("#"+fileid+"_checkbox").prop("checked"))
            this.enableFile(fileid);
        else
            this.disableFile(fileid);
        
        //選択しているファイルの個数が__upload_file_max_count個だったら
        //それ以上選択できないようにする。
        count = 0;
        jQuery('input.upload_checkbox_'+this.id_input_upload).each(
            function(index,node)
            {
                if(node.checked)
                    count++;
            });
        
        max = eval('__upload_max_file_count_'+this.id_input_upload);
        if(count >= max)
        {
            jQuery('input.upload_checkbox_'+this.id_input_upload).each(
                function(index,node)
                {
                    if(!node.checked)
                        node.disabled = true;
                });
        }
        else
        {
            jQuery('input.upload_checkbox_'+this.id_input_upload).each(
                function(index,node)
                {
                    node.disabled = false;
                });
        }
    };
    
    FileUpload.prototype.cancelUpload = function(e,fileid){
        e.preventDefault();
        if ( this.xhr ){
            this.endProcess(0);
        }
        
        jQuery("#row_"+fileid).remove();
        this.completeUpload(fileid);
    };
}