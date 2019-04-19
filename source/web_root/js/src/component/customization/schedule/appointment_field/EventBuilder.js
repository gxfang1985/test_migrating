import * as constant from "./constant";
import AppointmentFieldUtil from "./util";
import {RegularEventPeriodFields} from "../datetime_fields/RegularEventPeriodFields";
import {BannerEventPeriodFields} from "../datetime_fields/BannerEventPeriodFields";
import {RepeatEventPeriodFields} from "../datetime_fields/RepeatEventPeriodFields";

const $ = jQuery;

export default class EventBuilder {
    /**
     * init
     * @param {EventObject} event_obj
     * @param {EventObject} init_event_obj
     * @param {jQuery} $form
     */
    constructor(init_event_obj, event_obj, $form) {
        this.$form = $form;
        this.initEventObject = init_event_obj;
        this.eventObject = $.extend(true, {}, event_obj);
        this.util = new AppointmentFieldUtil($form);
    }

    /**
     * Build main event
     */
    buildEvent() {
        this._buildBaseEvent();
        this._buildCompany();
        this._buildVisibilityType();
        this._buildUseAttendanceCheck();
        this._buildMembers();
        this._buildStartEnd();
        this._buildStartOnlyAndIsAllDay();
        this._buildFacilities();
        this._buildFacilityPurpose();
        this._buildFacilityReservationInfo();
        this._buildRepeatInfo();
        this._buildCustomItem();
    }

    /**
     * Get Event Data
     * @returns {*}
     */
    getData() {
        return this.eventObject;
    }

    /**
     * Build base event
     * @private
     */
    _buildBaseEvent() {
        const $event_menu = this.$form
            .find("ul.js_customization_appointment_type")
            .closest("dl")
            .find("dt span.mRight3");
        if ($event_menu.length > 0) {
            this.eventObject.eventMenu = $event_menu.text();
            if (this.eventObject.eventMenu === constant.DEFAULT_EVENT_MENU) {
                this.eventObject.eventMenu = "";
            }
        }

        const $subject = this.$form.find("input[name='title']");
        if ($subject.length > 0) {
            this.eventObject.subject = $subject.val();
        }

        const $notes = this.$form.find("textarea[name='memo']");
        if ($notes.length > 0) {
            this.eventObject.notes = $notes.val();
        }
    }

    /**
     * Build start and end
     * @private
     */
    _buildStartEnd() {
        switch (this.initEventObject.eventType) {
            case constant.EVENT_TYPE.REGULAR:
                this.eventObject.start = RegularEventPeriodFields.getEventDateTime("start");
                this.eventObject.end = RegularEventPeriodFields.getEventDateTime("end");
                break;
            case constant.EVENT_TYPE.ALL_DAY:
                this.eventObject.start = BannerEventPeriodFields.getEventDateTime("start");
                this.eventObject.end = BannerEventPeriodFields.getEventDateTime("end");
                break;
        }
    }

    /**
     * Build start only and is all day
     * @private
     */
    _buildStartOnlyAndIsAllDay() {
        if (this.initEventObject.eventType === constant.EVENT_TYPE.REGULAR) {
            this.eventObject.isAllDay = RegularEventPeriodFields.isAllDay();
            this.eventObject.isStartOnly = RegularEventPeriodFields.isStartOnly();
        } else if (this.initEventObject.eventType === constant.EVENT_TYPE.ALL_DAY) {
            // isAllDay and isStartOnly are never changed
        } else {
            delete this.eventObject.isAllDay;
            delete this.eventObject.isStartOnly;
        }
    }

    /**
     * Build facility purpose
     * @private
     */
    _buildFacilityPurpose() {
        if (this.initEventObject.eventType === constant.EVENT_TYPE.REGULAR) {
            const $purpose = this.$form.find("textarea[name='using_purpose']");
            if ($purpose.length > 0 && this._hasFacilityPurpose()) {
                this.eventObject.facilityUsingPurpose = $purpose.val();
            } else {
                delete this.eventObject.facilityUsingPurpose;
            }
        } else {
            delete this.eventObject.facilityUsingPurpose;
        }
    }

    /**
     * Build facilities, facilitiesCandidate
     * @private
     */
    _buildFacilities() {
        if (this.initEventObject.eventType !== constant.EVENT_TYPE.ALL_DAY) {
            const facilities = this._getFacilities("facility_select", false);
            if (facilities !== null) {
                this.eventObject.facilities = facilities;
            } else {
                delete this.eventObject.facilities;
            }
            const facilities_candidate = this._getFacilities("facility_select", true);
            if (facilities_candidate !== null) {
                this.eventObject.facilitiesCandidate = facilities_candidate;
            } else {
                delete this.eventObject.facilitiesCandidate;
            }
        } else {
            delete this.eventObject.facilities;
            delete this.eventObject.facilitiesCandidate;
        }
    }

    /**
     * Build facility reservation info
     * @private
     */
    _buildFacilityReservationInfo() {
        if (this.initEventObject.eventType !== constant.EVENT_TYPE.ALL_DAY) {
            const facility_reservation_info = this.eventObject.facilityReservationInfo || {};
            this.$form.find("div#extended_items .js_item").each((index, item) => {
                if (!$(item).is(":disabled")) {
                    const item_code = $(item).data("code");
                    const item_type = this.util.convertFacilityReservationItem($(item).data("type"));
                    facility_reservation_info[item_code] = {type: item_type, value: $(item).val()};
                }
            });
            if (Object.keys(facility_reservation_info).length !== 0
                && this.eventObject.facilities
                && this.eventObject.facilities.length !== 0) {
                this.eventObject.facilityReservationInfo = facility_reservation_info;
            } else {
                delete this.eventObject.facilityReservationInfo;
            }
        } else {
            delete this.eventObject.facilityReservationInfo;
        }
    }

    /**
     * Build members (attendees, attendeesCandidate, watchers, watchersCandidate)
     * @private
     */
    _buildMembers() {
        this.eventObject.attendees = this._getMembers("attendees", "member_select", false, true);
        this.eventObject.attendeesCandidate = this._getMembers("attendeesCandidate", "member_select", true, false);
        if (this.initEventObject.eventType !== constant.EVENT_TYPE.ALL_DAY
            && this.eventObject.visibilityType === constant.VISIBILITY_TYPE_PRIVATE_WATCHERS) {
            this.eventObject.watchers = this._getMembers("watchers", "private_select", false, false);
            this.eventObject.watchersCandidate = this._getMembers("watchersCandidate", "private_select", true, false);
        } else {
            delete this.eventObject.watchers;
            delete this.eventObject.watchersCandidate;
        }
    }

    /**
     * Build use attendance check
     * @private
     */
    _buildUseAttendanceCheck() {
        if (this.initEventObject.eventType === constant.EVENT_TYPE.REGULAR) {
            const $attendance_check = this.$form.find("input[name='attendance_check']");
            if ($attendance_check.length > 0) {
                this.eventObject.useAttendanceCheck = $attendance_check.is(":checked");
            }
        } else {
            delete this.eventObject.useAttendanceCheck;
        }
    }

    /**
     * Build visibility type
     * @private
     */
    _buildVisibilityType() {
        const $visibility_type = this.$form.find("input[name='private']:checked");
        if ($visibility_type.length > 0 && this.initEventObject.eventType !== constant.EVENT_TYPE.ALL_DAY) {
            const visibility_type = parseInt($visibility_type.val(), 10);
            this.eventObject.visibilityType = constant.VISIBILITY_TYPE[visibility_type];
        } else {
            delete this.eventObject.visibilityType;
        }
    }

    /**
     * Build company information
     * @private
     */
    _buildCompany() {
        if (!this.eventObject.hasOwnProperty("companyInfo")) {
            this.eventObject.companyInfo = {};
        }
        this.eventObject.companyInfo.address = this.$form.find("input[name='physical_address']").val();
        this.eventObject.companyInfo.name = this.$form.find("input[name='company_name']").val();
        this.eventObject.companyInfo.phone = this.$form.find("input[name='company_telephone_number']").val();
        this.eventObject.companyInfo.route = this.$form.find("input[name='route']").val();
        this.eventObject.companyInfo.routeFare = this.$form.find("input[name='route_fare']").val();
        this.eventObject.companyInfo.routeTime = this.$form.find("input[name='route_time']").val();
        this.eventObject.companyInfo.zipCode = this.$form.find("input[name='zip_code']").val();
    }

    /**
     * Build repeat info
     * @private
     */
    _buildRepeatInfo() {
        if (this.initEventObject.eventType === constant.EVENT_TYPE.REPEATING) {
            const repeat_info = {};
            repeat_info.isAllDay = RepeatEventPeriodFields.isAllDay();
            repeat_info.isStartOnly = RepeatEventPeriodFields.isStartOnly();
            repeat_info.period = RepeatEventPeriodFields.getPeriodInfo();
            repeat_info.time = RepeatEventPeriodFields.getTimeInfo();
            repeat_info.timeZone = RepeatEventPeriodFields.getTimeZone("start");
            this.eventObject.repeatInfo = repeat_info;
            this._buildRepeatInfoRange();
            this._buildRepeatInfoDateCondition();
        } else {
            delete this.eventObject.repeatInfo;
        }
    }

    /**
     * Build repeat info range
     * @private
     */
    _buildRepeatInfoRange() {
        if (this.$form.find("input[name='apply']").length === 0) {
            return;
        }
        const range_type = this.$form.find("input[name='apply']:checked").val();
        let type = "";
        let date = "";
        switch (range_type) {
            case "this": {
                type = constant.REPEAT_RANGE.THIS_EVENT_ONLY;
                const year = parseInt(this.$form.find("select[name='this_year']").val(), 10);
                const month = parseInt(this.$form.find("select[name='this_month']").val(), 10);
                const day = parseInt(this.$form.find("select[name='this_day']").val(), 10);
                date = RepeatEventPeriodFields.formatDate(year, month, day);
                break;
            }
            case "after": {
                type = constant.REPEAT_RANGE.ON_AND_AFTER_THIS_EVENT;
                break;
            }
            case "all": {
                type = constant.REPEAT_RANGE.ALL_EVENT;
                break;
            }
        }
        this.eventObject.repeatInfo.range = {type: type, date: date};
    }

    /**
     * build repeat info condition
     * @private
     */
    _buildRepeatInfoDateCondition() {
        const type = this.$form.find("input[name='type']:checked").val();
        let repeat_type = "";
        delete this.eventObject.repeatInfo.dayOfMonth;
        delete this.eventObject.repeatInfo.dayOfWeek;
        switch (type) {
            case "day":
                repeat_type = constant.REPEAT_TYPE.EVERY_DAY;
                break;
            case "weekday":
                repeat_type = constant.REPEAT_TYPE.EVERY_WEEKDAY;
                break;
            case "week":
                repeat_type = this._getRepeatInfoDateConditionWeek();
                this.eventObject.repeatInfo.dayOfWeek = this._getRepeatInfoDayOfWeek();
                break;
            case "month":
                repeat_type = constant.REPEAT_TYPE.EVERY_MONTH;
                this.eventObject.repeatInfo.dayOfMonth = this._getRepeatInfoDayOfMonth();
                break;
        }
        this.eventObject.repeatInfo.type = repeat_type;
    }

    /**
     * Build custom item
     * @private
     */
    _buildCustomItem() {
        const $custom_item = this.$form.find("input[name='additional_items']");
        if ($custom_item.length > 0) {
            this.eventObject.additionalItems = {item: {value: $custom_item.val()}};
        }
    }

    /**
     * Get facility in component (Dom Html)
     * @param {string} add_name_instance component name instance (ex: facility_select)
     * @param {boolean} is_candidate is candidate or not
     * @returns {Array|null}
     * @private
     */
    _getFacilities(add_name_instance, is_candidate) {
        if (!grn.component.facility_add || !grn.component.facility_add.get_instance(add_name_instance)) {
            return null;
        }
        const facility_add_instance = grn.component.facility_add.get_instance(add_name_instance);
        const facilities = facility_add_instance.getFacilities(is_candidate);
        const facility_list = [];
        $.each(facilities, (key, facility) => {
            facility_list.push({id: facility.id, code: facility.code, name: facility.name});
        });
        return facility_list;
    }

    /**
     * Check has facility purpose
     * @returns {boolean}
     * @private
     */
    _hasFacilityPurpose() {
        if (!grn.component.facility_add || !grn.component.facility_add.get_instance("facility_select")) {
            return false;
        }
        const facility_add_instance = grn.component.facility_add.get_instance("facility_select");
        const facilities = facility_add_instance.getFacilities(false);
        return facilities.some(facility => facility.approval === "1");
    }

    /**
     * Get member list in schedule screen (Dom Html)
     * @param {string} event_member_property member property, ex: attendees, attendeesCandidate, watchers ,...
     * @param {string} add_name_instance component instance (ex: member_select, private_select)
     * @param {boolean} is_candidate is candidate list or not
     * @param {boolean} is_with_attendance_response is with attendance response data from server or not
     * @returns {Array}
     * @private
     */
    _getMembers(event_member_property, add_name_instance, is_candidate, is_with_attendance_response) {
        const member_add_instance = grn.component.member_add.get_instance(add_name_instance);
        let members = this.util.formatMembers(member_add_instance.getMembers(is_candidate));
        if (!is_with_attendance_response) {
            return members;
        }
        const member_list = {};
        $.each(members, (key, member) => {
            member_list[key] = member;
        });
        const post_data = {
            app_id: "schedule",
            event_id: this.eventObject.id ? this.eventObject.id : null,
            is_candidate: is_candidate,
            members: JSON.stringify(member_list),
            plugin_session_name: member_add_instance.formName,
            plugin_data_name: "access_plugin",
            is_watchers: event_member_property === "watchers" || event_member_property === "watchersCandidate"
        };
        const ajax_request = new grn.component.ajax.request(
            {
                grnUrl: "grn/ajax/get_members_by_code",
                method: "post",
                dataType: "json",
                data: post_data,
                async: false
            });
        ajax_request.send().done((json_data) => {
            members = this.util.formatMembers(json_data.members_info);
        });
        return members;
    }

    /**
     * get Repeat info date condition week option
     * @returns {string}
     * @private
     */
    _getRepeatInfoDateConditionWeek() {
        const week_repeat_type = this.$form.find("select[name='week']").val();
        const type_index = Object.values(constant.REPEAT_TYPE_VALUE).indexOf(week_repeat_type);
        const type = type_index !== -1 ? Object.keys(constant.REPEAT_TYPE_VALUE)[type_index] : "";
        return type;
    }

    /**
     * Get repeat info day of week
     * @returns {string}
     * @private
     */
    _getRepeatInfoDayOfWeek() {
        const day_of_week = parseInt(this.$form.find("select[name='wday']").val(), 10);
        let day_of_week_formatted = "";
        if (typeof (constant.REPEAT_DAY_OF_WEEK[day_of_week]) !== "undefined") {
            day_of_week_formatted = constant.REPEAT_DAY_OF_WEEK[day_of_week];
        }

        return day_of_week_formatted;
    }

    /**
     * Get Repeat info day of month
     * @returns {string}
     * @private
     */
    _getRepeatInfoDayOfMonth() {
        let day_of_month = this.$form.find("select[name='day']").val();
        if (day_of_month === "0") {
            day_of_month = constant.REPEAT_END_OF_MONTH;
        }
        return day_of_month;
    }
}