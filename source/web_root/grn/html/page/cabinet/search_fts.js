grn.base.namespace("grn.page.cabinet.search_fts");

(function () {
    var G = grn.page.cabinet.search_fts;
    var ParentSearchForm = grn.component.fts.SearchForm;

    G.SearchForm = function() {};
    G.SearchForm.prototype = jQuery.extend(new ParentSearchForm(), {
        initClient : function() {
            ParentSearchForm.prototype.initClient.apply(this);
            this.client_.addApp('cabinet');
            this.client_.setCabinetFolderId(jQuery('#search-cabinet-follder').val());
            if ( jQuery('#search-target').length !== 0 && jQuery('#search-target').prop( "checked" ) ) {
                this.client_.setTarget(jQuery('#search-target').val());
            }

            var  chkFile = jQuery('#scope-file-button');
            var  chkFolder = jQuery('#scope-folder-button');
            chkFile.on("change", this.handleScopeSelectChange.bind(this, chkFile));
            chkFolder.on("change", this.handleScopeSelectChange.bind(this, chkFolder));
            this.handleScopeSelectChange(chkFile);

            this.client_.setFileOnly(true);
        },
        appendDocument : function(doc) {
            var chkFolder = jQuery('#scope-folder-button');
            if (chkFolder.prop( "checked" )) {
                var resultDiv = document.createElement('div');
                resultDiv.setAttribute('class', "search-listBlock-grn");

                var folderDiv = document.createElement('div');
                folderDiv.setAttribute('class', "search-listTitle-grn");

                var folderImg = document.createElement('img');
                folderImg.setAttribute('class', "search-listAttachmentIcon-grn");
                folderImg.setAttribute('src', doc.folder_icon);

                var folderA = document.createElement('a');
                folderA.setAttribute('class', "search-listAttachment-grn");
                folderA.setAttribute('href', doc.folder_link);

                var folderNameSpan = document.createElement('span');
                folderNameSpan.setAttribute('class', "search-result-snippet");
                folderNameSpan.innerHTML = doc.folder_name;

                folderA.appendChild(folderImg);
                folderA.appendChild(folderNameSpan);
                folderDiv.appendChild(folderA);
                resultDiv.appendChild(folderDiv);

                if (doc.parent_folder_path != '') {
                    var parent_folderDiv = document.createElement('div');
                    parent_folderDiv.setAttribute('class', "search-listTitle-grn");

                    var appImg = document.createElement('img');
                    appImg.setAttribute('class', "search-listAttachmentIcon-grn");
                    appImg.setAttribute('src', doc.app_icon);

                    var parent_folderA = document.createElement('a');
                    parent_folderA.setAttribute('class', "search-listAttachment-grn");
                    parent_folderA.setAttribute('href', doc.parent_folder_link);

                    var parent_folderNameSpan = document.createElement('span');
                    parent_folderNameSpan.setAttribute('class', "search-result-snippet");
                    parent_folderNameSpan.innerHTML = doc.parent_folder_path;

                    var blank_str = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    var parent_indent = document.createElement('span');
                    parent_indent.setAttribute('class', "search-result-snippet");
                    parent_indent.innerHTML = blank_str;

                    parent_folderA.appendChild(appImg);
                    parent_folderA.appendChild(parent_folderNameSpan);
                    parent_folderDiv.appendChild(parent_indent);
                    parent_folderDiv.appendChild(parent_folderA);
                    resultDiv.appendChild(parent_folderDiv);
                }

                this.resultElement_[0].appendChild(resultDiv);
            }
            else {
                ParentSearchForm.prototype.appendDocument.apply(this,[doc]);
            }
        },
        handleScopeSelectChange : function(obj) {
            if (obj.val() == "file" && obj.prop("checked")) {
                jQuery('.search-conditionSort-grn').show();
                jQuery('.search-conditionFileApp-grn').show();
                jQuery('.search-otherCondition-grn').show();
            }
            else {
                jQuery('.search-conditionSort-grn').hide();
                jQuery('.search-conditionFileApp-grn').hide();
                jQuery('.search-otherCondition-grn').hide();
            }
        },
        onloadSearch: function () {
            if (!jQuery.trim(this.textElement_.val())) {
                this.spinnerElement_.hide();
                this.emptyTextElement_.show();
            } else {
                var chkFolder = jQuery('#scope-folder-button');
                if (chkFolder.prop( "checked" )) {
                    this.setSQLSearchMode();
                }
                this.emptyTextElement_.hide();
                this.handleMoreRead();
            }
        }
    });
})();
