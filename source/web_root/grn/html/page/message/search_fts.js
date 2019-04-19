grn.base.namespace("grn.page.message.search_fts");

(function () {
    var G = grn.page.message.search_fts;
    var ParentSearchForm = grn.component.fts.SearchForm;

    G.SearchForm = function() {};
    G.SearchForm.prototype = jQuery.extend(new ParentSearchForm(), {
        initClient : function() {
            ParentSearchForm.prototype.initClient.apply(this);
            this.client_.addApp('message');
            this.client_.setMessageFolderId(jQuery('#search-message-folder').val());
        },
        submitHandler : function(event) {
            var keyword = jQuery.trim(this.textElement_.val());
            var sender  = jQuery.trim(jQuery('#search-modifier').val());
            if( !keyword ) {
                if( !sender ) {
                    event.preventDefault();
                    return false;
                }
                this.setSQLSearchMode();
            }
        },
        onloadSearch : function() {
            var keyword   = jQuery.trim(this.textElement_.val());
            var modifier = jQuery.trim(jQuery('#search-modifier').val());

            if ( !keyword && !modifier ) {
                this.spinnerElement_.hide();
                this.emptyTextElement_.show();
            } else {
                this.emptyTextElement_.hide();
                if (!keyword) {
                    this.setSQLSearchMode();
                }
                this.handleMoreRead();
            }
        }
    });
})();
