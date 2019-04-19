grn.base.namespace("grn.page.schedule.view");

(function ($) {
    "use strict";

    var G = grn.page.schedule.view;

    G.init = function () {
        $("#history_link").on("click", G.handleToggleFacilityApprovalHistory);
        grn.component.button("#schedule_button_post").on("click", function() {
            var form = document.getElementById("follow");
            form.submit();
        });
    };

    G.handleToggleFacilityApprovalHistory = function () {
        $("#history_balloon_inline, #history_table").toggle();
        $("#history_icon_inline").toggleClass("icon_show_element_b_grn icon_hide_element_b_grn");
    };

    $(document).ready(G.init);
})(jQuery);
