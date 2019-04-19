(function ($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.component.member_select_list")) {
        return;
    }
    grn.base.namespace("grn.component.member_select_list");
    var member_select_list = grn.component.member_select_list;
    var default_options = {
        selectedClassName: "selectlist_selected_grn",
        isCalendar: false,
        isCurrentScreen: true,
        isFacilityCandidate: false
    };

    var instances = {};

    function get_full_list_name(list_name) {
        return "selectlist_" + list_name;
    }

    /**
     *
     * @type {{USER: string, GROUP: string, ROLE: string, DYNAMIC_ROLE: string, OMITTED:string}}
     * @const
     */
    member_select_list.MEMBER_TYPES = {
        USER: "user",
        GROUP: "group",
        ROLE: "static_role",
        DYNAMIC_ROLE: "dynamic_role",
        OMITTED: "omitted"
    };

    /**
     * @type {number}
     * @const
     */
    member_select_list.OMITTED_ID = 0;

    /**
     *
     * @type {{user: string, group: string, static_role: string, dynamic_role: string, omitted:string}}
     * @const
     */
    var PREFIXES = {
        user: "",
        group: "g",
        static_role: "r",
        dynamic_role: "dr",
        omitted: ""
    };

    /**
     *
     * @type {number}
     * @const
     */
    var SCROLL_INTERVAL = 50;

    /**
     *
     * @type {number}
     * @const
     */
    var MEMBER_HEIGHT_PX = 18;
    /**
     *
     * @param {string} list_name
     * @param {object} options
     * @constructor
     */
    member_select_list.MemberSelectList = function (list_name, options) {
        this.shortListName = list_name;
        this.listName = get_full_list_name(list_name);
        options = $.extend({}, default_options, options);
        this.selectedClassName = options.selectedClassName;
        this.isCalendar = options.isCalendar;
        this.isCurrentScreen = options.isCurrentScreen;
        this.isFacilityCandidate = options.isFacilityCandidate;
        this.lastSelectedId = null;
        this.lastRangedId = null;
        this.isMouseDown = null;
        this.isCandidateList = options.isCandidateList || false;
        this.memberAddName = options.memberAddName;
        this.isTouchSupported = 'ontouchstart' in window || navigator.maxTouchPoints;
        this.isScrollToAdd = options.isScrollToAdd || false;
        this.isNeedScroll = options.isNeedScroll || false;
        this.parameterForGetMoreMember = options.parameterForGetMoreMember;
        this.isLoading = false;
        this.ajaxGetMemberListUrl = options.ajaxGetMemberListUrl;

        var self = this;
        $(function () {
            self.init();
        });
        instances[list_name] = this;
    };

    /**
     *
     * @param {string} name
     * @returns {grn.component.member_select_list.MemberSelectList}
     */
    member_select_list.get_instance = function (name) {
        return instances[name];
    };

    member_select_list.MemberSelectList.prototype = {
        init: function () {
            var select_list = this;
            this.$ul_list = $("#ul_" + this.listName);
            this.$select_box = this.jQuery()("#selectlist_base_" + this.listName);
            this.$select_all = $("#select_all_" + this.listName);
            this.$un_select_all = $("#un_select_all_" + this.listName);

            this.$ul_list.on("mousedown", "li", function (event) {
                select_list.clickMember($(this), event);
                select_list.setMouseDownState();
                if (select_list.isFacilityCandidate) {
                    select_list.updateAncestorsPath();
                }
                return !event.shiftKey;
            });
            $(document).on("mouseup", function () {
                select_list.setMouseUpState();
            });
            if (grn.browser.chrome) {
                this.$select_box.on("dragstart", function () {
                    select_list.setMouseDownState();
                    return false;
                });
            }
            this.$ul_list.on("mouseenter", "li", function () {
                select_list.tracingSelect($(this));
            });
            this.$select_all.on("click", function () {
                if (select_list.isScrollToAdd && !select_list.$select_box.hasClass('selectlist_l_grn')) {
                    select_list._getAllMembers("select_all");
                }
                else {
                    select_list.selectAllMembers();
                    select_list.viewUnSelectAllLink();
                }

                if (select_list.isFacilityCandidate) {
                    select_list.updateAncestorsPath();
                }
            });
            this.$un_select_all.on("click", function () {
                select_list.unSelectAllMembers();
                select_list.viewSelectAllLink();
                if (select_list.isFacilityCandidate) {
                    select_list.updateAncestorsPath();
                }
            });

            this.$select_box.on("keydown", function (event) {
                var result = select_list.keyDown(event);
                if (select_list.isFacilityCandidate) {
                    select_list.updateAncestorsPath();
                }
                return result;
            });

            if (this.isScrollToAdd && this.isNeedScroll && !this.$select_box.hasClass('selectlist_l_grn')) {
                this.$select_box.on("scroll", function () {
                    var viewH = $(this).height(),
                        contentH = $(this).get(0).scrollHeight,
                        scrollTop = $(this).scrollTop();
                    if (contentH - viewH - scrollTop <= 1) {
                        select_list.loadMoreMember();
                    }
                });
            }

            setInterval(function () {
                select_list.scrollSelectBox();
            }, SCROLL_INTERVAL);

        },
        setMouseDownState: function () {
            this.isMouseDown = true;
            var select_list = this;
            this.mouseYFromList = this.$select_box.offset().top;
            $(document).on("mousemove.select_list", function (event) {
                select_list.mouseYFromList = event.pageY;
                return false;
            });

        },
        setMouseUpState: function () {
            this.isMouseDown = false;
            this.mouseYFromList = this.$select_box.offset().top;
            $(document).off("mousemove.select_list");

        },
        scrollSelectBox: function () {
            if (!this.isMouseDown) {
                return;
            }
            var scroll_position = this.$select_box.scrollTop();
            var offset = this.$select_box.offset().top;
            var scroll_speed = 0;
            var MARGIN = 8;
            var select_box_height = this.$select_box.prop("clientHeight");

            if (this.mouseYFromList < offset) {
                scroll_speed = this.mouseYFromList - offset;
            }
            if (this.mouseYFromList > offset + select_box_height - MARGIN) {
                scroll_speed = this.mouseYFromList - offset - select_box_height;
            }
            scroll_speed = Math.ceil(scroll_speed / MEMBER_HEIGHT_PX) * MEMBER_HEIGHT_PX;
            this.$select_box.scrollTop(scroll_position + scroll_speed);
        },
        orderTop: function () {
            var $selected = $("." + this.listName + "." + this.selectedClassName);
            $selected.remove();
            this.$ul_list.prepend($selected);
            this.scrollToTop();
        },
        orderUp: function () {
            var selected_class_name = this.selectedClassName;
            var $first_child = this.$ul_list.find("li:first-child");
            if (!$first_child.length) {
                return;
            }
            if ($first_child.attr("class").indexOf(selected_class_name) >= 0) {
                return;
            }
            var $selected_list = $("." + this.listName + "." + selected_class_name);
            $.each($selected_list, function (i, selected) {
                var $prev = $(selected).prev().not("." + selected_class_name);
                if ($prev) {
                    $(selected).insertBefore($prev);
                }
            });
            this.scrollToLastSelectedMember();
        },
        orderDown: function () {
            var selected_class_name = this.selectedClassName;
            var $last_child = this.$ul_list.find("li:last-child");
            if (!$last_child.length) {
                return;
            }
            if ($last_child.attr("class").indexOf(selected_class_name) >= 0) {
                return;
            }
            var $selected_list = $("." + this.listName + "." + selected_class_name).get().reverse();
            $.each($selected_list, function (i, selected) {
                var $next = $(selected).next().not("." + selected_class_name);
                if ($next) {
                    $(selected).insertAfter($next);
                }
            });
            this.scrollToLastSelectedMember();
        },
        orderBottom: function () {
            var $selected = $("." + this.listName + "." + this.selectedClassName);
            $selected.remove();
            this.$ul_list.append($selected);
            this.scrollToBottom();
        },
        scrollToTop: function () {
            this.$select_box.scrollTop(0);
        },
        scrollToBottom: function () {
            this.$select_box.scrollTop(this.$ul_list.height());
        },
        scrollToLastSelectedMember: function () {
            if (!this.lastSelectedId) {
                return;
            }
            var $lastSelectedMember = $("#" + this.lastSelectedId);
            if (!$lastSelectedMember.length) {
                return;
            }
            this._scrollToMember($lastSelectedMember);
        },

        loadMoreMember: function () {
            if (this.isLoading) {
                return;
            }
            this.isLoading = true;
            this.spinnerScrollOn();
            var request = new grn.component.ajax.request({
                    grnUrl: this.ajaxGetMemberListUrl,
                    method: "post",
                    dataType: "json",
                    data: this.parameterForGetMoreMember
                }
            );
            request.send().done(
                function (json_obj) {
                    this.appendMembers(json_obj["members_info"]);
                    if (!json_obj["is_need_scroll"]) {
                        this.$select_box.unbind('scroll');
                    }
                    this.setOffset();
                }.bind(this)
            ).fail(
                function () {
                    this.$select_box.unbind('scroll');
                }.bind(this)
            ).always(
                function () {
                    this.spinnerScrollOff();
                    this.isLoading = false;
                }.bind(this)
            );
        },

        setOffset: function () {
            this.parameterForGetMoreMember.more_user_offset = parseInt(this.parameterForGetMoreMember.more_user_offset)
                + parseInt(this.parameterForGetMoreMember.more_user_limit);
        },

        /**
         *
         * @param select_type
         * @private
         */
        _getAllMembers: function (select_type) {
            if (this.isLoading) {
                return;
            }
            this.spinnerOn();
            this.parameterForGetMoreMember.more_user_offset = 0;
            this.parameterForGetMoreMember.more_user_limit = -1;
            this.isLoading = true;
            var request = new grn.component.ajax.request({
                    grnUrl: this.ajaxGetMemberListUrl,
                    method: "post",
                    dataType: "json",
                    data: this.parameterForGetMoreMember
                }
            );
            request.send().done(
                function (json_obj) {
                    this.addMembers(json_obj["members_info"]);
                    if (select_type == "select_all") {
                        this.selectAllMembers();
                        this.viewUnSelectAllLink();
                    }
                    if (select_type == "page_down_with_shift") {
                        this._selectRangeMemberToLast();
                    }
                    if (select_type == "page_down") {
                        this._unSelectAllMembers();
                        this._selectLastMember();
                    }
                    this.$select_box.unbind('scroll');
                }.bind(this)
            ).always(
                function () {
                    this.spinnerOff();
                    this.isLoading = false;
                }.bind(this)
            );
        },

        /**
         *
         * @param {jQuery|HTMLElement} $clicked_member
         * @private
         */
        _selectMember: function ($clicked_member) {
            $clicked_member.addClass(this.selectedClassName);
            this.lastSelectedId = $clicked_member.attr("id");
            this.lastRangedId = null;
        },
        /**
         *
         * @param {jQuery|HTMLElement} $clicked_member
         * @private
         */
        _toggleMember: function ($clicked_member) {
            $clicked_member.toggleClass(this.selectedClassName);
            this.lastSelectedId = $clicked_member.attr("id");
            this.lastRangedId = null;
        },
        /**
         *
         * @param  {jQuery|HTMLElement} $selected_member
         * @private
         */
        _selectRangeMembers: function ($selected_member) {
            var selected_id = $selected_member.attr("id");
            var $last_clicked = $("#" + this.lastSelectedId);
            var $list = this.$ul_list.find("." + this.listName);
            var clicked_index = $list.index($selected_member);
            var last_clicked_index = $list.index($last_clicked);
            var gt, lt;
            var condition = "li";
            if (clicked_index <= last_clicked_index) {
                gt = clicked_index - 1;
                lt = last_clicked_index - clicked_index + 1;
            } else {
                gt = last_clicked_index - 1;
                lt = clicked_index - last_clicked_index + 1;
            }
            if (gt >= 0) {
                condition += ":gt(" + gt + ")";
            }
            condition += ":lt(" + lt + ")";
            this.$ul_list.find(condition).addClass(this.selectedClassName);
            this.lastRangedId = selected_id;
        },
        /**
         *
         * @private
         */
        _selectRangeMemberToFirst: function () {
            var $first = $("#ul_" + this.listName).children().first();
            this._selectRangeMembers($first);
        },
        /**
         *
         * @private
         */
        _selectRangeMemberToLast: function () {
            var $last = $("#ul_" + this.listName).children().last();
            this._selectRangeMembers($last);
        },
        /**
         *
         * @private
         */
        _unSelectAllMembers: function () {
            $("." + this.listName + "." + this.selectedClassName).removeClass(this.selectedClassName);
        },
        /**
         *
         * @private
         */
        _selectAllMembers: function () {
            $("." + this.listName).addClass(this.selectedClassName);
        },
        /**
         *
         * @private
         */
        _selectFirstMember: function () {
            var $first = $("#ul_" + this.listName).children().first();
            $first.addClass(this.selectedClassName);
            this._scrollToMember($first);
            this.lastSelectedId = $first.attr("id");
            this.lastRangedId = null;
        },
        /**
         *
         * @private
         */
        _selectLastMember: function () {
            var $last = $("#ul_" + this.listName).children().last();
            $last.addClass(this.selectedClassName);
            this._scrollToMember($last);
            this.lastSelectedId = $last.attr("id");
            this.lastRangedId = null;
        },
        /**
         *
         * @returns {boolean} this returns value is used for bubbling.
         * @private
         */
        _selectAboveMember: function () {
            var last_id = this.lastRangedId ? this.lastRangedId : this.lastSelectedId;
            if (last_id) {
                var $prev = $("#" + last_id).prev();
                if ($prev.length) {
                    this._unSelectAllMembers();
                    $prev.addClass(this.selectedClassName);
                    this._scrollToMember($prev);
                    this.lastSelectedId = $prev.attr("id");
                    this.lastRangedId = null;
                    return false;
                }
                return true;
            } else {
                this._selectLastMember();
                return false;
            }
        },
        /**
         *
         * @returns {boolean} this returns value is used for bubbling.
         * @private
         */
        _selectBelowMember: function () {
            var last_id = this.lastRangedId ? this.lastRangedId : this.lastSelectedId;
            if (last_id) {
                var $next = $("#" + last_id).next();
                if ($next.length) {
                    this._unSelectAllMembers();
                    $next.addClass(this.selectedClassName);
                    this._scrollToMember($next);
                    this.lastSelectedId = $next.attr("id");
                    this.lastRangedId = null;
                    return false;
                }
                return true;
            } else {
                this._selectFirstMember();
                return false;
            }
        },
        /**
         *
         * @private
         */
        _selectAboveMemberFurther: function () {
            var $select, $prev;
            if (this.lastRangedId) {
                $select = $("#" + this.lastRangedId);
            } else {
                $select = $("#" + this.lastSelectedId);
            }
            $prev = $select.prev();
            if ($prev.length) {
                $select.removeClass(this.selectedClassName);
                this._selectRangeMembers($prev);
                this._scrollToMember($prev);
            }
        },
        /**
         *
         * @private
         */
        _selectBelowMemberFurther: function () {
            var $select, $next;
            if (this.lastRangedId) {
                $select = $("#" + this.lastRangedId);
            } else {
                $select = $("#" + this.lastSelectedId);
            }
            $next = $select.next();
            if ($next.length) {
                $select.removeClass(this.selectedClassName);
                this._selectRangeMembers($next);
                this._scrollToMember($next);
            }
        },
        _scrollToMember: function ($member) {
            var offset = $member.offset().top - this.$ul_list.offset().top;
            var scroll_position = this.$select_box.scrollTop();
            var select_box_height = this.$select_box.prop("clientHeight") - MEMBER_HEIGHT_PX;
            if (scroll_position >= offset) {
                this.$select_box.scrollTop(offset);
            } else if (scroll_position + select_box_height <= offset) {
                this.$select_box.scrollTop(offset - select_box_height);
            }
        },
        removeSelectedMembers: function () {
            var remove_selected_members = this.getSelectedList().toArray();
            $("." + this.listName + "." + this.selectedClassName).remove();
            return remove_selected_members;
        },
        removeSelectedFacilities: function () {
            this.removeSelectedMembers();
        },
        removeMembers: function () {
            $("." + this.listName).remove();
        },

        unSelectAllMembers: function () {
            this._unSelectAllMembers();
        },
        selectAllMembers: function () {
            this._selectAllMembers();
        },

        /**
         *
         * @param {jQuery|HTMLElement} $clicked_member
         * @param event
         */
        clickMember: function ($clicked_member, event) {
            if (this.isTouchSupported) {
                this._toggleMember($clicked_member);
            } else if (event.shiftKey && this.lastSelectedId) {
                this._unSelectAllMembers();
                this._selectRangeMembers($clicked_member);
            } else if (this._isCommandKey(event)) {
                this._toggleMember($clicked_member);
            } else {
                this._unSelectAllMembers();
                this._selectMember($clicked_member);
            }
        },
        /**
         *
         * @param {jQuery|HTMLElement} $hovered_member
         */
        tracingSelect: function ($hovered_member) {
            if (this.isMouseDown && this.lastSelectedId) {
                this._unSelectAllMembers();
                this._selectRangeMembers($hovered_member);
                if (this.isFacilityCandidate) {
                    this.updateAncestorsPath();
                }
            }
        },
        /**
         *
         * @param event
         * @returns {boolean}
         */
        keyDown: function (event) {
            var key_code = event.keyCode;
            var KEYS = {
                PAGE_UP: 33,
                PAGE_DOWN: 34,
                END: 35,
                HOME: 36,
                UP: 38,
                DOWN: 40,
                A: 65
            };
            if (key_code === KEYS.UP) {
                if (event.shiftKey && this.lastSelectedId) {
                    this._selectAboveMemberFurther();
                    return false;
                } else {
                    return this._selectAboveMember();
                }
            }
            if (key_code === KEYS.DOWN) {
                if (event.shiftKey && this.lastSelectedId) {
                    this._selectBelowMemberFurther();
                    return false;
                } else {
                    return this._selectBelowMember();
                }
            }
            if (key_code === KEYS.PAGE_UP || key_code === KEYS.HOME) {
                if (event.shiftKey && this.lastSelectedId) {
                    this._selectRangeMemberToFirst();
                } else {
                    this._unSelectAllMembers();
                    this._selectFirstMember();
                    return false;
                }
            }
            if (key_code === KEYS.PAGE_DOWN || key_code === KEYS.END) {
                if (this.isScrollToAdd && !this.$select_box.hasClass('selectlist_l_grn')) {
                    var select_type = "page_down";
                    if (event.shiftKey && this.lastSelectedId) {
                        select_type = "page_down_with_shift";
                    }
                    this._getAllMembers(select_type);
                }
                else
                {
                    if (event.shiftKey && this.lastSelectedId) {
                        this._selectRangeMemberToLast();
                    } else {
                        this._unSelectAllMembers();
                        this._selectLastMember();
                        return false;
                    }
                }
            }
            if (key_code === KEYS.A && this._isCommandKey(event)) {
                this._selectAllMembers();
                return false;
            }
            return true;
        },
        /**
         *
         * @param event
         * @returns {boolean}
         * @private
         */
        _isCommandKey: function (event) {
            if (navigator.userAgent.indexOf('Mac') !== -1) {
                return event.metaKey;
            } else {
                return event.ctrlKey;
            }
        },

        /**
         *
         * @returns {jQuery}
         */
        jQuery: function () {
            if (this.isCurrentScreen) {
                return $;
            } else {
                return window.opener.jQuery;
            }
        },

        /**
         *
         * @returns {jQuery|HTMLElement}
         */
        getList: function () {
            return this.jQuery()("." + this.listName);
        },
        /**
         *
         * @returns {Array}
         */
        getValues: function () {
            return $.map(this.getList(), this.getValue);
        },
        /**
         *
         * @param target
         * @returns {string}
         */
        getValue: function (target) {
            return $(target).attr("data-value").split(":")[0];
        },
        /**
         *
         * @returns {Array}
         */
        getSelectedUsersValues: function () {
            return $.map(this.getSelectedList(), this.getValue);
        },
        /**
         *
         * @returns {jQuery|HTMLElement}
         */
        getSelectedList: function () {
            return $("." + this.listName + "." + this.selectedClassName);
        },
        /**
         * Get the users are belong to organization or role  (organization and role aren't included)
         *
         * @return {jQuery|HTMLElement}
         */
        getUsersList: function () {
            return this.jQuery()("." + this.listName + "[data-type='user']");
        },
        /**
         *
         * @param {object} users_info
         * @param {boolean=} selected_flag
         */
        addMembers: function (users_info, selected_flag) {
            this.removeMembers();
            this.appendMembers(users_info, selected_flag);
        },

        /**
         *
         * @param {object} users_info
         * @param {boolean=} selected_flag
         */
        appendMembers: function (users_info, selected_flag){
            var self = this;
            var fragmentNode = document.createDocumentFragment();
            var class_name = this.listName;
            class_name += selected_flag ? " " + this.selectedClassName : "";
            Object.keys(users_info).forEach(function (key) {
                var user_info = users_info[key];
                var member_id = (self.listName + "_member_" + user_info["type"] + "_" + user_info["id"]).replace(":", "-");
                var is_omitted_member = (user_info["type"] === member_select_list.MEMBER_TYPES.OMITTED);
                var data = self.getLabelAndClassName(user_info);
                var liNode = document.createElement('li');
                if ($("#" + member_id).length <= 0) {
                    liNode.id = member_id;
                    liNode.className = class_name;
                    liNode.setAttribute('data-value', PREFIXES[user_info["type"]] + user_info["id"]);
                    if (user_info["foreignKey"]) {
                        liNode.setAttribute("data-code", user_info["foreignKey"]);
                    }
                    liNode.setAttribute("data-name",  user_info["displayName"]);
                    liNode.setAttribute('data-type', user_info["type"]);
                    var spanNode1 = document.createElement('span');
                    spanNode1.className = data["class_name"];
                    if (!is_omitted_member) {
                        spanNode1.setAttribute('aria-label', data["label"]);
                        spanNode1.title = data["label"];
                    }
                    var spanNode2 = document.createElement('span');
                    spanNode2.className = "selectlist_text_grn";
                    if (is_omitted_member) {
                        spanNode2.className += " selectlist_text_omitted_grn";
                    }
                    spanNode2.textContent = user_info["displayName"];
                    liNode.appendChild(spanNode1);
                    liNode.appendChild(spanNode2);
                    fragmentNode.appendChild(liNode);
                }
            });
            $("#ul_" + this.listName).append(fragmentNode);
        },
        /**
         *
         * @param {object}facilities_info
         * @param {boolean=}selected_flag
         */
        addFacilities: function (facilities_info, selected_flag) {
            this.removeMembers();
            var self = this;
            var fragmentNode = document.createDocumentFragment();
            var class_name = this.listName;
            class_name += selected_flag ? " " + this.selectedClassName : "";
            facilities_info.forEach(function (facility_info) {
                var facility_id = (self.listName + "_member_facility_" + facility_info["id"]);
                var liNode = document.createElement('li');
                liNode.id = facility_id;
                liNode.className = class_name;
                liNode.setAttribute('data-value', facility_info["id"]);
                liNode.setAttribute('data-approval', facility_info["approval"]);
                liNode.setAttribute('data-repeat', facility_info["repeat"]);
                liNode.setAttribute('data-ancestors', facility_info["ancestors"]);
                liNode.setAttribute("data-code", facility_info["code"]);
                liNode.setAttribute("data-name", facility_info["name"]);
                var spanNode1 = document.createElement('span');
                spanNode1.className = "selectlist_facility_grn";
                var spanNode2 = document.createElement('span');
                spanNode2.className = "selectlist_text2_grn";
                spanNode2.textContent = facility_info["name"];
                liNode.appendChild(spanNode1);
                liNode.appendChild(spanNode2);
                fragmentNode.appendChild(liNode);
            });
            $("#ul_" + this.listName).append(fragmentNode);
            this.lastSelectedId = null;
            this.lastRangedId = null;
        },
        updateAncestorsPath: function () {
            var $parent_path_node = $('#selected-path');
            var list = this.getSelectedList();
            if (list.length === 1) {
                var path = $(list[0]).attr("data-ancestors");
                if (path === '') {
                    path = grn.component.i18n.cbMsg('grn.schedule', 'GRN_SCH-808');
                }
                $parent_path_node.text(path);
            } else {
                $parent_path_node.text('');
            }

        },
        /**
         *
         * @returns {Array}
         */
        getRepeatableSelectedFacilitiesValues: function () {
            return $.map(this.getList().filter("[data-repeat=1]"), this.getValue);
        },
        spinnerOn: function () {
            $("#spinner_" + this.listName).show();
        },
        spinnerOff: function () {
            $("#spinner_" + this.listName).hide();
        },
        spinnerScrollOn: function () {
            $("#spinner_scroll_" + this.listName).show();
        },
        spinnerScrollOff: function () {
            $("#spinner_scroll_" + this.listName).hide();
        },
        viewSelectAllLink: function () {
            this.$select_all.css("display", "");
            this.$un_select_all.css("display", "none");
        },
        viewUnSelectAllLink: function () {
            this.$un_select_all.css("display", "");
            this.$select_all.css("display", "none");
        },
        viewSelectAllOrClearAllLink: function () {
            if (this.getList().length && this.getList().length == this.getSelectedList().length) {
                this.viewUnSelectAllLink();
            } else {
                this.viewSelectAllLink();
            }
        },
        /**
         *
         * @param {boolean} is_only_selected
         * @returns {string}
         */
        makeHTMLTextForConfirmView: function (is_only_selected) {
            var $list;
            var self = this;
            var name = this.shortListName;
            if (is_only_selected) {
                $list = $("." + this.listName + '.' + this.selectedClassName);
            } else {
                $list = $("." + this.listName);
            }

            return $.map($list, function (member, index) {
                return '<input type="hidden" name="' + name + '[' + index + ']" value="' + self.getValue(member) + '">';
            }).join('');
        },
        /**
         *
         * @param {object} user_info
         * @returns {{label:string|undefined, class_name:string}}
         */
        getLabelAndClassName: function (user_info) {
            if (user_info["type"] === member_select_list.MEMBER_TYPES.USER) {
                if (user_info["isLoginUser"] === true) {
                    return {
                        "label": grn.component.i18n.cbMsg('grn.grn', 'GRN_GRN-LOGIN_USER'),
                        "class_name": "selectlist_user_login_grn"
                    };
                }
                if (user_info["isInvalidUser"] === true) {
                    return {
                        "label": grn.component.i18n.cbMsg('grn.grn', 'GRN_GRN-INACTIVE_USER'),
                        "class_name": "selectlist_user_invalid_grn"
                    };
                }
                if (user_info["isNotUsingApp"] === true) {
                    return {
                        "label": grn.component.i18n.cbMsg('grn.grn', 'GRN_GRN-NOT_APPLICATION_USER'),
                        "class_name": "selectlist_user_invalid_app_grn"
                    };
                }
                //Return default user icon.
                return {
                    "label": grn.component.i18n.cbMsg('grn.grn', 'GRN_GRN-1571'),
                    "class_name": "selectlist_user_grn"
                };

            }
            if (user_info["type"] === member_select_list.MEMBER_TYPES.GROUP) {
                if (this.isCalendar === true) {
                    return {
                        "label": grn.component.i18n.cbMsg('grn.grn', 'GRN_GRN-ORGANIZATION_PLAN'),
                        "class_name": "selectlist_cal_group_grn"
                    };
                }
                return {
                    "label": grn.component.i18n.cbMsg('grn.grn', 'GRN_GRN-ORGANIZATION'),
                    "class_name": "selectlist_group_grn"
                };
            }
            var is_static_role = user_info["type"] === member_select_list.MEMBER_TYPES.ROLE;
            var is_dynamic_role = user_info["type"] === member_select_list.MEMBER_TYPES.DYNAMIC_ROLE;
            if (is_static_role || is_dynamic_role) {
                return {
                    "label": grn.component.i18n.cbMsg('grn.grn', 'GRN_GRN-ROLE'),
                    "class_name": "selectlist_role_grn"
                };
            }
            if (user_info["type"] === member_select_list.MEMBER_TYPES.OMITTED) {
                return {
                    "class_name": "selectlist_omitted_grn"
                };
            }
        }
    };
})(jQuery);
