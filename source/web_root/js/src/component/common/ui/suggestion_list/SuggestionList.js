import KeyCode from "../../constant/KeyCode";
import Control from "../base/Control";
import List from "./List";
import ListItem from "./ListItem";
import HttpRequest from "../../ajax/HttpRequest";

const $ = jQuery;

const DEFAULT_SETTINGS = {
    name: "example_name", // The name of the suggestion list (required)
    element: "#example_incremental_search_input", // The element for search input (required)
    source: "example/path/to/search?", // The endpoint of search API (required)
    limit: 20, // The maximum number of items will be displayed
    autoInitSearchInput: true,
    timeDelay: 250, // The delay in milliseconds between when a keystroke occurs and when a search is performed.
    accessPluginEncoded: "",
    listClass: List,
    listItemClass: ListItem,
};

export default class SuggestionList extends Control {
    /**
     * @protected
     */
    _getDefaultSettings() {
        return DEFAULT_SETTINGS;
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
        this.$inputControl.after(this.list.render());
    }

    /**
     * @protected
     */
    _cacheElements() {
        this.$body = $(document.body);
    }

    /**
     * Clear the search input and hide the drop-down list
     */
    clearSearch() {
        this.$inputControl.val("");
        this.lastSearchText = "";
        this.list.hide();
    }

    /**
     * @returns {List}
     * @protected
     */
    _createList() {
        const ListClass = this.settings.listClass;
        return new ListClass({
            name: this.settings.name,
            limit: this.settings.limit,
            listItemClass: this.settings.listItemClass,
        });
    }

    /**
     * @param $search_input
     * @param [options]
     */
    bindToSearchInput($search_input, options = {}) {
        if (typeof $search_input.attr("id") === "undefined") {
            $search_input.attr("id", this.settings.name + "_incremental_search_input");
        }

        const default_options = {
            source: this._handleSearch.bind(this),
            delay: this.settings.timeDelay,
        };

        const autocomplete_options = $.extend(default_options, options);
        $search_input.autocomplete(autocomplete_options);

        $search_input.on("keydown", this._handleKeyDown.bind(this));
        $search_input.on("input", this._handleInput.bind(this));

        this.$inputControl = $search_input;
    }

    /**
     * @protected
     */
    _bindEvents() {
        this.list.on("selected", (event, data) => this.trigger("selected", data));
        this.$body.on("mouseup", this._handleDocumentOnMouseUp.bind(this));
    }

    /**
     * @param {Object} params Returned by jQuery.autocomplete function
     * @returns {*}
     * @protected
     */
    _handleSearch(params) {
        const text = this._filterSearchText(params.term);

        if (!this._canSearch(text)) {
            return;
        }

        if (this._request) {
            this._request.jqXHR.abort();
        }

        this._request = new HttpRequest({
            grnUrl: this.settings.source,
            method: "post",
            data: this._createSearchRequestData(text),
            grnLoadingIndicator: this._loadingIndicator.bind(this),
        });

        return this._request.send()
            .done(this._handleSearchSuccess.bind(this));
    }

    /**
     * @param {string} text
     * @returns {string}
     * @protected
     */
    _filterSearchText(text = "") {
        return text.trim();
    }

    /**
     * @param {string} text
     * @returns {boolean}
     * @protected
     */
    _canSearch(text) {
        if (text === "" || text === this.lastSearchText) {
            return false;
        }

        this.lastSearchText = text;
        return true;
    }

    /**
     * @param {Object} data
     * @protected
     */
    _handleSearchSuccess(data) {
        this.list.clear();
        this.list.hide();

        if (!this._canShowSearchResult(data)) {
            return;
        }

        const list_items = this._transformDataForRenderingItems(data);

        this.list.renderListItems(list_items);
        this.trigger("show");
    }

    /**
     * @param {Object} data
     * @returns {boolean}
     * @protected
     */
    _canShowSearchResult(data) {
        if (this.$inputControl.val().trim() === "" ||
            typeof data !== "object" ||
            Object.keys(data).length < 1) {
            return false;
        }

        if (!this.$inputControl.is(":visible")) {
            return false;
        }

        const is_empty = this._isEmptySearchResult(data);
        return !is_empty;
    }

    /**
     * @param {Object} data
     * @returns {Object}
     * @protected
     */
    _transformDataForRenderingItems(data) {
        return data;
    }

    /**
     * @param text
     * @returns {String}
     * @protected
     */
    _createSearchRequestData(text) {
        return {
            keyword: text,
            access_plugin_encoded: this.settings.accessPluginEncoded,
        };
    }

    /**
     * @param {Object|Array} result
     * @returns {boolean}
     * @protected
     */
    _isEmptySearchResult(result) {
        if (Array.isArray(result)) {
            return result.length === 0;
        }

        return Object.keys(result).length === 0;
    }

    /**
     * Toggle spinner when searching
     * @param {String} option
     * @protected
     */
    _loadingIndicator(option) {
        if (option === "show") {
            this.list.showSpinner();
        } else {
            this.list.hideSpinner();
        }
    }

    /**
     * Clear search when the input is empty
     * @protected
     */
    _handleInput() {
        // Hide the search result drop-down menu if there're only spaces are entered
        if (this.$inputControl.val().trim() === "") {
            this.list.hide();
        }

        // Clear search if there's no character is entered
        if (this.$inputControl.val() === "") {
            this.clearSearch();
        }
    }

    /**
     * @param {Event} event
     * @protected
     */
    _handleKeyDown(event) {
        switch (event.keyCode) {
            case KeyCode.ENTER:
                event.preventDefault();
                this.list.triggerSelectItem();
                this.clearSearch();
                break;
            case KeyCode.DOWN_ARROW:
                this.list.selectNextItem();
                break;
            case KeyCode.UP_ARROW:
                this.list.selectPreviousItem();
                break;
            case KeyCode.ESCAPE:
            case KeyCode.TAB:
            case KeyCode.ALT:
                this.clearSearch();
                break;
        }
    }

    /**
     * Clear search when clicking outside the input control
     * @protected
     */
    _handleDocumentOnMouseUp(event) {
        const target_id = event.target.id;
        if (target_id === this.$inputControl.attr("id")) {
            return;
        }

        if (this._isRightClickOnList(event)) {
            event.stopImmediatePropagation();
        } else {
            setTimeout(this.clearSearch.bind(this), 10);
        }
    }

    /**
     * @param event
     * @returns {boolean}
     * @private
     */
    _isRightClickOnList(event) {
        return this._isRightClick(event) &&
            $(event.target).closest(this.list.getElement().attr("id")).length > 0;
    }

    /**
     * @param event
     * @returns {boolean}
     * @private
     */
    _isRightClick(event) {
        let is_right_click = false;

        if ("which" in event) { // Gecko (Firefox), WebKit (Safari/Chrome) & Opera
            is_right_click = event.which === 3;
        } else if ("button" in event) { // IE, Opera
            is_right_click = event.button === 2;
        }

        return is_right_click;
    }
}
