const $ = jQuery;
/**
 *
 * @param last_value
 * @returns {*}
 */
export const getValue = (last_value) => {
    const $urgent_select = $(".js_customization_input_urgent");
    if ($urgent_select.length) {
        return $urgent_select.val() === "1";
    }
    return last_value;
};
