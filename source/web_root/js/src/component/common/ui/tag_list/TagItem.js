import Control from "../base/Control";
import {collapseWhiteSpace} from "../../utility/domUtil";
import Locale from "../../locale/Locale";

export default class TagItem extends Control {
    _getTemplates() {
        const delete_button_title = Locale.getMessage("grn", "grn.ui.tag_item.delete_button_title");
        return (data) => collapseWhiteSpace(this.html`
            <li class="bit-box js_tag_item" style="position:relative; opacity:1; z-index:0; left:0px; top:-1px;">
                <a class="js_label_a" href="javascript:void(0)">
                    <span class="js_label">${data.name}</span>
                </a>
                <a role="button" class="closebutton js_tag_item_close_button" href="javascript:void(0)"
                    title="${delete_button_title}"
                    aria-label="${delete_button_title}"></a>
            </li>`);
    }
}