/* global jQuery */
import {API_MEMBER_TYPE, FACILITY_RESERVATION_TYPE, MEMBER_TYPE} from "./constant";

const $ = jQuery;

export default class AppointmentFieldUtil {
    /**
     * @param {jQuery} $form_object
     */
    constructor($form_object) {
        this.$form = $form_object;
    }

    /**
     *
     * Get active item by code
     * @param {string} item_code item code
     * @returns {null|Dom} item found
     */
    findFacilityReservationItemByCode(item_code) {
        let $item = null;
        this.$form.find("div#extended_items .js_item").each((index, item) => {
            if (!$(item).is(":disabled")) {
                const code = $(item).data("code").toString();
                if (code === item_code) {
                    $item = $(item);
                }
            }
        });
        return $item;
    }

    /**
     * Check is modify member candidate, watcher candidate, facility  candidate
     * @param {[{id: string, code: string, name: string}]} current_item_list current item list in Dom
     * @param {Array} id_list Input ID list
     * @returns {boolean} true if the candidate list is modified, otherwise reurn false
     */
    isModifyCandidateList(current_item_list, id_list) {
        if (current_item_list.length !== id_list.length) {
            return true;
        }
        let is_modify = false;
        $.each(current_item_list, (index, item) => {
            if ($.inArray(item.id, id_list) === -1) {
                is_modify = true;
            }
        });
        return is_modify;
    }

    /**
     * Check page is loaded
     * @param {EventObject} initial_event_data
     * @returns {boolean}
     */
    isPageLoaded(initial_event_data) {
        let is_loaded = true;
        if (typeof GRN_ScheduleSelectTimezone === "undefined" ||
            (initial_event_data.hasOwnProperty("facilitiesCandidate") && !this.isLoadedFacilityDom("facility_select"))
            || (initial_event_data.hasOwnProperty("attendeesCandidate") && !this.isLoadedMemberDom("member_select"))
            || (initial_event_data.hasOwnProperty("watchersCandidate") && !this.isLoadedMemberDom("private_select"))) {
            is_loaded = false;
        }
        return is_loaded;
    }

    /**
     * Check facility dom is loaded
     * @param {string} add_name_instance
     * @return {boolean}
     */
    isLoadedFacilityDom(add_name_instance) {
        let is_loaded = false;
        if (grn.component.facility_add && grn.component.facility_add.get_instance(add_name_instance)) {
            is_loaded = true;
        }
        return is_loaded;
    }

    /**
     * Check member component is loaded
     * @param {string} add_name_instance
     * @returns {boolean}
     */
    isLoadedMemberDom(add_name_instance) {
        let is_loaded = false;
        if (grn.component.member_add && grn.component.member_add.get_instance(add_name_instance)) {
            is_loaded = true;
        }
        return is_loaded;
    }

    /**
     * @param {Array} members Member list before format
     * @returns {Array}
     */
    formatMembers(members) {
        const data = [];
        $.each(members, (index, member) => {
            let type = API_MEMBER_TYPE.USER;
            if (member.type === MEMBER_TYPE.ORGANIZATION) {
                type = API_MEMBER_TYPE.ORGANIZATION;
            } else if (member.type === MEMBER_TYPE.ROLE) {
                type = API_MEMBER_TYPE.ROLE;
            }
            // If there is an unnecessary prefix in the ID, remove it.
            const member_id = member.id.match(/\d+/);
            data[index] = {"id": member_id[0], "name": member.displayName, "type": type};
            if (member.foreignKey) {
                data[index].code = member.foreignKey;
            }
            if (member.hasOwnProperty("attendanceResponse")) {
                data[index].attendanceResponse = member.attendanceResponse;
            }
        });
        return data;
    }

    /**
     * Convert item type (data server) to JS Data
     * @param item_type
     * @returns {null|string}
     */
    convertFacilityReservationItem(item_type) {
        let new_item_type = null;
        switch (item_type) {
            case "menu":
                new_item_type = FACILITY_RESERVATION_TYPE.DROP_DOWN;
                break;
            case "string":
                new_item_type = FACILITY_RESERVATION_TYPE.SINGLE_LINE_TEXT;
                break;
            case "multiple_string":
                new_item_type = FACILITY_RESERVATION_TYPE.MULTI_LINE_TEXT;
                break;
        }
        return new_item_type;
    }
}