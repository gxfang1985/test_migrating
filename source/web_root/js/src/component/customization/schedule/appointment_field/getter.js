/* global jQuery */
import {isUndefined} from "../../../common/validator/validator";

export default class AppointmentFieldGetter {
    /**
     * @param {EventObject} event_object
     */
    constructor(event_object) {
        this.appointment = event_object;
        this.error_items = [];
    }

    /**
     * get Repeat Info data
     * @returns {RepeatInfoObject|null}
     */
    getRepeatInfo() {
        if (!this.appointment.hasOwnProperty("repeatInfo")) {
            return null;
        }
        if (isUndefined(this.appointment.repeatInfo)) {
            this.error_items.push("repeatInfo");
            return null;
        }
        return this.appointment.repeatInfo;
    }

    /**
     * Get member select list
     * @param {string} list_name_instance list name
     * @returns {grn.component.member_select_list.MemberSelectList}
     */
    getMemberSelectList(list_name_instance) {
        return grn.component.member_select_list.get_instance(list_name_instance);
    }
}