const UrlComponent = grn.component.url;
const $ = jQuery;

let instance;

export default class PageHistory {
    constructor() {
        if (instance) {
            throw new Error("PageHistory is not allowed to create multiple instances.");
        }

        this._events = $({});
        this._state = {};
    }

    /**
     * @return {PageHistory}
     */
    static getInstance() {
        if (instance) {
            return instance;
        }

        instance = new PageHistory();

        return instance;
    }

    /**
     * Start listening change of the browser URL
     */
    start() {
        this._parseParamsFromUrl();
        this._events.trigger("load", this.get());

        window.addEventListener("popstate", this._handlePopState.bind(this));
    }

    /**
     * Register an event listener.
     * Available events:
     *  - load: triggered at the first time the state is parsed from the URL params
     *  - change: triggered when user goes back/forward in browser
     * @param args
     */
    on(...args) {
        this._events.on(...args);
    }

    /**
     * Return the current state
     * @return {Object}
     */
    get() {
        return jQuery.extend({}, this._state);
    }

    /**
     * Push the new state to browser history.
     * The state will be reflected to the URL params in the browser.
     * @param {Object} state
     */
    pushState(state = {}) {
        this._state = state;
        this._pushToHistory();
    }

    /**
     * Parse params from URL query string and from URL fragment
     * @private
     */
    _parseParamsFromUrl() {
        this._path = location.pathname;
        const full_path = UrlComponent.parse(location.href);
        this._state = $.extend(
            UrlComponent.parseQueryString(full_path.search),
            UrlComponent.parseHash(location.href) || {},
        );
    }

    /**
     * Serialize the current state to URL params then push to the browser history
     * @private
     */
    _pushToHistory() {
        const url = UrlComponent.setParameters(this._path, this._state, "");
        history.pushState("", "", url);
    }

    /**
     * @private
     */
    _handlePopState() {
        this._parseParamsFromUrl();
        this._events.trigger("change", this.get());
    }
}
