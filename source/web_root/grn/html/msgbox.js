/* jshint bitwise: false */
/* global GRN_Event */

(function () {
    "use strict";

    var GRN_MsgBoxResult = {ok: 1, cancel: 2, yes: 4, no: 8};

    var GRN_MsgBoxButtons = {
        ok: GRN_MsgBoxResult.ok,
        okcancel: GRN_MsgBoxResult.ok | GRN_MsgBoxResult.cancel,
        yesno: GRN_MsgBoxResult.yes | GRN_MsgBoxResult.no
    };

    var GRN_MsgBox = {
        default_settings: {
            caption: {ok: 'OK', cancel: 'Cancel', yes: 'Yes', no: 'No'},
            ui: {width: null, height: null},    // if null, use size defined in CSS
            callback: function (result, form) {
            },
            html_id: {overlay: 'overlay', msgbox: 'msgbox'},
            enableKey: false,
            main_button: {ui: null, autoDisable: null}
        },

        // private properties
        settings: {},
        $overlay: null,
        $body: null,
        $msgbox: null,
        $selectboxs: null,
        $old_keypress_handler: null,
        $current_focus: 'yes',

        // public methods
        show: function (message, title, type, options) {
            if (typeof message === 'undefined') {
                throw 'missing parameter "message"';
            }

            title = title || '';
            type = type || GRN_MsgBoxButtons.ok;

            // ----- private variables -----
            var fn = GRN_MsgBox;    //short name
            var settings = {};
            jQuery.extend(settings, fn.default_settings);
            jQuery.extend(settings, options);
            fn.settings = settings;

            var $body = document.getElementsByTagName('body')[0];
            fn.$body = $body;

            // ----- render layout -----
            var $overlay = document.createElement('div');
            $overlay.setAttribute('id', settings.html_id.overlay);
            $overlay.setAttribute('class', "overlay");
            fn.$overlay = $overlay;
            if (jQuery('#' + $overlay.id).length === 0) {
                $body.appendChild($overlay);
            }
            var $msgbox = document.createElement('div');
            $msgbox.setAttribute('id', settings.html_id.msgbox);
            $msgbox.setAttribute('class', "msgbox");

            var ui = settings.ui;
            if (ui.width) {
                $msgbox.style.width = ui.width;
            }

            if (ui.height) {
                $msgbox.style.height = ui.height;
            }

            // STM-85 and STM-222 need to support message which is a DOM object
            var content = ""
            var html = "";
            html += "<div class=\"title\">" + title + "</div>";
            html += "<div class=\"content\">" + content + "</div><br />";
            html += "<div class=\"command\">";
            html += "</div>";

            $msgbox.innerHTML = html;

            // render buttons
            this._createButtons(jQuery($msgbox), type);

            fn.$msgbox = $msgbox;

            $msgbox.style.top = 0;
            $msgbox.style.left = 0;
            $body.appendChild($msgbox);
            // set overlay z-idex equals to box z-index
            var msg_box_index = jQuery("#" + $msgbox.id).css("z-index");
            jQuery("#" + $overlay.id).css("z-index", msg_box_index);

            var $content = jQuery('#' + settings.html_id.msgbox).children('.content');
            $content.html(message);
            // set position
            fn._setPosition();

            // ----- register event handler -----
            jQuery(window).resize(fn._setPosition);

            //disable keypress
            if (!fn.settings.enableKey) {
                fn._disableKeyPress();
            }

            //focus yes button
            fn.$current_focus = 'yes';
            var agent = window.navigator.userAgent;
            var btn_yes_focus = true;

            if (/(iPhone|iPad)/.test(agent)) {
                btn_yes_focus = false;
            }

            if (btn_yes_focus && fn.buttons.yes) {
                fn.buttons.yes.focus();
            }
        },
        close: function () {
            GRN_MsgBox._remove();
        },
        _createButtons: function ($msgbox, type) {
            var $button_area = $msgbox.find(".command");
            var resource = this.settings.caption;
            this.buttons = {};

            var types = Object.keys(GRN_MsgBoxResult);

            types.forEach(function (name) {
                var type_value = GRN_MsgBoxResult[name];
                if ((type & type_value) !== type_value) {
                    return;
                }

                var button_options = {
                    caption: resource[name],
                    id: "msgbox_btn_" + name // the ID is used by auto test (selenium)
                };

                if (name === "ok" || name === "yes") {
                    button_options = jQuery.extend({}, button_options, {
                        spacing: grn.component.button.SPACING.NORMAL,
                        ui: this.settings.main_button.ui,
                        autoDisable: this.settings.main_button.autoDisable
                    });
                }

                var button = grn.component.button()
                    .render(button_options)
                    .on("click", {
                        result: GRN_MsgBoxResult[name]
                    }, this._callback.bind(this));

                $button_area.append(button.$element);

                this.buttons[name] = button;

            }, this);
        },
        // private methods
        _setPosition: function () {
            var self = GRN_MsgBox;

            var pageHeight = window.innerHeight != null ?
                window.innerHeight : document.documentElement && document.documentElement.clientHeight ?
                    document.documentElement.clientHeight :
                    document.body != null ? document.body.clientHeight : null;
            var scrollHeight = document.documentElement.scrollHeight != null ?
                document.documentElement.scrollHeight : null;

            self.$overlay.style.width = Math.max(self.$body.clientWidth, self.$body.scrollWidth) + 'px';
            self.$overlay.style.height = Math.max(self.$body.clientHeight, self.$body.scrollHeight, pageHeight, scrollHeight) + 'px';

            var ScrollTop = document.body.scrollTop;
            if (ScrollTop === 0) {
                if (window.pageYOffset) {
                    ScrollTop = window.pageYOffset;
                } else {
                    ScrollTop = (document.body.parentElement) ? document.body.parentElement.scrollTop : 0;
                }
            }

            var top = ScrollTop + (pageHeight - self.$msgbox.clientHeight) / 2 + 'px';
            var left = (self.$body.clientWidth - self.$msgbox.clientWidth) / 2 + 'px';
            self.$msgbox.style.top = top;
            self.$msgbox.style.left = left;
        },
        _callback: function (event) {
            var result = event.data.result;
            var form = this.$msgbox.getElementsByTagName('form')[0] || null;
            this.settings.callback(result, form);
            if (result === GRN_MsgBoxResult.no || result === GRN_MsgBoxResult.cancel) {
                this._remove();
            }
        },
        _remove: function () {
            var self = GRN_MsgBox;

            //show select box
            if (self.$selectboxs && self.$selectboxs.length > 0) {
                jQuery.each(self.$selectboxs, function (index, value) {
                    jQuery(this).hide();
                });
            }
            var msg_box_index = parseInt(jQuery("#msgbox").css("z-index"));
            jQuery("#msgbox").remove();
            // remove overlay if doesn't exist msgbox
            if (!jQuery(".msgbox").is(":visible")) {
                jQuery("#overlay").remove();
            } else {
                // set z-index overlay < z-index msg box
                jQuery("#overlay").css("z-index", msg_box_index - 1);
            }
            jQuery(window).off("resize", self._setPosition);

            if (!self.settings.enableKey) {
                self._enableKeyPress();
            }
        },
        _disableKeyPress: function () {
            GRN_MsgBox.$old_keypress_handlar = document.onkeydown;
            document.onkeydown = function (e) {
                e = (typeof e === "undefined") ? event : e;
                var buttons = GRN_MsgBox.buttons;

                switch (GRN_Event.keyCode(e)) {
                    case 13: // Enter
                        if (GRN_MsgBox.$current_focus === 'yes') {
                            if (buttons.yes) {
                                buttons.yes.$element.trigger("click");
                            }
                        } else {
                            if (buttons.no) {
                                buttons.no.$element.trigger("click");
                            }
                        }
                        break;
                    case 27: // ESC
                        if (buttons.no) {
                            buttons.no.$element.trigger("click");
                        }
                        break;
                    case  9: // TAB
                    case 37: // Left allow
                    case 39: // Right allow
                        GRN_MsgBox._switchButtonFocus();
                        break;
                }
                return false;
            };
        },
        _enableKeyPress: function () {
            document.onkeydown = GRN_MsgBox.$old_keypress_handlar;
        },
        _switchButtonFocus: function () {
            if (GRN_MsgBox.$current_focus === 'yes') {
                if (this.buttons.no) {
                    this.buttons.no.focus();
                }
                GRN_MsgBox.$current_focus = 'no';
            }
            else {
                if (this.buttons.yes) {
                    this.buttons.yes.focus();
                }
                GRN_MsgBox.$current_focus = 'yes';
            }
        }
    };

    window.GRN_MsgBox = GRN_MsgBox;
    window.GRN_MsgBoxResult = GRN_MsgBoxResult;
    window.GRN_MsgBoxButtons = GRN_MsgBoxButtons;
})();
