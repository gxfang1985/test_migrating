/*global GRN_Event*/

(function ($) {
    "use strict";

    var default_options = {
        version: 2,
        zIndex: null,
        modal: false,
        backdropCSS: "overlay",
        title: "",
        content: "",
        asyncMethod: "post",
        asyncURL: "",
        asyncParams: "",
        hideCloseButton: false,
        closeByBackgroundClick: false,
        hideGoBackButton: true
    };

    var ZINDEX_MODAL = 2000;
    var ZINDEX_MODELLESS = 999;

    /**
     * @param {object} [options] - The options for the dialog.
     * @param {number} [options.version] - The version of the dialog.
     * @param {number} [options.zIndex] - The z-index of the dialog.
     * @param {boolean} [options.modal] - Whether the dialog is modal or not.
     * @param {string} [options.backdropCSS] - The CSS class of the dialog's backdrop.
     * @param {string} [options.title] - The title of the dialog.
     * @param {string} [options.content] - The content of the dialog.
     * @param {string} [options.asyncMethod] - The asynchronous method of the dialog.
     * @param {string} [options.asyncURL] - The asynchronous URL of the dialog.
     * @param {string|object} [options.asyncParams] - The asynchronous params of the dialog.
     */
    grn.component.WindowSimpleDialog = function (options) {
        /**
         * The dialog version 1 only supports to display only one instance at the same time.
         * For backward compatible, we don't change this behavior if using dialog version 1.
         * To allow using multiple instances of dialog, we should use dialog version 2.
         */
        if (!options) {
            options = {version: 1};
            $("#window_dialog_v1").remove();
        }

        this.options = $.extend({}, default_options, options);

        if (!this.options.zIndex) {
            this.options.zIndex = this.options.modal ? ZINDEX_MODAL : ZINDEX_MODELLESS;
        }

        this._isLoading = false;
        this._event = $({});

        this.$container = $($("#template_window_simple_dialog_v" + this.options.version).html());
        if (this.options.modal) {
            this.$container = $("<div class='modal_dialog_grn'></div>").html(this.$container);
        }
        this.$container.hide();

        this.$container.css("z-index", this.options.zIndex);
        this.$container.appendTo(document.body);
        this._$content = this.$container.find("#window_content");
        this._$title = this.$container.find("#window_title");
        this._$goBackButton = this.$container.find("#back_button");

        if (this.options.hideGoBackButton) {
            this._$goBackButton.hide();
        }

        if (this.options.hideCloseButton) {
            this.$container.find("#window_dialog_close").hide();
        }

        /**
         * _$spinnerVersion1 is the spinner of the dialog version 1
         */
        this._$spinnerVersion1 = this._$content.children();
        this._$headerWrap = $("#header-wrap");

        if (this.options.modal) {
            this.$container.find(".subwindow_title_grn").css("cursor", "default");
        }

        this._bindEvents();
    };
    grn.component.WindowSimpleDialog.prototype = {
        /**
         * @deprecated since F8.0
         * Use constructor of grn.component.WindowSimpleDialog to initialize the dialog instead of using grn.component.initialize
         */
        initialize: function (title, asyncMethod, asyncURL, asyncParams) {
            this._isLoading = false;
            this.options.title = title;
            this.options.asyncMethod = asyncMethod;
            this.options.asyncURL = asyncURL;
            this.options.asyncParams = asyncParams;
        },
        on: function (name, callback) {
            this._event.on(name, callback);
        },
        setTitle: function (title) {
            this.options.title = title;
            this._$title.html(title);
        },
        setContent: function (content) {
            this.options.content = content;
            this._$content.html(content);
        },
        openDialog: function () {
            if (this._isLoading) {
                return;
            }
            this._isLoading = true;

            if (this.options.version === 2) {
                if (this.options.asyncURL === "") {
                    this.setTitle(this.options.title);
                    this.setContent(this.options.content);
                    this._showDialog();
                    this._isLoading = false;
                    return;
                }
                else {
                    this._showSpinner();
                }
            }
            else if (this.options.version === 1) {
                this._$content.html(this._$spinnerVersion1);
                this.$container.show();
                this._moveToCenter();
            }

            this._loadContent()
                .done(this._showDialog.bind(this));
        },
        closeDialog: function () {
            this._removeSpinner();
            this.$container.hide();
            this._removeBackdrop();
        },
        _bindEvents: function () {
            this.$container.find("#window_dialog_close").click(this.closeDialog.bind(this));
            $(window).on("resize", this._resizeBackdrop.bind(this));
            $(document).keydown(this._closeDialogOnEsc.bind(this));

            if (!this.options.modal) {
                $(this._initDragDrop.bind(this));
            }

            if (this.options.closeByBackgroundClick) {
                $(document).click(this._closeDialogByBackgroundClick.bind(this));
            }
        },
        _closeDialogOnEsc: function (e) {
            //ESC key
            if (GRN_Event.keyCode(e) === 27) {
                this.closeDialog();
            }
        },
        _closeDialogByBackgroundClick: function (e) {

            if (this._isLoading) {
                return;
            }

            var clickX = e.pageX,
                clickY = e.pageY,
                dialogXStart = this.$container.position().left,
                dialogXEnd = dialogXStart + this.$container.outerWidth(),
                dialogYStart = this.$container.position().top,
                dialogYEnd = dialogYStart + this.$container.outerHeight(),
                isInDialogClick = ((dialogXStart < clickX ) && (clickX < dialogXEnd)) && ((dialogYStart < clickY ) && (clickY < dialogYEnd));

            if (!isInDialogClick) {
                this.closeDialog();
            }
        },
        _moveToCenter: function () {
            this.$container.css("top", Math.max(this._$headerWrap.height(), ((window.innerHeight - this.$container.outerHeight()) / 2) +
                    $(window).scrollTop()) + "px");
            this.$container.css("left", Math.max(0, ((window.innerWidth - this.$container.outerWidth()) / 2) +
                    $(window).scrollLeft()) + "px");
        },
        _loadContent: function () {
            var self = this;

            this.setTitle(this.options.title);

            var request = new grn.component.ajax.request({
                url: this.options.asyncURL,
                method: this.options.asyncMethod,
                dataType: "json",
                data: this.options.asyncParams
            });

            return request.send()
                .done(function (data) {
                    self._$content.html(data.content);
                    if (data.title) {
                        self._$title.html(data.title);
                    }
                    if (data.use_back_button && data.use_back_button == true) {
                        self._$goBackButton.show();
                    } else {
                        self._$goBackButton.hide();
                    }
                    self._event.trigger('loaded', data);
                })
                .fail(function () {
                    self.$container.hide();
                })
                .always(function () {
                    self._isLoading = false;
                    self._removeSpinner();
                    self._removeBackdrop();
                });
        },
        _initDragDrop: function () {
            if (this.$container.length === 0) {
                return;
            }
            var self = this;
            this.$container.draggable({
                handle: "#window_dialog_header",
                stop: function () {
                    /**
                     * On FireFox, when dragging jQuery will set the width and height of the container to a fixed size.
                     * So we need reset the size of the dialog after dragging is stopped.
                     */
                    self.$container.css({width: "auto", height: "auto"});
                }
            });

            /**
             * To limit the draggable area
             */
            this.$container.on("mouseenter", "#window_dialog_header", function () {
                self.$container.draggable("option", "containment", [-(self.$container.width() * 9 / 10), 0]);
            });
        },
        _showBackdrop: function () {
            this._$backdrop = $("<div ></div>");
            this._$backdrop.addClass(this.options.backdropCSS);
            this._$backdrop.css("z-index", this.options.zIndex - 2);
            this._resizeBackdrop();
            this._$backdrop.appendTo(document.body);
        },
        _removeBackdrop: function () {
            if (this._$backdrop) {
                this._$backdrop.remove();
            }
        },
        _resizeBackdrop: function () {
            if (!this._$backdrop) {
                return;
            }
            this._$backdrop.css({
                width: $(document).width(),
                height: $(document).height()
            });
        },
        _showContainer: function () {
            if (!this.$container.is(":visible")) {
                this.$container.show();
            }
        },
        _showSpinner: function () {
            this._$spinner = $('<div class="spinnerBoxBase-grn spinnerCentered"><div class="spinnerBox-grn"></div></div>');
            this._$spinner.css("z-index", this.options.zIndex - 1);
            this._$spinner.appendTo(document.body);
        },
        _removeSpinner: function () {
            if (this._$spinner) {
                this._$spinner.remove();
            }
        },
        _showDialog: function () {
            this._removeSpinner();
            if (this.options.modal) {
                this._showBackdrop();
            }
            this._showContainer();
            this._moveToCenter();
        }
    };
})(jQuery);