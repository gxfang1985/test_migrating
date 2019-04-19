grn.base.namespace('grn.page.schedule.mobile.view');
(function ($) {
    "use strict";

    var G = grn.page.schedule.mobile.view;

    G.init = function () {
        //GTM-1684: toggle facility approval history
        $('#facility_approval_history_link')
            .find('.mobile_process_history_link_grn')
            .on('click', G.handleToggleFacilityApprovalHistory);
    };

    G.handleToggleFacilityApprovalHistory = function() {
        var $historyList = $('#facility_approval_history_list');
        var $icon = $('#facility_approval_history_link_icon');

        $historyList.toggle();
        $icon.toggleClass('mobile_arrow_inline_up_grn mobile_arrow_inline_down_grn');
    };

    $(document).on("pagecreate", G.init);
})(jQuery);