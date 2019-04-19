(function ($) {
    "use strict";

    grn.base.namespace("grn.component.schedule.multi_view.without_time_event_renderer");

    grn.component.schedule.multi_view.without_time_event_renderer = function (settings) {
        this.settings = settings;
    };

    var multi_view = grn.component.schedule.multi_view;

    /**
     * @alias grn.component.schedule.multi_view.without_time_event_renderer
     * @type {grn.component.schedule.multi_view.without_time_event_renderer}
     */
    var G = grn.component.schedule.multi_view.without_time_event_renderer;

    G.prototype.render = function () {

        var settings = this.settings;

        var $without_time_area = $(settings.container.view).find(settings.container.withoutTimeEvents);

        var $columns = $without_time_area.find(".without_time_event_cell");

        for (var i = 0; i < $columns.length; i++) {
            $columns[i].setAttribute("data-bdate", settings.dates[i].value);
            this._renderSingleColumn($columns[i], settings.events.by_date[i]);
        }
    };

    G.prototype._renderSingleColumn = function (column, data) {
        var $column = $(column);

        var $all_day_event_list = $column.find(".without_time_event_list");

        $all_day_event_list[0].innerHTML = "";

        var renderer = new multi_view.calendar_item_renderer(this.settings);

        var events_fragment = document.createDocumentFragment();

        this._createCustomizationSpace($column);

        this._createCalendarEvents(renderer, events_fragment, data.calendar || []);

        this._createExpiredTodoItems(renderer, events_fragment, data.expired_personal_todos || [], "private");
        this._createExpiredTodoItems(renderer, events_fragment, data.expired_shared_todos || [], "shared");

        this._createTodoItems(renderer, events_fragment, data.todos || [], "private");

        this._createTodoItems(renderer, events_fragment, data.shared_todos || [], "shared");

        this._createAllDayEvents(renderer, events_fragment, data.events.allday || [], $column.attr('data-bdate'));

        $all_day_event_list.append(events_fragment);
    };

    G.prototype._createAllDayEvents = function(renderer, events_fragment, all_day_events, date) {
        all_day_events = this._sortMembersEvent(all_day_events);
        var groupby_events = multi_view.util.groupEventsById(all_day_events);
        all_day_events = this._sortEvents(groupby_events);

        for (var i = 0; i < all_day_events.length; i++) {
            var event = all_day_events[i];

            if ('private' in event) {
                continue;
            }

            var event_element = renderer.createWithoutTimeEventElement(event, { beginDate: date });
            
            $(event_element).data({
                'event': event
            });
            events_fragment.appendChild(event_element);

        }
    };

    G.prototype._createCalendarEvents = function (renderer, events_fragment, calendar_events) {
        for (var id in calendar_events) {
            if (!calendar_events.hasOwnProperty(id)) {
                continue;
            }

            var event = calendar_events[id];
            var event_element;

            if (event.type === "weather") {
                event_element = renderer.createWeatherElement(event);
            } else {
                event_element = renderer.createCalendarElement(event);
            }

            events_fragment.appendChild(event_element);
        }
    };

    G.prototype._createTodoItems = function(renderer, events_fragment, todo_list, todo_type) {
        for (var i = 0; i < todo_list.length; i++) {
            events_fragment.appendChild(
                renderer.createTodoElement(todo_list[i], todo_type)
            );
        }
    };

    G.prototype._createExpiredTodoItems = function(renderer, events_fragment, todo_list, todo_type) {
        for (var i = 0; i < todo_list.length; i++) {
            events_fragment.appendChild(
                renderer.createExpiredTodoElement(todo_list[i], todo_type)
            );
        }
    };

    G.prototype._sortMembersEvent = function(events) {
        var self = this;
        events.sort(function(event, another){
            if (event.id === another.id) {
                var member = multi_view.util.getMemberFromEvent(event);
                var member_index = self.settings.memberList.indexOf(member);
                var another_member = multi_view.util.getMemberFromEvent(another);
                var another_member_index = self.settings.memberList.indexOf(another_member);

                return member_index - another_member_index;
            }

            return parseInt(event.id, 10) - parseInt(another.id, 10);
        });

        return events;
    };

    G.prototype._sortEvents = function (events) {
        var self = this;

        var no_related_events = events.filter(function(filtered_item){
            return !filtered_item.relatedEvents;
        });

        var related_events = events.filter(function(filtered_item){
            return filtered_item.relatedEvents;
        });

        no_related_events = no_related_events.sort(function (event, another) {
            var member = multi_view.util.getMemberFromEvent(event);
            var another_member = multi_view.util.getMemberFromEvent(another);

            if (member.id === another_member.id) {
                var event_start = event.start_date;
                var another_start = another.start_date;
                if (event_start > another_start) {
                    return 1;
                }
                if (event_start < another_start) {
                    return -1;
                }

                var event_end = event.end_date;
                var another_end = another.end_date;
                if (event_end > another_end) {
                    return 1;
                }
                if (event_end < another_end) {
                    return -1;
                }

                return parseInt(event.id, 10) - parseInt(another.id, 10);
            }

            var member_index = self.settings.memberList.indexOf(member);
            var another_member_index = self.settings.memberList.indexOf(another_member);

            return member_index - another_member_index;
        });

        related_events = related_events.sort(function (event, another) {
            var event_start = event.start_date;
            var another_start = another.start_date;
            if (event_start > another_start) {
                return 1;
            }
            if (event_start < another_start) {
                return -1;
            }

            var event_end = event.end_date;
            var another_end = another.end_date;
            if (event_end > another_end) {
                return 1;
            }
            if (event_end < another_end) {
                return -1;
            }

            return parseInt(event.id, 10) - parseInt(another.id, 10);
        });

        return no_related_events.concat(related_events);
    };

    /**
     * @param {string} $column
     * @private
     */
    G.prototype._createCustomizationSpace = function (column) {
        var $column = $(column);
        $column.find("[class^='js_customization_schedule_date_']").remove();
        var $schedule_date = $("<div>", {"class": "js_customization_schedule_date_" + $column.attr('data-bdate')});
        $column.prepend($schedule_date);
    };
})(jQuery);