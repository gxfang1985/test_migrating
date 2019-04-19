(function ($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.component.category_list")) {
        return;
    }

    grn.base.namespace("grn.component.category_list");
    var instances = {};

    var default_options = {
        sessionManagerUrl: "path/to/session_manager",
        urlParams: {}
    };

    grn.component.category_list = function (name, options) {
        this.options = $.extend({}, default_options, options);

        var self = this;
        $(function () {
            self.init(name);
        });
        instances[name] = this;
    };

    var G = grn.component.category_list;

    /**
     *
     * @param {string} name
     * @return MemberAdd
     */
    G.get_instance = function (name) {
        return instances[name];
    };

    G.prototype = {

        useConfirmMessage: false,

        KEY_WORD: {
            BEFORE_UNLOAD: "beforeunload"
        },

        JS_RESOURCES: {
            CONFIRM_SAVED_MESSAGE: grn.component.i18n.cbMsg("grn", "confirm_saved_message")
        },

        init: function () {
            this.bindEvents();
        },

        bindEvents: function () {
            $(window).on(this.KEY_WORD.BEFORE_UNLOAD, $.proxy(this._handleBeforeUnload, this));
        },

        _handleBeforeUnload: function (event) {
            if (this.useConfirmMessage) {
                var confirmationMessage = this.JS_RESOURCES.CONFIRM_SAVED_MESSAGE;
                event.returnValue = confirmationMessage;// Gecko and Trident
                return confirmationMessage;// Gecko and WebKit
            }
        },

        /**
         * @param {String} node_id
         * @param {HTMLElement} el
         */
        onClickTreeCheckbox: function (node_id, el) {
            this.useConfirmMessage = true;
            this.setSessionInfo(node_id, el.checked);
        },

        /**
         * @param {HTMLElement} el
         */
        onClickSubmit: function (el) {
            this.useConfirmMessage = false;

            var button = grn.component.button(el);
            if (!button.isDisabled()) {
                button.$element.closest("form").submit();
            }
        },

        /**
         * @param {String} id
         * @param {Boolean} is_checked
         */
        setSessionInfo: function (id, is_checked) {
            var urlParams = this.options.urlParams;
            urlParams["id"] = id;
            urlParams["checked"] = is_checked ? 1 : 0;

            var request = new grn.component.ajax.request({
                grnUrl: this.options.sessionManagerUrl,
                method: "post",
                data: urlParams
            });
            return request.send().done();
        }
    };
})(jQuery);
