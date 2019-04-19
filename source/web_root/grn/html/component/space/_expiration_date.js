(function ($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.page.space._expiration_date")) {
        return;
    }
    grn.base.namespace("grn.page.space._expiration_date");

    var G = grn.page.space._expiration_date;

    G.cssSelectors = {
        "container": ".js_expiration_date",
        "unlimited": "#unlimited",
        "limited": "#limited",
        "expiration_date_month": "#expiration_date_month",
        "expiration_date_day": "#expiration_date_day",
        "expiration_date_year": "#expiration_date_year",
        "calendar_w": "a[name='calendar_w']",
        "expiration_date_hour": "#expiration_date_hour",
        "expiration_date_minute": "#expiration_date_minute"
    };

    G.KEY_WORDS = {
        CLICK: "click",
        CHECKED: "checked",
        DISABLED: "disabled"
    };

    G.init = function () {
        G.cacheElements();
        G.initCss();
        G._bindEvents();
        G.start_history_length = history.length;
    };

    G.cacheElements = function () {
        this.$container = $(this.cssSelectors.container);
        this.$unlimited = this.$container.find(this.cssSelectors.unlimited);
        this.$limited = this.$container.find(this.cssSelectors.limited);
        this.$expiration_date_month = this.$container.find(this.cssSelectors.expiration_date_month);
        this.$expiration_date_day = this.$container.find(this.cssSelectors.expiration_date_day);
        this.$expiration_date_year = this.$container.find(this.cssSelectors.expiration_date_year);
        this.$calendar_icon = this.$container.find(this.cssSelectors.calendar_w);
        this.$expiration_date_hour = this.$container.find(this.cssSelectors.expiration_date_hour);
        this.$expiration_date_minute = this.$container.find(this.cssSelectors.expiration_date_minute);
    };

    /**
     * Initialize the basic css
     * Note: use this function after calling function cacheElements
     */
    G.initCss = function () {
        this.$expiration_date_year.addClass("mRight5");
        this.$expiration_date_day.addClass("mRight2");
        if(grn.data && grn.data.locale === "en") {
            this.$expiration_date_year.removeClass("mRight5").addClass("mRight2 mLeft5");
            this.$expiration_date_day.removeClass("mRight2").addClass("mRight5 mLeft5");
        }
        this.$expiration_date_month.addClass("mRight5");
        this.$calendar_icon.addClass("mRight10");
        this.$expiration_date_hour.addClass("mRight5");
    };

    G._bindEvents = function () {
        this.$unlimited.off(this.KEY_WORDS.CLICK).on(this.KEY_WORDS.CLICK, $.proxy(this.changeUnlimited, this));
        this.$limited.off(this.KEY_WORDS.CLICK).on(this.KEY_WORDS.CLICK, $.proxy(this.changeLimited, this));
    };

    G.changeUnlimited = function (e) {
        var is_checked = $(e.currentTarget).prop(this.KEY_WORDS.CHECKED);
        this.$limited.prop(this.KEY_WORDS.CHECKED, !is_checked);
        this.markDisabledInputPublicPeriod(is_checked);
    };

    G.changeLimited = function (e) {
        var is_checked = $(e.currentTarget).prop(this.KEY_WORDS.CHECKED);
        this.$unlimited.prop(this.KEY_WORDS.CHECKED, !is_checked);
        this.markDisabledInputPublicPeriod(!is_checked);
    };

    /**
     *
     * @param {boolean} is_disabled
     */
    G.markDisabledInputPublicPeriod = function (is_disabled) {
        this.$expiration_date_month.prop(this.KEY_WORDS.DISABLED, is_disabled);
        this.$expiration_date_day.prop(this.KEY_WORDS.DISABLED, is_disabled);
        this.$expiration_date_year.prop(this.KEY_WORDS.DISABLED, is_disabled);
        this.$expiration_date_hour.prop(this.KEY_WORDS.DISABLED, is_disabled);
        this.$expiration_date_minute.prop(this.KEY_WORDS.DISABLED, is_disabled);

        if (is_disabled) {
            this.$calendar_icon.addClass("disable_filter_grn");
            this.$calendar_icon.removeAttr("style");
        } else {
            this.$calendar_icon.removeClass("disable_filter_grn");
            this.$calendar_icon.css("cursor", "pointer");
        }
    };

    G.pageLoad = function () {
        var is_unlimited = this.$unlimited.prop(this.KEY_WORDS.CHECKED);
        this.markDisabledInputPublicPeriod(is_unlimited);
    };

    G.spaceCancel = function (button_element, page) {
        var button = grn.component.button(button_element);
        if ( button.isDisabled() ) {
            return;
        }
        if ( page === "history_back" ) {
            var current_history_length = history.length;
            if ( current_history_length > 1 ) {
                var index = G.start_history_length - current_history_length - 1;
                history.go(index);
                return;
            }
            location.href = grn.component.url.page("space/root");
            return;
        }
        location.href = page;
        return;
    };
})(jQuery);

jQuery(document).ready(function () {
    var G = grn.page.space._expiration_date;
    G.init();
    G.pageLoad();
});