(function ($) {
    "use strict";

    grn.base.namespace("grn.component.schedule.multi_view.normal_event_renderer");

    grn.component.schedule.multi_view.normal_event_renderer = function (settings) {
        this.settings = settings;
    };

    var multi_view = grn.component.schedule.multi_view;
    var colspan_all;

    /**
     * @alias grn.component.schedule.multi_view.normal_event_renderer
     * @type {grn.component.schedule.multi_view.normal_event_renderer}
     */
    var G = grn.component.schedule.multi_view.normal_event_renderer;

    G.prototype.render = function () {

        var settings = this.settings;

        var $columns = $(this.settings.container.view).find(".personal_day_event_list");
        for (var i = 0; i < $columns.length; i++) {
            this._renderSingleColumn($columns[i], settings.events.by_date[i]);
        }
    };

    G.prototype._renderSingleColumn = function (column, column_data) {
        var $column = $(column);

        $column.css("z-index", "3"); // this element is above busy time layer and time rows layer

        var column_date = this.parseDate(column_data.date);
        $column.data("date", column_date);

        var day_stack_list = this._initDayStackList($column, column_data, column_date);

        this._renderEvents($column, day_stack_list);
        this._renderBusyTime($column, day_stack_list);

        if ($column.hasClass("last_date")) {
            $column.closest(".personal_calendar_list").css({"height": $column.height() + "px"});
            $column.closest(".showtime").css({"height": $column.height() + "px"});
        }
    };

    G.prototype._initDayStackList = function ($column, data, column_date) {
        var settings = this.settings;
        var events = data.events.normal || [];

        var hours_to_display = settings.maxTime - settings.minTime;

        var unit = 5;
        var span_unit = 60 / unit;
        colspan_all = Math.round(hours_to_display * span_unit);

        var begin_index = settings.minTime * span_unit;
        var end_index = settings.maxTime * span_unit;

        events = this._sortEvents(events);

        return new multi_view.normal_event_day_stack_list(
            events, column_date, colspan_all, unit, begin_index, end_index);
    };

    G.prototype._sortEvents = function (events) {
        var self = this;
        return events.sort(function (event, another) {

            var event_start = event.start_date_object;
            var another_start = another.start_date_object;

            if (event_start > another_start) {
                return 1;
            }

            if (event_start < another_start) {
                return -1;
            }

            var event_duration = self._computeEventDuration(event);
            var another_duration = self._computeEventDuration(another);

            if (event_duration > another_duration) {
                return -1;
            }

            if (event_duration < another_duration) {
                return 1;
            }

            var member = multi_view.util.getMemberFromEvent(event);
            var another_member = multi_view.util.getMemberFromEvent(another);

            var member_index = self.settings.memberList.indexOf(member);
            var another_member_index = self.settings.memberList.indexOf(another_member);

            if (member_index > another_member_index) {
                return 1;
            }

            if (member_index < another_member_index) {
                return -1;
            }

            return 0;
        });
    };

    G.prototype._computeEventDuration = function (event_item) {

        if (event_item.same_time) {
            return 60 * 30;
        }

        var event_start_date;
        var event_end_data;

        event_start_date = event_item.start_date_object;

        if ("end_date" in event_item) {
            event_end_data = event_item.end_date_object;
        } else {
            return 60 * 30;
        }

        return (event_end_data.getTime() - event_start_date.getTime()) / 1000;
    };

    G.prototype._renderEvents = function ($column, day_stack_list) {
        var column_height = $column.height();
        var column_width = $column.width();

        var distance_between_event;
        var distance_height = 0.8;

        var width_unit = 94;

        if ($column.find("div.personal_day_calendar_time_row").width() < 120) {
            width_unit = 87;
        }

        var height_unit = 100 / colspan_all;
        if (day_stack_list.stack.length !== 0) {
            width_unit = width_unit / (day_stack_list.stack.length);
        }

        if (this.settings.numberOfDays === 7) {
            switch (day_stack_list.stack.length) {
                case 1:
                    distance_between_event = 0.0025;
                    break;
                case 2:
                    distance_between_event = 0.018;
                    break;
                case 3:
                    distance_between_event = 0.02;
                    break;
                case 4:
                    distance_between_event = 0.029;
                    break;
                default:
                    distance_between_event = 0.035;
            }
        }
        else {
            distance_between_event = 0.004;
            if (this.settings.plid && this.settings.plid !== "") {
                if (day_stack_list.stack.length > 4) {
                    distance_between_event = distance_between_event + 0.01;
                }
            }
        }

        var events_fragment = document.createDocumentFragment();

        for (var i = 0; i < day_stack_list.stack.length; i++) {
            var slot, event_data;
            var width, height, top, left;
            var position_px = {top: 0, left: 0};
            var style;
            var start_at_mid_night;

            for (var j = 0; j < day_stack_list.stack[i].slots.length; j++) {
                slot = day_stack_list.stack[i].slots[j];

                event_data = slot.event;

                start_at_mid_night = (slot.startIndex === 0);

                width = (slot.width - distance_between_event) * width_unit;
                height = (slot.endIndex - slot.startIndex + distance_height) * height_unit;
                top = (slot.startIndex) * height_unit;
                left = i * width_unit;

                position_px.top = top * column_height / 100;
                position_px.left = left * column_width / 100;

                style = {
                    "width": width + "%",
                    "max-width": width + "%",
                    "height": height + "%",
                    "top": top + "%",
                    "left": left + "%"
                };

                var event_element = this._createEventElement(event_data, style, start_at_mid_night, position_px, $column.data("date"));
                events_fragment.appendChild(event_element);
            }
        }

        $column.append(events_fragment);
    };

    G.prototype._renderBusyTime = function($column, day_stack_list) {
        var distance_height = 0.8;
        var height_unit = 100 / colspan_all;

        var div_busy = $column.parent().find("div.busy_time_span");

        var busy_fragment = document.createDocumentFragment();
        var style_busy;

        for (var i = 0; i < day_stack_list.busyTimeStack.slots.length; i++) {
            var busy_event = day_stack_list.busyTimeStack.slots[i];

            var height_busy = (busy_event.endIndex - busy_event.startIndex + distance_height) * height_unit;
            var top_busy = (busy_event.startIndex) * height_unit;

            style_busy = {
                "width": "100%",
                "max-width": "100%",
                "height": height_busy + "%",
                "max-height": height_busy + "%",
                "top": top_busy + "%",
                "left": "0",
                "position": "absolute"
            };

            var busy_element = document.createElement("div");
            busy_element.className = "busytime_grn";
            $(busy_element).css(style_busy);

            busy_fragment.appendChild(busy_element);
        }

        div_busy.append(busy_fragment);
    };

    G.prototype._createEventElement = function (event_data, style, start_at_mid_night, position_px, bdate) {
        var settings = this.settings;

        var event_element = new multi_view.calendar_item_renderer(settings)
            .createNormalEventElement(event_data, {
                start_at_mid_night: start_at_mid_night,
                beginDate: bdate
            });

        var $event_element = $(event_element);

        $event_element.css(style);

        $event_element.data({
            "event": event_data,
            "event_id": event_data.id,
            "bdate": bdate,
            "title": $event_element.find("font > a"),
            "uid": settings.uid,
            "gid": settings.gid,
            "referer_key": settings.referer_key,
            "style": style
        });

        if (event_data.end_datetime && (event_data.type === "repeat" || event_data.type === "share_repeat")) {
            $event_element.data("end_datetime", event_data.end_datetime);
        }

        if (settings.plid !== "") {
            $event_element.data("plid", settings.plid);
        }

        if (!multi_view.util.isOneDayEvent(event_data)) {
            if (event_data.type === "repeat" || event_data.type === "share_repeat") {
                $event_element.data("group_drag", "group" + event_data.id +
                    event_data.start_date.substr(0, 10) + event_data.uid + settings.plid);
            }
            else {
                $event_element.data("group_drag", "group" + event_data.id + event_data.uid + settings.plid);
            }
        }

        return event_element;
    };

    G.prototype.parseDate = function(date)
    {
        return grn.component.date.parse(date);
    };

})(jQuery);

