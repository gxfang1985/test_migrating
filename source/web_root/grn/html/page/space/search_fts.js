grn.base.namespace("grn.page.space.search_fts");

(function () {
    var G = grn.page.space.search_fts;
    var ParentSearchForm = grn.component.fts.SearchForm;

    G.SearchForm = function() {};
    G.SearchForm.prototype = jQuery.extend(new ParentSearchForm(), {
        initClient : function() {
            var searchRange = jQuery('#search-space-range');
            var spaceId = jQuery('#search-space-id');
            var categoryId = jQuery('#search-category-id');

            ParentSearchForm.prototype.initClient.apply(this);
            this.client_.addApp('space');
            this.client_.setSearchRange(searchRange.val());
            if ( searchRange.val() == "SPACE" && spaceId.val().length > 0 ) {
                this.client_.setSpaceId(spaceId.val());
            }
            if ( searchRange.val() == "ALL" && categoryId.val().length > 0 ) {
                this.client_.setSpaceCategoryId(categoryId.val());
            }
            if ( jQuery('#app_discussion').prop( "checked")) {
                this.client_.addSpaceApp('discussion');
            }
            if ( jQuery('#app_todo').prop( "checked") ) {
                this.client_.addSpaceApp('todo');
            }
            if ( jQuery('#search-target').length !== 0 && jQuery('#search-target').prop( "checked") ) {
                this.client_.setTarget(jQuery('#search-target').val());
            }
        }
    });
})();
