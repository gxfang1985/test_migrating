(function ($) {
    "use strict";

    grn.base.namespace("grn.component.schedule.multi_view.date_navigator");

    grn.component.schedule.multi_view.date_navigator = function(settings) {
        grn.component.pubsub.installTo(this);
        this._settings = settings;
        this._init();
    };

    var date_component = grn.component.date;

    /**
     * @alias grn.component.schedule.multi_view.date_navigator
     * @type {grn.component.schedule.multi_view.date_navigator}
     */
    var G = grn.component.schedule.multi_view.date_navigator;

    G.prototype._init = function() {
        this._currentDate = date_component.parse(this._settings.beginDate);
        this._today = this._settings.today.value;
        this._cacheElements();
        this._bindEvents();
    };

    G.prototype.setDate = function(date) {
        this._currentDate = date;
    };

    G.prototype._cacheElements = function() {
        var settings = this._settings;

        // container
        this.$container = $(settings.container.view).find(settings.container.dateNavigator);

        // buttons
        var buttons = this.$container.find(".moveButtonBase-grn");
        this.$buttons = {};

        for(var i=0; i < buttons.length; i++) {
            switch (i) {
                case 0:
                    this.$buttons.$prevWeekButton = $(buttons[i]).attr("data-button-type", "prevWeek");
                    break;
                case 1:
                    this.$buttons.$prevDayButton = $(buttons[i]).attr("data-button-type", "prevDay");
                    break;
                case 2:
                    this.$buttons.$todayButton = $(buttons[i]).attr("data-button-type", "today");
                    break;
                case 3:
                    this.$buttons.$nextDayButton = $(buttons[i]).attr("data-button-type", "nextDay");
                    break;
                case 4:
                    this.$buttons.$nextWeekButton = $(buttons[i]).attr("data-button-type", "nextWeek");
                    break;
            }
        }
    };

    G.prototype._bindEvents = function() {
        this.$container.on("click", ".moveButtonBase-grn", $.proxy(this._handleButtonClick, this));
    };

    G.prototype._handleButtonClick = function(e) {
        e.preventDefault();
        e.stopPropagation();

        var $button = $(e.currentTarget);
        var button_type = $($button).data("button-type");
        var new_date = this._today;

        switch(button_type) {
            case "prevWeek":
                new_date = this._findCalendarWeekStartDate(this._currentDate, -1);
                break;
            case "prevDay":
                new_date = this._addDays(this._currentDate, -1);
                break;
            case "nextDay":
                new_date = this._addDays(this._currentDate, 1);
                break;
            case "nextWeek":
                new_date = this._findCalendarWeekStartDate(this._currentDate, 1);
                break;
        }

        this._currentDate = new_date;

        this.trigger("change", new_date);
    };

    G.prototype._addDays = function(date, days) {
        var new_date = new Date(date);
        new_date.setDate(new_date.getDate() + days);

        return new_date;
    };

    G.prototype._findCalendarWeekStartDate = function(date, nextOrPrev) {
        var calendarWeekStart = parseInt(this._settings.calendarWeekStart, 10);

        if (isNaN(calendarWeekStart)) {
            calendarWeekStart = 0;
        }

        var new_date = date;

        do {
            new_date = this._addDays(new_date, nextOrPrev);
        } while(new_date.getDay() !== calendarWeekStart);

        return new_date;
    };

})(jQuery);

