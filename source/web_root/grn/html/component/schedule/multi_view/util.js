(function ($) {
    "use strict";

    grn.base.namespace("grn.component.schedule.multi_view.util");

    var G = grn.component.schedule.multi_view.util;
    var date_component = grn.component.date;
    var url_component = grn.component.url;
    var multi_view = grn.component.schedule.multi_view;

    var EVENT_BLOCK_COLOR_CSS_FORMAT = "event_block_color%COLOR_ID%_grn";
    var HALF_HOUR_HEIGHT = 20;
    G.timeAfterDragDrop = '';
    G.resizing = false;
    G.dragging = false;
    G.duringDragdrop = false;

    /**
     * Parse "members" param to grn.component.schedule.multi_view.member_list object.
     *
     * The "members" param looks like this "members=u.10.1.1-u.20.0.2-f.30.1.3-f.40.1.4"
     * - Members are separated by hyphen "-".
     * - Each member item has 4 parts separated by dot "."
     * -- The first part represents member type. "u" is for user, "f" is for facility, "g" is for organization
     * -- The second part represents member ID.
     * -- The third part represents selection state. (1: selected, 0: unselected)
     * -- The fourth part represents color ID.
     *
     * @param members_string
     * @returns {grn.component.schedule.multi_view.member_list}
     */
    G.parseMembersParam = function (members_string) {
        members_string = members_string || '';

        var MEMBER_TYPE = multi_view.member_list.MEMBER_TYPE;
        var MEMBER_TYPE_MAP = {
            u: MEMBER_TYPE.USER,
            g: MEMBER_TYPE.ORGANIZATION,
            f: MEMBER_TYPE.FACILITY
        };

        var members_array = members_string.split("-");
        var member_list = new multi_view.member_list();

        for (var i = 0; i < members_array.length; i++) {
            var member_info = members_array[i].split('.');

            if (member_info.length < 2) {
                continue;
            }

            var type = MEMBER_TYPE_MAP[member_info[0]];
            if (!type) {
                continue;
            }

            var id = parseInt(member_info[1], 10);
            if (isNaN(id)) {
                continue;
            }

            var member = new multi_view.member_list.Member(id, type);

            // selected
            if (typeof member_info[2] !== "undefined") {
                member.selected = member_info[2] !== "0";
            }

            // color ID
            if (typeof member_info[3] !== "undefined") {
                member.colorId = member_info[3];
            }

            member_list.add(member);
        }

        return member_list;
    };

    /**
     * Serialize the given members array to string.
     * The result looks like this "u.1.1.0-f.3.1.1-g.4.1.2"
     * @param {Object[]} members
     * @param {Object} [options]
     * @returns {string}
     */
    G.serializeMembers = function (members, options) {
        var members_array = [];
        var MEMBER_TYPE = multi_view.member_list.MEMBER_TYPE;

        for (var i = 0; i < members.length; i++) {
            var member = members[i];

            var type = null;

            switch (member.type) {
                case MEMBER_TYPE.USER:
                    type = "u";
                    break;
                case MEMBER_TYPE.ORGANIZATION:
                    type = "g";
                    break;
                case MEMBER_TYPE.FACILITY:
                    type = "f";
                    break;
            }

            if (type == null) {
                continue;
            }

            var selected = member.selected ? 1 : 0;

            var member_array = [];
            if (options && options.id_type_only) {
                member_array = [type, member.id];
            }
            else {
                member_array = [type, member.id, selected, member.colorId];
            }

            members_array.push(member_array.join("."));
        }

        return members_array.join("-");
    };

    /**
     * @param {string} value Its format looks as follows "10", "g5", "m3", "f4", etc.
     * @returns {*}
     */
    G.parseMemberValue = function (value) {
        var parsed = value.match(/([a-z]*)(\d*)/);
        var map = {
            g: 'org',
            f: 'facility'
        };

        var abbr_type = parsed[1];
        var type = map[abbr_type] || 'user';
        var id = parsed[2];

        if (!id) {
            return null;
        }

        return new multi_view.member_list.Member(id, type);
    };

    G.createEventBlockColorCss = function (member_id, member_type, member_list) {
        var member = member_list.getById(member_id, member_type, member_list);

        if (member == null) {
            return "";
        }

        var color_id = parseInt(member.colorId, 10);
        color_id = color_id === 0 ? "_login_user" : color_id.toString();

        return EVENT_BLOCK_COLOR_CSS_FORMAT.replace("%COLOR_ID%", color_id);
    };

    G.getMemberFromEvent = function (event) {
        var MEMBER_TYPE = multi_view.member_list.MEMBER_TYPE;
        return {
            id: event.uid || event.fid || event.gid,
            type: event.uid ? MEMBER_TYPE.USER :
                event.gid ? MEMBER_TYPE.ORGANIZATION :
                    event.fid ? MEMBER_TYPE.FACILITY : null
        };
    };

    G.isOneDayEvent = function (data_event) {
        if (data_event.same_time) {
            return true;
        }

        if ('end_date' in data_event) {
            var start_time = data_event.start_date_object;
            var end_time = data_event.end_date_object;

            return (start_time.getDate() === end_time.getDate() &&
                start_time.getMonth() === end_time.getMonth() &&
                start_time.getYear() === end_time.getYear()) ||
                (end_time.getHours() === 0 && end_time.getMinutes() === 0 &&
                start_time.getDate() === end_time.getDate() - 1 &&
                start_time.getMonth() === end_time.getMonth() &&
                start_time.getYear() === end_time.getYear());
        }
        else {
            return true;
        }
    };

    G.createEventUrl = function (event_data, view_params, settings) {
        // uid
        var uid = "";
        if (!event_data.relatedEvents) {
            uid = this.createUidParamFromEvent(event_data);
        }

        // bdate
        var bdate = "";
        if (view_params) {
            if (typeof view_params.beginDate === "object") {
                bdate = jQuery.datepicker.formatDate('yy-mm-dd', view_params.beginDate);
            } else {
                bdate = view_params.beginDate;
            }
        }

        var url_params = {
            event: event_data.id,
            bdate: bdate,
            end_day: event_data.end_datetime || '', // for repeat event
            uid: uid,
            gid: settings.gid,
            referer_key: settings.refererKey
        };

        return url_component.page("schedule/view", url_params);
    };

    G.createUidParamFromEvent = function(event_data) {
        var MEMBER_TYPE = multi_view.member_list.MEMBER_TYPE;

        var uid = "";
        var map = {};
        map[MEMBER_TYPE.USER] = "u";
        map[MEMBER_TYPE.ORGANIZATION] = "g";
        map[MEMBER_TYPE.FACILITY] = "f";

        var member = this.getMemberFromEvent(event_data);
        var abbr_member_type = map[member.type];

        if (member.type === MEMBER_TYPE.USER) {
            uid = event_data.uid;
        } else if (abbr_member_type) {
            uid = abbr_member_type + event_data[abbr_member_type + "id"];
        }

        return uid;
    };

    G.createModifyDetailEventUrl = function (url, bdate, start_date, end_date, uid, gid, referer_key) {
        return url + 'uid=' + uid +
            '&gid=' + gid +
            '&referer_key=' + referer_key +
            '&bdate=' + bdate +
            '&start_date=' + start_date +
            '&end_date=' + end_date +
            '&event=' + this.timeAfterDragDrop.event_id +
            '&start_hour=' + this.timeAfterDragDrop.start_hour +
            '&start_minute=' + this.timeAfterDragDrop.start_minute +
            '&end_hour=' + this.timeAfterDragDrop.end_hour +
            '&end_minute=' + this.timeAfterDragDrop.end_minute;
    };

    G.checkEventCanDragDrop = function (ev) {
        var data_event = $(ev).data('event');
        return !(
            data_event.type === 'share_temporary' ||
            data_event.type === 'temporary' ||
            'private' in data_event
        );
    };

    G.checkEventHaveHandle = function (ev, direction) {
        var data_event = $(ev).data('event');
        var datetime;

        if (direction === 'top') {
            if ('end_date' in data_event) {
                datetime = data_event.start_date_object;
            }
            else {
                return false;
            }
        }

        if (direction === 'bottom') {
            if ('end_date' in data_event) {
                datetime = data_event.end_date_object;
            }
            else {
                return true;
            }
        }

        var bdate = ev.data('bdate');

        return datetime.getDate() === bdate.getDate();
    };

    G.afterDragDrop = function (element, oldParent, ev, onEventUpdate) {
        var self = this;
        var callback = function (oldParent, element) {
            if (typeof oldParent !== "undefined") {
                element.appendTo(oldParent);
                self.returnOriginalUI();
            }
            element.css(element.data('style'));
        };

        if (this.isDragToAnotherTime(element)) {
            this.showConfirmUpdateEventDialog(element, ev, callback, oldParent, element, onEventUpdate);
        }
        else {
            $('div.ui-draggable-dragging').remove();
            element.css(element.data('style'));
            element.appendTo(oldParent);
            this.returnOriginalUI();
        }
    };

    G.returnOriginalUI = function () {
        $('.dragging_schedule').each(function () {
            $(this).removeClass('dragging_schedule');
        });
        $('.resizing_schedule').each(function () {
            $(this).removeClass('resizing_schedule');
        });
    };

    G.isDragToAnotherTime = function (ev) {
        if (!this.timeAfterDragDrop) {
            return false;
        }

        var data_event = $(ev).data('event');
        var old_start_time = data_event.start_date_object;
        var old_end_time;

        if ('end_date' in data_event) {
            old_end_time = data_event.end_date_object;
        }

        if (this.timeAfterDragDrop.end_hour === 24 && this.timeAfterDragDrop.end_minute === 0) {
            this.timeAfterDragDrop.end_hour = 0;
            this.timeAfterDragDrop.edate.setDate(this.timeAfterDragDrop.edate.getDate() + 1);
        }

        if ('end_date' in data_event) {
            return !(
                old_start_time.getHours() === this.timeAfterDragDrop.start_hour &&
                old_start_time.getMinutes() === this.timeAfterDragDrop.start_minute &&
                old_end_time.getHours() === this.timeAfterDragDrop.end_hour &&
                old_end_time.getMinutes() === this.timeAfterDragDrop.end_minute &&
                old_start_time.getDate() === this.timeAfterDragDrop.bdate.getDate()
            );
        }
        else {
            return !(
                old_start_time.getHours() === this.timeAfterDragDrop.start_hour &&
                old_start_time.getMinutes() === this.timeAfterDragDrop.start_minute &&
                old_start_time.getDate() === this.timeAfterDragDrop.bdate.getDate() &&
                !this.timeAfterDragDrop.end_hour && !this.timeAfterDragDrop.end_minute
            );
        }
    };

    G.showConfirmUpdateEventDialog = function (element, ev, callback, opts, container, onEventUpdate) {
        // show dialog (spinner)
        var confirm_dialog = multi_view.confirm_dialog;
        confirm_dialog.init(element, ev);
        confirm_dialog.show();

        // prepare data for checking update
        var bdate = element.data('bdate');
        var bdate_text = jQuery.datepicker.formatDate("yy-mm-dd", bdate);
        var start_date = jQuery.datepicker.formatDate('yy-mm-dd', this.timeAfterDragDrop.bdate);
        var end_date = '';

        if (this.timeAfterDragDrop.edate) {
            end_date = jQuery.datepicker.formatDate('yy-mm-dd', this.timeAfterDragDrop.edate);
        }

        var event_data = $(element).data('event');
        if (!this.isOneDayEvent(event_data) &&
            (event_data.type === "repeat" || event_data.type === "share_repeat") && !event_data.end_datetime) {
            bdate_text = event_data.start_date.substr(0, 10);
        }

        var new_time = this.timeAfterDragDrop;

        // create request checking update
        var request = new grn.component.ajax.request({
            grnUrl: "schedule/drag_drop_checking",
            type: "post",
            data: {
                csrf_ticket: grn.data.CSRF_TICKET,
                event_id: element.data("event_id"),
                uid: element.data("uid"),
                gid: element.data("gid"),
                referer_key: element.data("referer_key"),
                bdate: bdate_text,
                start_date: start_date,
                end_date: end_date,
                start_hour: new_time.start_hour,
                start_minute: new_time.start_minute,
                end_hour: new_time.end_hour,
                end_minute: new_time.end_minute,
                is_personal: true
            }
        });

        // send request checking update
        var promise = request.send();

        promise.done(function (response_data) {
            // hide checking
            confirm_dialog.hide();

            // show confirmation dialog
            confirm_dialog.init(element, ev, response_data, onEventUpdate);
            confirm_dialog.callback = function (result) {
                if (result === "cancel") {
                    callback(opts, container);
                }
            };
            confirm_dialog.show();
        });
    };

    G.formatTimeString = function (hour, minute) {
        var string = '';
        if (hour >= 10) {
            string += hour + ':';
        }
        else {
            string += '0' + hour + ':';
        }
        if (minute >= 10) {
            string += minute;
        }
        else {
            string += '0' + minute;
        }
        return string;
    };

    G.calculateTimeDistance = function (currentPosition, originalPosition) {
        var span = currentPosition - originalPosition;
        var sign = 1;
        if (span < 0) {
            sign = -1;
            span = Math.abs(span);
        }
        var distance = Math.round(span / HALF_HOUR_HEIGHT);
        var distance_hour = parseInt(distance / 2, 10);
        var distance_minute = (distance % 2) * 30;
        return {'sign': sign, 'distance_hour': distance_hour, 'distance_minute': distance_minute};
    };

    G.setLeftTooltip = function (element, position, documentSize) {
        var div_tooltip_timespan_width = element.width();
        var paramsLeft = {
            position: position,
            size: div_tooltip_timespan_width,
            documentSize: documentSize,
            distanceTotal: 40, // total distance: distance from pointer + margin of element
            distanceTooltip: 30, // 30px is distance from tooltip timespan to document width
            distanceMargin: 20, // 20px is default value of distance horizontal from pointer to tooltip timespan
            type: 'left'
        };
        this.setPositionTooltipTimeSpan(element, paramsLeft);
    };

    G.setTopTooltip = function (element, position, documentSize) {
        var div_tooltip_timespan_height = element.height();
        var paramsTop = {
            position: position,
            size: div_tooltip_timespan_height,
            documentSize: documentSize,
            distanceTotal: 25, // total distance: distance from pointer + margin of element
            distanceTooltip: 15, // 30px is distance from tooltip timespan to document height
            distanceMargin: 10, // 20px is default value of distance vertical from pointer to tooltip timespan
            type: 'top'
        };
        this.setPositionTooltipTimeSpan(element, paramsTop);
    };

    G.setPositionTooltipTimeSpan = function (element, params) {
        if (params.position + params.distanceTotal + params.size > params.documentSize) {
            element.css(params.type, (params.documentSize - params.distanceTooltip - params.size) + 'px');
        }
        else {
            element.css(params.type, params.position + params.distanceMargin + 'px');
        }
    };

    G.removeResizingHandle = function (ev, element) {
        if (ev.pageX < element.offset().left || ev.pageX > element.offset().left + element.width() ||
            ev.pageY < element.offset().top || ev.pageY > element.offset().top + element.height()) {
            element.removeClass('personal_over_schedule').find('div.dragdrop_handle').remove();
        }
    };

    G.stringSpanTime = function (ev) {
        var data_event = $(ev).data('event');
        var start_time = data_event.start_date.substr(11, 5);
        var end_time;
        if ('end_date' in data_event) {
            end_time = data_event.end_date.substr(11, 5);
        }
        else {
            var enddatetime = new Date(data_event.start_date_object.getTime());
            enddatetime.setMinutes(enddatetime.getMinutes() + 30);
            end_time = multi_view.util.formatTimeString(enddatetime.getHours(), enddatetime.getMinutes());
        }

        return start_time + '-' + end_time;
    };

    G.groupEventsById = function (events) {
        var result_events = [];

        // clear existing related events to avoid duplication when the events are merged
        events.forEach(function (event) {
            delete event.relatedEvents;
        });

        // merge duplicated events
        events.forEach(function (event) {
            var filtered_items = result_events.filter(function (filtered_item) {
                return event.id === filtered_item.id && event.start_date === filtered_item.start_date;
            });

            if (filtered_items.length === 0) {
                result_events.push(event);
            }
            else {
                filtered_items[0].relatedEvents = filtered_items[0].relatedEvents || [];
                filtered_items[0].relatedEvents.push(event);
            }
        });

        return result_events;
    };

})(jQuery);

