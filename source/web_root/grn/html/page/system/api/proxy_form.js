/* global JSON */
grn.base.namespace("grn.page.system.api.proxy_form");

(function ($) {
    "use strict";

    var G = grn.page.system.api.proxy_form;
    var KeyValueEditableTable = grn.component.KeyValueEditableTable;
    var Validator = grn.component.validator;
    var i18n = grn.component.i18n;

    G.init = function (container, data) {
        this.$container = $(container);
        this.form = this.$container[0];

        this.data = data || {};

        this.formErrorMessage = $("#form_error_message")[0];
        this.viewMode = this.$container.data("mode");
        this.$methodSelection = this.$container.find("#method");
        this.$bodyRow = this.$container.find("#proxy_body_area").closest("tr");

        // Method
        this.$methodSelection.change(this.changeMethod.bind(this));
        this.changeMethod();

        // URL params
        this.params_table = new KeyValueEditableTable("#proxy_params_area", {
            JS_RESOURCES: {
                EMPTY_MESSAGE_LINK: i18n.cbMsg("grn.system.api", "proxy_url_params_empty_message_link")
            }
        });
        this.params_table.render(this.data.url_params);

        // Headers
        this.headers_table = new KeyValueEditableTable("#proxy_headers_area", {
            JS_RESOURCES: {
                EMPTY_MESSAGE_LINK: i18n.cbMsg("grn.system.api", "proxy_headers_empty_message_link")
            }
        });
        this.headers_table.render(this.data.headers);

        // Body
        this.body_table = new KeyValueEditableTable("#proxy_body_area", {
            JS_RESOURCES: {
                EMPTY_MESSAGE_LINK: i18n.cbMsg("grn.system.api", "proxy_body_form_params_empty_message_link")
            }
        });
        this.body_table.render(this.data.body);

        this.$container.find(".js_button_save").click(this.save.bind(this));
    };

    G.changeMethod = function () {
        var method_value = this.$methodSelection.find(":selected").val();
        if (method_value == "GET" || method_value == "DELETE") {
            this.$bodyRow.hide();
        } else {
            this.$bodyRow.show();
        }
    };

    G.save = function (e) {
        e.preventDefault();

        if (!this.validate()) {
            return;
        }

        var command_url = "system/api/command_proxy_" + this.viewMode;

        var elements = this.form.elements;
        var data = {
            csrf_ticket: grn.data.CSRF_TICKET,
            code: elements["code"].value,
            url: elements["url"].value,
            method: elements["method"].value,
            url_params: JSON.stringify(this.params_table.getTableData()),
            headers: JSON.stringify(this.headers_table.getTableData()),
            body: JSON.stringify(this.body_table.getTableData()),
            status_apply: elements["apply"].checked ? 1 : 0
        };

        if (this.viewMode === "modify") {
            data.id = elements["id"].value;
        }

        var request = new grn.component.ajax.request({
            grnUrl: command_url,
            method: "post",
            data: data
        });

        request.send().done(function (json_obj) {
            if (json_obj.success) {
                location.href = json_obj.redirect_url;
            }
        });
    };

    G.validate = function () {
        var validators = new Validator(this.form, this.formErrorMessage);

        validators.clearErrorMessage();

        validators.addValidator(new Validator.TextLengthLongerThan(
            "code", i18n.cbMsg("grn.system.api", "proxy_field_proxy_id_required"), 0));
        validators.addValidator(new Validator.TextLengthLongerThan(
            "url", i18n.cbMsg("grn.system.api", "proxy_field_url_required"), 0));

        return validators.validateAll();
    };

})(jQuery);
