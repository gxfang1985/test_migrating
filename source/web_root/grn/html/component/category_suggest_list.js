(function ($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.component.category_suggest_list")) {
        return;
    }

    grn.base.namespace("grn.component.category_suggest_list");

    var default_options = {
        url: "path/to/search_category?",
        urlParams: {},
        maxRowDisplay: 100,
        container: "cb-category-picker"
    };

    grn.component.category_suggest_list = function (options) {
        grn.component.pubsub.installTo(this);
        this.options = $.extend({}, default_options, options);
    };

    var G = grn.component.category_suggest_list;

    G.prototype = {
        cssSelector: {
            class_prefix: ".",
            search_panel: ".search_navi",
            input_control: ".js_input_incremental_search",
            input_control_icon: ".js_input_incremental_select_icon",
            pulldownMenuBaseScroll: ".pulldown_menu_base_scroll_y_grn",
            container_suggest_list: ".js_suggest_list",
            dropdown_list: ".js_dropdown_list",
            category_name: ".category_label",
            category_path_name: ".category_path_label",
            selected_member: "selected_item",
            spinner: ".js_spinner",
            member: "li",
            first_member_list: "li:first"
        },

        cssClass: {
            prefix: "prefix-grn"
        },

        htmlTemplate: {

            container: "<div class='pulldown_menu_style1_grn js_suggest_list' style='display: block;'>" +
            "  <div class='pulldown_menu_grn pulldown_menu_base_scroll_y_grn' style='display: block; min-width: 200px; max-height:450px;'>" +
            "    <ul class='js_dropdown_list'></ul>" +
            "  </div>" +
            "</div>",
            member: "<li class=''>" +
            "    <a href='javascript:void(0);'>" +
            "        <span class='block_grn category_label'></span><span class='block_grn text_color_sub_grn textSub-grn mTop3 category_path_label'></span>" +
            "    </a>" +
            "</li>",
            member_last: "<li class='last_item_grn'>" +
            "    <a href='javascript:void(0);'>" +
            "        <span class='block_grn category_label'></span><span class='block_grn text_color_sub_grn textSub-grn mTop3 category_path_label'></span>" +
            "    </a>" +
            "</li>",
            no_results_found: "<li class='last_item_grn'>" +
            "    <span class='block_grn mTop10 mRight10 mBottom10 mLeft10'>" + grn.component.i18n.cbMsg("grn", "ajax_search_no_result_message") + "</span>" +
            "</li>",
            spinner: "<li class='js_spinner'>" +
            "   <a href='javascript:void(0);' >" +
            "       <div class='spinner_s_base_grn'>" +
            "           <span class='spinner_s_grn'></span>" +
            "        </div>" +
            "   </a>" +
            "</li>"
        },

        KEY_WORD: {
            MEMBER_DATA: "memberData",
            CLICK: "click",
            KEY_DOWN: "keydown",
            SELECTED: "selected",
            HOVER: "mouseenter mouseleave",
            SHOW: "show",
            EMPTY: ""
        },

        KEY_CODE: {
            ENTER: 13,
            SHIFT: 16,
            PAUSE: 19,
            CAPS_LOCK: 20,
            PAGE_UP: 33,
            PAGE_DOWN: 34,
            END: 35,
            HOME: 36,
            LEFT: 37,
            UP: 38,
            RIGHT: 39,
            DOWN: 40,
            INSERT: 45,
            NUM_LOCK: 144,
            SCROLL_LOCK: 145,
            V_KEY: 86,
            Z_KEY: 90,
            SELECT_KEY: 93
        },

        isNoResultsFound: false,

        isSearched: false,

        isUsedMouse: true,

        searchKey: null,

        init: function () {
            this.createComponent();
            this.cacheElements();
            this.bindEvents();
            this.$suggestList.empty();
            this.$containerSuggestedList.hide();
        },

        createComponent: function () {
            $(this.cssSelector.class_prefix + this.options.container).find(this.cssSelector.search_panel).after(this.htmlTemplate.container);
        },

        cacheElements: function () {
            this.$container = $(this.cssSelector.class_prefix + this.options.container);
            this.$containerSuggestedList = this.$container.find(this.cssSelector.container_suggest_list);
            this.$suggestList = this.$container.find(this.cssSelector.dropdown_list);
            this.$inputControl = this.$container.find(this.cssSelector.input_control);
            this.$inputControlIcon = this.$container.find(this.cssSelector.input_control_icon);
        },

        bindEvents: function () {
            this.$suggestList.on(this.KEY_WORD.CLICK, this.cssSelector.member, $.proxy(this._selectedMember, this, true));
            this.$suggestList.on(this.KEY_WORD.HOVER, this.cssSelector.member, $.proxy(this._handleHoverMember, this));
            this.$inputControl.on(this.KEY_WORD.KEY_DOWN, $.proxy(this._handleKeyDown, this));
            this.$inputControl.on(this.KEY_WORD.CLICK, $.proxy(this._handleInputControlClick, this));
            this.$inputControlIcon.on(this.KEY_WORD.CLICK, $.proxy(this._selectedMember, this, false));
        },

        /**
         * @param {MouseEvent} event
         */
        _handleHoverMember: function (event) {
            if (this.isNoResultsFound) {
                return;
            }
            if (!this.isUsedMouse) {
                return;
            }
            if (this.$suggestList.children().length > 0) {
                this.$suggestList.children().removeClass(this.cssSelector.selected_member);
            }
            $(event.currentTarget).addClass(this.cssSelector.selected_member);
        },

        _handleInputControlClick: function () {
            this.isUsedMouse = true;
        },

        /**
         * @param {Boolean} isDuplicate
         * @param {MouseEvent} event
         */
        _selectedMember: function (isDuplicate, event) {

            if (isDuplicate) {
                if (this.$suggestList.children().length > 0) {
                    this.$suggestList.children().removeClass(this.cssSelector.selected_member);
                }
                $(event.currentTarget).addClass(this.cssSelector.selected_member);
            }

            this.trigger(this.KEY_WORD.SELECTED, this.getSelected(event));
        },

        getSelected: function () {
            return this.$suggestList.find(this.cssSelector.class_prefix + this.cssSelector.selected_member).prop(this.KEY_WORD.MEMBER_DATA);
        },

        /**
         *
         * @param {Object} params
         * @returns {*}
         */
        searchCategory: function (params) {
            var _SearchKey = params.term.trim();
            var request;

            if (this.isSearched) {
                this.searchKey = _SearchKey;
                return;
            }
            else if (_SearchKey === this.KEY_WORD.EMPTY) {
                this.searchKey = _SearchKey;
                return;
            }
            else if (_SearchKey === this.searchKey) {
                return;
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
         * @param {Object} dataResult - The json object
         * @param {String} textStatus
         * @param {Object} jqXHR
         */
        _renderMembersList: function (dataResult, textStatus, jqXHR) {
            var self = this;
            var limitDisplay = 1;
            var memberHTML;

            this.$suggestList.empty();
            if (this.$inputControl.val().trim() === this.KEY_WORD.EMPTY) {
                this.$suggestList.empty();
                this.$containerSuggestedList.hide();
                return;
            }

            if (this.$inputControl.hasClass(this.cssClass.prefix)) {
                return;
            }

            var category_result_length = Object.keys(dataResult.category).length;
            if (category_result_length) {
                this.$containerSuggestedList.show();
                $(this.cssSelector.pulldownMenuBaseScroll).scrollTop(0);
                this.isNoResultsFound = false;
                $.each(dataResult, function (type, memberList) {
                    $.each(memberList, function (index, member) {
                        if (limitDisplay > self.options.maxRowDisplay) {
                            return;
                        }
                        member.type = type;
                        if (category_result_length === limitDisplay || ( limitDisplay + 1 ) > self.options.maxRowDisplay) {
                            memberHTML = self._renderMember(self.htmlTemplate.member_last, member);
                        }
                        else {
                            memberHTML = self._renderMember(self.htmlTemplate.member, member);
                        }
                        self.$suggestList.append(memberHTML);
                        limitDisplay++;
                    });
                });
                this._setFocusFirstMember();
            }
            else {
                this.$containerSuggestedList.hide();
                this.isNoResultsFound = true;
            }
        },

        /**
         * @param {String} memberTemplate
         * @param {Object} memberData
         * @returns {*|HTMLElement}
         */
        _renderMember: function (memberTemplate, memberData) {
            var member_html = $(memberTemplate);

            member_html.find(this.cssSelector.category_name).text(memberData.name);
            member_html.find(this.cssSelector.category_path_name).text(memberData.path);

            member_html.prop(this.KEY_WORD.MEMBER_DATA, memberData);

            return member_html;
        },

        nextMemberSelected: function () {
            var selected = this.$suggestList.find(this.cssSelector.class_prefix + this.cssSelector.selected_member);
            var next_selected = selected.next();

            if (next_selected.length > 0) {
                selected.removeClass(this.cssSelector.selected_member);
                next_selected.addClass(this.cssSelector.selected_member);

                var baseScrollTop = $(this.cssSelector.pulldownMenuBaseScroll).scrollTop();
                var baseOffsetTop = $(this.cssSelector.pulldownMenuBaseScroll).offset().top;
                var baseHeight = $(this.cssSelector.pulldownMenuBaseScroll).height();
                var positionTop = next_selected.offset().top;
                var positionHeight = next_selected.height();

                var scroll = baseOffsetTop + baseHeight;
                var position = positionTop + positionHeight;
                var move = position - scroll + baseScrollTop;

                if (scroll < position) {
                    $(this.cssSelector.pulldownMenuBaseScroll).scrollTop(move);
                }
            }
        },

        prevMemberSelected: function () {
            var selected = this.$suggestList.find(this.cssSelector.class_prefix + this.cssSelector.selected_member);
            var prev_selected = selected.prev();

            if (prev_selected.length > 0) {
                selected.removeClass(this.cssSelector.selected_member);
                prev_selected.addClass(this.cssSelector.selected_member);

                var baseScrollTop = $(this.cssSelector.pulldownMenuBaseScroll).scrollTop();
                var baseOffsetTop = $(this.cssSelector.pulldownMenuBaseScroll).offset().top;
                var positionTop = prev_selected.offset().top;

                var scroll = baseOffsetTop;
                var position = positionTop;
                var move = position - scroll + baseScrollTop;

                if (position < scroll) {
                    $(this.cssSelector.pulldownMenuBaseScroll).scrollTop(move);
                }
            }
        },

        /**
         *
         * @param {KeyboardEvent} e
         * @private
         */
        _handleKeyDown: function (e) {
            var ctrlDown = e.ctrlKey || e.metaKey;

            if (ctrlDown || e.altKey) {
                if (e.keyCode === this.KEY_CODE.UP || e.keyCode === this.KEY_CODE.DOWN ||
                    e.keyCode === this.KEY_CODE.LEFT || e.keyCode === this.KEY_CODE.RIGHT ||
                    e.keyCode === this.KEY_CODE.SHIFT
                ) {
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
                        this._selectedMember(false, e);
                        this.$suggestList.empty();
                        this.$containerSuggestedList.hide();
                    }
                    e.preventDefault();
                    break;
                case this.KEY_CODE.DOWN:
                    this.isUsedMouse = false;
                    this.nextMemberSelected();
                    this.isSearched = true;
                    break;
                case this.KEY_CODE.UP:
                    this.isUsedMouse = false;
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
                    this.isUsedMouse = true;
                    this.isSearched = false;
                    this.searchKey = null;
                    break;
            }
        },

        _setFocusFirstMember: function () {
            this.$suggestList.find(this.cssSelector.first_member_list).addClass(this.cssSelector.selected_member);
        },

        /**
         * @param {String} option
         */
        _loadingIndicator: function (option) {
            this.$suggestList.find(this.cssSelector.spinner).remove();
            if (option === this.KEY_WORD.SHOW) {
                this.$suggestList.append(this.htmlTemplate.spinner);
            } else {
                this.$suggestList.find(this.cssSelector.spinner).remove();
            }
        }
    };
})(jQuery);
