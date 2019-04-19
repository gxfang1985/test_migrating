grn.base.namespace("grn.page.schedule.system.facility_set");

(function($)
{
    "use strict";
    var G = grn.page.schedule.system.facility_set;

    G.noticeMessage = null;
    G.confirmDialogTitle = null;
    G.confirmDialogAsyncURL = null;
    G.facilityGroupId = null;
    G.facilityId = null;

    $(document).ready(function () {
        $("#advance_select").on("change", changeAdvanceStatus);
        $("#apply_from_parent").on("click", changeItemStatus);
        changeItemStatus();

        $("#confirm_privilege").on("click", function () {
            var windowSimpleDialog = new grn.component.WindowSimpleDialog();
            var asyncParams = {"facility_group_id": G.facilityGroupId, "facility_id": G.facilityId};
            windowSimpleDialog.initialize(G.confirmDialogTitle, "post", G.confirmDialogAsyncURL, asyncParams);
            windowSimpleDialog.openDialog();
        });
    });

    var changeItemStatus = function () {
        var applyFromParent = $("#apply_from_parent");
        if (applyFromParent.length > 0) {
            if (applyFromParent.is(":checked")) {
                $("#advance_select").attr("disabled", "disabled");
                $("#advance").attr("disabled", "disabled");
                $("#max_time_1").attr("disabled", "disabled");
                $("#max_time_2").attr("disabled", "disabled");
                $("#scheduled_time_hour").attr("disabled", "disabled");
                $("#scheduled_time_minute").attr("disabled", "disabled");
                $("#creator").attr("disabled", "disabled");
                $("#member").attr("disabled", "disabled");
                $("#grantUser").attr("disabled", "disabled");
                $("#show_memo").attr("disabled", "disabled");
                $("#regularly").attr("disabled", "disabled");
                $("#approval").attr("disabled", "disabled");
            }
            else {
                $("#advance_select").prop("disabled", false);
                $("#advance").prop("disabled", false);
                $("#max_time_1").prop("disabled", false);
                $("#max_time_2").prop("disabled", false);
                $("#scheduled_time_hour").prop("disabled", false);
                $("#scheduled_time_minute").prop("disabled", false);
                $("#creator").prop("disabled", false);
                $("#member").prop("disabled", false);
                $("#grantUser").prop("disabled", false);
                $("#show_memo").prop("disabled", false);
                $("#regularly").prop("disabled", false);
                $("#approval").prop("disabled", false);
            }
        }
    };

    var changeAdvanceStatus = function () {
        if ($("#advance_select option:selected").attr("value") === "0") {
            $("#advance_span").hide();
        }
        else {
            $("#advance").val("");
            $("#advance_span").show();
        }
    };

    G.submitForm = function (f) {
        var checkApproval = function (f) {
            if ($("#approval").is(":checked")) {
                GRN_MsgBox.show(G.noticeMessage, "", GRN_MsgBoxButtons.yesno, {
                    ui: [],
                    caption: {
                        yes: grn.msg.YES,
                        no: grn.msg.NO
                    },
                    callback: function (result, form) {
                        if (result == GRN_MsgBoxResult.yes) {
                            GRN_MsgBox._remove();
                            $(f).submit();
                        }
                    }
                });
            }
            else {
                $(f).submit();
            }
        };

        var applyFromParent = $("#apply_from_parent");
        if (applyFromParent.length > 0) {
            if (applyFromParent.is(":checked")) {
                $(f).submit();
            }
            else {
                checkApproval(f);
            }
        }
        else {
            checkApproval(f);
        }
    };

})(jQuery);
