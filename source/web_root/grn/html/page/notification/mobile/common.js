grn.base.namespace("grn.page.notification.mobile.common");
(function ()
{
    "use strict";
    var G = grn.page.notification.mobile.common;

    G.getMoreNotificationList = function (moduleId) {
        var shortId = "";
        if (moduleId === "0") {
            moduleId = "";
            shortId = "all_data";
        }
        else {
            shortId = moduleId.split(".")[1];
        }

        var elementMoreDiv = $("#" + shortId + "_more_div");
        var elementMoreSp = $("#" + shortId + "_sp");
        var elementMoreLastDataId = $("#" + shortId + "_last_data_id");
        var elementIsShowSinge = $("#is_show_single");

        $.ajax({
            type: "Post",
            url: G.postMoreUrl,
            dataType: "json",
            data: "module_id=" + moduleId + "&sp=" + elementMoreSp.prop("value") + "&is_show_single=" + elementIsShowSinge.prop("value") + "&ldid=" + elementMoreLastDataId.prop("value"),
            beforeSend: function () {
                grn.component.mobile_loading.show();
            },
            success: function (data, textStatus, jqXHR) {
                if (grn.component.mobile_error_handler.hasCybozuError(jqXHR)) {
                    grn.component.mobile_error_handler.show(jqXHR);
                }
                else {
                    elementMoreSp.prop("value", data.sp);
                    elementMoreLastDataId.prop("value", data.lastDataId);
                    elementMoreDiv.before(data.moreList);
                    $("#" + shortId + "_count_num").prop("value", parseInt($("#" + shortId + "_count_num").prop("value"), 10) + data.countNumber);
                    if (!data.hasMore) {
                        elementMoreDiv.remove();
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
                $("#notification_data_list").listview("refresh");
                grn.component.mobile_loading.remove();
            }
        });
    };

    G.redirectTo = function (page, self) {
        if (self) {
            window.location.href = page;
        }
        else {
            window.open(page);
        }
    };

    G.downloadFile = function (page, event) {
        event.stopPropagation();
        G.redirectTo(page,true);
    };
})();
