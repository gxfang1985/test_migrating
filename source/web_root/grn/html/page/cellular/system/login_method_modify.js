(function () {
    "use strict";
    grn.base.namespace("grn.page.cellular.system.login_method_modify");

    jQuery(document).ready(function () {
        jQuery('#system_use_multi_repository').change(function () {
                var useMulti = jQuery(this);
                var rmid = jQuery('#rmid');
                var table = jQuery('#system_multi_repository_table');

                if (useMulti.prop('checked')) {
                    rmid.prop("disabled", true);
                    table.show();
                } else {
                    rmid.prop("disabled", false);
                    table.hide();
                }
            }
        ).change();
    });
})();
