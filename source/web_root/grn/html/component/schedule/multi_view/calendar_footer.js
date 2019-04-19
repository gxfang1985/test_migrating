(function ($) {
    "use strict";

    grn.base.namespace("grn.component.schedule.multi_view.calendar_footer");

    grn.component.schedule.multi_view.calendar_footer = function (settings) {
        this.settings = settings;

        this._cacheElements();
        this._createContainer();
        this.refresh();
    };

    /**
     * @alias grn.component.schedule.multi_view.calendar_footer
     * @type {grn.component.schedule.multi_view.calendar_footer}
     */
    var G = grn.component.schedule.multi_view.calendar_footer;

    G.prototype._cacheElements = function () {
        var settings = this.settings;

        var class_div = "week_bottom_parts_grn";

        if(settings.numberOfDays === 1){
            class_div = "day_bottom_parts_grn";
        }

        var $div = $("<div class='"+class_div+"'>");

        this.$view = $(settings.container.view);
        this.$viewMain = this.$view.find(settings.container.viewMain);

        var $navigator_clone = this.$view.find(".moveButtonBlock-grn").clone(true).css("margin-right","-7px");

        this.$calendarHeaderRow = $(this.$view.find(
            settings.container.withoutTimeEvents).find("tr")[0]);

        this.$headerContainer = $("<div><div class='inner'></div></div>");
        this.$dateNavigator = $div.append($navigator_clone);
    };

    G.prototype._createContainer = function () {
        var settings = this.settings;

        var $container = this.$headerContainer.find(".inner");

        if (settings.enableDateFooter) {
            var $date_area = $("" +
                "<div class='personal_week_calendar_base_header' style='border-top:0;border-bottom:1px solid #cccccc;'>" +
                "<div class='personal_week_calendar_header'>" +
                "<table class='personal_week_list_event_notime' cellspacing='0'>" +
                "</table>" +
                "</div>" +
                "</div>");

            $container.append($date_area);
        }

        if(settings.enableDateNavigatorFooter){

            $container.append(this.$dateNavigator);
        }

        this.$headerContainer.appendTo(this.$viewMain);
    };

    G.prototype.refresh = function () {
        // date cells
        this.$headerContainer.find(".personal_week_list_event_notime")
            .empty()
            .append(this.$calendarHeaderRow.clone());
    };

})(jQuery);