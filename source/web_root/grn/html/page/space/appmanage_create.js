grn.base.namespace("grn.page.space.appmanage_create");

(function () {
    "use strict";

    var G = grn.page.space.appmanage_create;

    G.init = function () {
        var buttonAdd = grn.component.button("#app_create");
        var $appNameInput = jQuery("#appname");

        $appNameInput.keyup(function () {
            var name = $appNameInput.val().replace(/^[\s　]+|[\s　]+$/g, "");
            var length = name.length;

            if (0 < length && length < 65) {
                buttonAdd.enable();
            } else {
                buttonAdd.disable();
            }
        });
    };

    jQuery(document).ready(G.init.bind(G));
})();
