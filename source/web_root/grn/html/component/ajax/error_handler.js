/* global grn_split_tags, GRN_MsgBox, GRN_MsgBoxButtons*/

(function ($) {
    "use strict";

    // Dependencies:
    // - jQuery
    // - grn.component.i18n
    // - grn.component.ajax.error_default_view

    grn.base.namespace("grn.component.ajax.error_handler");

    var G = grn.component.ajax.error_handler;
    var i18n = grn.component.i18n;

    G.settings = {
        errorView: grn.component.ajax.error_default_view
    };

    G.getHeader = function (request) {
        if (typeof(request.getAllResponseHeaders) === 'function') {
            return request.getAllResponseHeaders();
        }
        else {
            return request.getAllResponseHeaders; // for YAHOO.util.Connect.asyncRequest
        }
    };

    G.getCybozuError = function(request) {
        var headers = G.getHeader(request);
        var match = headers.match(/X-Cybozu-Error: (.*)/i);

        if (match.length === 2) {
            return match[1];
        }

        return null;
    };

    G.hasCybozuError = function (request) {
        var headers = G.getHeader(request);
        return (headers && headers.match(/X-Cybozu-Error/i)) ? true : false;
    };

    G.hasCybozuLogin = function (request) {
        var headers = G.getHeader(request);
        return (headers.match(/X-CybozuLogin/i) || !headers.match(/X-Cybozu-User/i));
    };

    G.show = function (request, on_close) {
        var responseText = request.responseText;
        var title = "";
        var content = "";
        var error_json = null;
        var resources = this._loadResources();

        if (typeof responseText !== "undefined") {
            try {
                error_json = JSON.parse(responseText);
            } catch(e){}

            if (error_json) {
                content = this._createCybozuErrorContent(error_json);
            } else if (responseText !== "") {
                title = resources.error;
                content = grn_split_tags(responseText, 1000);
            }
        }

        if (content === "") {
            title = resources.error;
            content = resources.undefinedError;
        }

        GRN_MsgBox.show(content, title, GRN_MsgBoxButtons.ok, {
            ui: [],
            caption: { ok: resources.ok },
            callback: function () {
                GRN_MsgBox._remove();

                if (typeof on_close === 'function') {
                    on_close();
                }
            }
        });
    };

    G._createCybozuErrorContent = function(error) {
        return this.settings.errorView.render(error);
    };

    G._loadResources = function() {
        return {
            error: i18n.cbMsg('fw.error', 'Error'),
            undefinedError: i18n.cbMsg('grn', 'ajax_undefined_error'),
            ok: i18n.cbMsg('grn.common', 'ok')
        };
    };
})(jQuery);
