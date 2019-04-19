/* global jQuery */
import Locale from "../../../common/locale/Locale";
import AppointmentFieldValidator from "./validator";
import AppointmentFieldSetter from "./setter";
import AppointmentFieldUtil from "./util";
import EventBuilder from "./EventBuilder";

const $ = jQuery;
const form_selector = ".js_customization_form";
let $form;

let appointment;
let initial_appointment;

let error_items = [];

/**
 * @typedef {Object} DateTimeWithZoneObject
 * @property {string} dateTime
 * @property {string} timeZone
 */

/**
 * @typedef {Object} CompanyObject
 * @property {string} name
 * @property {string} zipCode
 * @property {string} address
 * @property {string} route
 * @property {string} routeTime
 * @property {string} routeFare
 * @property {string} phone
 */

/**
 * @typedef {Object} PeriodObject
 * @property {string} start
 * @property {string} end
 */

/**
 * @typedef {Object} TimeObject
 * @property {string} start
 * @property {string} end
 */

/**
 * @typedef {Object} RepeatInfoRange
 * @property {string} type
 * @property {string} date
 */

/**
 * @typedef {Object} RepeatInfoObject
 * @property {string} type
 * @property {string} dayOfWeek
 * @property {string} dayOfMonth
 * @property {boolean} isAllDay
 * @property {boolean} isStartOnly
 * @property {PeriodObject} period
 * @property {TimeObject} time
 * @property {string} timeZone
 * @property {string} type
 * @property {RepeatInfoRange} range
 */

/**
 * @typedef {Object} FacilityReservationInfoObject
 * @property {string} code
 * @property {string} value
 * @property {string} type
 */

/**
 * @typedef {Object} additionalItemsObject
 * @property {itemObject} item
 */

/**
 * @typedef {Object} itemObject
 * @property {string} value
 */

/**
 * @typedef {Object} EventObject
 * @property {string} subject
 * @property {string} notes
 * @property {DateTimeWithZoneObject} start
 * @property {DateTimeWithZoneObject} end
 * @property {boolean} isAllDay
 * @property {boolean} isStartOnly
 * @property {boolean} useAttendanceCheck
 * @property {string} visibilityType
 * @property {string} eventMenu
 * @property {CompanyObject} companyInfo
 * @property {RepeatInfoObject} repeatInfo
 * @property {Array} facilities
 * @property {Array} facilitiesCandidate
 * @property {string} facilityUsingPurpose
 * @property {FacilityReservationInfoObject} facilityReservationInfo
 * @property {additionalItemsObject} additionalItems
 */

/**
 * @param {EventObject} event_object
 * @param {EventObject} initial_event_data
 */
export const init = (event_object, initial_event_data) => {
    appointment = event_object;
    initial_appointment = initial_event_data;

    $form = $(form_selector);
    error_items = [];
};

/**
 * @returns {boolean}
 */
export const isValidData = () => {
    const appointment_field_util = new AppointmentFieldUtil($form);
    if (!appointment_field_util.isPageLoaded(initial_appointment)) {
        throw new Error(Locale.getMessage("grn.schedule", "customization_error_call_function_when_page_not_ready"));
    }
    const appointment_field_validator = new AppointmentFieldValidator(appointment, initial_appointment, $form);
    appointment_field_validator.validateAll();
    error_items = [...error_items, ...appointment_field_validator.getErrorItems()];
    return error_items.length <= 0;
};

export const setData = () => {
    const appointment_field_setter = new AppointmentFieldSetter(appointment, initial_appointment, $form);
    appointment_field_setter.setAll();
};

/**
 * @returns {string[]}
 */
export const getErrorItems = () => {
    return error_items;
};

/**
 * @param {EventObject} initial_event_data
 * @returns {EventObject}
 */
export const getData = (initial_event_data) => {
    $form = $(form_selector);
    const appointment_field_util = new AppointmentFieldUtil($form);
    if (!appointment_field_util.isPageLoaded(initial_event_data)) {
        return undefined;
    }
    const init_event_data = initial_appointment ? initial_appointment : initial_event_data;
    const event_data = appointment ? appointment : initial_event_data;
    const event_builder = new EventBuilder(init_event_data, event_data, $form);
    event_builder.buildEvent();
    return event_builder.getData();
};

/**
 * @param {Array} members Member list before format
 * @returns {Array}
 */
export const formatMembers = (members) => {
    const appointment_field_util = new AppointmentFieldUtil($form);
    return appointment_field_util.formatMembers(members);
};