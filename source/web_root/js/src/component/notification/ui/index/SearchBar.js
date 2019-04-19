import Control from "../../../common/ui/base/Control";

const $ = jQuery;

export default class SearchBar extends Control {

    _getDefaultSettings() {
        const setting = {
            element: ".js_search_bar",
            css: {
                input: "input[name='module_id']",
                advancedSearch: ".searchboxSub-grn a",
            }
        };
        return $.extend(true, {}, super._getDefaultSettings(), setting);
    }

    _cacheElements() {
        this.$searchInput = this._find(this.settings.css.input);
        this.$searchForm = this._find("form");
        this.$searchAdvanced = this._find(this.settings.css.advancedSearch);
    }

    /**
     * Update the parameter and URL of search bar
     * @public
     */
    updateSearchBar({moduleId, read}) {
        this.$searchInput.val(moduleId);
        let action = "notification/search_pending";
        if (read) {
            action = "notification/search_history";
        }
        const action_url = grn.component.url.page(action);
        const advanced_url = grn.component.url.page(action, {
            module_id: moduleId
        });

        this.$searchForm.prop("action", action_url);
        this.$searchAdvanced.prop("href", advanced_url);

    }
}