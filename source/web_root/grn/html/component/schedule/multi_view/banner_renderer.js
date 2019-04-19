(function ($) {
    "use strict";

    grn.base.namespace("grn.component.schedule.multi_view.banner_renderer");

    grn.component.schedule.multi_view.banner_renderer = function (settings) {
        this.settings = settings;

        var $view = $(this.settings.container.view);

        this.$container = $view.find(this.settings.container.allDayEvents); // in case of Day view

        if (this.$container.length === 0) { // in case of Week view
            this.$container = $view.find(this.settings.container.withoutTimeEvents);
        }
    };

    /**
     * @alias grn.component.schedule.multi_view
     * @type {grn.component.schedule.multi_view}
     */
    var multi_view = grn.component.schedule.multi_view;

    /**
     * @alias grn.component.schedule.multi_view.banner_renderer
     * @type {grn.component.schedule.multi_view.banner_renderer}
     */
    var G = grn.component.schedule.multi_view.banner_renderer;

    G.prototype.render = function () {
        var events = this.settings.events.banner || [];

        this.$container.find(".list_banner").remove();

        if (events.length === 0) {
            return;
        }

        var sorted_events =  this._sortMembersEvent(events);
        var groupby_events = multi_view.util.groupEventsById(sorted_events);
        var event_stack_list = this._initEventStackList(groupby_events);
        this._renderEvents(event_stack_list);
    };

    G.prototype._renderEvents = function (event_stack_list) {
        var $container = this.$container;

        var rows_fragment = document.createDocumentFragment();

        for(var i=0; i < event_stack_list.stacks.length; i++) {

            var row_element = document.createElement("tr");
            row_element.className = "list_banner";

            rows_fragment.appendChild(row_element);

            var stack = event_stack_list.stacks[i];

            var j = 0;
            do {

                var slot = stack.slots[j];
                var event_item = slot.event ? slot.event.item : null;
                var span = stack.computeSlotSpan(slot);

                row_element.appendChild(this._createCell(event_item, span));

                j += span;

            } while (j < stack.slots.length);
        }

        $container.append(rows_fragment);
    };

    G.prototype._createCell = function(event, span) {
        var is_free = event == null;

        var css = is_free ? "br_banner3" : "s_banner3 normalEvent";

        var cell = document.createElement("td");
        cell.className = css;
        cell.colSpan = span;

        if (!is_free) {
            event.type = "banner";
            var event_element = new multi_view.calendar_item_renderer(this.settings).createBannerElement(event);

            $(event_element).data({
                'event': event
            });
            cell.appendChild(event_element);
        }

        return cell;
    };

    G.prototype._initEventStackList = function (events) {
        var settings = this.settings;
        var calendar_begin_date = this.parseDate(settings.beginDate);

        events = this._prepareData(events);
        events = this._sortEvents(events);

        return new EventStackList(events, calendar_begin_date, settings.numberOfDays);
    };

    G.prototype._prepareData = function (events) {
        function ms_to_days(millisecond) {
            return Math.ceil(millisecond / (1000 * 3600 * 24));
        }

        function date_only(datetime) {
            return new Date(datetime.getFullYear(),
                datetime.getMonth(),
                datetime.getDate());
        }

        var calendar_begin_date = this.parseDate(this.settings.beginDate);
        var calendar_end_date = new Date(calendar_begin_date);
        calendar_end_date.setDate(calendar_begin_date.getDate() + this.settings.numberOfDays - 1);

        var event_list = [];

        for (var i = 0; i < events.length; i++) {
            var event = {item: events[i]};

            event.startDateTime = event.item.start_date_object;
            event.endDateTime = event.item.end_date_object;
            event.duration = ms_to_days(event.endDateTime - event.startDateTime);

            var start_date_on_view = date_only(event.startDateTime);
            var end_date_on_view = date_only(event.endDateTime);

            event.startDateOnView = start_date_on_view - calendar_begin_date < 0 ?
                calendar_begin_date : start_date_on_view;

            event.endDateOnView = end_date_on_view - calendar_end_date > 0 ?
                calendar_end_date : end_date_on_view;

            event.durationOnView = ms_to_days(event.endDateOnView - event.startDateOnView) + 1;

            event_list.push(event);
        }

        return event_list;
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

        events.sort(function (event, another) {
            var event_start = event.startDateTime;
            var another_start = another.startDateTime;
            if (event_start > another_start) {
                return 1;
            }
            if (event_start < another_start) {
                return -1;
            }

            var event_end = event.endDateTime;
            var another_end = another.endDateTime;
            if (event_end > another_end) {
                return 1;
            }
            if (event_end < another_end) {
                return -1;
            }

            var type_of_event_related = typeof event.item.relatedEvents;
            var type_of_another_related = typeof another.item.relatedEvents;
            if (type_of_event_related !== 'undefined' && type_of_another_related === 'undefined') {
                return 1;
            }
            if (type_of_event_related === 'undefined' && type_of_another_related !== 'undefined') {
                return -1;
            }

            if (type_of_event_related === 'undefined' && type_of_another_related === 'undefined') {
                var member = multi_view.util.getMemberFromEvent(event.item);
                var another_member = multi_view.util.getMemberFromEvent(another.item);

                if (member.id === another_member.id) {
                    return parseInt(event.item.id, 10) - parseInt(another.item.id, 10);
                }

                var member_index = self.settings.memberList.indexOf(member);
                var another_member_index = self.settings.memberList.indexOf(another_member);

                return member_index - another_member_index;
            }
            if (type_of_event_related !== 'undefined' && type_of_another_related !== 'undefined') {
                return parseInt(event.item.id, 10) - parseInt(another.item.id, 10);
            }

            return 0;
        });

        return events;
    };

    G.prototype.parseDate = function (date) {
        return grn.component.date.parse(date);
    };


    /////////////////////////////////////////////////////////////////
    //  Helper classes
    /////////////////////////////////////////////////////////////////

    function EventStackList(events, start_date, num_of_days) {
        this.startDate = start_date;

        this.endDate = new Date(start_date);
        this.endDate.setDate(start_date.getDate() + num_of_days - 1);

        this.numOfDays = num_of_days;

        this.stacks = [];

        for (var i = 0; i < events.length; i++) {
            this._addEvent(events[i]);
        }
    }

    EventStackList.prototype = {
        _addEvent : function (event) {
            var added = false;
            for (var i = 0; i < this.stacks.length; i++) {
                added = this.stacks[i].addEvent(event);

                if (added) {
                    return;
                }
            }

            var new_stack = new EventStack(this);
            new_stack.addEvent(event);

            this.stacks.push(new_stack);
        }
    };

    function EventStack(list) {
        this.list = list;
        this.slots = [];
        this._initSlots(list.numOfDays);
    }

    EventStack.prototype = {
        _initSlots : function (num_of_slots) {
            var start_date = this.list.startDate;
            for (var i = 0; i < num_of_slots; i++) {

                var date = new Date(start_date);
                date.setDate(start_date.getDate() + i);

                var slot = {
                    index: i,
                    date: date,
                    event: null,
                    next: null,
                    prev: null
                };

                if(i > 0) {
                    slot.prev = this.slots[i - 1];

                    if(i < num_of_slots) {
                        this.slots[i - 1].next = slot;
                    }
                }


                this.slots.push(slot);
            }
        },

        addEvent: function (event) {

            var free_slots = this.findFreeSlots(event);

            if (free_slots === false) {
                return false;
            }

            for (var i = 0; i < free_slots.length; i++) {
                free_slots[i].event = event;
            }

            return true;
        },

        computeSlotSpan: function (slot) {
            var span = 0;
            var do_next;

            do {
                span++;

                var next_slot = slot.next;

                do_next = !!next_slot &&
                    (this.isFreeSlot(slot) && this.isFreeSlot(next_slot) ||
                    this.isSameEvent(slot, next_slot));

                slot = next_slot;

            } while (do_next);

            return span;
        },

        findFreeSlots : function (event) {
            var free_slots = [];

            for (var i = 0; i < this.slots.length; i++) {
                var slot = this.slots[i];

                if ( event.startDateOnView.getTime() <= slot.date.getTime() &&
                     event.endDateOnView.getTime() >= slot.date.getTime()) {

                    if (slot.event != null) {
                        return false;
                    }

                    free_slots.push(slot);
                }
            }

            return free_slots;
        },

        isFreeSlot: function(slot) {
            return slot.event == null;
        },

        isSameEvent: function(slot, other) {
            return !this.isFreeSlot(slot) && !this.isFreeSlot(other) &&
                slot.event.item.id === other.event.item.id &&
                slot.event.item.uid === other.event.item.uid;
        }
    };

})(jQuery);

