(function ($) {
    "use strict";

    grn.base.namespace("grn.component.schedule.multi_view.event_resize");

    grn.component.schedule.multi_view.event_resize = function(settings){
        grn.component.pubsub.installTo(this);
        this.settings = settings;
        this._$container = $(this.settings.container.view);
    };

    var multi_view = grn.component.schedule.multi_view;
    var date_component = grn.component.date;
    var ONE_HOUR_HEIGHT = 40;
    var HALF_HOUR_HEIGHT = 20;
    var start_time, end_time, string_time, distance, originalPosition, isTopResize, lastedPosition, bottom_position;
    var documentWidth, documentHeight;

    /**
     * @alias grn.component.schedule.multi_view.event_resize
     * @type {grn.component.schedule.multi_view.event_resize}
     */
    var G = grn.component.schedule.multi_view.event_resize;

    G.prototype.init = function () {
        var self = this;
        this._$container.find(".schedule").each(function () {
            var $schedule_element = $(this);
            if (!multi_view.util.checkEventCanDragDrop($schedule_element)) {
                return;
            }

            var string_handle = '';

            if (multi_view.util.checkEventHaveHandle($schedule_element, 'top')) {
                string_handle = 'n';
            }

            if (multi_view.util.checkEventHaveHandle($schedule_element, 'bottom')) {
                string_handle = string_handle + ',s';
            }

            if (!string_handle) {
                return;
            }

            $schedule_element.resizable({
                containment: $(this).parent(),
                handles: string_handle,
                grid: [0, HALF_HOUR_HEIGHT],
                minHeight: 17,
                distance: 1,
                resize: function (ev, ui) {
                    self.trigger("resize");
                    self.resizeSchedule(ev, ui);
                },
                start: function (ev, ui) {
                    self.trigger("start");
                    self.resizeStart(ev, ui);
                    self.resizeSchedule(ev, ui);
                },
                stop: function (ev, ui) {
                    self.trigger("stop");
                    self.resizeStop(ev, ui);
                }
            });
        });
    };

    G.prototype._onEventUpdate = function() {
        this.trigger("eventUpdate");
    };

    G.prototype.resizeSchedule = function (ev, ui) {
        // show time when resizing
        var div_tooltip_timespan = $('div.showTimeSpanTitle');
        // prevent drag pointer out of document width
        multi_view.util.setLeftTooltip(div_tooltip_timespan,ev.pageX,documentWidth);

        // prevent drag pointer out of document height
        multi_view.util.setTopTooltip(div_tooltip_timespan,ev.pageY,documentHeight);

        // do not allow to resize schedule less than 17px
        if (isTopResize && (bottom_position - ui.position.top < 17)) {
            ui.position.top = lastedPosition;
            ui.element.css({"top": lastedPosition});
        }
        else {
            lastedPosition = ui.position.top;
        }

        string_time = this.calculateSpanTime(ui, ui.element, start_time, end_time, isTopResize);
        div_tooltip_timespan.html(string_time);
        ev.preventDefault();
        ev.stopPropagation();
    };


    G.prototype.resizeStart = function (ev, ui) {
        multi_view.util.timeAfterDragDrop = null;
        // determine resize top or bottom
        isTopResize = Math.abs(ev.pageY - ui.element.offset().top) < 5;

        var old_element = ui.element.clone();
        old_element.removeClass()
            .addClass('critical3 original_schedule')
            .appendTo(ui.element.parent())
            .find('div.dragdrop_handle').remove();
        ui.element.addClass('resizing_schedule').css('z-index', 90); // make element resizing on top

        // show time when beginning resize schedule
        string_time = multi_view.util.stringSpanTime(ui.element);
        var div_tooltip_timespan = $('<div class="showTimeSpanTitle"/>').html(string_time);
        div_tooltip_timespan.css({'position': 'absolute', 'top': ev.pageY + 10 + 'px', 'z-index': '99'});
        $('body').append(div_tooltip_timespan);
        documentWidth = $(document).width();
        documentHeight = $(document).height();
        multi_view.util.setLeftTooltip(div_tooltip_timespan, ev.pageX, documentWidth);

        // check begin resizing
        multi_view.util.resizing = true;

        var data_event = $(ui.element).data('event');
        start_time = new Date(data_event.start_date_object.getTime());
        if ('end_date' in data_event) {
            end_time = new Date(data_event.end_date_object.getTime());
            if (data_event.same_time) {
                end_time.setMinutes(end_time.getMinutes() + 30);
            }
        }
        else {
            end_time = new Date(data_event.start_date_object.getTime());
            end_time.setMinutes(end_time.getMinutes() + 30);
        }

        originalPosition = ev.pageY;

        var check_top = (start_time.getMinutes() !== 0 && start_time.getMinutes() !== 30);
        var check_bottom = (end_time.getMinutes() !== 0 && end_time.getMinutes() !== 30);

        // change schedule over day to blue
        $('.' + ui.element.data('group_drag')).each(function () {
            $(this).addClass('resizing_schedule');
        });

        // round minute to 0 or 30
        var start_hour, start_minute, end_hour, end_minute, time_change, tempTopStartResizing;
        if (isTopResize && check_top) {
            time_change = this.changeTimeBeforeResizing(ui.position.top, ui.originalPosition.top, start_time, data_event);

            start_hour = time_change.start_hour;
            start_minute = time_change.start_minute;

            tempTopStartResizing = start_hour - this.settings.minTime;
            if (start_minute > 0) {
                tempTopStartResizing = tempTopStartResizing + (start_minute / 60);
            }

            tempTopStartResizing = tempTopStartResizing * ONE_HOUR_HEIGHT;
            distance = tempTopStartResizing - ui.originalPosition.top;

            ui.size.height = ui.size.height - distance;
            ui.originalSize.height = ui.originalSize.height - distance;

            ui.position.top = tempTopStartResizing;
            ui.originalPosition.top = tempTopStartResizing;

            ui.element.css({"top": ui.originalPosition.top, "height": ui.originalSize.height});

            start_time.setHours(start_hour);
            start_time.setMinutes(start_minute);
            end_hour = end_time.getHours();
            end_minute = end_time.getMinutes();

            string_time = multi_view.util.formatTimeString(start_hour, start_minute) + '-' + multi_view.util.formatTimeString(end_hour, end_minute);
        }
        else {
            if (!isTopResize && check_bottom) {
                time_change = this.changeTimeBeforeResizing(ui.size.height, ui.originalSize.height, end_time, data_event);
                end_hour = time_change.start_hour;
                end_minute = time_change.start_minute;

                tempTopStartResizing = end_hour - this.settings.minTime;
                if (end_minute > 0) {
                    tempTopStartResizing = tempTopStartResizing + (end_minute / 60);
                }
                tempTopStartResizing = tempTopStartResizing * ONE_HOUR_HEIGHT;
                ui.size.height = tempTopStartResizing - ui.position.top;
                ui.originalSize.height = tempTopStartResizing - ui.position.top;

                ui.element.css({"top": ui.originalPosition.top, "height": ui.originalSize.height});

                start_hour = start_time.getHours();
                start_minute = start_time.getMinutes();
                end_time.setHours(end_hour);
                end_time.setMinutes(end_minute);

                string_time = multi_view.util.formatTimeString(start_hour, start_minute) + '-' +
                    multi_view.util.formatTimeString(end_hour, end_minute);
            }
        }
        div_tooltip_timespan.html(string_time);
        lastedPosition = ui.position.top;
        bottom_position = ui.position.top + ui.size.height;

        ev.preventDefault();
        ev.stopPropagation();
    };

    G.prototype.resizeStop = function (ev, ui) {
        // stop resizing
        multi_view.util.resizing = false;

        // remove resizing handle if mouse out of schedule
        multi_view.util.removeResizingHandle(ev, ui.element);
        // remove time span
        $('div.showTimeSpanTitle').remove();

        var parent = ui.element.parent();
        parent.find('div.original_schedule').remove();

        multi_view.util.afterDragDrop(ui.element, parent, ev, $.proxy(this._onEventUpdate, this));
        ev.preventDefault();
        ev.stopPropagation();
    };

    G.prototype.calculateSpanTime = function (ui, ev, start_time, end_time, isTopResize) {
        var distance, start_hour, start_minute, end_hour, end_minute;
        if (ui.originalPosition.top === ui.position.top) {
            distance = multi_view.util.calculateTimeDistance(ui.size.height, ui.originalSize.height);
        }
        else {
            distance = multi_view.util.calculateTimeDistance(ui.position.top, ui.originalPosition.top);
        }

        var data_event = $(ev).data('event');

        if (ui.originalPosition.top === ui.position.top && !isTopResize) {
            if (end_time.getHours() === 23 && end_time.getMinutes() === 59) {
                end_hour = 24 + (distance.sign * distance.distance_hour);
                end_minute = distance.sign * distance.distance_minute;
            }
            else {
                end_hour = end_time.getHours() + (distance.sign * distance.distance_hour);
                end_minute = end_time.getMinutes() + (distance.sign * distance.distance_minute);
            }
            if (end_minute < 0) {
                end_minute = end_minute + 60;
                end_hour--;
            }
            if (end_minute >= 60) {
                end_minute = end_minute - 60;
                end_hour++;
            }
            if (end_hour >= 24) {
                end_hour = 23;
                end_minute = 59;
            }
            if (end_hour < 0) {
                end_hour += 24;
                end_time.setDate(end_time.getDate() - 1);
            }
            if (end_hour > this.settings.maxTime || (end_hour === this.settings.maxTime && end_minute > 0)) {
                end_hour = this.settings.maxTime;
                end_minute = 0;
            }
            multi_view.util.timeAfterDragDrop = {
                'start_hour': start_time.getHours(),
                'start_minute': start_time.getMinutes(),
                'end_hour': end_hour,
                'end_minute': end_minute,
                'bdate': start_time,
                'edate': end_time,
                'event_id': ev.data('event_id')
            };
            if (start_time.getDate() === end_time.getDate()) {
                return data_event.start_date.substr(11, 5) + '-' + multi_view.util.formatTimeString(end_hour, end_minute);
            }
            else {
                return grn.component.date.toLocaleDateString(start_time) + '-' + multi_view.util.formatTimeString(end_hour, end_minute);
            }
        }
        else {
            start_hour = start_time.getHours() + (distance.sign * distance.distance_hour);
            start_minute = start_time.getMinutes() + (distance.sign * distance.distance_minute);
            if (start_minute < 0) {
                start_minute = start_minute + 60;
                start_hour--;
            }
            if (start_minute >= 60) {
                start_minute = start_minute - 60;
                start_hour++;
            }
            if (start_hour < this.settings.minTime) {
                start_hour = this.settings.minTime;
                start_minute = 0;
            }
            if (start_time.getDate() === end_time.getDate()) {
                if (start_hour > end_time.getHours())
                    start_hour = end_time.getHours();
                if (start_hour == end_time.getHours() && start_minute > end_time.getMinutes())
                    start_minute = 0;
            }
            multi_view.util.timeAfterDragDrop = {
                'start_hour': start_hour,
                'start_minute': start_minute,
                'end_hour': end_time.getHours(),
                'end_minute': end_time.getMinutes(),
                'bdate': start_time,
                'edate': end_time,
                'event_id': ev.data('event_id')
            };

            var util = multi_view.util;
            if (start_time.getDate() === end_time.getDate()) {
                if ('end_date' in data_event) {
                    if (data_event.same_time) {
                        return util.formatTimeString(start_hour, start_minute) + '-' +
                            util.formatTimeString(end_time.getHours(), end_time.getMinutes());
                    }
                    else {
                        return util.formatTimeString(start_hour, start_minute) + '-' +
                            data_event.end_date.substr(11, 5);
                    }
                }
                else {
                    return util.formatTimeString(start_hour, start_minute) + '-' +
                        util.formatTimeString(end_time.getHours(), end_time.getMinutes());
                }
            }
            else {
                return util.formatTimeString(start_hour, start_minute) + '-' +
                    grn.component.date.toLocaleDateString(end_time);
            }
        }
    };

    G.prototype.changeTimeBeforeResizing = function (currentCursor, originalCursor, resize_begin_time) {
        var start_hour, start_minute;
        if (currentCursor - originalCursor > 0) {
            if (resize_begin_time.getMinutes() > 0 && resize_begin_time.getMinutes() < 30) {
                start_hour = resize_begin_time.getHours();
                start_minute = 30;
            }

            if (resize_begin_time.getMinutes() > 30) {
                start_hour = resize_begin_time.getHours() + 1;
                start_minute = 0;
            }

            if (start_hour === this.settings.maxTime) {
                start_hour = this.settings.maxTime - 1;
                start_minute = 30;
            }
        }
        else {
            if (resize_begin_time.getMinutes() > 0 && resize_begin_time.getMinutes() < 30) {
                start_hour = resize_begin_time.getHours();
                start_minute = 0;
            }

            if (resize_begin_time.getMinutes() > 30) {
                start_hour = resize_begin_time.getHours();
                start_minute = 30;
            }
        }
        return {start_hour: start_hour, start_minute: start_minute};
    };

})(jQuery);

