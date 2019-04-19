grn.base.namespace("grn.page.fts.search");

(function () {
    var G = grn.page.fts.search;
    var ParentSearchForm = grn.component.fts.SearchForm;

    G.SearchForm = function() {};
    G.SearchForm.prototype = jQuery.extend(new ParentSearchForm(), {
        initClient : function() {
            ParentSearchForm.prototype.initClient.apply(this);
            if ( jQuery('#app_mail').length !== 0 && jQuery('#app_mail').prop( "checked" ) ) {
                this.client_.addApp('mail');
            }
            if ( jQuery('#app_cabinet').length !== 0 && jQuery('#app_cabinet').prop( "checked" ) ) {
                this.client_.addApp('cabinet');
            }
            this.client_.setCabinetFolderId(1); // root folder
            if ( jQuery('#app_bulletin').length !== 0 && jQuery('#app_bulletin').prop( "checked" ) ) {
                this.client_.addApp('bulletin');
            }
            this.client_.setBulletinCategoryId(1); // root category
            if ( jQuery('#app_message').length !== 0 && jQuery('#app_message').prop( "checked" ) ) {
                this.client_.addApp('message');
            }
            if ( jQuery('#app_space').length !== 0 && jQuery('#app_space').prop( "checked" ) ) {
                this.client_.addApp('space');
            }
            if ( this.enableModifier_ ) {
                this.client_.setSender(jQuery('#search-modifier').val());
            }
        }
    });
})();
