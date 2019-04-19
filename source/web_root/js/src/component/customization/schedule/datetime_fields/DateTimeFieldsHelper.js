/**
 *
 * Trigger change month and day
 * 1. Trigger change month for reget day list on select box
 * 2. Because after trigger, the day will reset => set day again
 * @param {int} month month of date
 * @param {int} day day of date
 * @param {string} property property name (start, end)
 * @param {jQuery} $form Form object
 */
export const triggerSetMonthAndDay = (month, day, property, $form) => {
    const $month = $form.find("select[name=" + property + "_month]");
    if ($month.length > 0) {
        $month.find("option[value=" + month + "]").trigger("change");
    }
    const $day = $form.find("select[name=" + property + "_day]");
    // If the day element exists & input value must in select box
    if ($day.length > 0 && $day.find("option[value=" + day + "]").length > 0) {
        $day.val(day);
    }
};