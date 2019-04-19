import Control from "../base/Control";
import {collapseWhiteSpace} from "../../utility/domUtil";

export default class PaginationItemRange extends Control {
    _getTemplates() {
        return ({startNumber = 0, endNumber = 0} = {}) => collapseWhiteSpace(this.html`
            <span class="sub_title numberList vAlignMiddle-grn mLeft10">
                <span class="start_num">${startNumber}</span>-<span class="end_num">${endNumber}</span>
            </span>`);
    }
}
