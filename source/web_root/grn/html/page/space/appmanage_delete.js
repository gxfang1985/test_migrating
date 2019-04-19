grn.base.namespace("grn.page.space.appmanage_delete");

(function()
{
    "use strict";

    var G = grn.page.space.appmanage_delete;

    G.init = function() {
        this.removeAppButton = grn.component.button("#remove_app_button").on("click", this.onSubmit.bind(this));
    };

    G.onSubmit = function () {
        if (jQuery("input[name='delete_method']:checked").val()) {
            this.removeAppButton.showSpinner();
            document.getElementById('appmanage_delete_form').submit();
        }
        else {
            document.getElementById('warning').style.display = "inline";
        }
    };

    G.onSelectDeleteMethod = function () {
        document.getElementById('warning').style.display = "none";
    };

    jQuery(function(){
        grn.page.space.appmanage_delete.init();
    });

})();
