(function ($) {
    "use strict";
    grn.base.namespace("grn.base.system.application.change_allow_application");

    $(function() {
        var app_list = jQuery("#application_list");
        app_list.on("click", "input[name='appIds[]']", function (event) {
            var $target = $(event.target);
            var ext_checkbox = app_list.find("#ext_" + $target.prop("id"));
            if ($target.prop("checked") === true) {
                ext_checkbox.prop("disabled", false);
            }
            else {
                ext_checkbox.prop("checked", false ).prop("disabled", true);
            }
        });
        app_list.find("input[name='appIds[]']").each(function () {
            if (!$(this).prop("checked")) {
                app_list.find("#ext_" + $(this).prop("id")).prop("checked", false).prop("disabled", true);
            }
        });
    });

})(jQuery);
