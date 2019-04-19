import List from "../List";

const $ = jQuery;

export default class MobileList extends List {

    _getTemplates() {
        return {
            default: () =>
                `<div class="mobile_user_list_scroll_grn js_suggest_list" style="display:none">
                    <ul data-role="listview" data-theme="c"
                        class="js_dropdown_list mobile-ul-top-grn mobile-ul-bottom-grn mobile_user_list_grn">
                    </ul>
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

    /**
     * @protected
     */
    _bindEvents() {
        this._elementOn("click", ".js_item", this._handleClickSelectItem.bind(this));
    }

    /**
     * @protected
     */
    _handleClickSelectItem(event) {
        const $selected_item = $(event.target).closest(".js_item");
        this.trigger("selected", $selected_item.data("data"));
    }

    /**
     * @param items
     */
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

        this.show();
    }
}