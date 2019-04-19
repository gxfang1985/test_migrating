(function ($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.component.category_picker")) {
        return;
    }

    grn.base.namespace("grn.component.category_picker");
    var instances = {};

    var default_options = {
        searchBoxTextId: "id_search_box_text",
        searchBoxIconId: "id_search_box_icon",

        tree_name: "folder_tree",
        tree_list: "category_picker_tree_list",
        url: "path/to/search_category",
        sessionManagerUrl: "path/to/session_manager",
        urlParams: {},
        minLength: 1,
        timeDelay: 100,
        container: "cb-category-picker"
    };

    grn.component.category_picker = function (name, folder_tree, options) {
        grn.component.pubsub.installTo(this);
        this.folder_tree = folder_tree;
        this.options = $.extend({}, default_options, options);

        var self = this;
        $(function () {
            self.init(name);
        });
        instances[name] = this;
    };

    var G = grn.component.category_picker;

    /**
     *
     * @param {string} name
     * @return MemberAdd
     */
    G.get_instance = function (name) {
        return instances[name];
    };

    G.prototype = {

        folder_tree: null,
        useConfirmMessage: false,

        suggestList: null,

        idSelector: {
            idPrefix: "#"
        },

        cssSelector: {
            classPrefix: ".",
            body: "body",
            focus: ":focus",

            memberAdded: ".js_member",
            membersCheckUnchecked: ".js_member input[type='checkbox']",
            memberIsChecked: ".js_member input[type='checkbox']:checked",
            displayName: ".js_label",
            onOffEvent: ".js_checkbox",
            deleteIcon: ".js_del_icon",
            label: ".js_label_a",
            colorBlock: ".js_color_block",
            elementHide: ":visible",
            input: "input",

            inputIncrementalSearch: ".js_input_incremental_search",
            inputIncrementalSelectIcon: ".js_input_incremental_select_icon"
        },

        cssClass: {
            inputIncrementalSearch: "js_input_incremental_search",
            inputIncrementalSelectIcon: "js_input_incremental_select_icon",
            pulldownMenuBaseScroll: "pulldown_menu_base_scroll_y_grn",
            prefix: "prefix-grn"
        },

        JS_RESOURCES: {
            CONFIRM_SAVED_MESSAGE: grn.component.i18n.cbMsg("grn", "confirm_saved_message")
        },

        KEY_CODE: {
            BACK_SPACE: 8,
            ENTER: 13,
            ESC: 27,
            DEL: 46,
            END: 35,
            HOME: 36,
            LEFT: 37,
            UP: 38,
            RIGHT: 39,
            DOWN: 40,
            INSERT: 45,
            PAGE_UP: 33,
            PAGE_DOWN: 34,
            CAPS_LOCK: 20
        },

        KEY_WORD: {
            BEFORE_UNLOAD: "beforeunload",
            KEY_UP: "keyup",
            MOUSE_UP: "mouseup",
            SELECTED: "selected",
            CHANGE: "change",
            CUT: "cut",
            UNDEFINED: "undefined",
            STR_SEPARATOR: "; ",
            WHICH: "which",
            BUTTON: "button",
            EMPTY: ""
        },

        isLoading: false, //be used to prevent "Select or clear all checkboxes" while the last request is being processed

        init: function () {
            this.createComponent();
            this.cacheElements();

            this.suggestList = new grn.component.category_suggest_list({
                url: this.options.url,
                urlParams: this.options.urlParams
            });

            this.suggestList.init();
            this.bindEvents();
        },

        createComponent: function () {
            var container = $(this.cssSelector.classPrefix + this.options.container);
            container.find(this.idSelector.idPrefix + this.options.searchBoxTextId).addClass(this.cssClass.inputIncrementalSearch);
            container.find(this.idSelector.idPrefix + this.options.searchBoxIconId).addClass(this.cssClass.inputIncrementalSelectIcon);
        },

        cacheElements: function () {
            this.$body = $(this.cssSelector.body);
            this.$container = $(this.cssSelector.classPrefix + this.options.container);
            this.$inputControl = this.$container.find(this.cssSelector.inputIncrementalSearch);
        },

        bindEvents: function () {
            var self = this;

            $(window).on(this.KEY_WORD.BEFORE_UNLOAD, $.proxy(this._handleBeforeUnload, this));

            this.$body.on(this.KEY_WORD.KEY_UP, $.proxy(this._handleKeyUp, this));
            this.$inputControl.on(this.KEY_WORD.CUT, $.proxy(this._cutSearchKey, this));

            this.$inputControl.autocomplete({
                source: function (request) {
                    self.suggestList.searchCategory(request);
                },
                search: function () {
                    return !self.$inputControl.hasClass(self.cssClass.prefix);
                },
                minLength: this.options.minLength,
                delay: this.options.timeDelay
            });
            this.$inputControl.on(this.KEY_WORD.MOUSE_UP, $.proxy(this._handleMouseUp, this));
            this.$body.on(this.KEY_WORD.MOUSE_UP, $.proxy(this._handleDocumentMouseUp, this));
            this.suggestList.on(this.KEY_WORD.SELECTED, $.proxy(this._selectMemberFromSuggestList, this));
        },

        _handleBeforeUnload: function (event) {
            if (this.useConfirmMessage) {
                var confirmationMessage = this.JS_RESOURCES.CONFIRM_SAVED_MESSAGE;
                event.returnValue = confirmationMessage;// Gecko and Trident
                return confirmationMessage;// Gecko and WebKit
            }
        },

        _cutSearchKey: function () {
            var self = this;

            setTimeout(function () {
                if (!self.$inputControl.val().trim()) {
                    self.suggestList.$suggestList.empty();
                    self.suggestList.$containerSuggestedList.hide();
                }
            }, 0);
        },

        /**
         * @param {Boolean} isInputControlClear
         */
        _hideInputControl: function (isInputControlClear) {
            if (isInputControlClear) {
                this.$inputControl.val(this.KEY_WORD.EMPTY);
                this.$inputControl.blur();
            }

            if (this.$inputControl.is(this.cssSelector.focus) && ( this.suggestList.$suggestList.children().length === 0 )) {
                this.suggestList.$containerSuggestedList.show();
                var memberHTML = $(this.suggestList.htmlTemplate.no_results_found);
                this.suggestList.$suggestList.append(memberHTML);
            }
            else {
                this.suggestList.isSearched = false;
                this.suggestList.searchKey = null;
                this.suggestList.$suggestList.empty();
                this.suggestList.$containerSuggestedList.hide();
            }

        },

        /**
         * @param {MouseEvent} event
         */
        _handleDocumentMouseUp: function (event) {
            var self = this;
            var targetClass = event.target.className;
            var isRightClick = false;

            if (targetClass.indexOf(this.cssClass.inputIncrementalSearch) > 0) {
                return;
            }

            if (targetClass.indexOf(this.cssClass.inputIncrementalSelectIcon) > 0) {
                if (this.$inputControl.hasClass(this.cssClass.prefix) || ( this.suggestList.$suggestList.children().length === 0 )) {
                    this.suggestList.$containerSuggestedList.show();
                    this.suggestList.searchKey = null;
                    this.suggestList.$suggestList.empty();
                    var memberHTML = $(this.suggestList.htmlTemplate.no_results_found);
                    this.suggestList.$suggestList.append(memberHTML);
                }
                return;
            }

            if (targetClass.indexOf(this.cssClass.pulldownMenuBaseScroll) > 0) {
                return;
            }

            if (this.KEY_WORD.WHICH in event) {
                if (event.which === 3) {
                    isRightClick = true;
                }
            } else if (this.KEY_WORD.BUTTON in event) {
                if (event.button === 2) {
                    isRightClick = true;
                }
            }

            if (isRightClick) {
                event.stopImmediatePropagation();
            } else {
                setTimeout(function () {
                    self._hideInputControl(true);
                }, 10);
            }
        },

        _handleMouseUp: function () {
            var self = this;
            var oldValue;
            var newValue;

            oldValue = this.$inputControl.val().trim();
            if (oldValue === this.KEY_WORD.EMPTY) {
                return;
            }

            setTimeout(function () {
                newValue = self.$inputControl.val().trim();
                if (newValue === self.KEY_WORD.EMPTY) {
                    self.suggestList.searchKey = null;
                    self.suggestList.$suggestList.empty();
                    self.suggestList.$containerSuggestedList.hide();
                }
            }, 1);
        },

        /**
         * @param {Object} memberSelected
         * @param {Object} memberData
         */
        _selectMemberFromSuggestList: function (memberSelected, memberData) {

            if (typeof memberData === this.KEY_WORD.UNDEFINED) {
                return;
            }

            var $target = $(this.idSelector.idPrefix + this.options.tree_name + "-node-" + memberData.cid);
            if ($target.get(0)) {
                this.folder_tree.buildTreeExpand(memberData.cid);
                this.folder_tree.highlightNode(memberData.cid);
                this.movePositionTop(memberData.cid);
            }
            this._triggerChange();

            this._hideInputControl(true);
        },

        /**
         * @param {String} node_id
         */
        movePositionTop: function (node_id) {
            var $target = $(this.idSelector.idPrefix + this.options.tree_name + "-node-" + node_id);
            if ($target.get(0)) {
                var baseScrollTop = $(this.idSelector.idPrefix + this.options.tree_list).scrollTop();
                var positionTop = $target.offset().top;
                var targetTop = $(this.idSelector.idPrefix + this.options.tree_list).offset().top;
                positionTop = positionTop - targetTop + baseScrollTop;
                $(this.idSelector.idPrefix + this.options.tree_list).scrollTop(positionTop - 15);
            }
        },

        /**
         * @param {String} node_id
         */
        onClickCategoryName: function (node_id) {
            if (node_id) {
                this.folder_tree.highlightNode(node_id);
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
        },

        _triggerChange: function () {
            this.trigger(this.KEY_WORD.CHANGE);
        },

        /**
         * @param {KeyboardEvent} event
         */
        _handleKeyUp: function (event) {
            switch (event.keyCode) {
                case this.KEY_CODE.ESC:
                case this.KEY_CODE.ENTER:
                    this._hideInputControl(false);
                    break;
                case this.KEY_CODE.LEFT:
                case this.KEY_CODE.RIGHT:
                case this.KEY_CODE.UP:
                case this.KEY_CODE.DOWN:
                case this.KEY_CODE.INSERT:
                case this.KEY_CODE.END:
                case this.KEY_CODE.HOME:
                case this.KEY_CODE.PAGE_UP:
                case this.KEY_CODE.PAGE_DOWN:
                case this.KEY_CODE.CAPS_LOCK:
                    break;
                case this.KEY_CODE.DEL:
                case this.KEY_CODE.BACK_SPACE:
                    if (( !this.$inputControl.hasClass(this.cssClass.prefix) ) || (this.$inputControl.val().trim() === this.KEY_WORD.EMPTY )) {
                        this.suggestList.$suggestList.empty();
                        this.suggestList.$containerSuggestedList.hide();
                    }
                    break;
            }
        }
    };
})(jQuery);
