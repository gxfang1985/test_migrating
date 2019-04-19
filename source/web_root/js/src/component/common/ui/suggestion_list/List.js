import Control from "../base/Control";
import ListItem from "./ListItem";

const $ = jQuery;

const DEFAULT_SETTINGS = {
    name: null, // (required)
    limit: 20,
    css: {
        item: "js_item",
        selectedItem: "selected_item",
        dropdownList: "js_dropdown_list",
    },
    listItemClass: ListItem,
};

export default class List extends Control {
    _getRequiredSettings() {
        return ["name"];
    }

    _getDefaultSettings() {
        return DEFAULT_SETTINGS;
    }

    _getTemplates() {
        return {
            default: () =>
                `<div id="${this.settings.name}_incremental_search_dropdown" style="display:none"
                    class='pulldown_menu_grn pulldown_user_incremental_search_grn js_suggest_list'>
                    <ul class='js_dropdown_list'></ul>
                </div>`,
            spinner: () =>
                `<li class='js_spinner'>
                   <a href='javascript:void(0);'>
                       <div class='display_item cloudHeader-grnNotification-update-grn'>
                           <span class='icon-spinner-grn'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        </div>
                   </a>
                </li>`,
        };
    }

    _cacheElements() {
        this.$dropdown = this._findByClassName(this.settings.css.dropdownList);
        this.$spinner = $(this._getTemplates().spinner());
    }

    _bindEvents() {
        this._elementOn("click", "." + this.settings.css.item, this.triggerSelectItem.bind(this));
        this._elementOn("mouseenter mouseleave", "." + this.settings.css.item, this._handleHoverItem.bind(this));
    }

    _createItem() {
        const ListItemClass = this.settings.listItemClass;
        return new ListItemClass();
    }

    renderListItems(items) {
        let count = 0;
        items.forEach(item => {
            if (count === this.settings.limit) {
                return;
            }

            const list_item = this._createItem();
            this.$dropdown.append(list_item.render(item));
            count++;
        });

        this._setFocusToFirstItem();
        this.show();
    }

    selectNextItem() {
        const selected = this._getSelectedItem();
        const next_selected = selected.next();

        if (next_selected.length > 0) {
            selected.removeClass(this.settings.css.selectedItem);
            next_selected.addClass(this.settings.css.selectedItem);
        }
    }

    selectPreviousItem() {
        const selected = this._getSelectedItem();
        const prev_selected = selected.prev();

        if (prev_selected.length > 0) {
            selected.removeClass(this.settings.css.selectedItem);
            prev_selected.addClass(this.settings.css.selectedItem);
        }
    }

    clear() {
        this.$dropdown.empty();
    }

    showSpinner() {
        this.$dropdown.append(this.$spinner);
    }

    hideSpinner() {
        this.$spinner.remove();
    }

    hide() {
        this.$el.hide();
        this.$dropdown.empty();
    }

    triggerSelectItem() {
        if (this._getSelectedItem().length > 0) {
            this.trigger("selected", this._getSelectedItem().data("data"));
        }
    }

    _setFocusToFirstItem() {
        this.$dropdown.find(`.${this.settings.css.item}:first`).addClass(this.settings.css.selectedItem);
    }

    _getSelectedItem() {
        return this._findByClassName(this.settings.css.selectedItem);
    }

    _handleHoverItem(event) {
        this.$dropdown.children().removeClass(this.settings.css.selectedItem);
        $(event.currentTarget).addClass(this.settings.css.selectedItem);
    }
}