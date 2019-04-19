// namespace
grn.base.namespace("grn.page.space.config_view");

(function ($) {
    "use strict";

    var G = grn.page.space.config_view;

    $(function () {
        G.dialog = new grn.component.WindowSimpleDialog({
            asyncURL: grn.component.url.page("space/ajax/delete"),
            asyncParams: {
                "spid": G.spid
            },
            modal: true
        });

        G.dialog.on("loaded", function () {
            grn.component.button("#space_delete_submit").on("click", function () {
                var ajax_request = new grn.component.ajax.request({
                    grnUrl: "space/ajax/command_delete",
                    method: "post",
                    dataType: "json",
                    data: {
                        spid: G.spid,
                        csrf_ticket: grn.data["CSRF_TICKET"]
                    }
                });

                ajax_request.send().done(function (data) {
                    window.location.href = grn.component.url.page("space/list", "cid=" + data.cid);
                });
            });

            grn.component.button("#space_delete_cancel").on("click", function () {
                G.dialog.closeDialog();
            });
        });

        $("#space_delete").on("click", function () {
            G.dialog.openDialog();
        });
    });
})(jQuery);