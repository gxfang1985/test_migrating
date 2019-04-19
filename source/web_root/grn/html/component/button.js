(function ($) {
    "use strict";

    grn.base.namespace("grn.component.button");

    // Private constants

    var TEMPLATE = "<span class='button_grn_js'><a href='javascript:void(0);' role='button'></a></span>";

    var CSS = {
        normal: "button1_normal_grn",
        main: "button1_main_grn",
        attention: "button1_attention_grn",
        disabled: "button_disable_filter_grn",
        spinner: "spinner_button1_grn"
    };

    var CSS_UI = {
        normal: CSS.normal,
        main: CSS.main,
        attention: CSS.attention
    };

    var CSS_SPACING = {
        tight: "button1_r_margin1_grn",
        normal: "button1_r_margin2_grn",
        loose: "button1_r_margin3_grn",
        very_loose: "button1_r_margin4_grn"
    };

    // Public constants

    var UI = {
        NORMAL: "normal",
        MAIN: "main",
        ATTENTION: "attention"
    };

    var SPACING = {
        TIGHT: "tight",
        NORMAL: "normal",
        LOOSE: "loose",
        VERY_LOOSE: "very_loose"
    };

    /**
     * Create or retrieve a button controller
     * @memberOf grn.component
     * @alias button
     * @param {String|Object} element - Selector or DOM element of the button
     * @returns {Button}
     * @constructor
     */
    function Button(element) {
        // Allow instantiating/retrieving the button instance without using "new" operator
        // The button controller will be cached for later access
        if (!(this instanceof Button)) {
            var $controller = $(element).data("controller");

            if (!$controller) {
                $controller = new Button(element);
                $(element).data("controller", $controller);
            }

            return $controller;
        }

        this.$element = element ? $(element) : $(TEMPLATE);
        this.$element.on("click", this._preventClickWhenDisabled.bind(this));
    }

    // Prototype

    /**
     * Render HTML of the button
     * @param {Object} options
     * @param {String} options.caption - Button caption
     * @param {String} [options.ui] - Button style. See {@link grn.component.button.UI}
     * @param {String} [options.spacing] - Button spacing. See {@link grn.component.button.SPACING}
     * @param {String} [options.id] - Button ID
     * @param {String} [options.className] - Button extra CSS class name
     * @param {Boolean} [options.disabled] - Whether to disable the button
     * @param {Boolean} [options.autoDisable] - Whether to auto disable the button after user clicks on the button
     * @returns {Button}
     */
    Button.prototype.render = function (options) {
        if (typeof options !== "object") {
            throw "\"options\" parameter is required";
        }

        var $element = $(TEMPLATE);
        this.$element.replaceWith($element);
        this.$element = $element;

        this.setCaption(options.caption ? options.caption : "");

        this.setUI(options.ui ? options.ui : UI.NORMAL);

        if (options.spacing) {
            this.setSpacing(options.spacing);
        }

        if (options.id) {
            this.$element.attr("id", options.id);
        }

        if (options.className) {
            this.$element.addClass(options.className);
        }

        if (options.disabled) {
            this.disable();
        }

        if (options.autoDisable) {
            this.$element.attr("data-auto-disable", true);
        }

        this.$element.on("click", this._preventClickWhenDisabled.bind(this));

        return this;
    };

    /**
     * Set button style
     * @param {String} name - See {@link grn.component.button.UI}
     * @returns {Button}
     */
    Button.prototype.setUI = function (name) {
        if (name in CSS_UI) {
            var CSS_UI_array = [];
            for (var i in CSS_UI) {
                CSS_UI_array.push(CSS_UI[i]);
            }
            this.$element.removeClass(CSS_UI_array.join(" "));
            this.$element.addClass(CSS_UI[name]);
        }

        return this;
    };

    /**
     * Set button spacing
     * @param {String} value - See {@link grn.component.button.SPACING}
     * @returns {Button}
     */
    Button.prototype.setSpacing = function (value) {
        if (value in CSS_SPACING) {
            var CSS_SPACING_array = [];
            for (var i in CSS_SPACING) {
                CSS_SPACING_array.push(CSS_SPACING[i]);
            }
            this.$element.removeClass(CSS_SPACING_array.join(" "));
            this.$element.addClass(CSS_SPACING[value]);
        }

        return this;
    };

    /**
     * Set button caption
     * @param caption
     * @returns {Button}
     */
    Button.prototype.setCaption = function (caption) {
        this.$element.find("a").text(caption);
        return this;
    };

    Button.prototype.isDisabled = function () {
        return this.$element.hasClass(CSS.disabled);
    };

    /**
     * Enable the button
     * @returns {Button}
     */
    Button.prototype.enable = function () {
        this.$element.removeClass(CSS.disabled);
        this.$element.find("a").removeAttr("aria-disabled");
        return this;
    };

    /**
     * Disable the button
     * @returns {Button}
     */
    Button.prototype.disable = function () {
        this.$element.addClass(CSS.disabled);
        this.$element.find("a").attr({"aria-disabled": true});
        return this;
    };

    /**
     * Show spinner and disable the button
     * @returns {Button}
     */
    Button.prototype.showSpinner = function () {
        this.disable();
        this._getSpinner().css("display", "inline-block");
        return this;
    };

    /**
     * Hide spinner and enable the button
     * @returns {Button}
     */
    Button.prototype.hideSpinner = function () {
        this._getSpinner().hide();
        this.enable();
        return this;
    };

    /**
     * Add event listener
     * Reference: see jQuery.on()
     * @returns {Button}
     */
    Button.prototype.on = function () {
        this.$element.on.apply(this.$element, arguments);
        return this;
    };

    /**
     * Remove event listener
     * Reference: see jQuery.off()
     * @returns {Button}
     */
    Button.prototype.off = function () {
        this.$element.off.apply(this.$element, arguments);
        return this;
    };

    /**
     * Set focus on the button
     */
    Button.prototype.focus = function () {
        this.$element.find("a").focus();
    };

    Button.prototype._getSpinner = function () {
        var $spinner = this.$element.find("." + CSS.spinner);

        if ($spinner.length !== 0) {
            return $spinner;
        }

        return $("<span></span>")
            .addClass(CSS.spinner)
            .appendTo(this.$element);
    };

    Button.prototype._preventClickWhenDisabled = function (event) {
        if (!this.isDisabled()) {
            return;
        }

        event.preventDefault();
        event.stopImmediatePropagation();
    };

    // Utilities

    Button.util = {};

    Button.util.addEventListenerForAutoDisableButton = function () {
        $(document).on("click", ".button_grn_js", function (event) {
            var $button_element = $(event.currentTarget);
            if (!$button_element.data("auto-disable")) {
                return;
            }

            var button = grn.component.button($button_element);
            if (!button.isDisabled()) {
                grn.component.button($button_element).showSpinner();
            }
        });
    };

    Button.util.submit = function (button_element) {
        var button = grn.component.button(button_element);
        if (!button.isDisabled()) {
            button.$element.closest("form").submit();
        }
    };

    Button.util.redirect = function (button_element, page) {
        var button = grn.component.button(button_element);
        if (button.isDisabled()) {
            return;
        }
        if (page === 'history_back') {
            history.back();
        } else {
            location.href = page;
        }
    };

    // expose Button object

    Button.UI = UI;
    Button.SPACING = SPACING;
    grn.component.button = Button;

})(jQuery);
