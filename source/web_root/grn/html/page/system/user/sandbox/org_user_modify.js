(function () {
    "use strict";

    grn.base.namespace("grn.page.system.user.sandbox.org_user_modify");

    jQuery("#sandbox_toggle_detail").bind("click", function () {
        var hideIcon = "icon_hide_element_b_grn", showIcon = "icon_show_element_b_grn";
        var toggleIcon = jQuery(this).find("span.icon_inline_grn");
        var viewTable = jQuery("table.view_table");

        if (toggleIcon.hasClass(hideIcon)) {
            toggleIcon.removeClass(hideIcon).addClass(showIcon);
            viewTable.hide();
        } else {
            toggleIcon.removeClass(showIcon).addClass(hideIcon);
            viewTable.show();
        }
    });
})();