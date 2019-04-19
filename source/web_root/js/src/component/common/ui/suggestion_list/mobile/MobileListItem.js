import Control from "../../base/Control";

export default class MobileListItem extends Control {
    _getTemplates() {
        return ({name}) => this.html`
            <li class="js_item">
                <a href="javascript:void(0);" class="ui-btn js_item_anchor">
                   <span class="js_label">${name}</span> 
                </a>
            </li>`;
    }
}
