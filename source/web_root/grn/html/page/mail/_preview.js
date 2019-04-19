// namespace
grn.base.namespace("grn.page.mail._preview");

(function () {
    var G = grn.page.mail._preview;

    G.ajax_submit = function (command, form_name, submit_page, button_obj) {
        if (typeof form_name == "undefined" || typeof submit_page == "undefined") {
            return;
        }

        var f = document.forms[form_name];

        f.cmd.value = command;
        grn_onsubmit_common(f);

        grn.component.ajax_submit.ajax_submit(f, submit_page, before_send, after_send);

        function before_send() {
            grn.component.button( button_obj ).showSpinner();
        }

        function after_send(jqXHR) {
            f.cmd.value = '';
            if (jqXHR && !grn.component.error_handler.hasCybozuError(jqXHR) && !jQuery('#show_validation_errors').is(':visible')) {
                return;
            }
            grn.component.button(button_obj).hideSpinner();
        }
    };
})();
