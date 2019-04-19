(function () {
    "use strict";

    var CALENDAR_EVENT_TYPE_CSS_ICON_MAP = {
        "1": "calendar_event_icon_holiday",
        "2": "calendar_event_icon_anniversary",
        "3": "", // no icon for "Notes" type
        "4": "", // no icon for "Notes" type
        "5": "calendar_event_icon_workday"
    };

    grn.base.namespace("grn.component.schedule.multi_view.calendar_item_renderer");

    grn.component.schedule.multi_view.calendar_item_renderer = function (settings) {
        this.settings = settings;
    };

    /**
     * @alias grn.component.schedule.multi_view
     * @type {grn.component.schedule.multi_view}
     */
    var multi_view = grn.component.schedule.multi_view;

    /**
     * @alias grn.component.url
     * @type {grn.component.url}
     */
    var url_component = grn.component.url;

    /**
     * @alias grn.component.schedule.multi_view.calendar_item_renderer
     * @type {grn.component.schedule.multi_view.calendar_item_renderer}
     */
    var G = grn.component.schedule.multi_view.calendar_item_renderer;

    G.prototype.createNormalEventElement = function(event_data, params) {
        var settings = this.settings;

        var event_css = "critical3 schedule" + settings.plid + " " + this._createEventBlockCss(event_data);

        if (!multi_view.util.isOneDayEvent(event_data)) {
            if (event_data.type === "repeat" || event_data.type === "share_repeat") {
                event_css += " group" + event_data.id + event_data.start_date.substr(0, 10) + event_data.uid + settings.plid;
            }
            else {
                event_css += " group" + event_data.id + event_data.uid + settings.plid;
            }
        }

        if (params.start_at_mid_night) {
            event_css += " event_first_row";
        }

        var time_html = "";
        var subject_html = "";

        if ('private' in event_data) {
            time_html = event_data.showtime;
            subject_html = event_data.data;
        }
        else {
            var event_url = multi_view.util.createEventUrl(event_data, params, settings);

            time_html = this._createDateTimeElement(event_data, event_url);

            subject_html = this._createSubject(event_data, event_url);

            if (event_data.type === "share_temporary" || event_data.type === "temporary") {
                event_css = event_css + " temporary";
            }

            event_css += this._createCssIfNewEvent(event_data);
        }

        var event_element = document.createElement('div');

        event_element.className = event_css;

        event_element.innerHTML = '' +
        '<div class="event_content event_content_base">' +
        '<font size="-1">' +
        time_html + ' ' + subject_html +
        '</font>' +
        '</div>';

        return event_element;
    };

    G.prototype.createWithoutTimeEventElement = function(event_data, params) {
        var settings = this.settings;

        var event_css = "event_content_allday " + this._createEventBlockCss(event_data);

        var event_url = multi_view.util.createEventUrl(event_data, params, settings);

        var subject_html = this._createSubject(event_data, event_url);

        event_css += this._createCssIfNewEvent(event_data);

        var event_element = document.createElement("div");

        event_element.className = event_css;

        var allday_icon = "<span class='schedule_icon_allday'></span>";

        event_element.innerHTML = '' +
        '<span class="js_without_time_event_content">'+
        '   <font size="-1" >' +
        allday_icon + subject_html +
        '   </font>'+
        '</span>';

        return event_element;
    };

    G.prototype.createBannerElement = function(event_data) {
        var settings = this.settings;

        var event_css = "event_content_banner";

        var event_inner_css =  "normalEventElement " + this._createEventBlockCss(event_data);

        var event_url = multi_view.util.createEventUrl(event_data, null, settings);

        var subject_html = this._createSubject(event_data, event_url);

        event_css += this._createCssIfNewEvent(event_data);

        var event_element = document.createElement("div");

        event_element.className = event_css;

        event_element.innerHTML = '' +
        '<div class="' + event_inner_css + ' js_banner_event_content ">' +
        subject_html +
        '</div>';

        return event_element;
    };

    G.prototype.createCalendarElement = function(calendar_item) {
        var element = document.createElement("div");
        element.className = "personal_week_calendar_event_item";

        var element_inner = document.createElement("div");
        element.appendChild(element_inner);
        element_inner.className = "normalEventElement";

        var icon = document.createElement("span");
        icon.className = CALENDAR_EVENT_TYPE_CSS_ICON_MAP[calendar_item.type];
        element_inner.appendChild(icon);

        var text = document.createTextNode(calendar_item.data);
        element_inner.appendChild(text);

        return element;
    };

    G.prototype.createWeatherElement = function(calendar_item) {
        var escape = function(value) {
            return jQuery("<div>").text(value).html().replace(/'/g, "\\'").replace(/"/g, "\\\"");
        };

        var element = document.createElement("div");
        element.className = "personal_week_calendar_event_item";

        var element_inner = document.createElement("div");
        element_inner.className = "normalEventElement";
        element.appendChild(element_inner);

        var image;
        if (calendar_item.icon) {
            var src = grn.component.url.image("cybozu/" + calendar_item.icon);
            image = document.createElement("img");
            image.setAttribute("border", "0");
            image.setAttribute("src", src);
        }

        var link;
        if (calendar_item.data) {
            link = document.createElement("a");
            link.setAttribute("href", calendar_item.data.info.url);
            element_inner.appendChild(link);

            var details = calendar_item.data.info;
            var i18n = grn.component.i18n;

            var tooltip_html =
                "<nobr>" + escape(details.weather) + "<nobr>";

            link.setAttribute("onMouseOver", "tpon(event, '" + tooltip_html + "')");
            link.setAttribute("onMouseOut", "tpoff()");
            link.setAttribute("target", "_blank");

            var text = document.createTextNode(calendar_item.data.location_name);

            if (image) {
                link.appendChild(image);
            }

            link.appendChild(text);
        }

        if (image && !link) {
            element_inner.appendChild(image);
        }

        return element;
    };

    G.prototype.createTodoElement = function(todo, todo_type) {
        var element = document.createElement("div");
        element.className = "schedule_todo normalEventElement";

        if (!this.settings.showTodos) {
            element.style.display = "none";
        }

        var icon = document.createElement("span");
        icon.className = "schedule_icon_todo";
        element.appendChild(icon);

        var link = document.createElement("a");
        link.textContent = todo.title;
        link.href = this._createTodoUrl(todo, todo_type);
        element.appendChild(link);

        return element;
    };

    G.prototype.createExpiredTodoElement = function(todo, todo_type) {
        var element = document.createElement("div");
        element.className = "schedule_expired_todo normalEventElement";

        if (!this.settings.showExpiredTodos) {
            element.style.display = "none";
        }

        var icon = document.createElement("span");
        icon.className = "schedule_icon_todo_expired";
        element.appendChild(icon);

        var link = document.createElement("a");
        link.textContent = todo.title;
        link.href = this._createTodoUrl(todo, todo_type);
        element.appendChild(link);

        return element;
    };

    G.prototype._createTodoUrl = function(todo, todo_type) {
        var todoUrl = "";
        if (todo_type === "private") {

            todoUrl = url_component.page('todo/view', {tid: todo.tid || todo.id });

        } else if (todo_type === "shared") {

            todoUrl = url_component.page('space/application/todo/view', {
                spid: todo.space_id,
                tdid: todo.todo_id
            });

        }
        return todoUrl;
    };

    G.prototype._createEventBlockCss = function(event_data) {
        var member = multi_view.util.getMemberFromEvent(event_data);

        if(event_data.relatedEvents){
            return "event_block_color_share_grn";
        }
        return multi_view.util.createEventBlockColorCss(member.id, member.type, this.settings.memberList);
    };

    G.prototype._createIconsOnLeftSide = function(event_data) {
        var icons = "";

        var show_attendance_icon = event_data.attendance_check_show || false;

        if (event_data.type === "banner") {
            icons += "<span class='schedule_icon_banner'></span>";
        }

        if (event_data.conflict) {
            icons += "<span class='schedule_icon_attention'></span>";
        }

        if (show_attendance_icon) {
            icons += "<span class='schedule_icon_event_unanswered'></span>";
        }

        return icons;
    };

    G.prototype._createIconsOnRightSide = function(event_data) {
        var icons = "";

        if ("is_private" in event_data) {
            icons += "<span class='schedule_icon_event_private'></span>";
        }

        if (event_data.type === "repeat" || event_data.type === "share_repeat") {
            icons += "<span class='schedule_icon_event_repeat'></span>";
        }

        if ("report" in event_data) {
            icons += "<span class='schedule_icon_report'></span>";
        }

        return icons;
    };

    G.prototype._createAppointmentType = function(event_data) {
        return '<span class="event_color' + event_data.menu_color + '_grn">' + event_data.menu + '</span>';
    };

    G.prototype._createDateTimeElement = function(event_data, event_url) {
        return '<span class="time_critical_grn"><a href="' + event_url + '">' + event_data.showtime + '</a></span>';
    };

    G.prototype._createSubject = function(event_data, event_url) {
        var settings = this.settings;

        var subject_html = "";
        var subject_inner_html = "";

        var appointment_type_color = event_data.menu_color || "0";
        var facility_name = event_data.facility_name || "";
        var facility_items = event_data.faci_items || "";
        var facility_placement = settings.facilityPlacement || "after_subject";
        var creator_name = event_data.creator_name || "";
        var duplicated_appointment_count = "";

        if( event_data.relatedEvents && event_data.relatedEvents.length > 0 ) {
            duplicated_appointment_count = '' +
            "<span class=event_share_number_grn>"+
                ( event_data.relatedEvents.length + 1 ) +
            "</span>";
        }

        if (appointment_type_color !== '0') { // if color is set for the appointment type

            var appointment_type = this._createAppointmentType(event_data);

            var title_appointment = appointment_type + event_data.detail + duplicated_appointment_count;

            if (facility_placement === "after_subject") {
                subject_inner_html += title_appointment + facility_name;
            } else {
                subject_inner_html += facility_name + title_appointment;
            }

            subject_inner_html += creator_name + facility_items;
        }
        else {
            subject_inner_html += event_data.data + duplicated_appointment_count;
        }

        // icons
        var icons_left_side = this._createIconsOnLeftSide(event_data);
        var icons_right_side = this._createIconsOnRightSide(event_data);

        // link
        subject_html = '<a href="' + event_url + '">' + icons_left_side + subject_inner_html + icons_right_side + '</a>';

        return subject_html;
    };

    G.prototype._createCssIfNewEvent = function(event_data) {
        if (event_data.id === this.settings.newEventId) {
            return " newevent-grn";
        }

        return "";
    };
})();
