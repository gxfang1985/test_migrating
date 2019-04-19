import Control from "../base/Control";

export default class ListItem extends Control {
    _getTemplates() {
        return ({name}) => this.html`
            <li class="js_item">
                <a class="js_item_anchor" href="javascript:void(0);" >
                    <span class="js_label">${name}</span> 
                </a> 
            </li>`;
    }
}
