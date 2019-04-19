grn.base.namespace("grn.component.KeyValueEditableTable");

(function ($) {
    "use strict";

    grn.component.KeyValueEditableTable = (function () {
        var api = {};

        /**
         *
         * @param container
         * @param options
         * @private
         */
        api._construct = function (container, options) {
            var default_options = {};
            default_options.TEMPLATES = {
                ROW: "<tr class='js_row_item'>" +
                "   <td>" +
                "       <input class='input_text_grn js_key' type='text' style='width:350px;'>" +
                "   </td>" +
                "   <td>" +
                "       <input class='input_text_grn js_value' type='text' style='width:160px;'>" +
                "   </td>" +
                "   <td class='move_list_action_grn js_row_action'>" +
                "       <span class='mRight5 js_add_row'>" +
                "           <a href='javascript:void(0)' title='{{resource_GRN_SY_AP_109}}' class='action_base_grn' " +
                "aria-label='{{resource_GRN_SY_AP_109}}'>" +
                "               <span class='icon_add_grn icon_only_grn'></span>" +
                "           </a>" +
                "       </span>" +
                "       <span class='js_delete_row'>" +
                "           <a class='action_base_grn' title='{{resource_GRN_SY_AP_110}}'  href='javascript:void(0)' " +
                "aria-label='{{resource_GRN_SY_AP_110}}'>" +
                "               <span class='icon-delete-grn icon_only_grn'></span>" +
                "           </a>" +
                "       </span>" +
                "   </td>" +
                "</tr>",

                HEAD: "<tr class='js_row_header'>" +
                "    <th>{{key}}</th>" +
                "    <th>{{value}}</th>" +
                "    <th class='move_list_action_grn js_row_action'></th>" +
                "</tr>"
            };

            default_options.JS_RESOURCES = {
                COLUMN_KEY: grn.component.i18n.cbMsg("grn", "column_key"),
                COLUMN_VALUE: grn.component.i18n.cbMsg("grn", "column_value")
            };

            default_options.SELECTOR = {
                COLUMN_KEY: ".js_key",
                COLUMN_VALUE: ".js_value"
            };

            this.options = $.extend(true, {}, default_options, options);

            this._super._construct.call(this, container, this.options);
        };

        /**
         *
         * @param data
         */
        api.render = function (data) {
            this.$container.empty();
            this.$container.append(this._renderTable(data));
            this._bindEvents();
        };

        /**
         *
         * @param data
         * @returns {HTMLElement}
         * @private
         */
        api._renderTable = function (data) {
            var $table = this._super._renderTable.call(this, data);
            $table.addClass("list_column");
            return $table;
        };

        api._renderHead = function () {
            var $row = this._super._renderHead.call(this);
            var $columns = $row.find("th");
            $columns[0].textContent = this.options.JS_RESOURCES.COLUMN_KEY;
            $columns[1].textContent = this.options.JS_RESOURCES.COLUMN_VALUE;

            return $row;
        };

        /**
         *
         * @param data
         * @returns {HTMLElement}
         * @private
         */
        api._renderRow = function (data) {
            var $row = this._super._renderRow.call(this, data);

            var $key = $row.find(this.selector.COLUMN_KEY);
            var $value = $row.find(this.selector.COLUMN_VALUE);

            if (typeof data !== "undefined") {
                $key.val(data.key);
                $value.val(data.value);
            }

            return $row;
        };

        api._renderRowForEmptyList = function () {
            var $row = this._super._renderRowForEmptyList.call(this);
            $row.find("td:first").attr("colspan", 2);
            return $row;
        };

        /**
         *
         * @param $row
         * @returns {Object}
         * @private
         */
        api._getRowData = function ($row) {
            var data = {};
            data.key = $row.find(this.selector.COLUMN_KEY).val();
            data.value = $row.find(this.selector.COLUMN_VALUE).val();

            return data;
        };

        return grn.base.extendClass(grn.component.EditableTable, 'KeyValueEditableTable', api);
    })();

})(jQuery);