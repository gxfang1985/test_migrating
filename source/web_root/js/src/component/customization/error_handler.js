import Locale from "../common/locale/Locale";
import {throwError} from "./dialog";

export const throwInvalidParameters = (error_items) => {

    const error_causes = error_items.map((error_item) => {
        return Locale.getMessage("grn.customization",
            "customization_invalid_parameter_error_cause")
            .replace("&&parameter&&", "event." + error_item);
    });

    const dialog_error = {
        code: Locale.getMessage("grn.customization", "customization_invalid_parameter_error_code"),
        diagnosis: Locale.getMessage("grn.customization", "customization_invalid_parameter_error_diagnosis"),
        cause: error_causes.join("<br>"),
        counter_measure: Locale.getMessage("grn.customization", "customization_invalid_parameter_error_counter_measure"),
    };
    throwError(dialog_error);
};
