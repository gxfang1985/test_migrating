// namespace
grn.base.namespace("grn.page.workflow.ajax_submit");

(function () {
    var G = grn.page.workflow.ajax_submit;

    G.workflow_submit = function (form_name, submit_page, button_obj) {
        if (typeof form_name == "undefined" || typeof submit_page == "undefined") {
            return;
        }

        if(grn.component.button(button_obj).isDisabled())
        {
            return;
        }
        var f = document.forms[form_name];
        grn.component.ajax_submit_wf.init();
        if (f.cmd && f.cmd.value === "acceptance") {
            grn.component.ajax_submit_wf.on("afterSuccess", function (event, event_data) {
                return grn.js.component.customization.workflow.request_approve.triggerJsApiApproveSubmitSuccess(event_data);
            })
        }
        grn.component.ajax_submit_wf.ajax_submit(f, submit_page, before_send, after_send);

        function before_send() {
            if (button_obj) {
                var button = grn.component.button(button_obj);
                if (button) {
                    button.showSpinner();
                }
            }
        }

        function after_send(json_obj) {
            if (button_obj) {
                var is_request_success = json_obj && !grn.component.error_handler.hasCybozuError(json_obj);
                if (is_request_success && json_obj.success_do != "pop_up") {
                    return;
                }
                var button = grn.component.button(button_obj);
                button.hideSpinner();
            }
        }
    };
})();
