grn.base.namespace("grn.page.dezielink.system.modify");

(function ($) {
    "use strict";

    var G = grn.page.dezielink.system.modify;

    $(function (){
        var body_html = $(".mainarea");
        var new_html_string = body_html.html().replace(/&amp;&amp;module&amp;&amp;/gi, G.moduleName);
        body_html.html(new_html_string);
    });

    var connector_link_form_init = function (form) {
        var connector_available_len = form.connector_available.length;
        for (var connector_available_key = 0; connector_available_key < connector_available_len; connector_available_key++) {
            var connector_available_obj = form.connector_available[connector_available_key];
            if (connector_available_obj.checked) {
                connector_available_obj.click();
                break;
            }
        }

        var sync_user_len = form.sync_user.length;
        for (var sync_user_key = 0; sync_user_key < sync_user_len; sync_user_key++) {
            var sync_user_obj = form.sync_user[sync_user_key];
            if (sync_user_obj.checked) {
                sync_user_obj.click();
                break;
            }
        }

        var period_type_len = form.period_type.length;
        for (var period_type_key = 0; period_type_key < period_type_len; period_type_key++) {
            var period_type_obj = form.period_type[period_type_key];
            if (period_type_obj.checked) {
                period_type_obj.click();
                break;
            }
        }
    };

    G.connector_available = function (form) {
        var sync_user_len = form.sync_user.length;
        for (var sync_user_key = 0; sync_user_key < sync_user_len; sync_user_key++) {
            var sync_user_selected_obj = form.sync_user[sync_user_key];
            if (sync_user_selected_obj.checked) {
                break;
            }
        }

        switch (sync_user_selected_obj.id) {
            case 'sync_user_on':
                display_on( 'link_box' );
                break;
            default:
                display_off( 'link_box' );
                return;
        }

        var period_type_len = form.period_type.length;
        for (var period_type_key = 0; period_type_key < period_type_len; period_type_key++) {
            var period_type_obj = form.period_type[period_type_key];
            if (period_type_obj.checked) {
                break;
            }
        }

        switch (period_type_obj.id) {
            case 'day':
                setDisableById(form, 'wdays', 'on');
                setDisableById(form, 'days', 'on');
                break;
            case 'week':
                setDisableById(form, 'wdays', 'off');
                setDisableById(form, 'days', 'on');
                break;
            case 'month':
                setDisableById(form, 'wdays', 'on');
                setDisableById(form, 'days', 'off');
                break;
        }
    };

    G.sync_user_on = function () {
        var form = document.forms[G.formName];
        var period_type_len = form.period_type.length;
        for (var period_type_key = 0; period_type_key < period_type_len; period_type_key++) {
            var period_type_selected_obj = form.period_type[period_type_key];
            if (period_type_selected_obj.checked) {
                break;
            }
        }
        switch (period_type_selected_obj.id) {
            case 'day':
                setDisableById(form, 'wdays', 'on');
                setDisableById(form, 'days', 'on');
                break;
            case 'week':
                setDisableById(form, 'wdays', 'off');
                setDisableById(form, 'days', 'on');
                break;
            case 'month':
                setDisableById(form, 'wdays', 'on');
                setDisableById(form, 'days', 'off');
                break;
        }
    };

    if (window.onload) {
        var older_onload = window.onload;
        window.onload = function () {
            if( typeof(older_onload) == 'function') older_onload();

            var form = document.forms[G.formName];
            connector_link_form_init(form);
        }
    }
    else {
        window.onload = function () {
            var form = document.forms[G.formName];
            connector_link_form_init(form);
        }
    }
})(jQuery);
