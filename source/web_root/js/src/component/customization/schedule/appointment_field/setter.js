/* global jQuery */
/* global GRN_DropdownMenu */
import {parseRFC3339DatePartString} from "../../datetime";
import AppointmentFieldGetter from "./getter";
import AppointmentFieldUtil from "./util";
import {
    EVENT_TYPE, REPEAT_TYPE, REPEAT_TYPE_VALUE, REPEAT_DAY_OF_WEEK, VISIBILITY_TYPE,
    REPEAT_END_OF_MONTH, REPEAT_RANGE, MEMBER_TYPE_PREFIX, FACILITY_RESERVATION_TYPE, VISIBILITY_TYPE_PRIVATE_WATCHERS
} from "./constant";
import {RegularEventPeriodFields} from "../datetime_fields/RegularEventPeriodFields";
import {BannerEventPeriodFields} from "../datetime_fields/BannerEventPeriodFields";
import {RepeatEventPeriodFields} from "../datetime_fields/RepeatEventPeriodFields";
import TimeFlags from "../datetime_properties/TimeFlags";
import RegularEventPeriod from "../datetime_properties/RegularEventPeriod";
import BannerEventPeriod from "../datetime_properties/BannerEventPeriod";
import RepeatEventPeriod from "../datetime_properties/RepeatEventPeriod";
import RepeatEventTime from "../datetime_properties/RepeatEventTime";
import RepeatTimeFlags from "../datetime_properties/RepeatTimeFlags";

const $ = jQuery;

export default class AppointmentFieldSetter {
    /**
     * @param {EventObject} event_object
     * @param {EventObject} initial_event_data
     * @param {jQuery} $form_object
     */
    constructor(event_object, initial_event_data, $form_object) {
        this.appointment = event_object;
        this.initial_appointment = initial_event_data;
        this.$form = $form_object;
        this.getter = new AppointmentFieldGetter(event_object);
        this.util = new AppointmentFieldUtil($form_object);
    }

    setSubject() {
        if (!this.appointment.hasOwnProperty("subject")) {
            return;
        }

        const $subject = this.$form.find("input[name='title']");
        if ($subject.length > 0) {
            $subject.val(this.appointment.subject);
        }
    }

    setStartAndEnd() {
        const event_type = this.initial_appointment.eventType;
        let period;
        if (event_type === EVENT_TYPE.REGULAR) {
            const time_flags = new TimeFlags(this.appointment);
            period = new RegularEventPeriod(this.appointment, RegularEventPeriodFields, time_flags, this.$form);
            period.set();
        } else if (event_type === EVENT_TYPE.ALL_DAY) {
            period = new BannerEventPeriod(this.appointment, BannerEventPeriodFields, this.$form);
            period.set();
        }
    }

    setNotes() {
        if (!this.appointment.hasOwnProperty("notes")) {
            return;
        }

        const $memo = this.$form.find("textarea[name='memo']");
        if ($memo.length > 0) {
            $memo.val(this.appointment.notes);
        }
    }

    setUseAttendanceCheck() {
        if (!this.appointment.hasOwnProperty("useAttendanceCheck")) {
            return;
        }

        const $use_attendance_check = this.$form.find("input[name='attendance_check']");
        if ($use_attendance_check.length > 0) {
            $use_attendance_check.prop("checked", this.appointment.useAttendanceCheck);
        }
    }

    setVisibilityType() {
        if (!this.appointment.hasOwnProperty("visibilityType")) {
            return;
        }

        const $visibility_type = this.$form.find("input[name='private']");
        const visibility_type = VISIBILITY_TYPE.indexOf(this.appointment.visibilityType);
        if ($visibility_type.length > 0) {
            $visibility_type.filter("input[value=" + visibility_type + "]").prop("checked", true).trigger("click");
        }
    }

    setEventMenu() {
        if (!this.appointment.hasOwnProperty("eventMenu")) {
            return;
        }

        const $items = this.$form.find("ul.js_customization_appointment_type li");
        for (let i = 0; i < $items.length; i++) {
            if ($items[i].getAttribute("te") === this.appointment.eventMenu) {
                $items[i].click();
                return;
            }
        }
    }

    setCompany() {
        if (!this.appointment.hasOwnProperty("companyInfo")) {
            return;
        }

        const company = this.appointment.companyInfo;
        if (company.hasOwnProperty("name")) {
            const $company_name = this.$form.find("input[name='company_name']");
            if ($company_name.length > 0) {
                $company_name.val(company.name);
            }
        }

        if (company.hasOwnProperty("zipCode")) {
            const $zip_code = this.$form.find("input[name='zip_code']");
            if ($zip_code.length > 0) {
                $zip_code.val(company.zipCode);
            }
        }

        if (company.hasOwnProperty("address")) {
            const $physical_address = this.$form.find("input[name='physical_address']");
            if ($physical_address.length > 0) {
                $physical_address.val(company.address);
            }
        }

        if (company.hasOwnProperty("route")) {
            const $route = this.$form.find("input[name='route']");
            if ($route.length > 0) {
                $route.val(company.route);
            }
        }

        if (company.hasOwnProperty("routeTime")) {
            const $route_time = this.$form.find("input[name='route_time']");
            if ($route_time.length > 0) {
                $route_time.val(company.routeTime);
            }
        }

        if (company.hasOwnProperty("routeFare")) {
            const $route_fare = this.$form.find("input[name='route_fare']");
            if ($route_fare.length > 0) {
                $route_fare.val(company.routeFare);
            }
        }

        if (company.hasOwnProperty("phone")) {
            const $company_telephone_number = this.$form.find("input[name='company_telephone_number']");
            if ($company_telephone_number.length > 0) {
                $company_telephone_number.val(company.phone);
            }
        }
    }

    setRepeatInfo() {
        const repeat_info = this.getter.getRepeatInfo();
        if (repeat_info === null) {
            return;
        }

        this.setRepeatCondition(repeat_info);

        const period_fields = RepeatEventPeriodFields;
        if (repeat_info.hasOwnProperty("timeZone")) {
            period_fields.setTimeZones(repeat_info.timeZone, repeat_info.timeZone);
        }

        if (repeat_info.hasOwnProperty("period")) {
            const period = new RepeatEventPeriod(repeat_info.period, period_fields, this.$form);
            period.set();
        }
        if (repeat_info.hasOwnProperty("time")) {
            const time = new RepeatEventTime(repeat_info.time,
                period_fields,
                new RepeatTimeFlags(repeat_info));
            time.set();
        }

        this.setRepeatInfoRange(repeat_info);
    }

    /**
     * Set repeat condition data
     * @param {RepeatInfoObject} repeat_info
     */
    setRepeatCondition(repeat_info) {
        if (!repeat_info.hasOwnProperty("type")) {
            return;
        }
        let $day;
        let $week_day;
        let $week;
        let $month;
        switch (repeat_info.type) {
            case REPEAT_TYPE.EVERY_DAY:
                $day = this.$form.find("input[id='day']");
                if ($day.length > 0) {
                    $day.prop("checked", true).trigger("click");
                }
                break;
            case REPEAT_TYPE.EVERY_WEEKDAY:
                $week_day = this.$form.find("input[id='weekday']");
                if ($week_day.length > 0) {
                    $week_day.prop("checked", true).trigger("click");
                }
                break;
            case REPEAT_TYPE.EVERY_WEEK:
            case REPEAT_TYPE.EVERY_1STWEEK:
            case REPEAT_TYPE.EVERY_2NDWEEK:
            case REPEAT_TYPE.EVERY_3RDWEEK:
            case REPEAT_TYPE.EVERY_4THWEEK:
            case REPEAT_TYPE.EVERY_LASTWEEK:
                $week = this.$form.find("select[name='week']");
                if ($week.length > 0) {
                    $week.val(REPEAT_TYPE_VALUE[repeat_info.type]).trigger("click");
                    if (repeat_info.hasOwnProperty("dayOfWeek")) {
                        const day_of_week = REPEAT_DAY_OF_WEEK.indexOf(repeat_info.dayOfWeek);
                        const $day_of_week = this.$form.find("select[name='wday']");
                        $day_of_week.val(day_of_week).trigger("click");
                    }
                }
                break;
            case REPEAT_TYPE.EVERY_MONTH:
                $month = this.$form.find("input[id='3month']");
                if ($month.length > 0) {
                    $month.prop("checked", true).trigger("click");
                    if (repeat_info.hasOwnProperty("dayOfMonth")) {
                        let day_of_month = repeat_info.dayOfMonth;
                        if (day_of_month === REPEAT_END_OF_MONTH) {
                            day_of_month = 0;
                        }
                        const $day_of_month = this.$form.find("select[name='day']");
                        $day_of_month.val(day_of_month).trigger("click");
                    }
                }
                break;
        }
    }

    /**
     * Set data of repeat info range
     * @param {RepeatInfoObject} repeat_info
     */
    setRepeatInfoRange(repeat_info) {
        if (!repeat_info.hasOwnProperty("range")) {
            return;
        }
        const range = repeat_info.range;
        if (!range.hasOwnProperty("type")) {
            return;
        }
        const type = range.type;
        switch (type) {
            case REPEAT_RANGE.THIS_EVENT_ONLY:
                this.$form.find("input[name='apply']").val(["this"]);
                if (range.hasOwnProperty("date") && range.date) {
                    const parsed_data = parseRFC3339DatePartString(range.date);
                    this.$form.find("select[name='this_year']").val(parsed_data.year);
                    const $month = this.$form.find("select[name='this_month']");
                    $month.val(parsed_data.month);
                    if ($month.length > 0) {
                        $month.find("option[value=" + parsed_data.month + "]").trigger("change");
                    }
                    const $day = this.$form.find("select[name='this_day']");
                    // check if day element is exist & input value must in select box
                    if ($day.length > 0 && $day.find("option[value=" + parsed_data.day + "]").length > 0) {
                        $day.val(parsed_data.day);
                    }
                }
                break;
            case REPEAT_RANGE.ON_AND_AFTER_THIS_EVENT:
                this.$form.find("input[name='apply']").val(["after"]);
                break;
            case REPEAT_RANGE.ALL_EVENT:
                this.$form.find("input[name='apply']").val(["all"]);
                break;
        }
    }

    /**
     * Set member, member candidate, watcher, watcher candidate
     * @param {string} event_member_property event property (members, attendeesCandidate, watchers, watchersCandidate)
     * @param {string} list_name_instance List instance name (sUID, CID, p_sUID, p_CID)
     * @param {string} add_name_instance Add instance name (member_select, private_select)
     * @param {boolean} is_candidate Is candidate or not
     */
    setMembers(event_member_property, list_name_instance, add_name_instance, is_candidate) {
        if (!grn.component.member_add || !this.appointment.hasOwnProperty(event_member_property)) {
            return;
        }
        const member_add_instance = grn.component.member_add.get_instance(add_name_instance);
        if (!member_add_instance) {
            return;
        }
        const member_list_instance = this.getter.getMemberSelectList(list_name_instance);
        member_list_instance.spinnerOn();
        const member_list = {};
        $.each(this.appointment[event_member_property], (key, member) => {
            member_list[key] = member;
        });
        const post_data = {
            app_id: "schedule",
            event_id: this.initial_appointment.id ? this.initial_appointment.id : null,
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
                data: post_data
            });
        ajax_request.send().done((json_data) => {
            if (is_candidate) {
                const id_in_list_page = [];
                $.each(json_data.members_info, (key, member) => {
                    const member_id = MEMBER_TYPE_PREFIX[member.type.toUpperCase()] + member.id;
                    id_in_list_page.push(member_id);
                });
                const is_modified = this.util.isModifyCandidateList(member_add_instance.getMembers(true), id_in_list_page);
                // set label is "(Search Result)" when the list is modified only
                if (is_modified) {
                    const pulldown_menu = grn.component.pulldown_menu.pulldown_menu;
                    const $pulldown = $("#" + list_name_instance + "_pulldown");
                    const is_has_search_result_item = pulldown_menu.isItemHasValue($pulldown, "search");
                    if (!is_has_search_result_item) {
                        pulldown_menu.addItem($pulldown, grn.component.i18n.cbMsg("grn.grn", "GRN_GRN-807"), "search", {
                            select: true
                        });
                    }
                }
            }
            member_list_instance.isCalendar = event_member_property === "attendees" || event_member_property === "attendeesCandidate";
            member_list_instance.addMembers(json_data.members_info);
            // update data after response
            this.appointment[event_member_property] = this.util.formatMembers(json_data.members_info);
            member_list_instance.spinnerOff();
        });
    }

    /**
     * Set facilities, facilities candidate to view & update value after response data from Ajax
     * @param {string} event_facility_property event facility property (facilities, facilitiesCandidate)
     * @param {string} list_name_instance List name instance (sITEM, cITEM)
     * @param {boolean} is_candidate Is candidate or not
     */
    setFacilities(event_facility_property, list_name_instance, is_candidate) {
        if (!grn.component.facility_add || !this.appointment.hasOwnProperty(event_facility_property)) {
            return;
        }
        const facility_list_instance = this.getter.getMemberSelectList(list_name_instance);
        if (!facility_list_instance) {
            return;
        }
        facility_list_instance.spinnerOn();
        const facility_add_instance = grn.component.facility_add.get_instance("facility_select");
        const facilities_code = {};
        $.each(this.appointment[event_facility_property], (key, facility) => {
            facilities_code[key] = facility.code;
        });
        const post_data = {
            facilities_code: JSON.stringify(facilities_code),
            page_name: facility_add_instance.formName,
            event_id: this.initial_appointment.id ? this.initial_appointment.id : null,
            is_candidate: is_candidate
        };
        const ajax_request = new grn.component.ajax.request(
            {
                grnUrl: "grn/ajax/get_facility_by_code",
                method: "post",
                dataType: "json",
                data: post_data
            });
        ajax_request.send().done((facilities) => {
            const formatted_facilities = [];
            const id_in_list_page = [];
            $.each(facilities, (key, data) => {
                formatted_facilities.push({code: data.code, name: data.name});
                id_in_list_page.push("" + data.id);
            });
            if (is_candidate) {
                const is_modified = this.util.isModifyCandidateList(facility_add_instance.getFacilities(true), id_in_list_page);
                if (is_modified) {
                    const search_label = grn.component.i18n.cbMsg("grn.grn", "GRN_GRN-807");
                    GRN_DropdownMenu.getInstance(facility_add_instance.dropdownInstance).prependSearchLabel(search_label);
                }
            }
            this.appointment[event_facility_property] = formatted_facilities;
            facility_list_instance.addFacilities(facilities);
            facility_list_instance.spinnerOff();
            facility_list_instance.updateAncestorsPath();
            facility_add_instance.onOffNetmeetingFacilityItems();
            facility_add_instance.onOffExtendedItems();
            facility_add_instance.onOffUsingPurpose();
        });
    }

    /**
     * set facility using purpose
     */
    setFacilityUsingPurpose() {
        const $purpose = this.$form.find("textarea[name='using_purpose']");
        if ($purpose.length > 0) {
            $purpose.val(this.appointment.facilityUsingPurpose);
        }
    }

    /**
     * set facility reservation info
     */
    setFacilityReservationInfo() {
        if (!this.appointment.hasOwnProperty("facilities") || this.appointment.facilities.length === 0) {
            return;
        }
        $.each(this.appointment.facilityReservationInfo, (item_code, item) => {
            const $item = this.util.findFacilityReservationItemByCode(item_code);
            const item_type = this.util.convertFacilityReservationItem($item.data("type"));
            if (item_type === FACILITY_RESERVATION_TYPE.DROP_DOWN) {
                const $option = $item.find("option");
                $option.each((index, element) => {
                    const value = element.value;
                    if (value === "") {
                        $(element).val("").prop("selected", true);
                    } else if (value === item.value) {
                        $(element).val(item.value).prop("selected", true);
                    }
                });
            } else if ($item !== null
                && (item_type === FACILITY_RESERVATION_TYPE.MULTI_LINE_TEXT
                    || item_type === FACILITY_RESERVATION_TYPE.SINGLE_LINE_TEXT)) {
                $item.val(item.value);
            }
        });
    }

    setCustomItem() {
        if (!this.appointment.hasOwnProperty("additionalItems") || !this.appointment.additionalItems.hasOwnProperty("item")
            || !this.appointment.additionalItems.item.hasOwnProperty("value")) {
            return;
        }

        const $custom_item = this.$form.find("input[name='additional_items']");

        if ($custom_item.length > 0) {
            $custom_item.val(this.appointment.additionalItems.item.value);
        }
    }

    setAll() {
        this.setSubject();
        this.setNotes();
        this.setEventMenu();
        this.setCompany();
        this.setMembers("attendees", "sUID", "member_select", false);
        this.setMembers("attendeesCandidate", "CID", "member_select", true);

        const event_type = this.initial_appointment.eventType;

        if (event_type === EVENT_TYPE.REGULAR || event_type === EVENT_TYPE.ALL_DAY) {
            this.setStartAndEnd();
        }

        if (event_type === EVENT_TYPE.REGULAR) {
            this.setUseAttendanceCheck();
            this.setFacilityUsingPurpose();
        }

        if (event_type === EVENT_TYPE.REPEATING) {
            this.setRepeatInfo();
        }

        if (event_type === EVENT_TYPE.REGULAR || event_type === EVENT_TYPE.REPEATING) {
            this.setVisibilityType();
            if (this.appointment.visibilityType === VISIBILITY_TYPE_PRIVATE_WATCHERS) {
                this.setMembers("watchers", "p_sUID", "private_select", false);
                this.setMembers("watchersCandidate", "p_CID", "private_select", true);
            }
            this.setFacilities("facilities", "sITEM", false);
            this.setFacilities("facilitiesCandidate", "cITEM", true);
            this.setFacilityReservationInfo();
        }

        this.setCustomItem();
    }
}