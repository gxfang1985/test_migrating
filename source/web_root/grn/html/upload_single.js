//upload.jsの一部の関数を上書きする

//戻るボタンなどで戻って来た場合に既にアップしたファイルを取得する
function getUploadedTempFiles()
{
    //何もしない
}

if(grn.browser.isSupportHTML5)
{

    function traverseFiles (files) {
        if (typeof files !== "undefined" && files.length > 0) {
               fileUpload = new FileUpload(files[0]);
        }
    }

    DragDropFile.prototype.init = function(){
        window.addEventListener("dragover", handleDrag, false);
        window.addEventListener("drop", handleDrag, false);

        var self = this;
        this.filesUpload.addEventListener("change", function () {
            traverseFiles(this.files, self.id);
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
            jQuery("div.drop").each(function (i, e) {
                jQuery(e).removeClass("over");
            });
            jQuery("div.file_input_div").each(function (i, e) {
                jQuery(e).removeClass("drag_in");
            });
            traverseFiles(evt.dataTransfer.files, self.id);
            evt.preventDefault();
            evt.stopPropagation();
        }, false);
    };

    FileUpload.prototype.endProcess = function(control) {
        if ( this.xhr )
        {
            if(this.xhr.responseText == "COMPLETE")
            {
                jQuery("#" + this.fid + "_progressItem").remove();
                jQuery("#" + this.fid + "_percent").remove();
                jQuery("#" + this.fid + "_message").remove();
                jQuery("#" + this.fid + "_check").html('<input type="hidden" name="upload_fileids[]" value="' + this.fid + '" />');
                
                this.completeUpload(this.fid);
            }
            else
            {
                this.onUploadError(this.fid,this.xhr.responseText);
            }
            
            this.xhr.abort();
        }
    };

    FileUpload.prototype.onUploadOpen = function(fileid,filename,size,e){
        var self = this;
        var tmp_div = jQuery("<div id='tmpdiv'></div>");
        var tmp_div_text = tmp_div.text(filename);
        var escape_filename = tmp_div_text.html();
        var table = document.getElementById("upload_table");
        var elm;
        while (elm=table.firstChild)
            table.removeChild(elm);
        var row = document.getElementById("upload_table").insertRow(-1);
        row.id = 'row_'+fileid;
        var cell1 = row.insertCell(-1);
        cell1.id = fileid+"_check";

        var cell2 = row.insertCell(-1);
        cell2.id = fileid+"_filename";
        cell2.innerHTML = escape_filename+' ('+this._getSizeString(size)+')';
        
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
        
        this.startUpload(fileid);
    };
}