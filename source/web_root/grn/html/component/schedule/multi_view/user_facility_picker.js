(function ($) {
    "use strict";

    grn.base.namespace("grn.component.schedule.user_facility_picker");

    var _options = {
        maxListMemberAdded: 20,
        minLength: 1, // The minimum number of characters a user must type before a search is performed.
        timeDelay: 100,//The delay in milliseconds between when a keystroke occurs and when a search is performed.
        url: "schedule/ajax_user_org_facility_list",//The url for receives server data,
        container: "cb-user-picker"
    };

    grn.component.schedule.user_facility_picker = function (options) {
        grn.component.pubsub.installTo(this);
        this.options = $.extend({}, _options, options);
        this._memberList = new grn.component.schedule.multi_view.member_list();
    };

    var G = grn.component.schedule.user_facility_picker;

    G.prototype = {
        MEMBER_TYPE: {
            USER: "user",
            ORGANIZATION: "org",
            FACILITY: "facility"
        },

        suggestList: null,

        viewUtil: grn.component.schedule.multi_view.util,

        htmlTemplate: {
            component: "<table class='table_plain_grn calendar_user_facility_list_base_grn'>" +
            "   <tbody>" +
            "       <tr>" +
            "           <td style='width:1%;line-height: 18px;' class='vAlignTop-grn'>" +
            "               <span class='user_facility_listitem_sub_grn small_button_base_grn'>" +
            "                   <span class='aButtonStandard-grn'>" +
            "                       <a href='javascript:void(0)' class='js_check_all_member'>" +
            "                           <span class='listcheck_button_grn'> </span>" +
            "                       </a>" +
            "                   </span>" +
            "               </span>" +
            "           </td>" +
            "            <td class='vAlignTop-grn'>" +
            "               <div class='calendar_user_facility_list_grn'>" +
            "                   <ul class='listitem_delete_grn js_added_list'>" +
            "                       <li class='js_input_controller'>" +
            "                           <span class='user_facility_listitem_sub_grn nowrap-grn'>" +
            "                               <div class='searchbox-grn inline_block_grn mRight3'>" +
            "                                   <div id='searchbox-schedule-schedules' class='input-text-outer-schedule " +
            "searchbox-keyword-schedule'>" +
            "                                       <input type='text' class='input-text-schedule' name='search_text' autocomplete='off'>" +
            "                                   </div>" +
            "                               </div>" +
            "                               <a style='margin-left:-3px;' href='javascript:void(0);' class='action_base_grn js_add_command'>" +
            "                                   <span class='icon_add_grn icon_only_grn'></span>" +
            "                               </a>" +
            "                           </span>" +
            "                       </li>" +
            "                       <li class='js_msg_over_load_selected'>" +
            "                           <span class='icon_attention_grn'>" +
            "                               <span class='attentionMessage-grn js_msg'></span>" +
            "                           </span>" +
            "                       </li>" +
            "                   </ul>" +
            "               </div>" +
            "           </td>" +
            "       </tr>" +
            "   </tbody>" +
            "</table>",

            userFacilitySelected: "<li class='js_member'>" +
            "    <span class='user_facility_listitem_grn js_color_block'>" +
            "        <input type='checkbox' class='view_item_checkbox js_checkbox' checked/>" +
            "            <a class='js_label_a'>" +
            "                <span class='js_label'></span>" +
            "            </a>" +
            "        <a class='closebutton js_del_icon' href='javascript:void(0);'></a>" +
            "    </span>" +
            "</li>",

            orgSelected: "<span class='v-allign-middle'>" +
            "    <span class='js_label'></span>" +
            "</span>"
        },

        cssSelector: {
            classPrefix: ".",
            body: "body",
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
            inputController: ".js_input_controller",
            checkAllMember: ".js_check_all_member",
            searchInput: "input[type='text']",
            addCommand: ".js_add_command",
            msgOverLoadSelected: ".js_msg_over_load_selected",
            inputIncrementalSearch: ".js_input_incremental_search",
            addedList: ".js_added_list",
            msg: ".js_msg"
        },

        cssClass: {
            inputIncrementalSearch: "js_input_incremental_search"
        },

        KEY_CODE: {
            BACK_SPACE: 8,
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
            MEMBER_DATA: "memberData",
            TITLE: "title",
            HEAD: "head",
            CLICK: "click",
            KEY_UP: "keyup",
            MOUSE_UP: "mouseup",
            SELECTED: "selected",
            CHECKED: "checked",
            CHANGE: "change",
            CUT: "cut",
            HREF: "href",
            TARGET: "target",
            BLANK: "_blank",
            UNDEFINED: "undefined",
            MOUSE_DOWN: "mousedown",
            OBJECT: "object",
            STR_SEPARATOR: "; ",
            GREATER_LESS_SIGN: "><",
            WHICH: "which",
            BUTTON: "button",
            EMPTY: ""
        },

        JS_RESOURCES: {
            DELETE_TOOLTIP: grn.component.i18n.cbMsg("grn.schedule", "GRN_SCH-1051"),
            CHECK_UNCHECKED: grn.component.i18n.cbMsg("grn.schedule", "GRN_SCH-1050"),
            ADD: grn.component.i18n.cbMsg("grn.schedule", "GRN_SCH-1049"),
            OVER_LOAD_SELECTED: grn.component.i18n.cbMsg("grn.schedule", "GRN_SCH-1052")
        },

        _memberList: null,

        isLoading: false, //be used to prevent "Select or clear all checkboxes" while the last request is being processed


        /**
         * The prepend function. It uses to initialize this component.
         */
        init: function () {
            this.createComponent();
            this.cacheElements();

            this.suggestList = new grn.component.user_org_facility_suggest_list({
                url: this.options.url
            });
            this.suggestList.init();
            this.bindEvents();

            this.$inputControl.hide();

            //Controlling the input or msg overload
            this.$msgOverloadAdded.hide();
            this.$inputController.show();

            this.htmlTemplate.userFacilitySelected = this.htmlTemplate.userFacilitySelected.replace(/>\s+</g, this.KEY_WORD.GREATER_LESS_SIGN);
            this.htmlTemplate.orgSelected = this.htmlTemplate.orgSelected.replace(/>\s+</g, this.KEY_WORD.GREATER_LESS_SIGN);
        },

        /**
         * The function created the html of component to document. It will be replaced "options.container" on tpl file.
         */
        createComponent: function () {
            var container = $(this.htmlTemplate.component.replace(/>\s+</g, this.KEY_WORD.GREATER_LESS_SIGN))
                .addClass(this.options.container);

            container.find(this.cssSelector.checkAllMember).prop(this.KEY_WORD.TITLE, this.JS_RESOURCES.CHECK_UNCHECKED);
            container.find(this.cssSelector.searchInput).addClass(this.cssClass.inputIncrementalSearch);
            container.find(this.cssSelector.addCommand).prop(this.KEY_WORD.TITLE, this.JS_RESOURCES.ADD);
            container.find(this.cssSelector.msgOverLoadSelected).find(this.cssSelector.msg).
                text(this.JS_RESOURCES.OVER_LOAD_SELECTED.replace("%d", this.options.maxListMemberAdded));

            $(this.cssSelector.classPrefix + this.options.container).replaceWith(container);
        },

        /**
         * The function creates variables and cache for this component using
         */
        cacheElements: function () {
            this.$body = $(this.cssSelector.body);
            this.$container = $(this.cssSelector.classPrefix + this.options.container);
            this.$checkAllMembers = this.$container.find(this.cssSelector.checkAllMember);
            this.$inputController = this.$container.find(this.cssSelector.inputController);
            this.$inputControl = this.$inputController.find(this.cssSelector.inputIncrementalSearch);
            this.$addCommand = this.$container.find(this.cssSelector.addCommand);
            this.$msgOverloadAdded = this.$container.find(this.cssSelector.msgOverLoadSelected);
            this.$addedList = this.$container.find(this.cssSelector.addedList);
        },

        /**
         * The function bind events for this component
         */
        bindEvents: function () {
            var self = this;

            this.$addCommand.on(this.KEY_WORD.CLICK, $.proxy(this.addInputCommand, this));
            this.$body.on(this.KEY_WORD.KEY_UP, $.proxy(this._handleKeyUp, this));
            this.$inputControl.on(this.KEY_WORD.CUT, $.proxy(this._cutSearchKey, this));

            this.$inputControl.autocomplete({
                source: function (request) {
                    self.suggestList.searchUserOrgFacility(request);
                },
                minLength: this.options.minLength,
                delay: this.options.timeDelay
            });

            this.$inputControl.on(this.KEY_WORD.MOUSE_UP, $.proxy(this._handleMouseUp, this));
            this.$body.on(this.KEY_WORD.MOUSE_UP, $.proxy(this._handleDocumentMouseUp, this));
            this.suggestList.on(this.KEY_WORD.SELECTED, $.proxy(this._selectMemberFromSuggestList, this));
            this.$checkAllMembers.on(this.KEY_WORD.CLICK, $.proxy(this._checkAllMember, this));
            this.$addedList.on(this.KEY_WORD.CLICK, this.cssSelector.onOffEvent, $.proxy(this._hasChanged, this));
            this.$addedList.on(this.KEY_WORD.CLICK, this.cssSelector.deleteIcon, $.proxy(this._removeMemberAdded, this));
        },

        /**
         * The function get member list
         * @returns {grn.component.schedule.multi_view.member_list}
         */
        getMemberList: function () {
            return this._memberList;
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

        _hideInputControl: function () {
            if (this.$inputControl.is(this.cssSelector.elementHide)) {
                this.$inputControl.hide();
            }

            this.suggestList.isSearched = false;
            this.suggestList.searchKey = null;
            this.suggestList.$suggestList.empty();
            this.suggestList.$containerSuggestedList.hide();
        },

        /**
         *
         * @param {MouseEvent} e
         */
        addInputCommand: function (e) {
            e.preventDefault();
            var isShowed = this.$inputControl.is(this.cssSelector.elementHide);
            if (!isShowed) {
                this.suggestList.$containerSuggestedList.hide();
                this.suggestList.$suggestList.empty();
                this.$inputControl.show();
                this.$inputControl.focus();
                this.$inputControl.val(this.KEY_WORD.EMPTY);
            }else{
                this._hideInputControl();
            }
            e.stopImmediatePropagation();
        },

        _handleDocumentMouseUp: function (e) {

            var self = this;
            var targetClass = e.target.className;
            var plusIcon = $(e.target).closest(this.cssSelector.addCommand).length;
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
            } else if (!plusIcon) {
                setTimeout(function () {
                    self._hideInputControl();
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

            var member = this._memberList.add({
                id: memberData._id,
                type: memberData.type,
                name: memberData.col_display_name,
                selected: true,
                url: memberData.url || this.KEY_WORD.EMPTY
            });

            if (member !== false) {
                this._renderSelectedMember(memberData, firingTrigger);
            }

            this._hideInputControl();
        },

        /**
         * The function stand memberInput data
         * @param {Object} memberDataInput - JSON data
         * @returns {Object}
         * @private
         */
        _translateIndex: function (memberDataInput) {
            if (memberDataInput == null) {
                return null;
            }

            return {
                _id: memberDataInput.id,
                col_display_name: memberDataInput.name,
                type: memberDataInput.type,
                selected: memberDataInput.selected || false,
                primary_group: memberDataInput.primary_group || this.KEY_WORD.EMPTY,
                colorId: memberDataInput.colorId,
                url: memberDataInput.url || this.KEY_WORD.EMPTY
            };
        },

        /**
         *
         * @param {Object} memberData
         * @param {Boolean} isFiringTrigger
         */
        _renderSelectedMember: function (memberData, isFiringTrigger) {
            var member_html;
            var primary_group;
            var css_class;
            var url;

            if (memberData == null) {
                return;
            }

            if (typeof memberData.selected === this.KEY_WORD.UNDEFINED) {
                memberData.selected = true;
            }

            member_html = $(this.htmlTemplate.userFacilitySelected);

            if (memberData.type === this.MEMBER_TYPE.ORGANIZATION) {
                member_html
                    .find(this.cssSelector.label).replaceWith(this.htmlTemplate.orgSelected);
            }

            primary_group = memberData.primary_group || this.KEY_WORD.EMPTY;

            if (primary_group !== this.KEY_WORD.EMPTY) {
                primary_group = this.KEY_WORD.STR_SEPARATOR + primary_group;
            }

            if (memberData.type === this.MEMBER_TYPE.ORGANIZATION) {
                memberData.col_display_name = "[" + memberData.col_display_name + "]";
            }

            member_html.find(this.cssSelector.displayName).text(memberData.col_display_name + primary_group);
            member_html.prop(this.KEY_WORD.MEMBER_DATA, memberData);
            member_html.find(this.cssSelector.onOffEvent).prop(this.KEY_WORD.CHECKED, memberData.selected);
            member_html.find(this.cssSelector.deleteIcon).prop(this.KEY_WORD.TITLE, this.JS_RESOURCES.DELETE_TOOLTIP);

            url = memberData.url || this.KEY_WORD.EMPTY;

            if (!url.match(/^javascript/)) {
                member_html.find(this.cssSelector.label).attr(this.KEY_WORD.TARGET, this.KEY_WORD.BLANK);
            }

            member_html.find(this.cssSelector.label).prop(this.KEY_WORD.HREF, memberData.url);
            member_html.insertBefore(this.$inputController);

            if (typeof this.viewUtil) {
                css_class = this.viewUtil.createEventBlockColorCss(memberData._id, memberData.type, this._memberList);
                member_html.children(this.cssSelector.colorBlock).addClass(css_class);
            }

            if (isFiringTrigger === true) {
                this._triggerChange();
            }

        },

        /**
         * Render members with state when page loads have selected members
         * @param {Object} dataResult - XHR ajax result
         * @param {string} textStatus - The text status of ajax
         * @param {object} jqXHR
         */
        _setMembers: function (dataResult, textStatus, jqXHR) {
            var members;
            var members_to_remove;
            var count_max_member;
            var member;
            var member_type;
            var member_data;

            if (typeof grn.component.error_handler !== this.KEY_WORD.UNDEFINED &&
                grn.component.error_handler.hasCybozuError(jqXHR) &&
                jqXHR.responseText.isJSON()) {
                grn.component.error_handler.show(jqXHR);
                return;
            }

            this.$container.find(this.cssSelector.memberAdded).detach();

            if (typeof dataResult !== this.KEY_WORD.OBJECT || Object.keys(dataResult).length < 1) {
                return;
            }

            if (dataResult.facility && dataResult.user && dataResult.org) {
                members = this._memberList.getMembers();
                members_to_remove = [];
                count_max_member = 0;
                for (var i = 0; i < members.length; i++) {
                    member = members[i];
                    member_type = member.type;
                    member_data = this._checkMemberExists(member, dataResult[member_type], member_type);

                    if (member_data != null) {
                        if (count_max_member < this.options.maxListMemberAdded) {
                            ++count_max_member;
                            member.name = member_data.col_display_name;
                            member.primary_group = member_data.primary_group || this.KEY_WORD.EMPTY;
                            member.url = member_data.url || this.KEY_WORD.EMPTY;
                            this._renderSelectedMember(this._translateIndex(member), false);
                        }
                    } else {
                        members_to_remove.push(member);
                    }
                }

                this._showInputController(count_max_member);

                for (i = 0; i < members_to_remove.length; i++) {
                    this._memberList.remove(members_to_remove[i]);
                }
            }
        },

        /**
         * The function check a member in member list
         * @param {Object} member - The member need to check
         * @param {grn.component.schedule.multi_view.member_list} memberList - The members list
         * @param {string} type - The value is user/facility
         * @returns {Object} member form member list in the case exists or null if not exists
         * @private
         */
        _checkMemberExists: function (member, memberList, type) {
            var count = Object.keys(memberList).length;

            for (var i = 0; i < count; i++) {
                if (memberList[i]._id === member.id && member.type === type) {
                    return memberList[i];
                }
            }

            return null;
        },

        /**
         * Trigger when member is changed
         * @private
         */
        _triggerChange: function () {
            this.trigger(this.KEY_WORD.CHANGE);
        },

        /**
         * The function for listens the checkbox is changed to fire a trigger.
         * @param event
         * @private
         */
        _hasChanged: function (event) {
            var target_event = event.target;
            var member_element = $(target_event).closest(this.cssSelector.memberAdded);
            var member_data = member_element.prop(this.KEY_WORD.MEMBER_DATA);
            var member = this._memberList.getById(member_data._id, member_data.type);

            member.selected = target_event.checked;
            this._triggerChange();
        },

        /**
         * The function controlled deleted member after selected
         * @param {MouseEvent} event
         */
        _removeMemberAdded: function (event) {
            event.preventDefault();

            var member_element = $(event.target).closest(this.cssSelector.memberAdded);
            var member_data = member_element.prop(this.KEY_WORD.MEMBER_DATA);

            this._memberList.remove({
                id: member_data._id,
                type: member_data.type
            });

            member_element.remove();
            this._triggerChange();
        },

        /**
         * The function render previous state members include facility or user
         * @param {grn.component.schedule.multi_view.member_list} memberList
         */
        setMemberList: function (memberList) {
            if (memberList.resolved) {
                this._setResolvedMemberList(memberList);
                this.isLoading = false;
                return;
            }

            var flag = this.KEY_WORD.SELECTED;
            var uids = [];
            var oids = [];
            var fids = [];
            var members;
            var request;

            if (typeof memberList === this.KEY_WORD.UNDEFINED) {
                this.isLoading = false;
                return;
            }

            this._memberList = memberList;
            this.isLoading = false;
            members = memberList.getMembers();

            for (var i = 0; i < members.length; i++) {
                if (members[i].id === this.KEY_WORD.EMPTY) {
                    continue;
                }

                if (members[i].type === this.MEMBER_TYPE.USER) {
                    uids.push(members[i].id);
                } else if (members[i].type === this.MEMBER_TYPE.ORGANIZATION) {
                    oids.push(members[i].id);
                }
                else if (members[i].type === this.MEMBER_TYPE.FACILITY) {
                    fids.push(members[i].id);
                }
            }

            request = new grn.component.ajax.request({
                grnUrl: this.options.url,
                method: "post",
                data: {
                    uids: uids,
                    oids: oids,
                    fids: fids,
                    flag: flag
                }
            });

            return request.send()
                .done($.proxy(this._setMembers, this));
        },

        /**
         * Set member list which is already loaded details data and render UI
         * @param {grn.component.schedule.multi_view.member_list} memberList
         */
        _setResolvedMemberList: function (memberList) {
            var self = this;
            this._memberList = memberList;
            var members = this._memberList.getMembers();
            var count_max_member = 0;

            this.$container.find(this.cssSelector.memberAdded).remove();

            members.forEach(function (member) {
                if (count_max_member < self.options.maxListMemberAdded) {
                    ++count_max_member;
                    self._renderSelectedMember(self._translateIndex(member), false);
                }
            });

            this._showInputController(count_max_member);
        },

        /**
         * The function handles check/unchecked all member on added list.
         * @param {MouseEvent} e
         * @private
         */
        _checkAllMember: function (e) {

            if (this.isLoading) {
                return;
            }
            this.isLoading = true;

            var member;
            var memberData;
            var memberElement;
            var allMembers = this.$container.find(this.cssSelector.membersCheckUnchecked);
            var memberIsChecked = this.$container.find(this.cssSelector.memberIsChecked);
            var self = this;

            e.preventDefault();

            if (allMembers.length < 1) {
                return;
            }

            if (allMembers.length === memberIsChecked.length) {
                memberIsChecked.prop(this.KEY_WORD.CHECKED, false);
            } else {
                allMembers.prop(this.KEY_WORD.CHECKED, true);
            }

            this.$container.find(this.cssSelector.memberAdded).each(function () {
                memberElement = $(this);
                memberData = memberElement.prop(self.KEY_WORD.MEMBER_DATA);
                member = self._memberList.getById(memberData._id, memberData.type);
                member.selected = memberElement.find(self.cssSelector.input).prop(self.KEY_WORD.CHECKED);
            });

            this._triggerChange();
        },

        /**
         * The function handles show/hide of the input and overload message on the added list
         * @param {number} countMaxMember
         * @private
         */
        _showInputController: function (countMaxMember) {

            if (countMaxMember >= this.options.maxListMemberAdded) {
                this.$inputController.hide();
                this.$msgOverloadAdded.show();
            } else {
                this.$inputController.show();
                this.$msgOverloadAdded.hide();
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
                    this._hideInputControl();
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
                    if (this.$inputControl.val().trim() === this.KEY_WORD.EMPTY) {
                        this.suggestList.$containerSuggestedList.hide();
                        this.suggestList.$suggestList.empty();
                    }
                    break;
            }
        }
    };
})(jQuery);

