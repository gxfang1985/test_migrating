import Control from "./Control";
import PageHistory from "./PageHistory";

const $ = jQuery;

/**
 * Base controller for a page
 */
export default class Page extends Control {
    constructor(settings) {
        super(settings);

        this.history = this.settings.useHistory ? this._createHistory() : null;

        this.render();
    }

    _getDefaultSettings() {
        return $.extend(true, {}, super._getDefaultSettings(), {
            element: ".mainarea",
            useHistory: false,
        });
    }

    /**
     * @returns {PageHistory}
     * @protected
     */
    _createHistory() {
        const history = PageHistory.getInstance();

        history.on("load", this._handleHistoryOnLoad.bind(this));
        history.on("change", this._handleHistoryOnChange.bind(this));

        history.start();

        return history;
    }

    /**
     * Override this method to handle the state at the time the page is loading
     *
     * @param {Event} event
     * @param {Object} state The params which are decoded from the current URL
     * @protected
     */
    _handleHistoryOnLoad(event, state) {
    }

    /**
     * Override this method to handle the state at the time user goes back/forward in browser
     *
     * @param {Event} event
     * @param {Object} state The params which are decoded from the current URL
     * @protected
     */
    _handleHistoryOnChange(event, state) {
    }
}