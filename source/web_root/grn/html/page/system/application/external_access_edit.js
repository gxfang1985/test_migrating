/* global JSON */
if (!grn.base.isNamespaceDefined("grn.page.system.application.external_access_edit")) {
    (function ($) {
        "use strict";

        grn.base.namespace("grn.page.system.application.external_access_edit");

        var external_access_edit = grn.page.system.application.external_access_edit;

        var CONST = {
            NOT_USE: "0",
            USE_RSM: "1",
            USE_INTERNAL_ADDRESS: "2",
            INTERNAL_IP_ADDRESS_LIST: "system/application/ajax/get_internal_address_list",
            EXTERNAL_ACCESS_EDIT: "system/application/ajax/command_external_access_edit",
            DETAIL_PAGE: "system/application/external_access_detail",
            CONFIRM_PAGE: "system/application/external_access_edit_confirm"
        };

        external_access_edit.init = function () {
            var self = this;

            this.internalAddressView = new InternalAddressView("#internal_address");
            this.css_class = this.internalAddressView.options.CSS_CLASS;
            this.selector = this.internalAddressView.options.SELECTOR;

            this.$container = this.internalAddressView.$container;
            this.$parent_container = this.$container.closest("table");

            this.setting = this.$parent_container.find(this.selector.RADIO_CHECKED).val();
            this.backPage = grn.component.url.page(CONST.DETAIL_PAGE);

            this.fetchSetting().done(function (response) {
                var setting = self.isEnable(self.setting);
                self.internalAddressView.render(response.ip_list, setting);
            });

            this.bindEvents();
        };

        var InternalAddressView = (function () {

            var api = {};

            api._construct = function (container) {

                var options = {};
                options.TEMPLATES = {

                    TITLE: "<div class='sub_explanation js_sub_title'>{{resource_GRN_SY_AP_89}}</div>",

                    HEAD_EXTEND: "<th style='min-width:5px; width: 5px;'>/</th>" +
                    "<th style='min-width:5px; width: 5px;'>{{resource_GRN_SY_AP_77}}</th>" +
                    "<th>{{resource_GRN_SY_AP_78}}</th>",

                    ROW_EXTEND: "<td>/</td>" +
                    "<td><input maxlength='3' class='input_text_grn js_column_cidr' name='colName' type='text' style='width:40px;'></td>" +
                    "<td><input class='input_text_grn js_column_memo' name='colName' type='text' style='width:350px;'></td>",

                    REQUIRED_MESSAGE: "<div class='attentionMessage-grn js_required_message'></div>"
                };

                options.JS_RESOURCES = {
                    COLUMN_CIDR: grn.component.i18n.cbMsg("grn.system.application", "GRN_SY_AP-77"),
                    COLUMN_MEMO: grn.component.i18n.cbMsg("grn.system.application", "GRN_SY_AP-78"),
                    COLUMN_TITLE: grn.component.i18n.cbMsg("grn.system.application", "GRN_SY_AP-89")
                };

                options.SELECTOR = {
                    ROWS_SUBMIT: ".js_rows_submit",
                    COLUMN_CIDR: ".js_column_cidr",
                    COLUMN_MEMO: ".js_column_memo",
                    REQUIRED_MESSAGE: ".js_required_message",
                    SUB_TITLE: ".js_sub_title",
                    RADIO_CHECKED: "input[type='radio']:checked",
                    RADIO_CHECK: ".js_radio_check"
                };

                options.CSS_CLASS = {
                    LIST_COLUMN: "list_column"
                };

                options.NUMBER_ROW_LIMIT = 500;

                this._super._construct.call(this, container, options);
            };

            api.render = function (data, setting) {
                var ipList = data;
                var dataRow = [];
                for (var index in ipList) {
                    if (ipList.hasOwnProperty(index)) {
                        var row = ipList[index];
                        var ipSetting = {};
                        ipSetting.selected = false;
                        ipSetting.subject = row.ip_address;
                        ipSetting.cidr = row.cidr;
                        ipSetting.memo = row.memo;
                        dataRow.push(ipSetting);
                    }
                }

                this._super.render.call(this, dataRow);

                this._renderTitle();

                this.enable(setting);
            };

            api._renderHead = function () {
                var $head = this._super._renderHead.call(this);
                var resources = {
                    "{{resource_GRN_SY_AP_76}}": this.options.JS_RESOURCES.COLUMN_SUBJECT,
                    "{{resource_GRN_SY_AP_77}}": this.options.JS_RESOURCES.COLUMN_CIDR,
                    "{{resource_GRN_SY_AP_78}}": this.options.JS_RESOURCES.COLUMN_MEMO
                };
                var self = this;
                var head_extend = this._super.translateResource.call(this, self.options.TEMPLATES.HEAD_EXTEND, resources);
                $head.find(this.selector.ROW_ACTION).before($(head_extend));

                return $head;
            };

            api._renderRow = function (data) {
                var $row = this._super._renderRow.call(this, data);
                $row.find(this.selector.ROW_ACTION).before($(this.options.TEMPLATES.ROW_EXTEND));

                if (typeof data !== "undefined") {
                    $row.find(this.selector.COLUMN_CIDR).val(data.cidr);
                    $row.find(this.selector.COLUMN_MEMO).val(data.memo);
                }

                return $row;
            };

            api._renderTable = function (data) {
                var $table = this._super._renderTable.call(this, data);
                $table.addClass(this.css_class.LIST_COLUMN);
                $table.css({"width": "auto", "min-width": "500px"});

                return $table;
            };

            api.enable = function (enable) {
                var action = this._super.enable.call(this, enable);
                this.$container.find(this.selector.SUB_TITLE)[action](this.css_class.DISABLE_FILTER_GRN);
            };

            api._getRowData = function ($row) {
                var data = this._super._getRowData.call(this, $row);
                data.cidr = $row.find(this.selector.COLUMN_CIDR).val();
                data.memo = $row.find(this.selector.COLUMN_MEMO).val();

                return data;
            };

            api._renderTitle = function () {
                var resources = {
                    "{{resource_GRN_SY_AP_89}}": this.options.JS_RESOURCES.COLUMN_TITLE
                };
                var self = this;
                var title = this._super.translateResource.call(this, self.options.TEMPLATES.TITLE, resources);

                return this.$container.prepend($(title));
            };

            return grn.base.extendClass(grn.component.EditableTable, 'InternalAddressView', api);
        })();

        external_access_edit.isEnable = function (settingValue) {
            var is_enable = true;
            if (settingValue === CONST.NOT_USE || settingValue === CONST.USE_RSM) {
                is_enable = false;
            } else if (settingValue === CONST.USE_INTERNAL_ADDRESS) {
                is_enable = true;
            }

            return is_enable;
        };

        external_access_edit.bindEvents = function () {
            this.$parent_container.find(this.selector.RADIO_CHECK)
                .on("change", $.proxy(this.handleSettingChange, this));
            this.$parent_container.find(this.selector.ROWS_SUBMIT).on("click", $.proxy(this.handleSave, this));
        };

        external_access_edit.handleSettingChange = function (e) {
            var settingValue = $(e.target).val();
            var enable = this.isEnable(settingValue);
            this.internalAddressView.enable(enable);
        };

        external_access_edit.fetchSetting = function () {
            var request;
            request = new grn.component.ajax.request({
                grnUrl: CONST.INTERNAL_IP_ADDRESS_LIST,
                method: "post"
            });
            return request.send();
        };

        external_access_edit.handleSave = function () {
            var self = this;

            var setting_value = this.$parent_container.find(this.selector.RADIO_CHECKED).val();
            if ((this.setting === CONST.USE_INTERNAL_ADDRESS || this.setting === CONST.USE_RSM) &&
                setting_value === CONST.NOT_USE) {
                window.location.href = grn.component.url.page(CONST.CONFIRM_PAGE);
                return;
            }

            var ip_list = {};
            if (setting_value === CONST.USE_INTERNAL_ADDRESS) {
                ip_list = this.internalAddressView.getTableData();
            }

            this.saveSetting(setting_value, ip_list)
                .done(
                    function (data) {
                        if (data.success === false) {
                            self.showValidationError(data.message);
                            grn.component.button(self.selector.ROWS_SUBMIT).hideSpinner();
                            return;
                        }
                        window.location.href = self.backPage;
                    }
                );
        };

        external_access_edit.saveSetting = function (setting_value, ip_list) {
            var request;

            request = new grn.component.ajax.request({
                grnUrl: CONST.EXTERNAL_ACCESS_EDIT,
                method: "post",
                data: {
                    setting: setting_value,
                    ip_list: JSON.stringify(ip_list),
                    csrf_ticket: grn.data.CSRF_TICKET
                }
            });

            return request.send();
        };

        external_access_edit.showValidationError = function(message){
            var $required_message = this.$container.find(this.selector.REQUIRED_MESSAGE);
            if ($required_message.length > 0) {
                $required_message.remove();
            }
            var rows = $(this.selector.ROW_ITEM);
            for (var item in message) {
                if (message.hasOwnProperty(item)) {
                    $(rows[item]).find(this.selector.COLUMN_SUBJECT)
                        .before(this.internalAddressView.options.TEMPLATES.REQUIRED_MESSAGE);
                    $(rows[item]).find(this.selector.REQUIRED_MESSAGE).html(message[item]);
                }
            }
        };

        $(document).ready(function () {
            grn.page.system.application.external_access_edit.init();
        });
    })(jQuery);
}


