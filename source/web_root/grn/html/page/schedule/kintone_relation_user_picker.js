(function ($) {
    "use strict";

    grn.base.namespace("grn.component.schedule.kintone_relation_user_picker");

    var _options = {
        maxListMemberAdded: 20,
        minLength: 1, // The minimum number of characters a user must type before a search is performed.
        timeDelay: 100,//The delay in milliseconds between when a keystroke occurs and when a search is performed.
        url: "schedule/ajax_user_org_facility_list",//The url for receives server data,
        container: "searchbox-kintone",
        triggerClickElementID: ""
    };

    grn.component.schedule.kintone_relation_user_picker = function (options) {
        grn.component.pubsub.installTo(this);
        this.options = $.extend({}, _options, options);
    };

    var G = grn.component.schedule.kintone_relation_user_picker;

    G.prototype = {
        MEMBER_TYPE: {
            USER: "user",
            ORGANIZATION: "org",
            FACILITY: "facility"
        },

        suggestList: null,

        cssSelector: {
            classPrefix: ".",
            body: "body",
            input: "input",
            inputController: ".searchbox-user-cybozu",
            searchInput: "input[type='text']",
            inputIncrementalSearch: ".keyword_kintone_search_user",
            hiddenMemberCodeName: "#kintone_user_code_name"
        },

        cssClass: {
            inputIncrementalSearch: "keyword_kintone_search_user"
        },

        KEY_CODE: {
            BACK_SPACE: 8,
            ESC: 27,
            ENTER: 13,
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
            KEY_UP: "keyup",
            MOUSE_UP: "mouseup",
            SELECTED: "selected",
            CHANGE: "change",
            CUT: "cut",
            UNDEFINED: "undefined",
            WHICH: "which",
            BUTTON: "button",
            EMPTY: ""
        },

        /**
         * The prepend function. It uses to initialize this component.
         */
        init: function () {
            this.cacheElements();
            this.suggestList = new grn.component.user_org_facility_suggest_list({
                url: this.options.url,
                container: this.cssSelector.classPrefix + this.options.container,
                memberType: this.MEMBER_TYPE.USER
            });
            this.suggestList.init();
            this.bindEvents();

        },

        /**
         * The function creates variables and cache for this component using
         */
        cacheElements: function () {
            this.$body = $(this.cssSelector.body);
            this.$container = $(this.cssSelector.classPrefix + this.options.container);
            this.$inputController = this.$container.find(this.cssSelector.inputController);
            this.$inputControl = this.$inputController.find(this.cssSelector.inputIncrementalSearch);
            this.$hiddenMemberCodeName = this.$inputController.find(this.cssSelector.hiddenMemberCodeName);
        },

        /**
         * The function bind events for this component
         */
        bindEvents: function () {
            var self = this;

            this.$inputControl.on(this.KEY_WORD.KEY_UP, $.proxy(this._handleKeyUp, this));
            this.$inputControl.on(this.KEY_WORD.CUT, $.proxy(this._cutSearchKey, this));
            this.$inputControl.autocomplete({
                source: function (request) {
                    self.suggestList.searchUserOrgFacility(request);
                },
                minLength: this.options.minLength,
                delay: this.options.timeDelay
            });

            this.$inputControl.on(this.KEY_WORD.MOUSE_UP, $.proxy(this._handleMouseUp, this));
            this.$inputControl.on(this.KEY_WORD.CHANGE, $.proxy(this._handleChangeInput, this));
            this.$body.on(this.KEY_WORD.MOUSE_UP, $.proxy(this._handleDocumentMouseUp, this));
            this.suggestList.on(this.KEY_WORD.SELECTED, $.proxy(this._selectMemberFromSuggestList, this));
        },

        /**
         * Trigger when member is changed
         * @private
         */
        _triggerChange: function () {
            this.trigger(this.KEY_WORD.CHANGE);
        },

        _handleChangeInput: function () {
            if( ! this.suggestList.isSearched ) {
                this.$hiddenMemberCodeName.val("");
            }
        },

        _cutSearchKey: function () {
            var self = this;

            //Using setTimeout with a duration is 0 for immediate execution when cutting value.
            setTimeout(function () {
                if (!self.$inputControl.val().trim()) {
                    self.suggestList.$containerSuggestedList.hide();
                }
            }, 0);
        },

        _hideSuggestListControl: function () {
            this.suggestList.isSearched = false;
            this.suggestList.searchKey = null;
            this.suggestList.$suggestList.empty();
            this.suggestList.$containerSuggestedList.hide();
        },

        _handleDocumentMouseUp: function (e) {
            var self = this;
            var targetClass = e.target.className;
            var isRightClick = false;

            if (targetClass.indexOf(self.cssClass.inputIncrementalSearch) > 0) {
                return;
            }

            if (this.KEY_WORD.WHICH in e) {
                if (e.which === 3) {
                    isRightClick = true;
                }
            }
            else if (this.KEY_WORD.BUTTON in e) {
                if (e.button === 2) {
                    isRightClick = true;
                }
            }

            if (isRightClick) {
                e.stopImmediatePropagation();
            } else {
                setTimeout(function () {
                    self._hideSuggestListControl();
                }, 10);
            }
        },

        /**
         *<pre> The function fixes for case: drop-down list is displaying and then click 'x' icon of IE input control.
         * When this event is fired after clicking on the clear button the value is not cleared yet. We have to wait for it.
         * </pre>
         * @private
         */
        _handleMouseUp: function () {
            var self = this;
            var oldValue;
            var newValue;

            oldValue = this.$inputControl.val().trim();
            if (oldValue === this.KEY_WORD.EMPTY) {
                return;
            }

            //Using setTimeout with a duration is 1 for delayed execution when the mouse is up.
            setTimeout(function () {
                newValue = self.$inputControl.val().trim();
                if (newValue === self.KEY_WORD.EMPTY) {
                    self.suggestList.searchKey = null;
                    self.suggestList.$containerSuggestedList.hide();
                }
            }, 1);
        },

        /**
         *
         * @param {Object} memberSelected
         * @param {Object} memberData
         * @private
         */
        _selectMemberFromSuggestList: function (memberSelected, memberData) {
            var firingTrigger = true;

            if (typeof memberData === this.KEY_WORD.UNDEFINED) {
                return;
            }
            this._renderSelectedMember(memberData, firingTrigger);
        },

        /**
         *
         * @param {Object} memberData
         * @param {Boolean} isFiringTrigger
         */
        _renderSelectedMember: function (memberData, isFiringTrigger) {
            if (memberData == null) {
                return;
            }

            if (typeof memberData.selected === this.KEY_WORD.UNDEFINED) {
                memberData.selected = true;
            }

            this.suggestList.isSearched = true;
            this.$inputControl.val(memberData.col_display_name);
            this.$hiddenMemberCodeName.val(memberData.col_loginname);

            if (isFiringTrigger === true) {
                this._triggerChange();
                if(this.options.triggerClickElementID !== "")
                {
                    jQuery(this.options.triggerClickElementID).trigger("click");
                }
            }

        },

        /**
         * The function handles Key-up of keyboard for executing shown/hide the User/Facility picker.
         * @param {MouseEvent} e
         * @private
         */
        _handleKeyUp: function (e) {
            switch (e.keyCode) {
                case this.KEY_CODE.ESC:
                case this.KEY_CODE.ENTER:
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
                    if (this.$inputControl.val().trim() === this.KEY_WORD.EMPTY) {
                        this.suggestList.$containerSuggestedList.hide();
                        this.suggestList.$suggestList.empty();
                    }
                    this.$hiddenMemberCodeName.val("");
                    break;
                default:
                    this.$hiddenMemberCodeName.val("");
                    break;
            }
        }
    };
})(jQuery);

