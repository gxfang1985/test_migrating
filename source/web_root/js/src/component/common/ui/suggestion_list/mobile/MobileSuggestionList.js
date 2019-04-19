import SuggestionList from "../SuggestionList";
import MobileList from "./MobileList";
import KeyCode from "../../../constant/KeyCode";

const $ = jQuery;

export default class MobileSuggestionList extends SuggestionList {
    /**
     * @protected
     */
    _getDefaultSettings() {
        return $.extend(super._getDefaultSettings(), {
            listClass: MobileList,
        });
    }

    /**
     * @protected
     */
    _onRender() {
        // search input control
        this.$inputControl = $(this.settings.element);

        if (this.settings.autoInitSearchInput) {
            this.bindToSearchInput(this.$inputControl);
        }

        // result list
        this.list = this._createList();
        this.$searchResultArea = $(this.settings.searchResultArea);
        this.$searchResultArea.append(this.list.render());
    }

    /**
     * @protected
     */
    _bindEvents() {
        this.list.on("selected", this._handleListSelected.bind(this));
    }

    _handleListSelected(event, data) {
        this.trigger("selected", data);
        this.clearSearch();
    }

    /**
     * @protected
     */
    _handleKeyDown() {
        switch (event.keyCode) {
            case KeyCode.ENTER:
                event.preventDefault();
        }
    }
}

