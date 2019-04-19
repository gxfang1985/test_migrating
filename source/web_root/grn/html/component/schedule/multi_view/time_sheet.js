(function ($) {
    "use strict";

    grn.base.namespace("grn.component.schedule.multi_view.time_sheet");

    var ONE_HOUR_HEIGHT = 40; // height of one hour cell
    var DATE_CELLS_CSS = [
        "s_date_holiday",
        "s_date_sunday",
        "s_date_monday",
        "s_date_tuesday",
        "s_date_wednesday",
        "s_date_thursday",
        "s_date_friday",
        "s_date_saturday"];

    grn.component.schedule.multi_view.time_sheet = function (settings) {
        this.settings = settings;
    };

    /**
     * @alias grn.component.schedule.multi_view.time_sheet
     * @type {grn.component.schedule.multi_view.time_sheet}
     */
    var G = grn.component.schedule.multi_view.time_sheet;

    G.prototype.render = function () {
        this._createDateCellsContent();
        this._createTimeHeader();
        this._createTimeRowsForAllColumns();
        this._createTimeRowsBusyForAllColumns();
    };

    G.prototype._createDateCellsContent = function () {
        var settings = this.settings;
        var $view = $(settings.container.view);
        var $cells = $view.find(settings.container.withoutTimeEvents + " .date_cell");

        for (var i = 0; i < $cells.length; i++) {

            this._updateDateCellCss($($cells[i]), settings.dates[i].type);

            var link = $cells[i].getElementsByTagName("a")[0];

            // set link text
            link.textContent = settings.dates[i].text;

            // update link URL
            var href = link.getAttribute("href");
            var url_params = {
                bdate: settings.dates[i].value,
                uid: settings.uid,
                gid: settings.gid
            };

            link.setAttribute("href", grn.component.url.setParameters(href, url_params));
        }
    };

    G.prototype._updateDateCellCss = function($cell, css) {
        $cell.removeClass(DATE_CELLS_CSS.join(" "));
        $cell.addClass(css);
    };

    G.prototype._createTimeHeader = function () {
        var settings = this.settings;

        var $view = $(settings.container.view);
        var $time_sheet = $view.find(settings.container.timeSheet);

        $time_sheet.find(settings.container.timeSheetHeader).remove();

        var view_height = (settings.maxTime - settings.minTime) * ONE_HOUR_HEIGHT;

        $time_sheet.css('height', view_height + 'px');
        $time_sheet.find(settings.container.normalEvents).css('height', view_height + 'px');

        var $time_sheet_header = $('<div class="personal_calendar_time_sheet"/>');
        var $time_slot;

        for (var i = settings.minTime; i < settings.maxTime; i++) {
            $time_slot = $('<div class="personal_day_calendar_time_cell"/>').html(i);

            if (i < 12) {
                $time_slot.addClass('m');
            }
            else if (i < 18) {
                $time_slot.addClass('e');
            }
            else {
                $time_slot.addClass('a');
            }

            $time_slot.appendTo($time_sheet_header);
        }

        $time_sheet_header.appendTo($time_sheet);
    };

    G.prototype._createTimeRowsBusyForAllColumns = function () {
        var $columns = $(this.settings.container.view).find(".personal_day_event_list");

        $columns.each(function () {
            var $event_list = $(this);
            var $column = $event_list.parent();
            $column.find("div.busy_time_span").remove();
            var div_busy = $event_list.clone()
                .attr({
                    "class": "busy_time_span",
                    "id" : "",
                    "style" : ""
                });

            $column.append(div_busy);
        });
    };

    G.prototype._createTimeRowsForAllColumns = function () {
        var self = this;
        var $columns = $(this.settings.container.view).find(".personal_day_event_list");

        var column_date = grn.component.date.parse(this.settings.beginDate);

        $columns.each(function () {
            self._createTimeRows(this, column_date);

            column_date.setDate(column_date.getDate() + 1);
        });
    };

    G.prototype._createTimeRows = function (column, date) {
        // remove old children elements if existing
        column.innerHTML = "";

        var settings = this.settings;

        var rows_fragment = document.createDocumentFragment();

        for (var i = settings.minTime; i < settings.maxTime; i++) {
            var row = this._createTimeRow(date, i, false);
            row.className += ' snapto';
            var row_alternative = this._createTimeRow(date, i, true);

            row.appendChild(row_alternative);
            rows_fragment.appendChild(row);
        }

        column.appendChild(rows_fragment);
    };

    G.prototype._createTimeRow = function (date, hour, alternative) {
        var settings = this.settings;

        var css_row = alternative ? "personal_day_calendar_time_row_alt" : "personal_day_calendar_time_row";

        var row = document.createElement("div");
        row.className = css_row + ' add_quick';

        var $row = $(row);

        var date_string = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();

        $row.attr({
            "data-hour": hour,
            "data-minute": alternative ? 0 : 30,
            "data-bdate": date_string,
            "data-uid": settings.uid,
            "data-gid": settings.gid,
            "data-referer_key": settings.refererKey
        });

        if (settings.plid && settings.plid !== "") {
            $row.attr("plid", settings.plid);
        }

        return row;
    };

})(jQuery);

