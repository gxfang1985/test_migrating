import * as input_field_items from "../../component/customization/workflow/input_field/items";
import * as input_field_urgent from "../../component/customization/workflow/input_field/urgent";
import Locale from "../../component/common/locale/Locale";
import * as customization_events from "../../component/customization/events";
import {throwInvalidParameters} from "../../component/customization/error_handler";

const $ = jQuery;

const getSpaceElement = (blank_space_code) => {
    const $blank_space = $("#js_customization_item_" + blank_space_code);
    return $blank_space.length ? $blank_space[0] : null;
};

const get = () => {
    const workflow_data = garoon.workflow.data[garoon.workflow.currentEventName];
    const workflow_request = workflow_data.request;

    if (customization_events.onHandle) {
        throw new Error(Locale.getMessage("grn.workflow", "customization_error_execute_request_get_on_event_handler"));
    }

    if (typeof workflow_request.isUrgent !== "undefined") {
        workflow_request.isUrgent = input_field_urgent.getValue(workflow_request.isUrgent);
    }

    $.each(workflow_request.items, (code, item) => {
        if (item !== null) {
            workflow_request.items[code].value = input_field_items.getValue(code, item);
        }
    });

    const request = $.extend(true, {}, workflow_request);
    return request;
};

const set = (request) => {
    const workflow_data = garoon.workflow.data[garoon.workflow.currentEventName];
    const workflow_request = workflow_data.request;

    if (customization_events.onHandle) {
        throw new Error(Locale.getMessage("grn.workflow", "customization_error_execute_request_set_on_event_handler"));
    }

    if (typeof request === "undefined") {
        throw new Error(Locale.getMessage("grn.workflow", "customization_error_execute_request_set_missing_param"));
    }

    const not_supported_types = ["workflow.request.detail.show", "workflow.request.print.show"];
    if (not_supported_types.indexOf(workflow_data.type) !== -1) {
        return;
    }

    if (typeof request.items === "undefined") {
        throw new Error(Locale.getMessage("grn.workflow", "customization_error_execute_request_set_invalid_request_object"));
    }

    const error_items = [];
    const new_item_values = [];
    $.each(request.items, (code, item) => {
        // Item which does not set its item code
        if (code.indexOf("$") === 0) {
            return;
        }

        if (typeof workflow_request.items[code] === "undefined") {
            error_items.push(`request.items["${code}"]`);
            return;
        }

        const set_validate_result = input_field_items.validateSetValue(code, item, workflow_request.items[code]);
        switch (set_validate_result.status) {
            case "read-only":
                break;
            case "error":
                error_items.push(set_validate_result.value);
                break;
            case "success":
                new_item_values.push({
                    code: code,
                    type: workflow_request.items[code].type,
                    value: set_validate_result.value
                });
                break;
        }
    });

    if (error_items.length > 0) {
        throwInvalidParameters(error_items);
        return;
    }

    new_item_values.forEach((new_item_info) => {
        input_field_items.setValue(new_item_info);
    });

    // recalculate for item Automated calculation
    if (grn.base.isNamespaceDefined("grn.page.workflow.update_automated_calculation")) {
        grn.page.workflow.update_automated_calculation.update_automated_calculation();
    }
};

export default {
    getSpaceElement,
    get,
    set
};