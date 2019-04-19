
grn.base.namespace("grn.page.notification.mobile.pendinglist");
(function ()
{
    "use strict";
    var G = grn.page.notification.mobile.pendinglist;

    G.confirmNotification = function (notificationId, shortId, event) {
        var page_instance = grn.js.page.notification.mobile.Index.getInstance();
        var is_to_me = page_instance.notificationList.isToMe() === true ? 1 : "";
        event.stopPropagation();
        $.ajax({
            type: "Post",
            url: G.postConfirmUrl,
            dataType: "json",
            data: "nid=" + notificationId + "&csrf_ticket=" + grn.data["CSRF_TICKET"] + "&is_to_me=" + is_to_me,
            beforeSend: function () {
                grn.component.mobile_loading.show();
            },
            success: function (data, textStatus, jqXHR) {
                if (grn.component.mobile_error_handler.hasCybozuError(jqXHR)) {
                    grn.component.mobile_error_handler.show(jqXHR);
                }
                else {
                    if (data.confirmResult) {
                        $("#notif_" + notificationId).remove();
                        $("#" + shortId + "_count_num").prop("value", parseInt($("#" + shortId + "_count_num").prop("value"), 10) - 1);
                    }
                }
            },
            error: function (jqXHR) {
                if (!grn.component.mobile_error_handler.hasCybozuLogin(jqXHR)) {
                    document.write(jqXHR.responseText);
                    document.close();
                }
            },
            complete: function (jqXHR) {
                if (parseInt($("#" + shortId + "_count_num").prop("value"), 10) === 0 && $("#" + shortId + "_more_div").length === 0) {
                    $("#" + shortId + "_title").remove();
                }
                page_instance.notificationList.refresh();
            }
        });
    };
})();
