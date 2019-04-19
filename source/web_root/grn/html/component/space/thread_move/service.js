(function () {
    "use strict";

    grn.base.namespace("grn.component.space.thread_move.service");

    var Service = grn.component.space.thread_move.service;
    var request;

    grn.component.pubsub.installTo(Service);

    Service.getThreads = function (spaceId, did, sp) {
        request = new grn.component.ajax.request({
                grnUrl: "space/ajax/thread_move_list",
                method: "post",
                data: {spid: spaceId, did: did, sp: sp}
            }
        );

        request.on("errorClosed", this._handleError.bind(this));

        return request.send();
    };

    Service.getSpaces = function (spid, sp) {
        request = new grn.component.ajax.request({
                grnUrl: "space/ajax/get_space_list_dialog",
                method: "post",
                data: {spid: spid, sp: sp}
            }
        );

        request.on("errorClosed", this._handleError.bind(this));

        return request.send();
    };

    Service.moveThreads = function (listItem, source, target, notifyFlag) {
        request = new grn.component.ajax.request({
                grnUrl: "space/ajax/command_thread_move",
                method: "post",
                data: {
                    listItem: listItem,
                    source: source,
                    target: target,
                    notifyFlag: notifyFlag,
                    csrf_ticket: grn.data["CSRF_TICKET"]
                }
            }
        );

        request.on("errorClosed", this._handleError.bind(this));

        return request.send();
    };

    Service._handleError = function(e, jqXHR) {
        this.trigger("error", request.getErrorHandler().getCybozuError(jqXHR));
    };

})();