/* global GRN_ScheduleSimpleAdd, JSON, isTouchDevice */

(function ($) {
    "use strict";

    grn.base.namespace("grn.component.schedule.multi_view.main");

    var url_component = grn.component.url;
    var date_component = grn.component.date;
    var multi_view = grn.component.schedule.multi_view;

    var default_settings = {
        container: {
            view: "#view",
            viewMain: ".view_main_area",
            calendar: ".calendar_area",
            timeSheet: ".showtime",
            timeSheetHeader: ".personal_calendar_time_sheet",
            withoutTimeEvents: ".without_time_events_area",
            allDayEvents: ".all_day_area",
            normalEvents: ".normal_events_area",
            miniCalendarNavigator: "#schedule_calendar",
            dateNavigator: ".moveButtonBlock-grn"
        },
        eventListUrl: 'schedule/ajax_event_list',
        simpleAddUrl: url_component.page("schedule/simple_add"),
        beginDate: "", //e.g. "2015-07-27"
        minTime: 8,
        maxTime: 18,
        eventTimeUnit: 30, // minutes
        dates: [], // date objects for rendering date column
        today: {},
        events: {},
        initialMembers: [],  // array of users, organizations, facilities will be added to the view
        memberList: {},      // list of users, organizations, facilities already added to the view
        numberOfDays: 7,
        facilityPlacement: "after_subject", // "after_subject" | "before_subject"
        loginUser: {}, // current logged in user. e.g. { id: 10, name: "Foo Bar" }
        enableDateFooter: true,
        enableDateNavigatorFooter: true,
        newEventId: null, // ID of the new event which is created by QuickAdd
        uid: null,
        gid: null,
        gidIsEmpty: false,
        plid: "",
        refererKey: null,
        usingPrivilege: null,
        showTodos: true,
        showExpiredTodos: true,
        enableDragAndDrop: false,
        shortDateFormat: "",
        locale: "",
        viewType: ""
    };

    grn.component.schedule.multi_view.main = function (settings) {
        this.settings = $.extend({}, default_settings, settings);
        this.ignoreNextHashChange = false;
    };

    /**
     * @alias grn.component.schedule.multi_view.main
     * @type {grn.component.schedule.multi_view.main}
     */
    var G = grn.component.schedule.multi_view.main;

    G.prototype.init = function() {
        var settings = this.settings;

        settings.today.value = date_component.parse(settings.today.value);

        settings.memberList = new multi_view.member_list();

        // if this param is set to "true", the members which have been saved
        // in the session on server side will be removed
        this._emptyMembers = false;

        this.$view = $(settings.container.view);

        this._initViewMainArea();

        this.$currentDate = this.$view.find(".displaydate");

        this.memberDialog = new multi_view.select_user_org_facility_dialog();
        this.memberDialog.setMemberList(settings.memberList);
        this.$openMemberDialogLink = this.$view.find("#select_users_facilities");

        this.memberPicker = new grn.component.schedule.user_facility_picker();
        this.memberPicker.init();

        this.memberDropdownlist = new multi_view.select_user_org_facility_dropdownlist();

        this.miniCalendarNavigator = new multi_view.mini_calendar_navigator(settings);

        this.dateNavigator = new multi_view.date_navigator(settings);

        this._initDisplayOptionsDropdownList();

        if (this.settings.enableDateNavigatorFooter) {
            this.calendarFooter = new multi_view.calendar_footer(settings);
        }

        this._bindEvents();

        this._loadState();
        this._reload();
    };

    G.prototype._bindEvents = function () {
        this.memberDialog.on("apply", $.proxy(this.memberDialogOnApply, this));
        this.$openMemberDialogLink.on("click", this.memberDialog.showDialog.bind(this.memberDialog));
        this.memberPicker.on("change", $.proxy(this._membersPickerOnChange, this));
        this.memberDropdownlist.on("select", $.proxy(this._memberDropdownlistOnSelect, this));
        this.miniCalendarNavigator.on("change", $.proxy(this._miniCalendarNavigatorOnChange, this));
        this.dateNavigator.on("change", $.proxy(this._dateNavigatorOnChange, this));
        $(window).on("hashchange", $.proxy(this._onHashChange, this));
    };

    G.prototype._onHashChange = function() {
        if (this.ignoreNextHashChange) {
            this.ignoreNextHashChange = false;
            return;
        }

        this._loadState();
        this._reload();
    };

    G.prototype._onEventDragStart = function() {
        // do not show tooltip when dragging event
        multi_view.event_tooltip.deactivate();
    };

    G.prototype._onEventDragStop = function() {
        multi_view.event_tooltip.activate();
    };

    G.prototype._renderCalendar = function () {
        var settings = this.settings;

        this.$currentDate.text(settings.dates[0].text_full);

        var time_sheet = new multi_view.time_sheet(settings);
        time_sheet.render();

        var normal_event_renderer = new multi_view.normal_event_renderer(settings);
        normal_event_renderer.render();

        var without_time_event_renderer = new multi_view.without_time_event_renderer(settings);
        without_time_event_renderer.render();

        var banner_renderer = new multi_view.banner_renderer(settings);
        banner_renderer.render();

        if (!isTouchDevice()) {
            multi_view.event_tooltip.init(settings);

            this._initQuickAdd();

            if (settings.enableDragAndDrop) {
                this._initDragDrop();
            }
        }

        if (this.calendarFooter) {
            this.calendarFooter.refresh();
        }
    };

    G.prototype._initViewMainArea = function() {
        this.$viewMain = this.$view.find(this.settings.container.viewMain);

        if (this.$viewMain.length === 0) {
            this.$viewMain = this.$view;
        }

        this.$viewMain.css("position", "relative"); // the this._$overlay DIV requires
    };

    G.prototype._initDragDrop = function() {
        var settings = this.settings;

        var event_resize = new grn.component.schedule.multi_view.event_resize(settings);
        event_resize.init();
        event_resize.on("eventUpdate", $.proxy(this._reload, this));
        event_resize.on("start", $.proxy(this._onEventDragStart, this));
        event_resize.on("stop", $.proxy(this._onEventDragStop, this));

        var event_drag_drop = new grn.component.schedule.multi_view.event_drag_drop(settings);
        event_drag_drop.init();
        event_drag_drop.on("eventUpdate", $.proxy(this._reload, this));
    };

    G.prototype._initQuickAdd = function() {
        var settings = this.settings;
        var self = this;
        var qAdd = Object.create(GRN_ScheduleSimpleAdd);

        var selected_members = [];
        var MEMBER_TYPE = multi_view.member_list.MEMBER_TYPE;
        var members = settings.memberList.getMembers();
        members.forEach(function(member){
            if (!member.selected) {
                return;
            }

            var prefix = "";
            switch (member.type) {
                case MEMBER_TYPE.ORGANIZATION:
                    selected_members.push("g" + member.id);
                    prefix = "g";
                    break;
                case MEMBER_TYPE.FACILITY:
                    prefix = "f";
                    break;
            }

            selected_members.push(prefix + member.id);
        });

        var configs = $.extend({
            members: selected_members,
            onAddSuccess: function() {
                self._reload();
            }
        }, settings);
        qAdd.cfg(configs);

        //remove previous created dialog
        $(".dialog").remove();

        var $selector = ".personal_day_calendar_time_row, .without_time_event_cell";
        this.$view.find( $selector).each(function() {
            var row = this;
            row.firstInit = false;
            row.dialog = undefined;
        });
        this.$view.off("dblclick", $selector, $.proxy(qAdd.doubleClickPersonalHandler, qAdd));
        this.$view.on("dblclick", $selector, $.proxy(qAdd.doubleClickPersonalHandler, qAdd));

        qAdd.enableDragAdd();
    };

    G.prototype._initDisplayOptionsDropdownList = function () {
        var self = this;

        this.$displayOptionDropDown = this.$view.find(".js_schedule_display_options_dropdown");
        var $show_todos_checkbox = this.$displayOptionDropDown.find(".js_show_todos input");
        var $show_expired_todos_checkbox = this.$displayOptionDropDown.find(".js_show_expired_todos input");

        function _update_settings() {
            self.settings.showTodos = $show_todos_checkbox.is(":checked");
            self.settings.showExpiredTodos = $show_expired_todos_checkbox.is(":checked");
        }

        this.$displayOptionDropDown.find("input").change(_update_settings);

        _update_settings();
    };

    G.prototype._reloadEvent = function() {
        var self = this;

        var request = this._fetchEvents();

        return request.done(function(data){
            self._parseEventsData(data);
            self.settings.dates = data.dates;
            self.settings.events = data.events;
            self.settings.minTime = data.minTime;
            self.settings.maxTime = data.maxTime;
            self.settings.calendarWeekStart = data.calendarWeekStart;
            self.settings.memberList = multi_view.member_list.createFromArray(data.members, true);
            self.settings.facilityPlacement = data.facilityPlacement;
        });
    };

    G.prototype._parseEventsData = function(data) {
        data.events.by_date.forEach(function (day_data) {
            var eventsNormal = day_data.events.normal || [];

            eventsNormal.forEach(function (event) {
                event.start_date_object = grn.component.date.parse(event.start_date);
                if ("end_date" in event) {
                    event.end_date_object = grn.component.date.parse(event.end_date);
                }
            });

        });

        data.events.banner.forEach(function (event) {
            event.start_date_object = grn.component.date.parse(event.start_date);
            event.end_date_object = grn.component.date.parse(event.end_date);
        });
    };

    G.prototype._fetchEvents = function() {
        var self = this;
        var settings = this.settings;

        var request_data = {
            referer_key: settings.refererKey,
            begin_date: settings.beginDate,
            number_of_days: settings.numberOfDays,
            uid: settings.uid,
            gid: settings.gid,
            selected_group_type: settings.selectedGroupType
        };

        if (settings.gid === "selected") {
            request_data.members = settings.memberList.getMembers()
                .map(function (member) {
                    return JSON.stringify({
                        id: member.id,
                        type: member.type,
                        selected: member.selected,
                        colorId: member.colorId
                    });
                });
        }

        if (settings.gid === "search" && settings.searchText) {
            request_data.search_text = settings.searchText;
        }

        if (this._emptyMembers) {
            // set this param to clear the members which have been saved in the session on server side
            request_data.members = "empty";
        }

        var request = new grn.component.ajax.request({
            grnUrl: this.settings.eventListUrl,
            grnLoadingIndicator: this._toggleSpinner.bind(this),
            method: "post",
            data: request_data
        });

        request.on("errorClosed", function (e, jqXHR) {
            self._handleCybozuError(request.getErrorHandler().getCybozuError(jqXHR));
        });

        return request.send();
    };

    G.prototype._handleCybozuError = function(error) {
        switch(error) {
            case "GRN_CMMN_00105": // user not found
            case "GRN_SCHD_13203": // facility not found
            case "GRN_SCHD_13050": // group not found
            case "GRN_SCHD_13042": // access denied
                // display logged-in user events
                this.settings.gid = "login";
                this.settings.uid = null;
                this._reloadAndSaveState();
                break;
        }
    };

    G.prototype._loadState = function() {
        var settings = this.settings;

        var url_params = url_component.parseQueryString(location.search);
        var url_hash = url_component.parseHash(location.hash);
        url_params = $.extend(url_params, url_hash);

        // member
        var member_id = url_params.uid || null;

        // group
        var group_id = url_params.gid || null;
        settings.gidIsEmpty = (group_id === null);

        // member list
        var member_list = null;
        settings.memberList.clear();

        if (url_params.members) {
            member_list = multi_view.util.parseMembersParam(url_params.members);
        }

        var member_list_is_empty = member_list && member_list.getMembers().length === 0;
        this._emptyMembers = url_params.members === "" || member_list_is_empty;

        // Priority of parameter for fetching event is in the following order: members, gid, uid.

        if (member_list) {
            // case of a member list is specified
            settings.gid = "selected";
            settings.memberList = member_list;
        } else if (group_id) {
            // case of a group is specified
            settings.gid = group_id;

            // the following condition is for compatible with the legacy code
            if (group_id === "virtual") {
                settings.gid = "selected";
            }

            // case of search
            if (group_id === "search") {
                settings.searchText = url_params.search_text;
            }

            /**
             * If the "uid" param is specified, the "gid" should be set to "selected".
             * It means one member is selected by user.
             */
            if (group_id === "selected" && member_id) {
                settings.uid = member_id;
            }

            if (group_id !== "selected") {
                settings.uid = null;
            }
        } else if (member_id) {
            // case of a member is specified
            settings.uid = member_id;
            settings.gid = "selected";
        } else {
            // default case
            settings.gid = "login";
        }

        // group select type (often-used / recently-selected facility group)
        settings.selectedGroupType = url_params.p || "";

        // begin date of the current view
        settings.beginDate = url_params.bdate || settings.beginDate;

        // validate format of the begin date, reset to today if the given date is invalid
        var beginDate = grn.component.date.parse(settings.beginDate);
        if (settings.beginDate !== jQuery.datepicker.formatDate("yy-mm-dd", beginDate)) {
            settings.beginDate = jQuery.datepicker.formatDate("yy-mm-dd", settings.today.value);
        }
    };

    G.prototype._saveState = function() {
        var hash_params = {};

        if (this.settings.gid === "selected") {
            hash_params.members = multi_view.util.serializeMembers(this.settings.memberList.getMembers());
        }

        hash_params.gid = this.settings.gidIsEmpty ? "" : this.settings.gid;
        hash_params.bdate = this.settings.beginDate;
        hash_params.p = this.settings.selectedGroupType;

        this.ignoreNextHashChange = true;
        url_component.changeCurrentLocationHash(hash_params);
    };

    G.prototype._reload = function() {
        var self = this;
        var begin_date = date_component.parse(this.settings.beginDate);

        return this._reloadEvent()
            .done(function (data) {
                self.dateNavigator.setDate(begin_date);
                self.miniCalendarNavigator.selectDate(begin_date);

                self._renderCalendar();
                self.memberPicker.setMemberList(self.settings.memberList);
                self.memberDialog.setMemberList(self.settings.memberList);

                if (data.group) {
                    self.memberDropdownlist.setSelectedGroup(data.group, self.settings.selectedGroupType);
                } else {
                    self.memberDropdownlist.setSelectedGroup(self.settings.gid, self.settings.selectedGroupType);
                }

                self._updateLinks();
                self._addUserClassNameJsApi();
                self.triggerJsApiShow(data);
            });
    };

    G.prototype._reloadAndSaveState = function() {
        this._reload()
            .done(this._saveState.bind(this));
    };

    /**
     * Update URL parameters for the links to another views, children page
     * @private
     */
    G.prototype._updateLinks = function() {
        var settings = this.settings;

        var selected_members = settings.memberList.getMembers().filter(function(member) {
            return member.selected;
        });

        var print_link_class = "schedule_print_personal_week";

        $("#menu_part a, .global_navi_title a").each(function () {
            var href = this.getAttribute("href");

            if (href.match(/^javascript:/)) {
                // do not change the link with javascript code
                // e.g. "Options" link (for operator)
                return;
            }

            // create parameters
            var is_print_link = $(this).hasClass(print_link_class);
            var gid = (settings.gidIsEmpty && !is_print_link) ? "" : settings.gid;

            var url_params = {
                bdate: settings.beginDate,
                gid: gid,
                p: settings.selectedGroupType
            };

            if (settings.gid === "selected") {
                url_params.uid = "";
            }

            // find "New" & "Arrange appointments" links to set members
            if (href.match(/schedule\/add|schedule\/adjust_search/)) {
                url_params.members = multi_view.util.serializeMembers(selected_members);
            }

            this.setAttribute("href", grn.component.url.setParameters(href, url_params));
        });
    };

    G.prototype.memberDialogOnApply = function() {
        this.settings.memberList = this.memberDialog.getMemberList();
        this.settings.gid = "selected";
        this.settings.gidIsEmpty = false;
        this.settings.uid = null;
        this._emptyMembers = this.settings.memberList.getMembers().length === 0;
        this._reloadAndSaveState();
    };

    G.prototype._membersPickerOnChange = function() {
        this.settings.memberList = this.memberPicker.getMemberList();
        this.settings.gid = "selected";
        this.settings.gidIsEmpty = false;
        this.settings.uid = null;
        this._emptyMembers = this.settings.memberList.getMembers().length === 0;
        this._reloadAndSaveState();
    };

    G.prototype._memberDropdownlistOnSelect = function(ev, data) {
        this.settings.gid = data.gid;
        this.settings.gidIsEmpty = false;
        this.settings.uid = null;
        this._emptyMembers = false;

        this.settings.selectedGroupType = "";
        if (data.node && data.node.extra_param) {
            this.settings.selectedGroupType = data.node.extra_param;
        }

        this._reloadAndSaveState();
    };

    G.prototype._miniCalendarNavigatorOnChange = function(ev, date) {
        this.settings.beginDate = jQuery.datepicker.formatDate("yy-mm-dd", date);
        this._reloadAndSaveState();
    };

    G.prototype._dateNavigatorOnChange = function(ev, date) {
        this.settings.beginDate = jQuery.datepicker.formatDate("yy-mm-dd", date);
        this._reloadAndSaveState();
    };

    G.prototype._toggleSpinner = function (option) {
        var zIndex = 900;

        // Create spinner
        if (!this._$spinner) {
            this._$spinner = $("<div class='spinnerBoxBase-grn spinnerCentered'><div class='spinnerBox-grn'></div></div>")
                .css("z-index", zIndex);
        }

        // When data is huge, continuously sending request may cause error on the server.
        // So when fetching data we create a overlay DIV which displays over the scheduler view area
        // to prevent user from clicking continuously on buttons for fetching data.
        if (!this._$overlay) {
            this._$overlay = $(document.createElement("div")).addClass("viewoverlay");
        }

        if (option === "show") {
            this._$spinner.appendTo(document.body);
            this._$overlay.appendTo(this.$viewMain);
        } else {
            this._$spinner.remove();
            this._$overlay.remove();
        }
    };

    /**
     * @param {object} data
     */
    G.prototype.triggerJsApiShow = function (data) {
        var self = this;
        var view_type = self.settings.viewType;
        if (grn.base.isNamespaceDefined("garoon.schedule.data")
            && garoon.schedule.data.isCustomizationAvailable
            && view_type !== "") {
            var week = [];
            data.dates.forEach(function (date) {
                week.push(date.value);
            });

            var view_events = {
                DAY: "schedule.calendar.dayIndex.show",
                WEEK: "schedule.calendar.weekIndex.show"
            };

            if (!view_events.hasOwnProperty(view_type)) {
                return;
            }

            var event_name = view_events[view_type];
            var event_data = { "type": event_name, "viewType": view_type, "dates": week };
            garoon.events.trigger(event_name, event_data);
        }
    };

    /**
     * @private
     */
    G.prototype._addUserClassNameJsApi = function () {
        var member_list = this.settings.memberList;
        var login_user_id = grn.data.login.id;
        var login_user_in_list = member_list.getById(login_user_id, "user");
        
        var user_calendar_class_name = "js_customization_schedule_user_id";
        var $user_calendar = this.$view.find("[class^='" + user_calendar_class_name + "']").first();
        
        if (typeof login_user_in_list !== "undefined" && login_user_in_list.selected) {
            user_calendar_class_name += "_" + login_user_id;
        }

        jQuery($user_calendar).attr("class", user_calendar_class_name);
    };
})(jQuery);
