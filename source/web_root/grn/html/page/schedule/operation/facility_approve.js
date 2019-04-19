(function ($) {
    if (grn.base.isNamespaceDefined("grn.page.schedule.operation.facility_approve")) {
        return;
    }
    grn.base.namespace("grn.page.schedule.operation.facility_approve");
    grn.page.schedule.operation.facility_approve.OperationFacilityApprove = function () {
    };
    var instance = grn.page.schedule.operation.facility_approve.OperationFacilityApprove;
    instance.Parameters = {};
    //Init function
    instance.prototype = {
        formSubmitApprove: function (target) {
            jQuery("form" + target).append(jQuery("<input name=\"approve\" type=\"hidden\" value=\"1\"/>"))
                .submit();
        },
        formSubmitReject: function (target) {
            jQuery("form" + target).append(jQuery("<input name=\"approve\" type=\"hidden\" value=\"0\"/>"))
                .submit();
        },
        backToNotification: function () {
            window.location.href = instance.Parameters.mobileNotificationPage;
        }
    };

})(jQuery);

jQuery(document).ready(function () {
    var instance = new grn.page.schedule.operation.facility_approve.OperationFacilityApprove();
    jQuery("#linkApprove").on("click", function () {
        instance.formSubmitApprove("#formFacilityApprove");
    });

    jQuery("#linkReject").on("click", function () {
        instance.formSubmitReject("#formFacilityApprove");
    });

    //on mobile view screen
    jQuery("input[type=submit]").bind("tap", function (e) {
        instance.formSubmitApprove("#formFacilityApprove");
        e.preventDefault();
    });

    jQuery("input[type=reset]").bind("tap", function (e) {
        instance.formSubmitReject("#formFacilityApprove");
        e.preventDefault();
    });

    jQuery("div.mobile_breadcrumbtitle_left_grn> a.mobile_breadcrumbtitle_back_grn").bind("tap", function (e) {
        instance.backToNotification();
        e.preventDefault();
    });
});
