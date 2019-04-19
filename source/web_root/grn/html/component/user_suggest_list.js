(function ($) {
    "use strict";

    if (grn.base.isNamespaceDefined("grn.component.user_suggest_list")) {
        return;
    }
    grn.base.namespace("grn.component.user_suggest_list");

    var default_options = {
        url: "path/to/ajax_search_user?",
        urlParams: {},
        maxRowDisplay: 20,
        container: ".cb-user-picker"
    };

    var G = grn.component.user_suggest_list = function (options) {
        grn.component.pubsub.installTo(this);
        this.options = $.extend({}, default_options, options);
    };

    G.prototype = {
        cssSelector: {
            class_prefix: ".",
            input_control: ".js_input_incremental_search",// suggest list append after this control
            input_control_icon: ".js_input_incremental_select_icon",// suggest list append after this control
            container_suggest_list: ".js_suggest_list",
            dropdown_list: ".js_dropdown_list",
            img_profile: ".js_img_profile",
            display_name: ".js_label",
            selected_member: "selected_item",//It does not include "."
            spinner: ".js_spinner",
            member: "li",
            first_member_list: "li:first"
        },

        htmlTemplate: {
            container: "<div class='pulldown_menu_grn pulldown_user_incremental_search_grn js_suggest_list'>" +
            "    <ul class='js_dropdown_list'></ul>" +
            "</div>",
            member: "<li>" +
            "    <a href='javascript:void(0);' >" +
            "        <div class='profileImage-grn v-allign-middle mRight7'>" +
            "            <div class='profileImageFrame-grn'>" +
            "                <div class='js_img_profile user_photo_grn'></div>" +
            "            </div>" +
            "        </div>" +
            "        <span class='js_label'></span>" +
            "    </a>" +
            "</li>",
            spinner: "<li class='js_spinner'>" +
            "   <a href='javascript:void(0);' >" +
            "       <div class='display_item cloudHeader-grnNotification-update-grn'>" +
            "           <span class='icon-spinner-grn'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>" +
            "        </div>" +
            "   </a>" +
            "</li>"
        },

        KEY_WORD: {
            MEMBER_DATA: "memberData",
            CLICK: "click",
            KEY_DOWN: "keydown",
            KEY_UP: "keyup",
            SELECTED: "selected",
            HOVER: "mouseenter mouseleave",
            SHOW: "show",
            SEARCH: "search",
            UNDEFINED: "undefined",
            STYLE: "style",
            OBJECT: "object",
            STR_SEPARATOR: "; ",
            EMPTY: ""
        },

        KEY_CODE: {
            BACK_SPACE: 8,
            ENTER: 13,
            SHIFT: 16,
            CTRL: 17,
            ALT: 18,
            PAUSE: 19,
            CAPS_LOCK: 20,
            TAB: 9,
            ESC: 27,
            PAGE_UP: 33,
            PAGE_DOWN: 34,
            END: 35,
            HOME: 36,
            LEFT: 37,
            UP: 38,
            RIGHT: 39,
            DOWN: 40,
            INSERT: 45,
            DEL: 46,
            NUM_LOCK: 144,
            SCROLL_LOCK: 145,
            V_KEY: 86,
            Z_KEY: 90,
            SELECT_KEY: 93
        },

        MEMBER_TYPE: {
            USER: "user"
        },

        isSelectedMember: false,

        isSearched: false,

        searchKey: null,

        init: function () {
            this.createComponent();
            this.cacheElements();
            this.bindEvents();
            this.$containerSuggestedList.hide();
        },

        createComponent: function () {
            $(this.options.container).find(this.cssSelector.input_control).after(this.htmlTemplate.container);
        },

        cacheElements: function () {
            this.$container = $(this.options.container);
            this.$containerSuggestedList = this.$container.find(this.cssSelector.container_suggest_list);
            this.$suggestList = this.$container.find(this.cssSelector.dropdown_list);
            this.$inputControl = this.$container.find(this.cssSelector.input_control);
            this.$inputControlIcon = this.$container.find(this.cssSelector.input_control_icon);
        },

        bindEvents: function () {
            this.$suggestList.on(this.KEY_WORD.CLICK, this.cssSelector.member, $.proxy(this._selectedMember, this));
            this.$suggestList.on(this.KEY_WORD.HOVER, this.cssSelector.member, $.proxy(this._handleHoverMember, this));
            this.$inputControl.on(this.KEY_WORD.KEY_DOWN, $.proxy(this._handleKeyDown, this));
            this.$inputControlIcon.on(this.KEY_WORD.CLICK, $.proxy(this._selectedMember, this));
        },

        /**
         *
         * @param {MouseEvent} event
         * @private
         */
        _handleHoverMember: function (event) {
            if (this.$suggestList.children().length > 0) {
                this.$suggestList.children().removeClass(this.cssSelector.selected_member);
            }
            $(event.currentTarget).addClass(this.cssSelector.selected_member);
        },

        /**
         *
         * @param {MouseEvent} event
         * @private
         */
        _selectedMember: function (event) {
            var selected_member = this.getSelected(event);
            if( typeof selected_member !== this.KEY_WORD.UNDEFINED )
            {
                this.isSelectedMember = true;
                this.trigger(this.KEY_WORD.SELECTED, selected_member);
            }
        },

        getSelected: function () {
            return this.$suggestList.find(this.cssSelector.class_prefix + this.cssSelector.selected_member).prop(this.KEY_WORD.MEMBER_DATA);
        },

       /**
        *
        * @param {Object} params
        * @returns {Object}
        */
       searchUser: function (params) {

           this.isSelectedMember = false;

           var _SearchKey = params.term.trim();
           var request;

           if (this.isSearched) {
               this.searchKey = _SearchKey;
               return false;
           }
           else if (_SearchKey === this.KEY_WORD.EMPTY) {
               this.searchKey = _SearchKey;
               return false;
           }
           else if (_SearchKey === this.searchKey) {
               return false;
           }

           var urlParams = this.options.urlParams;
           urlParams["keyword"] = _SearchKey;

           request = new grn.component.ajax.request({
               grnUrl: this.options.url,
               method: "post",
               data: urlParams,
               grnLoadingIndicator: $.proxy(this._loadingIndicator, this)
           });

           return request.send()
               .done($.proxy(this._renderMembersList, this));
       },

        /**
         * The function render list of user
         * @param {Object} dataResult - The json object
         * @param {String} textStatus
         * @param {Object} jqXHR
         * @private
         */
        _renderMembersList: function (dataResult, textStatus, jqXHR) {
            var self = this;
            var limitDisplay = 1;
            var memberHTML;

            this.$suggestList.empty();
            if ( this.$inputControl.val().trim() === this.KEY_WORD.EMPTY || typeof dataResult !== this.KEY_WORD.OBJECT || Object.keys(dataResult).length < 1 )
            {
                this.$containerSuggestedList.hide();
                return;
            }

            if (Object.keys(dataResult.user).length > 0)
            {
                this.$containerSuggestedList.show();
                $.each(dataResult, function (index,memberList) {
                    $.each(memberList, function (member_index, member) {
                        if (limitDisplay > self.options.maxRowDisplay) {
                            return;
                        }
                        limitDisplay++;
                        memberHTML = self._renderMember(self.htmlTemplate.member, member);
                        self.$suggestList.append(memberHTML);
                    });
                });
            }
            else
            {
                this.$containerSuggestedList.hide();
            }
        },

        /**
         *
         * @param {String} memberTemplate
         * @param {Object} memberData
         * @returns {*|HTMLElement}
         * @private
         */
        _renderMember: function (memberTemplate, memberData) {
            var primary_group;
            var member_html;

            primary_group = memberData.primary_group || this.KEY_WORD.EMPTY;
            if (primary_group !== this.KEY_WORD.EMPTY)
            {
                primary_group = this.KEY_WORD.STR_SEPARATOR + primary_group;

            }

            member_html = $(memberTemplate);
            member_html.find(this.cssSelector.display_name).text(memberData.col_display_name + primary_group);

            if (memberData.isInvalidUser != null)
            {
                member_html.find(this.cssSelector.img_profile).replaceWith("<div class='profileImageInvaliduser-grn'></div>");
            }
            else if (typeof memberData.icon_path !== this.KEY_WORD.UNDEFINED && memberData.icon_path !== this.KEY_WORD.EMPTY)
            {
                member_html.find(this.cssSelector.img_profile).css("background-image", "url(" + memberData.icon_path + ")");
            }
            else if (memberData.isLoginUser)
            {
                member_html.find(this.cssSelector.img_profile).replaceWith("<div class='profileImageLoginuser-grn'></div>");
            }
            else if (memberData.isNotUsingApp)
            {
                member_html.find(this.cssSelector.img_profile).replaceWith("<div class='profileImageInvalidAppUser-grn'></div>");
            }
            else
            {
                member_html.find(this.cssSelector.img_profile).replaceWith("<div class='profileImageUser-grn'></div>");
            }

            member_html.prop(this.KEY_WORD.MEMBER_DATA, memberData);

            return member_html;
        },

        nextMemberSelected: function () {
            var selected = this.$suggestList.find(this.cssSelector.class_prefix + this.cssSelector.selected_member);
            if( selected.length === 0 )
            {
                this._setFocusFirstMember();
                return;
            }

            var next_selected = selected.next();
            if (next_selected.length > 0)
            {
                selected.removeClass(this.cssSelector.selected_member);
                next_selected.addClass(this.cssSelector.selected_member);
            }
        },

        prevMemberSelected: function () {
            var selected = this.$suggestList.find(this.cssSelector.class_prefix + this.cssSelector.selected_member);
            var prev_selected = selected.prev();

            if (prev_selected.length > 0)
            {
                selected.removeClass(this.cssSelector.selected_member);
                prev_selected.addClass(this.cssSelector.selected_member);
            }
        },


        /**
         *
         * @param {KeyBoardEvent} e
         * @private
         */
        _handleKeyDown: function (e) {
            var ctrlDown = e.ctrlKey || e.metaKey;

            if (ctrlDown || e.altKey)
            {
                if (e.keyCode === this.KEY_CODE.UP || e.keyCode === this.KEY_CODE.DOWN ||
                    e.keyCode === this.KEY_CODE.LEFT || e.keyCode === this.KEY_CODE.RIGHT ||
                    e.keyCode === this.KEY_CODE.SHIFT
                   )
                {
                    this.isSearched = true;
                } else if (e.keyCode === this.KEY_CODE.V_KEY || e.keyCode === this.KEY_CODE.Z_KEY) {
                    this.isSearched = false;
                    this.searchKey = null;
                    this.$suggestList.empty();
                    this.$containerSuggestedList.hide();
                }
            }

            switch (e.keyCode) {
                case this.KEY_CODE.ENTER:
                    if (this.$suggestList.children().length > 0) {
                        this._selectedMember(e);
                        this.$suggestList.empty();
                        this.$containerSuggestedList.hide();
                    }
                    e.preventDefault();
                    break;
                case this.KEY_CODE.DOWN:
                    this.nextMemberSelected();
                    this.isSearched = true;
                    break;
                case this.KEY_CODE.UP:
                    this.prevMemberSelected();
                    this.isSearched = true;
                    break;
                case this.KEY_CODE.LEFT:
                case this.KEY_CODE.RIGHT:
                case this.KEY_CODE.INSERT:
                case this.KEY_CODE.END:
                case this.KEY_CODE.HOME:
                case this.KEY_CODE.PAGE_UP:
                case this.KEY_CODE.PAGE_DOWN:
                case this.KEY_CODE.PAUSE:
                case this.KEY_CODE.CAPS_LOCK:
                case this.KEY_CODE.NUM_LOCK:
                case this.KEY_CODE.SCROLL_LOCK:
                case this.KEY_CODE.SHIFT:
                case this.KEY_CODE.SELECT_KEY:
                    this.isSearched = true;
                    break;
                default:
                    this.isSearched = false;
                    this.searchKey = null;
                    break;
            }
        },

        _setFocusFirstMember: function () {
            this.$suggestList.find(this.cssSelector.first_member_list).addClass(this.cssSelector.selected_member);
        },

        /**
         *
         * @param {String} option
         * @private
         */
        _loadingIndicator: function (option) {
            this.$suggestList.find(this.cssSelector.spinner).remove();
            if (option === this.KEY_WORD.SHOW)
            {
                this.$suggestList.append(this.htmlTemplate.spinner);
            }
            else
            {
                this.$suggestList.find(this.cssSelector.spinner).remove();
            }
        }
    };
})(jQuery);
