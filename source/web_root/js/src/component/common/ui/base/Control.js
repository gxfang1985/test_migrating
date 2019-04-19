import html from "../../template_string/html";

const $ = jQuery;

/**
 * Default settings of a Control
 * @see {Control}
 */
const DEFAULT_SETTINGS = {
    element: null,
    data: {},
    css: {},
};

/**
 * Base class for a UI component
 */
export default class Control {
    /**
     * Constructor
     *
     * @param {Object} settings Setting of the component.
     *
     * @param {string|HTMLElement} [settings.element] The CSS selector or the DOM element which is the root element of the control.
     *
     *      By default the root element will be automatically created at client side when you call the render() method.
     *      In case of the root element of the component is rendered at server side, you need to set
     *      the "element" property to ignore creating the element at client side.
     *
     * @param {*} [settings.data] The data object which is used for rendering the content of the control.
     *
     * @param {Object|null} [settings.css] The object declares the CSS for DOM manipulation. For example:
     *      css: {
     *          item: "js_item",
     *          selectedItem: "selected"
     *      }
     */
    constructor(settings = {}) {
        this._checkRequiredSettings(settings);
        this._createSettings(settings);
        this._setElementFromSetting(this.settings);
        this._bindJQueryMethods();
        this._createTemplates();
        this._customEvents = $({});
        this.html = html;
    }

    /**
     * Returns the root element of the control
     * @returns {*}
     */
    getElement() {
        return this.$el;
    }

    /**
     * Add an event listener to the control
     * @param args
     */
    on(...args) {
        this._customEvents.on(...args);
    }

    /**
     * Trigger an event of the control
     * @param args
     */
    trigger(...args) {
        this._customEvents.trigger(...args);
    }

    /**
     * Renders the content and adds event listeners
     * @param data
     * @returns {jQuery} HTML Element
     */
    render(data = this.settings.data) {
        if (!this.settings.element) {
            this._createElement(data);
        }

        this._onRender(data);
        this._cacheElements();
        this._bindEvents();

        return this.$el;
    }

    /**
     * Returns the default settings of the control
     * @returns {Object}
     * @protected
     */
    _getDefaultSettings() {
        return DEFAULT_SETTINGS;
    }

    /**
     * Extends the default settings with the settings specified at the time the control is instantiated
     * @param {Object} settings
     * @protected
     */
    _createSettings(settings) {
        this.settings = $.extend(true, {}, this._getDefaultSettings(), settings);
    }

    /**
     * Override this method for rendering content
     * @param data
     * @protected
     */
    _onRender(data) {
    }

    /**
     * Override this method for caching the child elements of the control
     * @protected
     */
    _cacheElements() {
    }

    /**
     * Override this method for adding event listeners to the elements
     * @protected
     */
    _bindEvents() {
    }

    /**
     * Add an event listener to the root element or child elements
     * @param args
     * @protected
     */
    _elementOn(...args) {
        this.$el.on(...args);
    }

    /**
     * Find child elements by the specified CSS class name
     * @param class_name
     * @returns {*}
     */
    _findByClassName(class_name) {
        return this._find("." + class_name);
    }

    /**
     * Find child elements by the specified CSS selector
     * @param selector
     */
    _find(selector) {
        return this.$el.find(selector);
    }

    /**
     * Set the root element of the control
     * @param settings
     * @private
     */
    _setElementFromSetting(settings) {
        const $element = $(settings.element);
        this.$el = $element.length !== 0 ? $element : null;
    }

    /**
     * Render the root element from the default template
     * @param data
     * @private
     */
    _createElement(data) {
        this.$el = $((this._templates.default || this._templates)(data));
        this.$el.data("data", data);
    }

    /**
     * Set templates for rendering the control
     * @private
     */
    _createTemplates() {
        this._templates = this._getTemplates();
    }

    /**
     * Override this method to define the templates for rendering the control
     * @returns {*}
     * @protected
     */
    _getTemplates() {
        return {
            default: (data = "") => this.html`<div>${data}</div>`,
        };
    }

    /**
     * Override this method to define properties of the "settings" object which are required for the control
     * @returns {Array} Name of the properties
     * @private
     */
    _getRequiredSettings() {
        return [];
    }

    /**
     * Check whether the required settings are set. If it is not set, an error will be thrown.
     * @param settings
     * @private
     */
    _checkRequiredSettings(settings) {
        const required_settings = this._getRequiredSettings();
        if (required_settings.length === 0) {
            return;
        }

        required_settings.forEach(name => {
            if (typeof settings[name] === "undefined" || settings[name] === null) {
                throw new Error(`A required setting is missing. "${this.constructor.name}" class requires "${name}" setting.`);
            }
        });
    }

    /**
     * @private
     */
    _bindJQueryMethods() {
        const methods = ["show", "hide", "toggle", "fadeIn", "fadeOut"];
        methods.forEach(method => {
            if (this[method]) {
                return;
            }

            this[method] = (...args) => {
                this.$el[method](...args);
            };
        });
    }

    // ***** JSDoc for dynamic methods *****

    /**
     * @name Control#show
     * @function
     */

    /**
     * @name Control#hide
     * @function
     */

    /**
     * @name Control#toggle
     * @function
     */

    /**
     * @name Control#fadeIn
     * @function
     */

    /**
     * @name Control#fadeOut
     * @function
     */
}
