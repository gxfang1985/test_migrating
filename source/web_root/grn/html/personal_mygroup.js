(function($) {
    "use strict";
    $(function() {
        $("#my_group_button_save").on("click", function() {
            if (grn.base.isNamespaceDefined("grn.component.member_add")) {
                var member_select = grn.component.member_add.get_instance("member_select");
                if (member_select) {
                    member_select.prepareSubmit();
                }
            }
            if (grn.base.isNamespaceDefined("grn.component.facility_add")) {
                var facility_select = grn.component.facility_add.get_instance("facility_select");
                if (facility_select) {
                    facility_select.prepareSubmit();
                }
            }
            grn.component.button.util.submit(this);
        });
    });
})(jQuery);