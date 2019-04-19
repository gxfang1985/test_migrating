(function ($) {
    "use strict";

    // Dependencies:
    // - jQuery
    // - grn.component.url
    // - grn.component.ajax.error_handler

    /**
     * Example of usage
     *
     *    // Initialize a request
     *
     *    var request = new grn.component.ajax.request({
     *            grnUrl: 'schedule/ajax_event_list',
     *            grnLoadingIndicator: '#loading',
     *            method: 'post',
     *            data: {bdate: '2014-07-02'}
     *        }
     *    );
     *
     *    // Add event listener
     *
     *    request.on('beforeShowError', function (e, jqXHR) {
     *        // This event is triggered before the error popup will be displayed
     *
     *        console.log('beforeShowError', arguments);
     *
     *        // If you wish to handle showing error by your own way,
     *        // You can use "e.preventDefault()" to prevent showing the default error popup
     *        // e.preventDefault(); // or use "return false"
     *    });
     *
     *    request.on('errorClosed', function (e, jqXHR) {
     *        // This event is triggered after the error popup is closed
     *        console.log('errorClosed', arguments);
     *    });
     *
     *    // Send the request
     *
     *    request.send()
     *        .done(function(data, textStatus, jqXHR){
     *            // Request is success when X-Cybozu-Error|X-CybozuLogin does not occur
     *            console.log('success', arguments);
     *        })
     *        .fail(function(jqXHR, textStatus){
     *            // Request is fail when HTTP error or X-Cybozu-Error occurs
     *            console.log('fail', arguments);
     *
     *            // You can get the X-Cybozu-Error
     *            console.log('X-Cybozu-Error', request.getErrorHandler().getCybozuError(jqXHR));
     *        });
     */

    grn.base.namespace("grn.component.ajax.request");

    /**
     * Constructor
     * @param {object} settings A set of key/value pairs that configure the Ajax request.
     *                 Refer: http://api.jquery.com/jquery.ajax/#jQuery-ajax-settings
     * @param [settings.grnUrl] The garoon URL, e.g. schedule/ajax_event_list
     * @param [settings.grnErrorHandler] The error handler for handling ajax error
     * @param [settings.grnRedirectOnLoginError] When the login error, whether to redirect(to the login screen)
     * @param [settings.grnLoadingIndicator] jQuery selector (or a function) which determines AJAX loading spinner
     */
    grn.component.ajax.request = function (settings) {

        this._settings = this._initSettings(settings);

        this._ajaxDefered = $.Deferred();
        this._event = $({});

        this.initOnBeforeUnload();
    };

    grn.component.ajax.request.EVENT = {
        ERROR_CLOSED: "errorClosed",
        BEFORE_SHOW_ERROR: "beforeShowError"
    };

    /**
     * @alias grn.component.ajax.request
     * @type {grn.component.ajax.request}
     */
    var G = grn.component.ajax.request;

    var EVENT = grn.component.ajax.request.EVENT;

    var before_unload_called = false;
    var window_on_beforeunload_registered = false;

    G.prototype.initOnBeforeUnload = function () {
        if (window_on_beforeunload_registered) {
            return;
        }
        $(window).on('beforeunload', function () {
            before_unload_called = true;
        });

        window_on_beforeunload_registered = true;
    };

    /**
     * Sent request
     * @param data Data to be sent to the server. This parameter is optional.
     * @returns A Deferred’s Promise object.
     */
    G.prototype.send = function (data) {

        this._prepareData(data);

        this._invokeLoadingIndicator('show');

        this.jqXHR = $.ajax(this._settings)
            .done(this._ajaxOnSuccess.bind(this))
            .fail(this._ajaxOnFail.bind(this))
            .always(this._ajaxOnComplete.bind(this));

        return this._ajaxDefered.promise();
    };

    G.prototype.on = function (name, callback) {
        this._event.on(name, callback);
    };

    G.prototype.getErrorHandler = function() {
        return this._settings.grnErrorHandler;
    };

    /**
     * Prepare data for sending to the server
     * @param data
     * @private
     */
    G.prototype._prepareData = function(data) {
        if(typeof data === "undefined") {
            data = this._settings.data;
        }

        var local_data = data || {};

        if(this._settings.processData === false) {
            this._settings.data = data;
            return;
        }

        // Add "use_ajax" param
        // NOTE: The "use_ajax" param is used for determining AJAX request and handling error on server side

        switch (typeof local_data) {
            case "object":
                local_data.use_ajax = 1;
                break;
            case "string":
                local_data += "&use_ajax=1";
                break;
            default: // unexpected
                throw "The given data should be a query string or JSON";
        }

        this._settings.data = local_data;
    };

    /**
     * Initialize settings for jQuery AJAX
     * @param settings
     * @returns {object}
     * @private
     */
    G.prototype._initSettings = function (settings) {

        // additional properties for Garoon
        var garoon_settings = {
            grnErrorHandler: grn.component.ajax.error_handler,
            grnUrl: null,
            grnRedirectOnLoginError: false,
            grnLoadingIndicator: null
        };

        this._throwErrorIfUsingUnsupportedOption(settings);

        var _settings = $.extend(garoon_settings, settings || {});

        if (_settings.grnUrl) {
            _settings.url = grn.component.url.page(_settings.grnUrl);
        }

        return _settings;
    };

    G.prototype._throwErrorIfUsingUnsupportedOption = function (settings) {
        if ("success" in settings ||
            "error" in settings ||
            "complete" in settings) {

            throw "Garoon AJAX component does not support success/error/complete callback options. " +
            "Use jqXHR.done(), jqXHR.fail(), and jqXHR.always(), jqXHR.then() instead. " +
            "Refer (The jqXHR Object): http://api.jquery.com/jquery.ajax/";
        }
    };

    G.prototype._trigger = function (event_name, data) {
        var $event = $.Event(event_name);
        this._event.trigger($event, data || null);
        return $event;
    };

    G.prototype._ajaxOnSuccess = function (data, textStatus, jqXHR) {
        var error = this._handleError(textStatus, jqXHR);

        if (error) {
            this._ajaxDefered.rejectWith(this, [jqXHR, textStatus, null]);
        } else {
            this._ajaxDefered.resolveWith(this, arguments);
        }
    };

    G.prototype._ajaxOnFail = function (jqXHR, textStatus, errorThrown) {
        this._handleError(textStatus, jqXHR);
        this._ajaxDefered.rejectWith(this, arguments);
    };

    G.prototype._ajaxOnComplete = function () {
        this._invokeLoadingIndicator('hide');
    };

    /**
     * Handle HTTP errors and Cybozu errors
     * @param textStatus
     * @param jqXHR
     * @returns {boolean} "true" if error occurs, otherwise is "false"
     * @private
     */
    G.prototype._handleError = function (textStatus, jqXHR) {
        var error_handler = this._settings.grnErrorHandler;

        if (textStatus === 'abort' || error_handler === null) {
            return false;
        }

        if (error_handler.hasCybozuLogin(jqXHR) && this._settings.grnRedirectOnLoginError) {
            // force reloading page to display the login page
            location.reload(true);
            return;

            // NOTE: don't use location.href, it will not reload page if URL contains fragment "#"
            // location.href = location.href;
        }

        if (textStatus !== 'success' || error_handler.hasCybozuError(jqXHR)) {

            var $event = this._trigger(EVENT.BEFORE_SHOW_ERROR, [jqXHR]);
            if (!$event.isDefaultPrevented()) {
                // NOTE: don't show error popup for request which does not has "hasCybozuError" and marked as canceled (such as: reload, refresh, redirect, ...)
                if (before_unload_called && !error_handler.hasCybozuError(jqXHR)) {
                    return;
                }
                error_handler.show(jqXHR, this._errorPopupClosed.bind(this, jqXHR));
            }

            return true;
        }
    };

    G.prototype._errorPopupClosed = function (jqXHR) {
        this._trigger(EVENT.ERROR_CLOSED, [jqXHR]);
    };

    /**
     * Toggle ajax indicator (spinner icon)
     * @param option "show" or "hide"
     * @private
     */
    G.prototype._invokeLoadingIndicator = function (option) {
        var indicator = this._settings.grnLoadingIndicator;

        if (!indicator) {
            return;
        }

        if (typeof indicator === "function") {
            indicator(option);
        } else {
            $(indicator)[option]();
        }
    };

})(jQuery);