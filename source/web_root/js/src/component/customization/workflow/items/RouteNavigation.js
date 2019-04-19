import ItemBase from "./ItemBase";
import {createValidateSetReturn} from "./utility";

export default class RouteNavigation extends ItemBase {
    /**
     *
     * @returns {*}
     */
    getValue() {
        const $container = this.getElement();
        if ($container === null) {
            return undefined;
        }

        const $route = $container.find("input[name*='route']");
        const $fare = $container.find("input[name*='fare']");
        const value = {};
        if ($route.length) {
            value.route = $route.val();
        }
        if ($fare.length) {
            value.expense = $fare.val();
        }

        return value;
    }

    /**
     *
     * @param value
     */
    setValue(value) {
        const $container = this.getElement();

        if (typeof value.route !== "undefined") {
            $container.find("input[name*='route']").val(value.route);
        }

        if (typeof value.expense !== "undefined") {
            $container.find("input[name*='fare']").val(value.expense);
        }
    }

    /**
     *
     * @param value
     * @returns {{status, value}|*}
     */
    validateSetValue(value) {
        let return_error = createValidateSetReturn("read-only");
        const $container = this.getElement();
        if ($container === null) {
            return return_error;
        }

        const $route = $container.find("input[name*='route']");
        const $fare = $container.find("input[name*='fare']");
        if ($route.length === 0 && $fare.length === 0) {
            return return_error;
        }

        return_error = createValidateSetReturn("error", `request.items["${this.itemCode}"].value`);
        if (($route.length === 0 || $fare.length === 0) && typeof value.route !== "undefined" && typeof value.expense !== "undefined") {
            return return_error;
        }

        const return_value = createValidateSetReturn("success", {});
        if ($route.length > 0) {
            if (typeof value.route === "undefined") {
                return return_error;
            }
            return_value.value.route = value.route;
        }

        if ($fare.length > 0) {
            if (typeof value.expense === "undefined") {
                return return_error;
            }
            return_value.value.expense = value.expense;
        }

        return return_value;
    }
}
