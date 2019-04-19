(function ($) {
    "use strict";

    grn.base.namespace("grn.component.schedule.multi_view.event_drag_drop");

    grn.component.schedule.multi_view.event_drag_drop = function (settings) {
        grn.component.pubsub.installTo(this);
        this.settings = settings;
        this._$container = $(settings.container.view);
    };

    var multi_view = grn.component.schedule.multi_view;
    var date_component = grn.component.date;
    var ONE_HOUR_HEIGHT = 40;
    var HALF_HOUR_HEIGHT = 20;
    var check_first, data_event, start_time, end_time, string_time, originalCursor, distance, originalPosition;
    var documentWidth, documentHeight, check_need_resize_before_drag;

    /**
     * @alias grn.component.schedule.multi_view.event_drag_drop
     * @type {grn.component.schedule.multi_view.event_drag_drop}
     */
    var G = grn.component.schedule.multi_view.event_drag_drop;

    G.prototype.init = function () {
        this._initDragHandle();
        this._initDragDropArea();
        this._initDraggable();
        this._initDroppable();
    };

    G.prototype._onEventUpdate = function () {
        this.trigger("eventUpdate");
    };

    G.prototype._initDragHandle = function () {
        var events = $(this.settings.container.view).find(".critical3");

        events.mouseenter(function showHandle() {
            var $event = $(this);
            if (multi_view.util.resizing || multi_view.util.dragging ||
                !multi_view.util.checkEventCanDragDrop($event)) {
                return;
            }

            $event
                .css({
                    "background-color": "",
                    "z-index": 2
                })
                .addClass("personal_over_schedule");

            if (multi_view.util.checkEventHaveHandle($event, "top")) {
                var $handle_top = $(
                    "<div class='dragdrop_handle' style='text-align:center;margin-top:-2px;'>" +
                    "   <div class='resizer_top'/>" +
                    "</div>");
                $handle_top.appendTo($event);
            }

            if (multi_view.util.checkEventHaveHandle($event, "bottom")) {
                var $handle_bottom = $(
                    "<div class='dragdrop_handle' style='text-align:center;margin-bottom:-2px;'>" +
                    "   <div class='resizer_bottom'/>" +
                    "</div>");
                $handle_bottom.appendTo($event);
            }
        });

        events.mouseleave(function removeHandle() {
            if (multi_view.util.resizing) {
                return;
            }

            $(this)
                .css({
                    "background-color": "",
                    "z-index": ""
                })
                .removeClass("personal_over_schedule")
                .find(".dragdrop_handle").remove();
        });
    };

    G.prototype._initDragDropArea = function () {
        var $draggableArea = this._$container.find(this.settings.container.normalEvents);
        $draggableArea.parent().find('.dummy-container').remove();
        $draggableArea.parent().find('.dragdrop-container').remove();

        var $containment = $('<div class="dragdrop-container"/>');
        $containment.offset({top: $draggableArea.position().top - 1, left: $draggableArea.position().left});
        $containment.css({
            'right' : 0,
            'bottom' : 0,
            'position': 'absolute',
            'margin-left': '24px',
            'z-index': '-1'
        });
        $containment.appendTo($draggableArea.parent());

        this._$draggableArea = $draggableArea;
        this._$containment = $containment;
    };

    G.prototype._initDraggable = function () {
        var self = this;
        var $draggableArea = this._$draggableArea;
        var $containment = this._$containment;

        // D&D single day
        this._$container.find(".schedule:not([class*='group'])")
            .hover(function () {
                var data_event = $(this).data('event');

                if (!multi_view.util.isOneDayEvent(data_event)) {
                    return;
                }

                $(this).draggable({
                    addClasses: false,
                    containment: $containment,
                    zIndex: '99',
                    distance: 5,
                    revert: true,
                    revertDuration: 0,
                    appendTo: $draggableArea.find('div.last_date'),
                    helper: function () {
                        return self._createDraggingEventHelper($(this), data_event);
                    },
                    create: function () {
                        if (!multi_view.util.checkEventCanDragDrop($(this))) {
                            $(this).draggable("destroy");
                        }
                    },
                    drag: function (ev, ui) {
                        self.draggingDrag(ev, ui, $(this), $draggableArea);
                    },
                    start: function (ev, ui) {
                        self.draggingStart(ev, ui, $(this), $draggableArea);
                    },
                    stop: function (ev, ui) {
                        self.draggingStop(ev, ui, $(this));
                    }
                });
            });

        // D&D multiple days
        this._$container.find(".schedule[class*='group']").each(function () {
            self.initMultiple(this, {
                addClasses: false,
                zIndex: '99',
                distance: 5,
                group: $draggableArea.find('.' + $(this).data('group_drag')),
                container: $draggableArea
            });
        });
    };

    G.prototype._initDroppable = function () {
        var self = this;
        var dropped;
        this._$container.find("div.snapto").each(function () {
            $(this).droppable({
                accept: ".schedule",
                addClasses: false,
                tolerance: 'touch',
                activate: function () {
                    dropped = false;
                },
                drop: function (ev, ui) {
                    if (ui.draggable.hasClass(ui.draggable.data('group_drag'))) {
                        return;
                    }

                    // determine drop area
                    var $drop_area = $(this);
                    if (Math.ceil(Math.abs(ui.helper.offset().top - $drop_area.offset().top)) >= 40) {
                        return;
                    }

                    if (dropped) {
                        return;
                    }

                    dropped = true;
                    var oldParent = ui.draggable.parent();
                    var half = false;
                    if (Math.abs(ui.helper.offset().top - $drop_area.offset().top) > 15) {
                        half = true;
                    }

                    var top = $drop_area.position().top;
                    var left = $drop_area.position().left;
                    if (half) {
                        top = top + 20;
                    }

                    ui.draggable.css({
                        left: left + "px",
                        top: top + "px",
                        zIndex: 1
                    });

                    ui.draggable.appendTo($drop_area.parent());
                    ui.draggable.addClass('dragging_schedule');
                    multi_view.util.afterDragDrop(ui.draggable, oldParent, ev, $.proxy(self._onEventUpdate, self));
                }
            });
        });
    };

    G.prototype._createDraggingEventHelper = function ($event_element, data_event) {
        if ($event_element.css('left').indexOf('0') === 0) {
            check_need_resize_before_drag = true;
            $event_element.css('left', '3%');
        }

        var member = multi_view.util.getMemberFromEvent(data_event);
        member = this.settings.memberList.getById(member.id, member.type);

        var member_color_css = multi_view.util.createEventBlockColorCss(
            member.id, member.type, this.settings.memberList);

        var $helper = $event_element.clone();
        $helper.removeClass();
        $helper.addClass('dragging_schedule ' + member_color_css);
        $helper.css({'width': '90%'});

        $helper.find('div.event_content').css({'width': '90%', 'height': '90%'});

        return $helper;
    };

    G.prototype.draggingDrag = function (ev, ui, thisObj, element) {
        // hide tooltip event
        $("div.tooltipEventContainer").remove();
        // show time when dragging
        var div_tooltip_timespan = $('div.showTimeSpanTitle');

        // prevent drag pointer out of document width
        multi_view.util.setLeftTooltip(div_tooltip_timespan, ev.pageX, documentWidth);

        // prevent drag pointer out of document height
        multi_view.util.setTopTooltip(div_tooltip_timespan, ev.pageY, documentHeight);

        var currentCursor = ev.pageY;

        if (check_first && currentCursor !== originalCursor) {
            var start_hour, start_minute, end_hour, end_minute;
            var time_change;
            if (!end_time) {
                var end_time_temp = new Date(start_time.getTime());
                end_time_temp.setMinutes(end_time_temp.getMinutes() + 30);
                time_change = this.changeTimeBeforeDragging(currentCursor, originalCursor, start_time, end_time_temp, data_event);
            }
            else {
                time_change = this.changeTimeBeforeDragging(currentCursor, originalCursor, start_time, end_time, data_event);
            }
            start_hour = time_change.start_hour;
            start_minute = time_change.start_minute;
            end_hour = time_change.end_hour;
            end_minute = time_change.end_minute;
            var tempTopStartTime = start_hour - this.settings.minTime;
            if (start_minute > 0) {
                tempTopStartTime = tempTopStartTime + (start_minute / 60);
            }
            tempTopStartTime = tempTopStartTime * ONE_HOUR_HEIGHT;
            distance = tempTopStartTime - ui.position.top;
            ui.position.top = tempTopStartTime;
            originalPosition.top = originalPosition.top + distance;

            start_time.setHours(start_hour);
            start_time.setMinutes(start_minute);
            if (end_time) {
                end_time.setHours(end_hour);
                end_time.setMinutes(end_minute);
            }

            string_time = multi_view.util.formatTimeString(start_hour, start_minute) + '-' +
                multi_view.util.formatTimeString(end_hour, end_minute);
            check_first = false;
        }
        else {
            // distance to be dragged horizontally
            var distance_date = 0;
            if (element.find('td.personal_week_calendar_date.firstColumn').length > 0) {
                distance_date = element.find('td.personal_week_calendar_date.firstColumn').width() + 1;
            }

            if (distance !== 0) {
                ui.position.top = ui.position.top + distance;
            }
            if (ui.position.top < 0) {
                ui.position.top = 0;
            }

            // measurement uncertainty for zoom is 5 pixel
            while (ui.position.top + thisObj.height() - element.height() > 5) {
                ui.position.top = ui.position.top - HALF_HOUR_HEIGHT;
            }

            string_time = this.calculateDragTime(ui.helper.offset(), originalPosition,
                thisObj, distance_date, start_time, end_time);
        }
        div_tooltip_timespan.html(string_time);
    };

    G.prototype.draggingStart = function (ev, ui, thisObj, element) {
        // check dragging
        multi_view.util.dragging = true;

        // check show tooltip of schedule
        if (check_need_resize_before_drag) {
            thisObj.css('left', '0%');
        }
        thisObj.addClass('original_schedule');

        data_event = $(thisObj).data('event');
        start_time = new Date(data_event.start_date_object.getTime());
        if ('end_date' in data_event) {
            end_time = new Date(data_event.end_date_object.getTime());
        }
        else {
            end_time = false;
        }

        check_first = false;
        distance = 0;
        if (start_time.getMinutes() !== 0 && start_time.getMinutes() !== 30) {
            check_first = true;
        }
        originalCursor = ev.pageY;
        originalPosition = {top: thisObj.offset().top, left: thisObj.offset().left};

        // distance to be dragged horizontally
        var gridX = 0;

        if (element.find('td.personal_week_calendar_date.firstColumn').length > 0) {
            gridX = element.find('td.personal_week_calendar_date.firstColumn').width();
        }

        thisObj.draggable({
            grid: [gridX, HALF_HOUR_HEIGHT]
        });

        // init for show time when dragging
        string_time = this.stringDragTime(thisObj);
        var div_tooltip_timespan = $('<div class="showTimeSpanTitle"/>').html(string_time);
        div_tooltip_timespan.css({'position': 'absolute', 'top': ev.pageY + 10 + 'px', 'z-index': '99'});
        $('body').append(div_tooltip_timespan);
        documentWidth = $(document).width();
        documentHeight = $(document).height();
        multi_view.util.setLeftTooltip(div_tooltip_timespan, ev.pageX, documentWidth);
    };

    G.prototype.draggingStop = function (ev, ui, thisObj) {
        multi_view.util.dragging = false;
        //check_show_tooltip_schedule = true;
        check_need_resize_before_drag = false;
        thisObj.removeClass('original_schedule');
        $('div.showTimeSpanTitle').remove();

        // remove resizing handle if mouse out of schedule
        multi_view.util.removeResizingHandle(ev, thisObj);
    };

    G.prototype.calculateDateDistance = function (currentPosition, originalPosition, distance_date) {
        if (distance_date === 0) {
            return 0;
        }
        return Math.round((currentPosition - originalPosition) / distance_date);
    };

    G.prototype.calculateDragTime = function (currentPosition, originalPosition, ev, distance_date, start_time, end_time) {
        var distance, start_hour, start_minute, end_hour, end_minute;
        distance = multi_view.util.calculateTimeDistance(currentPosition.top, originalPosition.top);
        var change_date = this.calculateDateDistance(currentPosition.left, originalPosition.left, distance_date);
        var start = new Date(start_time.getTime());
        start_hour = start.getHours() + (distance.sign * distance.distance_hour);
        start_minute = start.getMinutes() + (distance.sign * distance.distance_minute);
        if (start_minute < 0) {
            start_minute = start_minute + 60;
            start_hour--;
        }
        if (start_minute >= 60) {
            start_minute = start_minute - 60;
            start_hour++;
        }
        start.setDate(start.getDate() + change_date);

        if (end_time) {
            var end = new Date(end_time.getTime());
            if (end.getHours() === 23 && end.getMinutes() === 59) {
                end_hour = 24 + (distance.sign * distance.distance_hour);
                end_minute = distance.sign * distance.distance_minute;
            }
            else {
                end_hour = end.getHours() + (distance.sign * distance.distance_hour);
                end_minute = end.getMinutes() + (distance.sign * distance.distance_minute);
            }
            if (end_minute < 0) {
                end_minute = end_minute + 60;
                end_hour--;
            }
            if (end_minute >= 60) {
                end_minute = end_minute - 60;
                end_hour++;
            }
            end.setDate(end.getDate() + change_date);
            if (end_hour >= 24) {
                end_hour = 23;
                end_minute = 59;
            }
            if (end_hour < 0) {
                end_hour += 24;
                end.setDate(end.getDate() - 1);
            }
            multi_view.util.timeAfterDragDrop = {
                'start_hour': start_hour,
                'start_minute': start_minute,
                'end_hour': end_hour,
                'end_minute': end_minute,
                'bdate': start,
                'edate': end,
                'event_id': ev.data('event_id')
            };
            return multi_view.util.formatTimeString(start_hour, start_minute) + '-' +
                multi_view.util.formatTimeString(end_hour, end_minute);
        }
        else {
            multi_view.util.timeAfterDragDrop = {
                'start_hour': start_hour,
                'start_minute': start_minute,
                'end_hour': '',
                'end_minute': '',
                'bdate': start,
                'edate': false,
                'event_id': ev.data('event_id')
            };
            return multi_view.util.formatTimeString(start_hour, start_minute);
        }
    };

    G.prototype.changeTimeBeforeDragging = function (currentCursor, originalCursor, start_time, end_time) {
        var start_hour, start_minute, end_hour, end_minute;
        if (currentCursor - originalCursor > 0) {
            if (start_time.getMinutes() > 0 && start_time.getMinutes() < 30) {
                start_hour = start_time.getHours();
                start_minute = 30;
                end_minute = end_time.getMinutes() + (30 - start_time.getMinutes());
            }

            if (start_time.getMinutes() > 30) {
                start_hour = start_time.getHours() + 1;
                start_minute = 0;
                end_minute = end_time.getMinutes() + (60 - start_time.getMinutes());
            }

            if (end_minute >= 60) {
                end_hour = end_time.getHours() + 1;
                end_minute = end_minute - 60;
            }
            else {
                end_hour = end_time.getHours();
            }

            if (start_hour === this.settings.maxTime) {
                start_hour = this.settings.maxTime - 1;
                start_minute = 30;
            }

            if (end_hour >= this.settings.maxTime) {
                end_hour = end_time.getHours() - 1;
                end_minute = end_minute - 30;
                if (end_minute < 0) {
                    end_hour = end_hour - 1;
                    end_minute = end_minute + 60;
                }
            }
        }
        else {
            if (start_time.getMinutes() > 0 && start_time.getMinutes() < 30) {
                start_hour = start_time.getHours();
                start_minute = 0;
                end_minute = end_time.getMinutes() - start_time.getMinutes();
            }

            if (start_time.getMinutes() > 30) {
                start_hour = start_time.getHours();
                start_minute = 30;
                end_minute = end_time.getMinutes() - (start_time.getMinutes() - 30);
            }

            if (end_minute < 0) {
                end_hour = end_time.getHours() - 1;
                end_minute = end_minute + 60;
            }
            else {
                end_hour = end_time.getHours();
            }
        }
        return {start_hour: start_hour, start_minute: start_minute, end_hour: end_hour, end_minute: end_minute};
    };

    G.prototype.calculateMinTimeDistanceToBeginEndDay = function (event_data, start_time, end_time) {
        // fix for case start time is 00:00 and end time is 23:59
        if (start_time.getHours() === 0 && start_time.getMinutes() === 0 &&
            end_time.getHours() === 23 && end_time.getMinutes() === 59) {
            return {
                min_distance_to_begin: {
                    hour_to_begin: 0,
                    minute_to_begin: 0
                },
                min_distance_to_end: {
                    hour_to_end: 0,
                    minute_to_end: 0
                }
            };
        }

        var hour_to_begin, minute_to_begin, hour_to_end, minute_to_end;
        if (start_time.getHours() > end_time.getHours() ||
            (start_time.getHours() === end_time.getHours() && start_time.getMinutes() > end_time.getMinutes())) {
            hour_to_begin = end_time.getHours() - this.settings.minTime;
            minute_to_begin = end_time.getMinutes() - 30;

            hour_to_end = this.settings.maxTime - 1 - start_time.getHours();
            minute_to_end = 30 - start_time.getMinutes();
        }
        else {
            if (start_time.getHours() === end_time.getHours() && start_time.getMinutes() === end_time.getMinutes()) {
                hour_to_begin = end_time.getHours() - this.settings.minTime;
                minute_to_begin = end_time.getMinutes() - 30;

                hour_to_end = this.settings.maxTime - 1 - start_time.getHours();
                minute_to_end = 30 - start_time.getMinutes();

            }
            else {
                hour_to_begin = start_time.getHours() - this.settings.minTime;
                minute_to_begin = start_time.getMinutes();

                hour_to_end = this.settings.maxTime - 1 - end_time.getHours();
                minute_to_end = 60 - end_time.getMinutes();
            }
        }

        if (minute_to_begin < 0) {
            minute_to_begin += 60;
            hour_to_begin--;
        }

        var min_distance_to_begin = {
            hour_to_begin: hour_to_begin,
            minute_to_begin: minute_to_begin
        };

        if (minute_to_end === 60) {
            minute_to_end = 0;
            hour_to_end++;
        }

        var min_distance_to_end = {
            hour_to_end: hour_to_end,
            minute_to_end: minute_to_end
        };

        return {min_distance_to_begin: min_distance_to_begin, min_distance_to_end: min_distance_to_end};
    };

    G.prototype.stringDragTime = function (ev) {
        var data_event = $(ev).data('event');
        var start_time = data_event.start_date.substr(11, 5);
        var end_time;
        if ('end_date' in data_event) {
            end_time = data_event.end_date.substr(11, 5);
            return start_time + '-' + end_time;
        }
        else {
            return start_time;
        }
    };

    G.prototype.initMultiple = function (element, opts) {
        var self = this;

        var originalPosition, currentPosition;
        var container = $(opts.container);
        var container_parent = container.parent();
        var dummy_container = container_parent.find('div.dummy-container');

        if (dummy_container.length === 0) {

            var container_for_dragging = this._createContainerForDraggingMultipleDaysEvent(container);
            dummy_container = container_for_dragging.$container;
            var date_columns = container_for_dragging.$columns;

            var one_day = 1000 * 60 * 60 * 24;
            container.data('check_save_original_position', false);

            dummy_container.mousemove(function (ev) {
                var width_column = container.width() / self.settings.numberOfDays;
                var height_column = container.height() / ONE_HOUR_HEIGHT;
                var xpos = ev.pageX - $(this).offset().left;
                var ypos = ev.pageY - $(this).offset().top;

                if (!container.data('check_save_original_position')) {
                    originalPosition = ypos;
                    container.data('check_save_original_position', true);
                }

                // current date mouse over
                var date_mouse_over = $(date_columns[Math.ceil(xpos / width_column) - 1]).data('date');
                // event dragging
                var event_dragging = container.data('event_dragging');
                var event_data = $(event_dragging).data('event');
                // date when start dragging
                var date_start_dragging = event_dragging.data('bdate');
                // begin date event
                var date_start_event = date_component.parse(event_data.start_date.substr(0, 10));
                // end date event
                var date_end_event = date_component.parse(event_data.end_date.substr(0, 10));
                // distance from date start dragging to begin date event
                var diff = (date_start_dragging - date_start_event) / one_day;
                // duration of event dragging
                var duration = (date_end_event - date_start_event) / one_day;
                // new begin date after dragging
                var new_date_start_event = new Date(date_mouse_over.getTime());
                new_date_start_event.setDate(new_date_start_event.getDate() - diff);
                // new end date after dragging
                var new_date_end_event = new Date(date_mouse_over.getTime());
                new_date_end_event.setMonth(new_date_start_event.getMonth());
                new_date_end_event.setDate(new_date_start_event.getDate() + duration);

                currentPosition = ypos;
                var distance, string_time;
                var start_time = container.data('start_time'),
                    end_time = container.data('end_time');
                var start_hour, start_minute, end_hour, end_minute;
                var time_begin_event = event_data.start_date_object;

                // show time when dragging
                var div_tooltip_timespan = $('div.showTimeSpanTitle');

                if (date_start_dragging.getTime() === date_start_event.getTime() ||
                    date_start_dragging.getTime() === date_end_event.getTime()) {
                    if (time_begin_event.getMinutes() !== 0 && time_begin_event.getMinutes() !== 30 &&
                        container.data('check_first') && currentPosition !== originalPosition) {
                        var time_change = self.changeTimeBeforeDragging(currentPosition, originalPosition, start_time, end_time, event_data);
                        start_hour = time_change.start_hour;
                        start_minute = time_change.start_minute;
                        end_hour = time_change.end_hour;
                        end_minute = time_change.end_minute;
                        start_time.setHours(start_hour);
                        start_time.setMinutes(start_minute);
                        end_time.setHours(end_hour);
                        end_time.setMinutes(end_minute);
                        container.data('start_time', start_time);
                        container.data('end_time', end_time);
                        container.data('check_first', false);
                    }
                    else {
                        var min_distance_to_begin, min_distance_to_end;
                        var distance_to_begin_hour, distance_to_begin_minute, distance_to_end_hour, distance_to_end_minute;

                        if (!container.data('calculate_distance') && !container.data('check_first')) {
                            var min_distance = self.calculateMinTimeDistanceToBeginEndDay(event_data, start_time, end_time);
                            min_distance_to_begin = min_distance.min_distance_to_begin;
                            min_distance_to_end = min_distance.min_distance_to_end;

                            container.data('min_distance_to_begin', min_distance_to_begin);
                            container.data('min_distance_to_end', min_distance_to_end);
                            container.data('calculate_distance', true);
                        }
                        else {
                            min_distance_to_begin = container.data('min_distance_to_begin');
                            min_distance_to_end = container.data('min_distance_to_end');
                        }

                        distance = multi_view.util.calculateTimeDistance(currentPosition, originalPosition);
                        start_hour = start_time.getHours() + (distance.sign * distance.distance_hour);
                        start_minute = start_time.getMinutes() + (distance.sign * distance.distance_minute);

                        if (end_time.getHours() === 23 && end_time.getMinutes() === 59) {
                            end_hour = 24 + (distance.sign * distance.distance_hour);
                            end_minute = distance.sign * distance.distance_minute;
                        }
                        else {
                            end_hour = end_time.getHours() + (distance.sign * distance.distance_hour);
                            end_minute = end_time.getMinutes() + (distance.sign * distance.distance_minute);
                        }

                        if (start_minute < 0) {
                            start_minute = start_minute + 60;
                            start_hour--;
                        }
                        if (start_minute >= 60) {
                            start_minute = start_minute - 60;
                            start_hour++;
                        }

                        if (end_minute < 0) {
                            end_minute = end_minute + 60;
                            end_hour--;
                        }
                        if (end_minute >= 60) {
                            end_minute = end_minute - 60;
                            end_hour++;
                        }

                        if (container.data('calculate_distance')) {
                            distance_to_begin_hour = min_distance_to_begin.hour_to_begin;
                            distance_to_begin_minute = min_distance_to_begin.minute_to_begin;
                            distance_to_end_hour = min_distance_to_end.hour_to_end;
                            distance_to_end_minute = min_distance_to_end.minute_to_end;

                            if (start_hour < self.settings.minTime) {
                                start_hour = start_time.getHours() - distance_to_begin_hour;
                                start_minute = start_time.getMinutes() - distance_to_begin_minute;

                                end_hour = end_time.getHours() - distance_to_begin_hour;
                                end_minute = end_time.getMinutes() - distance_to_begin_minute;
                            }
                            if (start_hour > (self.settings.maxTime - 1) && start_minute >= 0) {
                                start_hour = start_time.getHours() + distance_to_end_hour;
                                start_minute = start_time.getMinutes() + distance_to_end_minute;

                                end_hour = end_time.getHours() + distance_to_end_hour;
                                end_minute = end_time.getMinutes() + distance_to_end_minute;
                            }

                            if (end_hour < self.settings.minTime ||
                                (end_hour === self.settings.minTime && end_minute <= 30)) {
                                end_hour = end_time.getHours() - distance_to_begin_hour;
                                end_minute = end_time.getMinutes() - distance_to_begin_minute;

                                start_hour = start_time.getHours() - distance_to_begin_hour;
                                start_minute = start_time.getMinutes() - distance_to_begin_minute;
                            }
                            if (end_hour > self.settings.maxTime ||
                                (end_hour === self.settings.maxTime && end_minute > 0)) {
                                end_hour = end_time.getHours() + distance_to_end_hour;
                                end_minute = end_time.getMinutes() + distance_to_end_minute;

                                start_hour = start_time.getHours() + distance_to_end_hour;
                                start_minute = start_time.getMinutes() + distance_to_end_minute;
                            }

                            if (start_minute < 0) {
                                start_minute += 60;
                                start_hour--;
                            }
                            if (start_minute >= 60) {
                                start_minute -= 60;
                                start_hour++;
                            }
                            if (end_minute < 0) {
                                end_minute += 60;
                                end_hour--;
                            }
                            if (end_minute >= 60) {
                                end_minute -= 60;
                                end_hour++;
                            }
                            if (end_hour >= 24) {
                                end_hour = 23;
                                end_minute = 59;
                            }
                        }
                    }
                    if (date_start_dragging.getTime() === date_start_event.getTime()) {
                        string_time = multi_view.util.formatTimeString(start_hour, start_minute) + '-' +
                            grn.component.date.toLocaleDateString(end_time);
                    }
                    if (date_start_dragging.getTime() === date_end_event.getTime()) {
                        string_time = grn.component.date.toLocaleDateString(start_time) + '-' +
                            multi_view.util.formatTimeString(end_hour, end_minute);
                    }
                }
                else {
                    start_hour = start_time.getHours();
                    start_minute = start_time.getMinutes();
                    end_hour = end_time.getHours();
                    end_minute = end_time.getMinutes();
                    string_time = grn.component.date.toLocaleDateString(start_time) + '-' +
                        grn.component.date.toLocaleDateString(end_time);
                }
                div_tooltip_timespan.html(string_time);

                start_time.setDate(new_date_start_event.getDate());
                start_time.setMonth(new_date_start_event.getMonth());
                start_time.setYear(new_date_start_event.getFullYear());
                end_time.setDate(new_date_end_event.getDate());
                end_time.setMonth(new_date_end_event.getMonth());
                end_time.setYear(new_date_end_event.getFullYear());
                multi_view.util.timeAfterDragDrop = {
                    'start_hour': start_hour,
                    'start_minute': start_minute,
                    'end_hour': end_hour,
                    'end_minute': end_minute,
                    'bdate': start_time,
                    'edate': end_time,
                    'event_id': event_dragging.data('event_id')
                };

                date_columns.each(function () {
                    var current_day = $(this).data('date');
                    var tempEvent = $(this).find('div.tempEvent');
                    var tempTopStartTime, tempHeightStartTime, tempHeightEndTime;

                    if (current_day.getTime() === new_date_start_event.getTime()) {
                        tempTopStartTime = start_hour - self.settings.minTime;
                        if (start_minute > 0) {
                            tempTopStartTime = tempTopStartTime + (start_minute / 60);
                        }
                        tempTopStartTime = tempTopStartTime / height_column * 100;
                        tempHeightStartTime = 100 - tempTopStartTime;
                        tempEvent.html(container.data('title').clone());
                        tempEvent.css({'height': tempHeightStartTime + '%', 'top': tempTopStartTime + '%'});
                        tempEvent.show();
                    }
                    else {
                        if (current_day.getTime() === new_date_end_event.getTime()) {
                            tempHeightEndTime = end_hour - self.settings.minTime;
                            if (end_minute > 0) {
                                tempHeightEndTime = tempHeightEndTime + (end_minute / 60);
                            }
                            tempHeightEndTime = tempHeightEndTime / height_column * 100;
                            tempEvent.html(container.data('title').clone());
                            tempEvent.css({'height': tempHeightEndTime + '%', 'top': '0%'});
                            tempEvent.show();
                        }
                        else {
                            if (current_day.getTime() > new_date_start_event.getTime() && current_day.getTime() < new_date_end_event.getTime()) {
                                tempEvent.html(container.data('title').clone());
                                tempEvent.css({'height': '100%', 'top': '0%'});
                                tempEvent.show();
                            }
                            else {
                                tempEvent.hide();
                            }
                        }
                    }
                });
            });

            dummy_container.hide();
        }

        return $(element).each(function () {
            $(this).on("mouseover", function () {
                $.each(opts.group || {}, function (key, value) {
                    if (!multi_view.util.dragging) {
                        $(value).css('background-color', '').addClass('personal_over_schedule');
                    }
                });
                var documentWidth, documentHeight;
                if (!$(this).data("init")) {
                    $(this).data("init", true).draggable(opts, {
                        helper: function () {
                            return $('<div/>');
                        },
                        start: function (ev) {

                            multi_view.util.dragging = true;

                            dummy_container.css({
                                'width': container.width() + 'px',
                                'height': container.height() + 'px',
                                'position': 'absolute',
                                'z-index': '1001',
                                'cursor': 'move'
                            }).show();

                            container.data('check_first', false);
                            container.data('calculate_distance', false);
                            var thisObj = $(this);
                            var event_data = $(thisObj).data('event');
                            var start_time = new Date(event_data.start_date_object),
                                end_time = new Date(event_data.end_date_object);
                            if (start_time.getMinutes() !== 0 && start_time.getMinutes() !== 30) {
                                container.data('check_first', true);
                            }
                            container.data('start_time', start_time);
                            container.data('end_time', end_time);

                            // set color for the event which is being dragged
                            var member = multi_view.util.getMemberFromEvent(event_data);
                            member = self.settings.memberList.getById(member.id, member.type);

                            var member_color_css = multi_view.util.createEventBlockColorCss(
                                member.id, member.type, self.settings.memberList);

                            container.find('div.tempEvent')
                                .removeClass()
                                .addClass('tempEvent dragging_schedule ' + member_color_css);

                            // set title
                            var title;
                            $.each(opts.group || {}, function (key, value) {
                                $(value).addClass('original_schedule');
                                title = $($(value).data('title'));
                                container.data('title', title);
                            });

                            // init tooltip displays time when dragging
                            var div_tooltip_timespan = $('<div class="showTimeSpanTitle"/>').html(multi_view.util.stringSpanTime(thisObj));
                            div_tooltip_timespan.css({
                                'position': 'absolute',
                                'top': ev.pageY + 10 + 'px',
                                'z-index': '99'
                            });
                            $('body').append(div_tooltip_timespan);
                            documentWidth = $(document).width();
                            documentHeight = $(document).height();
                            multi_view.util.setLeftTooltip(div_tooltip_timespan, ev.pageX, documentWidth);

                            if (opts.startNative) {
                                opts.startNative();
                            }
                        },
                        drag: function (ev) {
                            // hide tooltip event
                            $("div.tooltipEventContainer").remove();
                            container.data('event_dragging', $(this));
                            $.each(opts.group || {}, function (key, value) {
                            });

                            // show time when dragging
                            var div_tooltip_timespan = $('div.showTimeSpanTitle');
                            // prevent drag pointer out of document width
                            multi_view.util.setLeftTooltip(div_tooltip_timespan, ev.pageX, documentWidth);

                            // prevent drag pointer out of document height
                            multi_view.util.setTopTooltip(div_tooltip_timespan, ev.pageY, documentHeight);

                            if (opts.dragNative) {
                                opts.dragNative();
                            }
                        },
                        stop: function (ev) {
                            multi_view.util.dragging = false;
                            container.data('check_save_original_position', false);
                            container.find('div.tempEvent');
                            dummy_container.hide();

                            $.each(opts.group || {}, function (key, value) {
                                $(value).removeClass('original_schedule').hide();
                            });

                            $('div.showTimeSpanTitle').remove();

                            var element = $(this);
                            var callback = function (opts, container) {
                                $.each(opts.group || {}, function (key, value) {
                                    $(value).show();
                                });
                                container.find('div.tempEvent').hide();
                            };

                            if (multi_view.util.isDragToAnotherTime(element)) {
                                multi_view.util.showConfirmUpdateEventDialog(element, ev, callback, opts,
                                    container, $.proxy(self._onEventUpdate, self));
                            }
                            else {
                                $.each(opts.group || {}, function (key, value) {
                                    $(value).show();
                                });
                                container.find('div.tempEvent').hide();
                            }

                            if (opts.stopNative) {
                                opts.stopNative();
                            }
                        }
                    });
                }
            });

            $(this).on("mouseout", function () {
                $.each(opts.group || {}, function (key, value) {
                    $(value).removeClass('personal_over_schedule');
                });
            });
        });
    };

    G.prototype._createContainerForDraggingMultipleDaysEvent = function ($container) {
        var $container_parent = $container.parent();

        var $dummy_container = $('<div class="dummy-container"/>').css({
            'width': $container.width() + 'px',
            'height': $container.height() + 'px',
            'position': 'absolute',
            'z-index': '1001'
        });

        $dummy_container.offset({top: 0, left: 24});
        $dummy_container.appendTo($container_parent);

        var $columns = $container.find('.personal_day_event_list');

        $columns.each(function () {
            var $column = $(this);
            var $event = $('<div class="critical3 tempEvent"/>').css({
                'width': '90%',
                'max-width': '90%',
                'height': '100%',
                'top': '0%',
                'left': '0%',
                'overflow': 'hidden',
                'cursor': 'move'
            }).hide();

            $event.appendTo($column);
        });

        return {
            $container: $dummy_container,
            $columns: $columns
        };
    };

})(jQuery);

