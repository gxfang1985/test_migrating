import {isBoolean} from "../../../common/validator/validator";
import {DEFAULT_TIME_FLAG_IS_ALL_DAY, DEFAULT_TIME_FLAG_START_ONLY} from "../appointment_field/constant";

export default class RepeatTimeFlags {
    /**
     * @param {{isStartOnly: !boolean, isAllDay: !boolean}} data
     * @constructor
     */
    constructor(data) {
        this._errors = [];
        this._validateAndStoreData(data);
    }

    /**
     * @param {{isStartOnly: !boolean, isAllDay: !boolean}} data
     * @private
     */
    _validateAndStoreData(data) {
        if (data.hasOwnProperty("isStartOnly") && !isBoolean(data.isStartOnly)) {
            this._errors.push("repeatInfo.isStartOnly");
        }

        if (data.hasOwnProperty("isAllDay") && !isBoolean(data.isAllDay)) {
            this._errors.push("repeatInfo.isAllDay");
        }

        if (this._errors.length !== 0) {
            return;
        }

        this.isStartOnly = data.hasOwnProperty("isStartOnly") ? data.isStartOnly : DEFAULT_TIME_FLAG_START_ONLY;
        this.isAllDay = data.hasOwnProperty("isAllDay") ? data.isAllDay : DEFAULT_TIME_FLAG_IS_ALL_DAY;
        if (this.isStartOnly && this.isAllDay) {
            this._errors.push("repeatInfo.isStartOnly");
            this._errors.push("repeatInfo.isAllDay");
        }
    }

    /**
     * @returns {Array.<string>}
     */
    getErrors() {
        return this._errors;
    }
}