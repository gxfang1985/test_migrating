import Control from "../base/Control";

const $ = jQuery;
const instances = {};
const DEFAULT_SETTINGS = {
    css: {
        dropdown: "js_dropdown",
        head: "js_dropdown_head",
        arrow: "js_dropdown_arrow",
        list: "js_dropdown_list",
        item: "js_dropdown_item",
        arrowDown: "pulldownbutton_arrow_down_grn",
        arrowUp: "pulldownbutton_arrow_up_grn",
        buttonText: "button_text_grn",
    },
    selectors: {
        head: ".js_dropdown_head",
        arrow: ".js_dropdown_arrow",
        item: ".js_dropdown_item",
    },
};

export default class AbstractDropdown extends Control {
    constructor(settings = {}) {
        super(settings);
        if (this.constructor == AbstractDropdown) {
            throw new Error("Abstract classes can't be instantiated");
        }

        instances[this.settings.name] = this;
    }

    static getInstance(name) {
        return instances[name];
    }

    _getDefaultSettings() {
        return $.extend(true, {}, super._getDefaultSettings(), DEFAULT_SETTINGS);
    }

    _getRequiredSettings() {
        return ["name"];
    }

    _getTemplates() {
        const id_prefix = {head: "dropdown_head_", list: "dropdown_list_"};
        return {
            default: () => `<span class="${this.settings.css.dropdown} pulldownbutton_grn"></span>`,
            head: () => {
                throw new Error("This method should be implemented in the derived class")
            },
            headAttributes: () => `id="${id_prefix.head + this.settings.name}"
                                   class="${this.settings.css.head}"
                                   aria-controls="${id_prefix.list + this.settings.name}"
                                   aria-expanded="false"`,
            list: () => `<div id="${id_prefix.list + this.settings.name}" 
                            aria-labelledby="${id_prefix.head + this.settings.name}" 
                            aria-hidden="true" 
                            class="pulldown_menu_grn ${this.settings.css.list}" 
                            style="display: none;">
                        </div>`,
            item: () => {
                throw new Error("This method should be implemented in the derived class")
            },
        };
    }

    _onRender() {
        this.getElement()
            .append(this._renderHead())
            .append(this._renderList())
    }

    _renderHead() {
        return $(this._getTemplates().head());
    }

    _renderList() {
        return $(this._getTemplates().list());
    }

    _renderItems(items) {
        const $item_elements = $(document.createDocumentFragment());
        items.forEach(item =>
            $item_elements.append(this._renderItem(item))
        );

        return $item_elements;
    }

    _renderItem(item) {
        const $item = $(this._getTemplates().item(item));
        $item.data("data", item);
        return $item;
    }

    _cacheElements() {
        this.$head = this._findByClassName(this.settings.css.head);
        this.$list = this._findByClassName(this.settings.css.list);
        this.$arrow = this._findByClassName(this.settings.css.arrow);
    }

    _bindEvents() {
        this._elementOn("click", this.settings.selectors.head, this._handleClickOnHead.bind(this));
        this._elementOn("click", this.settings.selectors.item, this._handleClickOnItem.bind(this));
        $(document).click(this._handleClickOutside.bind(this));
    }

    _handleClickOnHead() {
        if (this.$list.is(":visible")) {
            this._hideList();
        } else {
            this._showList();
        }
    }

    _handleClickOnItem(event) {
        this.selectedValue = $(event.currentTarget).data("data").value;
        this.trigger("select", this.selectedValue);
    }

    _handleClickOutside(event) {
        if (this.$head.is(event.target) || $(event.target).closest(this.settings.selectors.head).is(this.$head)) {
            return;
        }
        this._hideList();
    }

    _showList() {
        this.$list.show().attr("aria-hidden", false);
        this.$head.attr("aria-expanded", true);
        this.$arrow.removeClass(this.settings.css.arrowDown)
            .addClass(this.settings.css.arrowUp);
    }

    _hideList() {
        this.$list.hide()
            .attr("aria-hidden", true);
        this.$head.attr("aria-expanded", false);
        this.$arrow.removeClass(this.settings.css.arrowUp)
            .addClass(this.settings.css.arrowDown);
    }

    getSelectedValue() {
        return this.selectedValue;
    }
}