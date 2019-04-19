(function () {
    "use strict";

    grn.base.namespace("grn.component.schedule.multi_view.normal_event_day_stack_list");

    grn.component.schedule.multi_view.normal_event_day_stack_list = function (
        events, date, duration, unit, begin_index, end_index) {

        this.events = events;
        this.date = date;
        this.duration = duration;
        this.unit = unit;
        this.beginIndex = begin_index;
        this.endIndex = end_index;
        this.stack = [];
        this.busyTimeStack = new EventSlotList();

        this.init();
    };

    /**
     * @alias grn.component.schedule.multi_view.normal_event_day_stack_list
     * @type {grn.component.schedule.multi_view.normal_event_day_stack_list}
     */
    var G = grn.component.schedule.multi_view.normal_event_day_stack_list;

    G.prototype.init = function() {
        var events = this.events;
        var i;

        for (i = 0; i < events.length; i++) {
            this.addEvent(events[i]);
        }

        for (i = 0; i < this.stack.length; i++) {
            for (var j = 0; j < this.stack[i].slots.length; j++) {

                var slot = this.stack[i].slots[j];
                this.computeEventSlotWidth(slot, i);

            }
        }
    };

    G.prototype.addEvent = function (event) {
        var event_start_date = new Date(event.start_date_object.getTime());
        var event_end_date;

        if ('end_date' in event) {
            event_end_date = new Date(event.end_date_object.getTime());
            if (event_start_date.getTime() === event_end_date.getTime()) {
                event_end_date.setMinutes(event_end_date.getMinutes() + 30);
                event.same_time = true;
            }
        } else {
            event_end_date = new Date(event.start_date_object.getTime());
            event_end_date.setMinutes(event_end_date.getMinutes() + 30);
        }

        var start_point = this.computeStartPoint(event_start_date);
        var end_point;

        if (event_start_date.getTime() - event_end_date.getTime() === 0) {
            end_point = start_point;
        } else {
            end_point = this.computeEndPoint(event_end_date);
        }

        if (end_point - start_point < 3) {
            end_point = start_point + 3;
            if (end_point >= this.endIndex - this.beginIndex) {
                end_point = this.endIndex - this.beginIndex - 1;
                start_point = end_point - 3;
            }
        }

        var added = false;
        for (var i = 0; i < this.stack.length; i++) {
            if (this.stack[i].checkFreeTime(start_point, end_point) < 0) {
                this.stack[i].addSlot(start_point, end_point, event);
                added = true;
                break;
            }
        }

        if (!added) {
            this.addStack();
            this.stack[this.stack.length - 1].addSlot(start_point, end_point, event);
        }

        var slot_index = this.busyTimeStack.checkFreeTime(start_point, end_point);
        if (slot_index < 0) {
            this.busyTimeStack.addSlot(start_point, end_point, -1);
        }
        else {
            if (this.busyTimeStack.slots[slot_index].startIndex > start_point) {
                this.busyTimeStack.slots[slot_index].startIndex = start_point;
            }
            if (this.busyTimeStack.slots[slot_index].endIndex < end_point) {
                this.busyTimeStack.slots[slot_index].endIndex = end_point;
            }
        }
    };

    G.prototype.addStack = function () {
        this.stack.push(new EventSlotList());
    };

    G.prototype.computeStartPoint = function (start_date) {
        var view_date = new Date(this.date.getFullYear(), this.date.getMonth(), this.date.getDate(), 0, 0, 0);

        var start_hour = 0;
        var start_index;

        if (view_date.getDate() !== start_date.getDate()) {
            start_index = 0;
        }
        else {
            if (view_date.getTime() - start_date.getTime() < 0) {
                start_hour = start_date.getHours();
            } else {
                start_hour = view_date.getHours();
            }

            var time_span = (start_hour - view_date.getHours()) * 60;

            if (start_date.getMinutes()) {
                time_span = time_span + start_date.getMinutes();
            }

            start_index = Math.round(time_span / this.unit) - this.beginIndex;
            if (start_index < 0) {
                start_index = 0;
            }
        }
        return start_index;
    };

    G.prototype.computeEndPoint = function (end_date) {
        var end_time = 0;
        var view_date = new Date(this.date.getFullYear(), this.date.getMonth(), this.date.getDate(), 24, 0, 0);

        if (end_date.getTime() - view_date.getTime() >= 0) {
            end_time = view_date.getTime();
        } else {
            end_time = end_date.getTime();
        }

        var time_span = (end_time - this.date.getTime()) / 60000;
        var end_index = Math.round(time_span / this.unit) - 1 - this.beginIndex;

        if (end_index > this.endIndex - this.beginIndex) {
            end_index = this.endIndex - this.beginIndex - 1;
        }

        return end_index;
    };

    G.prototype.computeEventSlotWidth = function (event_slot, stack_id) {
        for (var i = 0; i < this.stack.length; i++) {
            if (i > stack_id) {
                if (this.stack[i].checkFreeTime(event_slot.startIndex, event_slot.endIndex) < 0) {
                    event_slot.width++;
                } else {
                    return;
                }
            }
        }
    };

    //---------------------------------------------------------------
    // EventSlot
    //---------------------------------------------------------------

    function EventSlot(start_index, end_index, event) {
        this.startIndex = start_index;
        this.endIndex = end_index;
        this.event = event;
        this.width = 1;
    }

    EventSlot.prototype.exists = function (start_index, end_index) {
        return (start_index <= this.startIndex && this.startIndex <= end_index) ||
            (this.startIndex <= start_index && start_index <= this.endIndex) ||
            (this.startIndex <= start_index && end_index <= this.endIndex) ||
            (start_index <= this.startIndex && this.endIndex <= end_index);
    };

    //---------------------------------------------------------------
    // EventSlotList
    //---------------------------------------------------------------

    function EventSlotList() {
        this.slots = [];
    }

    EventSlotList.prototype.addSlot = function (start, end, event) {
        this.slots.push(new EventSlot(start, end, event));
    };

    EventSlotList.prototype.checkFreeTime = function (start, end) {
        for (var i = 0; i < this.slots.length; i++) {
            if (this.slots[i].exists(start, end)) {
                return i;
            }
        }
        return -1;
    };
})();

