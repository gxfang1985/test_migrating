import Control from "../../../common/ui/base/Control";

export default class ApplicationList extends Control {

    _getDefaultSettings() {
        return {
            element: ".js_notification_application_list",
            css: {
                appItem: "tree_part_item_grn",
                selectedItem: "hilight",
            },
        };
    }

    _bindEvents() {
        this._elementOn("click", "." + this.settings.css.appItem, this._changeApplication.bind(this));
    }

    /**
     * Handle change application event
     * @param event
     * @private
     */
    _changeApplication(event) {
        this.setSelectItem(event.currentTarget.dataset.module_id);
        this.trigger("change", {moduleId: event.currentTarget.dataset.module_id});
    }

    /**
     *
     * @param module_id
     */
    setSelectItem(module_id) {
        const selected_item = this.$el.find(`[data-module_id='${module_id}']`);
        this.$el.find("." + this.settings.css.appItem).removeClass(this.settings.css.selectedItem);
        selected_item.addClass(this.settings.css.selectedItem);
    }
}