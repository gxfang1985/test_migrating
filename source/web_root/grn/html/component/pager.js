(function ($) {
    "use strict";

    grn.base.namespace("grn.component.pager");

    function Pager(container, settings) {
        this.settings = settings;
        this.limit = settings.limit;
        this.container = $(container);

        this.init();

        this.bindEvents();
    }

    Pager.prototype.init = function () {
        this._event = $({});

        this.topPage = {
            on: this.container.find('.js_top_page_on'),
            off: this.container.find('.js_top_page_off')
        };

        this.previousPage = {
            on: this.container.find('.js_prev_page_on'),
            off: this.container.find('.js_prev_page_off')
        };

        this.nextPage = {
            on: this.container.find('.js_next_page_on'),
            off: this.container.find('.js_next_page_off')
        };

        this.startNumber = this.container.find('.js_start_num');
        this.endNumber = this.container.find('.js_end_num');
    };

    Pager.prototype.on = function(eventName, callback){
        this._event.on(eventName,callback);
    };

    Pager.prototype.bindEvents = function(){
        var self = this;
        this.container.on('click', '.js_top_page_on, .js_prev_page_on, .js_next_page_on', function(event){
            self._event.trigger("paging", $(event.currentTarget).data('page'));
        });
    };

    Pager.prototype.show = function (object) {
        object.on.show();
        object.off.hide();
    };

    Pager.prototype.hide = function (object) {
        object.on.hide();
        object.off.show();
    };

    Pager.prototype.setState = function (naviInfo) {
        this.show(this.topPage);
        this.show(this.previousPage);
        this.show(this.nextPage);

        if (naviInfo.prev === -1) {
            this.hide(this.topPage);
            this.hide(this.previousPage);
        }

        if (naviInfo.next === -1) {
            this.hide(this.nextPage);
        }

        this.startNumber.html(naviInfo.start);
        this.endNumber.html(naviInfo.end);

        // update title of navigation
        if (this.limit !== naviInfo.limit) {
            this.updateTitle(naviInfo);
            this.limit = naviInfo.limit;
        }
    };

    Pager.prototype.updateTitle = function (naviInfo) {
        var previousTitle = grn.component.i18n.cbMsg("grn.grn", "GRN_GRN-1556") + naviInfo.limit + grn.component.i18n.cbMsg("grn.grn", "GRN_GRN-1557");
        this.previousPage.on.children('a').attr('title', previousTitle);
        this.previousPage.off.children('span').attr('title', previousTitle);

        var nextTitle = grn.component.i18n.cbMsg("grn.grn", "GRN_GRN-1558") + naviInfo.limit + grn.component.i18n.cbMsg("grn.grn", "GRN_GRN-1559");
        this.nextPage.on.children('a').attr('title', nextTitle);
        this.nextPage.off.children('span').attr('title', nextTitle);
    };

    grn.component.pager = Pager;

})(jQuery);