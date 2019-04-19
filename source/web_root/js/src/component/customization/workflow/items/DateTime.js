import ItemBase from "./ItemBase";
import {createValidateSetReturn, existsSelectOption} from "./utility";

const MAX_YEAR_OPTION_VALUE = 2037;
const MIN_YEAR_OPTION_VALUE = 1970;
export default class DateTime extends ItemBase {
    /**
     *
     * @returns {*}
     */
    getSelectElement() {
        const $container = this.getElement();
        if ($container === null) {
            return null;
        }

        const $year = $container.find("select[id*='year']");
        if ($year.length === 0) {
            return null;
        }

        const $month = $container.find("select[id*='month']");
        const $day = $container.find("select[id*='day']");

        const $hour = $container.find("select[id*='hour']");
        if ($hour.length === 0) {
            return {$year: $year, $month: $month, $day: $day, type: "DATE"};
        }

        const $minute = $container.find("select[id*='minute']");
        return {$year: $year, $month: $month, $day: $day, $hour: $hour, $minute: $minute, type: "DATETIME"};
    }

    /**
     *
     * @returns {{date, time}|*}
     */
    getValue() {
        const select_el = this.getSelectElement();
        if (select_el === null) {
            return undefined;
        }

        const month = select_el.$month.val();
        const day = select_el.$day.val();
        const year = select_el.$year.val();

        if (select_el.type === "DATE") {
            return createDatetime(year, month, day);
        }

        const hour = select_el.$hour.val();
        const minute = select_el.$minute.val();
        return createDatetime(year, month, day, hour, minute);
    }

    /**
     *
     * @param value
     */
    setValue(value) {
        const select_el = this.getSelectElement();

        if (!existsSelectOption(select_el.$year[0], value.year)) {
            select_el.$year.append(`<option value="${value.year}">${value.year}</option>`);
        }

        select_el.$year.val(value.year).trigger("change");
        select_el.$month.val(value.month).trigger("change");
        select_el.$day.val(value.day);

        if (select_el.type === "DATETIME") {
            select_el.$hour.val(value.hour);
            select_el.$minute.val(value.minute);
        }
    }

    /**
     *
     * @param value
     * @returns {{status, value}|*}
     */
    validateSetValue(value) {
        let return_error = createValidateSetReturn("read-only");
        const select_el = this.getSelectElement();
        if (select_el === null) {
            return return_error;
        }

        return_error = createValidateSetReturn("error", `request.items["${this.itemCode}"].value`);
        let full_date_value = "";
        let time_value = "";
        const return_value = {year: "", month: "", day: ""};

        if (select_el.type === "DATE") {
            if (typeof value !== "string") {
                return return_error;
            }
            full_date_value = value === "--" ? "" : value;
        } else {
            if (typeof value === "string" && value !== "") {
                return return_error;
            }

            const value_obj_prop = Object.keys(value);
            if (!value_obj_prop.some(
                key => ["date", "time"].indexOf(key) !== -1)
            ) {
                return return_error;
            }

            if (typeof value.date !== "undefined" && value.date !== null) {
                full_date_value = value.date === "--" ? "" : value.date;
            }
            if (typeof value.time !== "undefined" && value.time !== null) {
                time_value = value.time === ":" ? "" : value.time;
            }
        }

        if (full_date_value !== "") {
            const full_date = this._parseDate((full_date_value));
            if (!full_date) {
                return return_error;
            }

            return_value.year = full_date.year;
            return_value.month = full_date.month;
            return_value.day = full_date.date;

        }

        if (select_el.type === "DATE") {
            return createValidateSetReturn("success", return_value);
        }

        return_value.hour = "";
        return_value.minute = "";
        if (time_value !== "") {
            const time = this._parseTime(time_value, select_el);
            if (!time) {
                return return_error;
            }

            return_value.hour = time.hour;
            return_value.minute = time.minute;
        }

        return createValidateSetReturn("success", return_value);
    }

    /**
     * @private
     * @param full_date_value
     * @returns {*}
     */
    _parseDate(full_date_value) {
        const full_date_reg = full_date_value.match(/^(\d{4})-(\d|\d{2})-(\d|\d{2})$/);
        if (full_date_reg === null) {
            return false;
        }
        const year = parseInt(full_date_reg[1], 10);
        const month = parseInt(full_date_reg[2], 10);
        const date = parseInt(full_date_reg[3], 10);

        const valid_date_obj = new Date(year, month - 1, date);
        const not_valid_year = (year !== valid_date_obj.getFullYear())
            || (MIN_YEAR_OPTION_VALUE > year
                || MAX_YEAR_OPTION_VALUE < year);

        const not_valid_month = month !== 1 + valid_date_obj.getMonth();
        const not_valid_date = date !== valid_date_obj.getDate();
        if (not_valid_year || not_valid_month || not_valid_date) {
            return false;
        }
        return {year, month, date};
    }

    /**
     * @private
     * @param time_value
     * @param select_el
     * @returns {*}
     */
    _parseTime(time_value, select_el) {
        const time_reg = time_value.match(/^(\d{0,2}):(\d{0,2})$/);

        if (time_reg === null) {
            return false;
        }

        const hour = time_reg[1] === "" ? "" : parseInt(time_reg[1], 10);
        if (!existsSelectOption(select_el.$hour[0], hour)) {
            return false;
        }

        const minute = time_reg[2] === "" ? "" : parseInt(time_reg[2], 10);
        if (!existsSelectOption(select_el.$minute[0], minute)) {
            return false;
        }

        return {hour, minute};
    }
}

/**
 *
 * @param year
 * @param month
 * @param day
 * @param hour
 * @param minute
 * @returns {*}
 */
function createDatetime(year, month, day, hour, minute) {
    const year_value = year ? ("000" + year).slice(-4) : "";
    const month_value = month ? ("0" + month).slice(-2) : "";
    const day_value = day ? ("0" + day).slice(-2) : "";

    const date_string = year_value + "-" + month_value + "-" + day_value;
    if (arguments.length === 3) {
        return date_string;
    }

    const hour_value = hour ? ("0" + hour).slice(-2) : "";
    const minute_value = minute ? ("0" + minute).slice(-2) : "";
    const time_string = hour_value + ":" + minute_value;
    return {date: date_string, time: time_string};
}
