/* global doMoveCalednar */

(function ($) {
    "use strict";

    grn.base.namespace("grn.component.schedule.multi_view.mini_calendar_navigator");

    grn.component.schedule.multi_view.mini_calendar_navigator = function (settings) {
        grn.component.pubsub.installTo(this);
        this._settings = settings;
        this._init();
    };

    var SELECTED_CELL_CSS = "calendar_navi_today";

    /**
     * @alias grn.component.schedule.multi_view.mini_calendar_navigator
     * @type {grn.component.schedule.multi_view.mini_calendar_navigator}
     */
    var G = grn.component.schedule.multi_view.mini_calendar_navigator;

    G.prototype._init = function () {
        this._currentDate = grn.component.date.parse(this._settings.beginDate);
        this._cacheElements();
        this._bindEvents();
    };

    G.prototype.selectDate = function (date) {

        var $cell = this._findDateCell(date);

        if ($cell) {
            this._selectCell($cell);
            return;
        }

        // if the specified date is not in the current view,
        // reload UI of the mini calendar navigator.

        var date_string = this._dateFormat(date);
        this._currentDate = date;

        doMoveCalednar(date_string, $.proxy(this._selectDateAfterMovingCalendar, this));

        // NOTE:
        // The "doMoveCalednar" function is a legacy function which is defined
        // in the schedule/_schedule_navi_calendar.tpl file
    };

    G.prototype._selectDateAfterMovingCalendar = function() {
        var $cell = this._findDateCell(this._currentDate);
        this._selectCell($cell);
    };

    G.prototype._cacheElements = function () {
        var settings = this._settings;

        this.$container = $(settings.container.view).find(settings.container.miniCalendarNavigator);
    };

    G.prototype._bindEvents = function () {
        this.$container.on("click", ".date_cell", $.proxy(this._handleSelectDate, this));
    };

    G.prototype._handleSelectDate = function (e) {
        e.preventDefault();
        e.stopPropagation();

        var $cell = $(e.currentTarget);

        this._selectCell($cell);

        this._currentDate = grn.component.date.parse($cell.data("date"));

        this.trigger("change", this._currentDate);
    };


    G.prototype._findDateCell = function(date) {
        var date_string =  this._dateFormat(date);
        var $cell = this.$container.find(".date_cell_" + date_string);

        return $cell.length === 0 ? null : $cell;
    };

    G.prototype._selectCell = function ($cell) {
        this._clearSelection();
        $cell.addClass(SELECTED_CELL_CSS);
    };

    G.prototype._clearSelection = function () {
        this.$container.find("." + SELECTED_CELL_CSS)
            .removeClass(SELECTED_CELL_CSS);
    };

    G.prototype._dateFormat = function(date) {
        return jQuery.datepicker.formatDate('yy-mm-dd', date);
    };

})(jQuery);

