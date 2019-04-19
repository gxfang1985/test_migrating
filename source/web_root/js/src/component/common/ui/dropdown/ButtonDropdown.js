import AbstractDropdown from "./AbstractDropdown";
import {collapseWhiteSpace} from "../../utility/domUtil";

const $ = jQuery;

export default class ButtonDropdown extends AbstractDropdown {
    _getTemplates() {
        const {headAttributes} = super._getTemplates();
        const templates = {
            head: () => collapseWhiteSpace(this.html`
                <button type="button" ${headAttributes()}|noescape>
                    <span class="${this.settings.css.buttonText}">${this.settings.text}</span>
                    <span class="${this.settings.css.arrow} ${this.settings.css.arrowDown}"></span>
                </button>`),
            item: ({text}) => collapseWhiteSpace(this.html`
                <li class="${this.settings.css.item}"><a>${text}</a></li>`
            ),
        };
        return $.extend(true, {}, super._getTemplates(), templates);
    }

    _renderList() {
        const $items = $("<ul></ul>").append(this._renderItems(this.settings.items));
        return super._renderList().append($items);
    }
}