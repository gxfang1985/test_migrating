/* global jQuery */
/* global GRN_TimezoneInfo */
import {isObject, isBoolean, isUndefined} from "../../../common/validator/validator";
import {parseRFC3339DatePartString} from "../../datetime";
import AppointmentFieldGetter from "./getter";
import AppointmentFieldUtil from "./util";
import {
    COMPANY_FIELDS, DEFAULT_EVENT_MENU, EVENT_TYPE, REPEAT_TYPE, REPEAT_WEEK_TYPES, REPEAT_DAY_OF_WEEK,
    REPEAT_END_OF_MONTH, REPEAT_DAY_1, REPEAT_DAY_31, VISIBILITY_TYPE,
    FACILITY_RESERVATION_TYPE, DEFAULT_FACILITY_RESERVATION_DROP_DOWN, API_MEMBER_TYPE, REPEAT_RANGE,
    VISIBILITY_TYPE_PRIVATE_WATCHERS
} from "./constant";
import {RegularEventPeriodFields} from "../datetime_fields/RegularEventPeriodFields";
import {BannerEventPeriodFields} from "../datetime_fields/BannerEventPeriodFields";
import {RepeatEventPeriodFields} from "../datetime_fields/RepeatEventPeriodFields";
import TimeFlags from "../datetime_properties/TimeFlags";
import RegularEventPeriod from "../datetime_properties/RegularEventPeriod";
import BannerEventPeriod from "../datetime_properties/BannerEventPeriod";
import RepeatTimeFlags from "../datetime_properties/RepeatTimeFlags";
import RepeatEventPeriod from "../datetime_properties/RepeatEventPeriod";
import RepeatEventTime from "../datetime_properties/RepeatEventTime";

const $ = jQuery;

export default class AppointmentFieldValidator {
    /**
     * @param {EventObject} event_object
     * @param {EventObject} initial_event_data
     * @param {jQuery} $form_object
     */
    constructor(event_object, initial_event_data, $form_object) {
        this.appointment = event_object;
        this.initial_appointment = initial_event_data;
        this.$form = $form_object;
        this.error_items = [];
        this.getter = new AppointmentFieldGetter(event_object);
        this.util = new AppointmentFieldUtil($form_object);
    }

    validateSubjectData() {
        this.validateStringProperty(this.appointment, ["subject"], "");
    }

    validateStartAndEnd() {
        const event_type = this.initial_appointment.eventType;
        let period;
        let time_flags;
        if (event_type === EVENT_TYPE.REGULAR) {
            time_flags = new TimeFlags(this.appointment);
            if (time_flags.getErrors().length !== 0) {
                this.error_items = this.error_items.concat(time_flags.getErrors());
                return;
            }

            period = new RegularEventPeriod(this.appointment, RegularEventPeriodFields, time_flags, this.$form);
            if (period.getErrors().length !== 0) {
                this.error_items = this.error_items.concat(period.getErrors());
            }
        } else if (event_type === EVENT_TYPE.ALL_DAY) {
            period = new BannerEventPeriod(this.appointment, BannerEventPeriodFields, this.$form);
            if (period.getErrors().length !== 0) {
                this.error_items = this.error_items.concat(period.getErrors());
            }
        }
    }

    validateNotesData() {
        this.validateStringProperty(this.appointment, ["notes"], "");
    }

    validateUseAttendanceCheckData() {
        if (this.appointment.hasOwnProperty("useAttendanceCheck") && !isBoolean(this.appointment.useAttendanceCheck)) {
            this.error_items.push("useAttendanceCheck");
        }
    }

    validateVisibilityTypeData() {
        if (!this.appointment.hasOwnProperty("visibilityType")) {
            return;
        }
        if (VISIBILITY_TYPE.indexOf(this.appointment.visibilityType) === -1) {
            this.error_items.push("visibilityType");
        }
    }

    validateEventMenuData() {
        if (!this.appointment.hasOwnProperty("eventMenu")) {
            return;
        }

        if (this.appointment.eventMenu === DEFAULT_EVENT_MENU) {
            this.error_items.push("eventMenu");
            return;
        }

        if (this.appointment.eventMenu === "") {
            this.appointment.eventMenu = DEFAULT_EVENT_MENU;
        }

        const available_event_menu_values = [];
        this.$form.find("ul.js_customization_appointment_type li").each((index, element) => {
            const val = $(element).attr("te");
            available_event_menu_values.push(val);
        });
        if (available_event_menu_values.indexOf(this.appointment.eventMenu) === -1) {
            this.error_items.push("eventMenu");
        }
    }

    validateCompanyData() {
        if (!this.appointment.hasOwnProperty("companyInfo")) {
            return;
        }

        if (isUndefined(this.appointment.companyInfo)) {
            this.error_items.push("companyInfo");
            return;
        }

        this.validateStringProperty(this.appointment.companyInfo, COMPANY_FIELDS, "companyInfo.");
    }

    validateRepeatInfoData() {
        const repeat_info = this.getter.getRepeatInfo();
        if (repeat_info === null) {
            return;
        }

        const time_flags = new RepeatTimeFlags(repeat_info);
        if (time_flags.getErrors().length !== 0) {
            this.error_items = this.error_items.concat(time_flags.getErrors());
            return;
        }

        if (repeat_info.hasOwnProperty("period")) {
            const period = new RepeatEventPeriod(repeat_info.period, RepeatEventPeriodFields, this.$form);
            if (period.getErrors().length !== 0) {
                this.error_items = this.error_items.concat(period.getErrors());
            }
        }

        if (repeat_info.hasOwnProperty("time")) {
            const time = new RepeatEventTime(repeat_info.time, RepeatEventPeriodFields, time_flags);
            if (time.getErrors().length !== 0) {
                this.error_items = this.error_items.concat(time.getErrors());
            }
        }

        this.validateRepeatConditionData(repeat_info);

        if (repeat_info.hasOwnProperty("timeZone")) {
            if (!GRN_TimezoneInfo[repeat_info.timeZone]) {
                this.error_items.push("repeatInfo.timeZone");
            }
        }
        this.validateRepeatInfoRangeData(repeat_info);
    }

    /**
     * Validate repeat condition data
     * @param {RepeatInfoObject} repeat_info
     */
    validateRepeatConditionData(repeat_info) {
        if (!repeat_info.hasOwnProperty("type")) {
            return;
        }

        const repeat_types = $.map(REPEAT_TYPE, (type) => {
            return type;
        });
        if (repeat_types.indexOf(repeat_info.type) === -1) {
            this.error_items.push("repeatInfo.type");
            return;
        }
        if (REPEAT_WEEK_TYPES.indexOf(repeat_info.type) !== -1
            && repeat_info.hasOwnProperty("dayOfWeek")
            && REPEAT_DAY_OF_WEEK.indexOf(repeat_info.dayOfWeek) === -1) {
            this.error_items.push("repeatInfo.dayOfWeek");
            return;
        }

        if (repeat_info.type === REPEAT_TYPE.EVERY_MONTH && repeat_info.hasOwnProperty("dayOfMonth")) {
            const day_of_month = parseInt(repeat_info.dayOfMonth, 10);
            let is_valid_day = false;
            if (repeat_info.dayOfMonth === REPEAT_END_OF_MONTH) {
                is_valid_day = true;
            } else if (day_of_month >= REPEAT_DAY_1 && day_of_month <= REPEAT_DAY_31) {
                is_valid_day = true;
            }
            if (!is_valid_day) {
                this.error_items.push("repeatInfo.dayOfMonth");
            }
        }
    }

    /**
     * validation facility using purpose data
     * @returns {boolean}
     */
    validateFacilityUsingPurposeData() {
        return !this.appointment.hasOwnProperty("facilityUsingPurpose");
    }

    /**
     * Validate facility reservation data
     */
    validateFacilityReservationData() {
        if (!this.appointment.hasOwnProperty("facilityReservationInfo")) {
            return;
        }
        $.each(this.appointment.facilityReservationInfo, (item_code, item) => {
            const error_path = "facilityReservationInfo['" + item_code + "']";
            const $item = this.util.findFacilityReservationItemByCode(item_code);
            if (!item || !item.hasOwnProperty("value") || !$item) {
                this.error_items.push(error_path);
                return;
            }
            const item_type = this.util.convertFacilityReservationItem($item.data("type"));
            if (item_type === FACILITY_RESERVATION_TYPE.DROP_DOWN) {
                if (item.value === DEFAULT_FACILITY_RESERVATION_DROP_DOWN) {
                    this.error_items.push(error_path);
                    return;
                }
                const available_item_values = [];
                if ($item !== null) {
                    $item.find("option").each((index, element) => {
                        available_item_values.push(element.value);
                    });
                }
                if (available_item_values.indexOf(item.value) === -1) {
                    this.error_items.push(error_path);
                }
            }
        });
    }

    /**
     * Validate member data
     * @param {string} event_member_property event member property ( attendees, attendeesCandidate, watchers, watchersCandidate)
     */
    validateMembersData(event_member_property) {
        if (!this.appointment.hasOwnProperty(event_member_property)) {
            return;
        }
        const allowed_types = [API_MEMBER_TYPE.USER, API_MEMBER_TYPE.ORGANIZATION];
        if (event_member_property === "watchers" || event_member_property === "watchersCandidate") {
            allowed_types.push(API_MEMBER_TYPE.ROLE);
        }
        $.each(this.appointment[event_member_property], (member) => {
            if (member.hasOwnProperty("type") && allowed_types.indexOf(member.type) === -1) {
                this.error_items.push(event_member_property + ".type");
            }
        });
    }

    /**
     * Validate repeat info range data
     * @param {RepeatInfoObject} repeat_info
     */
    validateRepeatInfoRangeData(repeat_info) {
        if (!repeat_info.hasOwnProperty("range")) {
            return;
        }
        const range = repeat_info.range;
        if (!range.hasOwnProperty("type") || !range.type) {
            return;
        }
        const type = range.type;
        if (type !== REPEAT_RANGE.THIS_EVENT_ONLY
            && type !== REPEAT_RANGE.ON_AND_AFTER_THIS_EVENT
            && type !== REPEAT_RANGE.ALL_EVENT) {
            this.error_items.push("repeatInfo.range.type");
        }

        if (type === REPEAT_RANGE.THIS_EVENT_ONLY && range.hasOwnProperty("date") && range.date) {
            const parsed_data = parseRFC3339DatePartString(range.date);
            if (parsed_data === null || !RepeatEventPeriodFields.isValidYear(parsed_data.year)) {
                this.error_items.push("repeatInfo.range.date");
            }
        }
    }

    validateCustomItemData() {
        if (!this.appointment.hasOwnProperty("additionalItems")) {
            return;
        }

        const additional = this.appointment.additionalItems;
        if (!isObject(additional) || additional === null || !additional.hasOwnProperty("item") || Object.keys(additional).length > 1) {
            delete this.appointment.additionalItems;
            return;
        }

        const item = additional.item;
        if (!isObject(item) || item === null || !item.hasOwnProperty("value") || Object.keys(item).length > 1) {
            delete this.appointment.additionalItems;
            return;
        }

        if (isUndefined(item.value)) {
            this.error_items.push("additionalItems.item.value");
        }
    }

    /**
     * @param {Object} target
     * @param {string[]} property_keys
     * @param {string} error_prefix
     */
    validateStringProperty(target, property_keys, error_prefix) {
        property_keys.forEach((property_key) => {
            if (target.hasOwnProperty(property_key) && isUndefined(target[property_key])) {
                this.error_items.push(error_prefix + property_key);
            }
        });
    }

    validateAll() {
        this.validateSubjectData();
        this.validateNotesData();
        this.validateEventMenuData();
        this.validateCompanyData();
        this.validateMembersData("attendees");
        this.validateMembersData("attendeesCandidate");

        const event_type = this.initial_appointment.eventType;

        if (event_type === EVENT_TYPE.REGULAR || event_type === EVENT_TYPE.ALL_DAY) {
            this.validateStartAndEnd();
        }

        if (event_type === EVENT_TYPE.REGULAR) {
            this.validateUseAttendanceCheckData();
            this.validateFacilityUsingPurposeData();
        }

        if (event_type === EVENT_TYPE.REPEATING) {
            this.validateRepeatInfoData();
        }

        if (event_type === EVENT_TYPE.REGULAR || event_type === EVENT_TYPE.REPEATING) {
            this.validateVisibilityTypeData();
            if (this.appointment.visibilityType === VISIBILITY_TYPE_PRIVATE_WATCHERS) {
                this.validateMembersData("watchers");
                this.validateMembersData("watchersCandidate");
            }
            this.validateFacilityReservationData();
        }

        this.validateCustomItemData();
    }

    /**
     * @returns {string[]}
     */
    getErrorItems() {
        return this.error_items;
    }
}