import ButtonGroup from "../ButtonGroup";
import {collapseWhiteSpace} from "../../../utility/domUtil";

export default class MobileButtonGroup extends ButtonGroup {

    _getDefaultSettings() {
        return {
            css: {
                button: "js_button",
                label: "js_label",
                active: "mobile_button_group_item_select_grn",
                bold: "mobile_bold_grn",
                normal: "font_normal_grn",
            }
        };
    }

    _getTemplates() {
        const css = this.settings.css;
        return {
            default: () => `<ul class="mobile_button_group_ul_grn"></ul>`,
            item: ({text, isActive}) => collapseWhiteSpace(this.html`
                <li class="mobile_button_group_li_grn">
                    <button type="button"
                        class="js_button mobile_button_group_item_grn mobile_button_style_off_grn ${isActive ? css.active : ""}"
                        aria-pressed="${isActive ? "true" : "false"}">
                        <span class="js_label">${text}</span>
                    </button>
                </li>`)
        };
    }
}