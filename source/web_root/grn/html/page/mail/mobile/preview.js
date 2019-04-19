grn.base.namespace("grn.page.mail.mobile.preview");

(function () {
    var G = grn.page.mail.mobile.preview;

    G.ajaxSubmit = function (command, formId, formName) {
        if (typeof formId === "undefined") {
            return;
        }
        var f = document.forms[formName];
        f.cmd.value = command;

        grn.component.mobile_ajax_submit.ajaxSubmit(formId);
    };
})();
