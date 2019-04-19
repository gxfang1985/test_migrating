grn.base.namespace("grn.page.space.join_leave");

(function ($) {
    "use strict";

    var G = grn.page.space.join_leave;

    G.getDialogUrl = "space/application/ajax/get_join_leave_dialog";
    G.commandJoinLeaveUrl = "space/application/ajax/command_join_leave";
    G.overlayElement = null;
    G.containerDivDialog = null;
    G.doingCheckShowDialog = false;

    G.checkShowDialog = function (spid, action) {
        if (G.doingCheckShowDialog === true) {
            return;
        }

        G.doingCheckShowDialog = true;
        G.spid = spid;
        G.action = action;

        var ajax_send_data = {"spid": spid, "action": action};

        var request_ajax = new grn.component.ajax.request({
            grnUrl: G.getDialogUrl,
            method: "post",
            dataType: "json",
            data: ajax_send_data,
            grnRedirectOnLoginError: true
        });

        request_ajax.send().done(function (data) {
            G.dialog.setTitle(data.title);
            G.dialog.setContent(data.content);
            G.dialog.openDialog();
        }).always(function () {
            G.doingCheckShowDialog = false;
        });
    };

    G.closeDialog = function () {
        G.dialog.closeDialog();
    };

    G.submitDialog = function (button_element) {
        var button = grn.component.button(button_element);
        if (button.isDisabled()) {
            return;
        }

        var ajax_send_data = {
            spid: G.spid,
            action: G.action,
            csrf_ticket: grn.data["CSRF_TICKET"]
        };

        var request_ajax = new grn.component.ajax.request({
            grnUrl: G.commandJoinLeaveUrl,
            method: "post",
            dataType: "json",
            data: ajax_send_data,
            grnRedirectOnLoginError: true
        });

        request_ajax.on("errorClosed", function (e, jqXHR) {
            button.enable();
            button.hideSpinner();
        });

        request_ajax.send().done(function (data) {
            if (data.redirect && G.action === "leave") {
                window.location.href = grn.component.url.page("space/root");
            }
            else {
                location.reload(true);
            }
        });
    };

    $(function () {
        G.dialog = new grn.component.WindowSimpleDialog({
            modal: true
        });
    });

})(jQuery);
