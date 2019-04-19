(function ($) {
    "use strict";

    grn.base.namespace("grn.component.TransitSearch");
    var ROUTE_SEARCH_LOADING_SELECTOR_ID = "js_route_search_loading";
    var DEFAULT_OPTIONS = {
        "loading_style": {"top": "50%", "left": "49%", "margin-top": "-50px", "position": "fixed"},
        "service_url": "",
        "route_name_field": "route",
        "route_fare_field": "route_fare",
        "route_time_field": "route_time",
        "popup_width": 720,
        "popup_height": 575
    };
    DEFAULT_OPTIONS.TEMPLATES = {
        CONTAINER: "<div>" +
            "<div class='" + ROUTE_SEARCH_LOADING_SELECTOR_ID + "' class='spinnerBoxBase-grn'>" +
                "<div class='spinnerBox-grn'></div>" +
            "</div>" +
        "</div>"
    };
    grn.component.TransitSearch = function (element_selector) {
        this.$dataContainer = $(element_selector);
        this.$routeSearchButton = this.$dataContainer.find('.js_route_button_element');
        var route_data_options = this.$routeSearchButton.data("route");
        this.setOption(route_data_options);
        if (this.$dataContainer.length > 0 && !route_data_options.error_message) {
            this._bindEvents();
        }
    };
    grn.component.TransitSearch.handleSearchResult = function (e) {
        var transit_search = grn.component.TransitSearch.currentInstance;
        if (!transit_search || !transit_search.isValidMessageEvent(e)) {
            return;
        }
        var message = e.data;
        switch (message.type) {
            case "importFare":
                transit_search.setRouteSearchResult(message.data);
                transit_search.close();
                break;
            case "close":
                transit_search.close();
                break;
        }
    };
    grn.component.TransitSearch.prototype = {
        setOption: function (options) {
            this.options = $.extend({}, DEFAULT_OPTIONS, options);
            this.dialog = new grn.component.WindowSimpleDialog({
                title: "",
                modal: true
            });
        },
        setRouteSearchResult: function (data) {
            var $data_container = this.$dataContainer;
            var options = this.options;
            $data_container.find("input[name=" + options.route_name_field + "]").val(data.pathDescription);
            $data_container.find("input[name=" + options.route_fare_field + "]").val(data.fare);
            $data_container.find("input[name=" + options.route_time_field + "]").val(data.duration);
        },
        show: function () {
            var div_content = this.options.TEMPLATES.CONTAINER;
            // add dialog
            var dom_content = $(div_content);
            dom_content.css({"width": this.options.popup_width, "height": this.options.popup_height});
            dom_content.find("." + ROUTE_SEARCH_LOADING_SELECTOR_ID).css(this.options.loading_style);
            this.dialog.setContent(dom_content);
            this.dialog.$container.find("#window_dialog_header").remove();
            this.dialog.$container.find("#window_content").css("padding", "0px 0px");
            // set container
            this.$container = dom_content;
            this.dialog.openDialog();
            // add event handler
            var route_search_iframe = this.createRouteSearchIframe();
            dom_content.append(route_search_iframe);
            $(route_search_iframe).on("load", function () {
                dom_content.find("." + ROUTE_SEARCH_LOADING_SELECTOR_ID).hide();
            });
            grn.component.TransitSearch.currentInstance = this;
            this.$routeSearchWindow = route_search_iframe.contentWindow;
            window.addEventListener("message", grn.component.TransitSearch.handleSearchResult);
        },
        _bindEvents: function () {
            this.$routeSearchButton.click(function () {
                this.show();
                return false;
            }.bind(this));
        },
        close: function () {
            this.dialog.closeDialog();
            grn.component.TransitSearch.currentInstance = null;
            window.removeEventListener("message", grn.component.TransitSearch.handleSearchResult);
        },
        createRouteSearchIframe: function () {
            // create iframe
            var route_search_iframe = document.createElement("iframe");
            route_search_iframe.style.width = "100%";
            route_search_iframe.style.height = "100%";
            route_search_iframe.frameBorder = "0";
            route_search_iframe.src = this.options.service_url;
            return route_search_iframe;
        },
        getServiceHost: function (url) {
            var a = document.createElement('a');
            a.href = url;
            return a.protocol + '//' + a.hostname;
        },
        isValidMessageEvent: function (event) {
            if (!event.data) {
                return false;
            }
            var service_host = this.getServiceHost(this.options.service_url);
            if (event.origin !== service_host) {
                return false;
            }
            if (event.source !== this.$routeSearchWindow) {
                return false;
            }
            return true;
        }
    };
})(jQuery);


