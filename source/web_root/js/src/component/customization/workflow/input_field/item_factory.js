import AutoCalculate from "../items/AutoCalculate";
import CheckBox from "../items/CheckBox";
import DateTime from "../items/DateTime";
import DropDown from "../items/DropDown";
import ItemBase from "../items/ItemBase";
import RadioButton from "../items/RadioButton";
import RouteNavigation from "../items/RouteNavigation";

/**
 *
 * @param type
 * @param code
 * @returns {*}
 */
export const createItem = (type, code) => {
    let item;
    switch (type) {
        case "SINGLE_LINE_TEXT":
        case "MULTI_LINE_TEXT":
        case "NUMBER":
            item = new ItemBase(code);
            break;
        case "DROP_DOWN":
            item = new DropDown(code);
            break;
        case "RADIO_BUTTON":
            item = new RadioButton(code);
            break;
        case "CHECK_BOX":
            item = new CheckBox(code);
            break;
        case "DATE":
        case "DATETIME":
            item = new DateTime(code);
            break;
        case "ROUTE_NAVI":
            item = new RouteNavigation(code);
            break;
        case "CALC":
            item = new AutoCalculate(code);
            break;
    }

    return item;
};
