import Control from "../base/Control";
import {collapseWhiteSpace} from "../../utility/domUtil";

const $ = jQuery;

export default class ButtonGroup extends Control {

    _getDefaultSettings() {
        return {
            css: {
                button: "js_button",
                label: "js_label",
                active: "button_group_item_select_grn",
                bold: "bold_grn",
                normal: "font_normal_grn",
            }
        };
    }

    _getTemplates() {
        const css = this.settings.css;
        return {
            default: () => `<ul class="button_group_ul_grn"></ul>`,
            item: ({text, isActive}) => collapseWhiteSpace(this.html`
                <li class="button_group_li_grn">
                    <button type="button"
                        class="js_button button_group_item_grn button_style_off_grn ${isActive ? css.active : ""}"
                        aria-pressed="${isActive ? "true" : "false"}">
                        <span class="js_label">${text}</span>
                    </button>
                </li>`)
        };
    }

    _onRender(items) {
        this._renderItems(items);
    }

    _bindEvents() {
        this._elementOn("click", "." + this.settings.css.button, this._handleClick.bind(this));
    }

    _renderItems(items) {
        items.forEach(item => {
            const $item = this._renderItem(item);
            this.getElement().append($item);
        });
    }

    _renderItem(item) {
        const html = this._getTemplates().item(item);
        const $item = $(collapseWhiteSpace(html));
        $item.find("." + this.settings.css.button).data("data", item);
        return $item;
    }

    _handleClick(event) {
        const $selected_item = $(event.currentTarget);
        this._resetSelection();
        this._selectElement($selected_item);
    }

    _resetSelection() {
        this._getSelectedItem().removeClass(this.settings.css.active).attr("aria-pressed", "false");
    }

    _getSelectedItem() {
        return this._findByClassName(this.settings.css.active);
    }

    _selectElement($item) {
        $item.addClass(this.settings.css.active).attr("aria-press", "true");
        this.trigger("click", this.getSelectedValue());
    }

    getSelectedValue() {
        return this._getSelectedItem().data("data").value;
    }

    _findByValue(value) {
        let $item = null;
        $.each(this._findByClassName(this.settings.css.button), (index, element) => {
            if ($(element).data("data").value === value) {
                $item = $(element);
                return false;
            }
        });
        return $item;
    }

    setActive(value) {
        $.each(this._findByClassName(this.settings.css.button), (index, element) => {
            if ($(element).data("data").value === value) {
                $(element).addClass(this.settings.css.active);
            } else {
                $(element).removeClass(this.settings.css.active);
            }
        });
    }

    setBold(value, is_bold) {
        const $button = this._findByValue(value);
        if ($button) {
            if (is_bold) {
                $button.find("." + this.settings.css.label).addClass(this.settings.css.bold);
                $button.removeClass(this.settings.css.normal);
            } else {
                $button.find("." + this.settings.css.label).removeClass(this.settings.css.bold);
                $button.addClass(this.settings.css.normal);
            }
        }
    }

    setLabel(value, label) {
        const $button = this._findByValue(value);
        if ($button) {
            $button.find("." + this.settings.css.label).html(label);
        }
    }
}
