grn.base.namespace("grn.page.schedule.adjust_link");
(function() {
    "use strict";
    var adjust_link = grn.page.schedule.adjust_link;
    adjust_link.adjust_submit = function (form_name, action_page_name) {
        var f = document.forms[form_name];
        var member_select = grn.component.member_add.get_instance("member_select");
        member_select.prepareSubmit();
        var facility_select = grn.component.facility_add.get_instance("facility_select");
        facility_select.prepareSubmit();
        f.target = '_self';
        f.action = action_page_name;
        f.submit();
    };
})();
