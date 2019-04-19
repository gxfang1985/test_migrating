grn.base.namespace("grn.page.bulletin.search_fts");

(function () {
    var G = grn.page.bulletin.search_fts;
    var ParentSearchForm = grn.component.fts.SearchForm;

    G.SearchForm = function() {};
    G.SearchForm.prototype = jQuery.extend(new ParentSearchForm(), {
        initClient : function() {
            ParentSearchForm.prototype.initClient.apply(this);
            this.client_.addApp('bulletin');
            this.client_.setBulletinCategoryId(jQuery('#bulletin-search-category').val());
            if ( jQuery('#search-target').length !== 0 && jQuery('#search-target').prop( "checked" ) ) {
                this.client_.setTarget(jQuery('#search-target').val());
            }

            var  chkTopic = jQuery('#scope-topic-button');
            var  chkCategory = jQuery('#scope-category-button');
            chkTopic.on("change", this.handleScopeSelectChange.bind(this, chkTopic));
            chkCategory.on("change", this.handleScopeSelectChange.bind(this, chkTopic));
            this.handleScopeSelectChange(chkTopic);
        },
        appendDocument : function(doc) {
            var chkCategory = jQuery('#scope-category-button');
            if (chkCategory.prop( "checked" )) {
                var resultDiv = document.createElement('div');
                resultDiv.setAttribute('class', "search-listBlock-grn");

                var categoryDiv = document.createElement('div');
                resultDiv.setAttribute('class', "search-listTitle-grn");

                var categoryImg = document.createElement('img');
                categoryImg.setAttribute('class', "search-listAttachmentIcon-grn");
                categoryImg.setAttribute('src', doc.category_icon);

                var categoryA = document.createElement('a');
                categoryA.setAttribute('class', "search-listAttachment-grn");
                categoryA.setAttribute('href', doc.category_link);

                var categoryNameSpan = document.createElement('span');
                categoryNameSpan.setAttribute('class', "search-result-snippet");
                categoryNameSpan.innerHTML = doc.category_name;

                categoryA.appendChild(categoryImg);
                categoryA.appendChild(categoryNameSpan);
                categoryDiv.appendChild(categoryA);
                resultDiv.appendChild(categoryDiv);

                if (doc.parent_category_path != '')
                {
                    var parent_categoryDiv = document.createElement('div');
                    parent_categoryDiv.setAttribute('class', "search-listTitle-grn");

                    var appImg = document.createElement('img');
                    appImg.setAttribute('class', "search-listAttachmentIcon-grn");
                    appImg.setAttribute('src', doc.app_icon);

                    var parent_categoryA = document.createElement('a');
                    parent_categoryA.setAttribute('class', "search-listAttachment-grn");
                    parent_categoryA.setAttribute('href', doc.parent_category_link);

                    var parent_categoryNameSpan = document.createElement('span');
                    parent_categoryNameSpan.setAttribute('class', "search-result-snippet");
                    parent_categoryNameSpan.innerHTML = doc.parent_category_path;

                    var blank_str = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

                    var parent_indent = document.createElement('span');
                    parent_indent.setAttribute('class', "search-result-snippet");
                    parent_indent.innerHTML = blank_str;

                    parent_categoryA.appendChild(appImg);
                    parent_categoryA.appendChild(parent_categoryNameSpan);
                    parent_categoryDiv.appendChild(parent_indent);
                    parent_categoryDiv.appendChild(parent_categoryA);
                    resultDiv.appendChild(parent_categoryDiv);
                }

                this.resultElement_[0].appendChild(resultDiv);
            }
            else
            {
                ParentSearchForm.prototype.appendDocument.apply(this,[doc]);
            }
        },
        handleScopeSelectChange : function(obj) {
            if (obj.val() == "topic" && obj.prop( "checked" ))
            {
                jQuery('.search-conditionSort-grn').show();
                jQuery('.search-conditionFileApp-grn').show();
                jQuery('.search-otherCondition-grn').show();
                jQuery('.search-conditionTitleApp-grn').show();
                jQuery('.search-conditionsPartition-grn').show();
            }
            else
            {
                jQuery('.search-conditionSort-grn').hide();
                jQuery('.search-conditionFileApp-grn').hide();
                jQuery('.search-otherCondition-grn').hide();
                jQuery('.search-conditionTitleApp-grn').hide();
                jQuery('.search-conditionsPartition-grn').hide();
            }
        },
        onloadSearch: function () {
            if (!jQuery.trim(this.textElement_.val())) {
                this.spinnerElement_.hide();
                this.emptyTextElement_.show();
            } else {
                var chkCategory = jQuery('#scope-category-button');
                if (chkCategory.prop( "checked" )) {
                    this.setSQLSearchMode();
                }
                this.emptyTextElement_.hide();
                this.handleMoreRead();
            }
        }
    });
})();
