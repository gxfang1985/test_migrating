/* global _getSizeString */
(function ($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.page.customization.group_view")) {
        return;
    }
    grn.base.namespace("grn.page.customization.group_view");

    var group_view = grn.page.customization.group_view;

    var ResourceView = (function () {
        var api = {};

        /**
         * @param {string} container_id
         * @private
         */
        api._construct = function (container_id) {
            this.TEMPLATES = {
                FILE_ROW: "<tr>" +
                "   <td>" +
                "<img src='" + grn.component.url.image("cybozu/disk20.gif") + "' border='0'>" +
                "       <a class='js_subject mRight15'></a>" +
                "       <span class='text_color_sub_grn nowrap-grn'></span>" +
                "   </td>" +
                "</tr>",

                URL_ROW: "<tr>" +
                "   <td>" +
                "       <a class='js_subject mRight15'></a>" +
                "   </td>" +
                "</tr>",

                HEAD: "<tr>" +
                "    <th nowrap=''>{{resource_GRN_SY_AP_76}}</th>" +
                "</tr>"
            };

            this.JS_RESOURCES = {
                COLUMN_SUBJECT: grn.component.i18n.cbMsg("grn.system.application", "GRN_SY_AP-114")
            };

            this.$container = $(container_id);
        };

        /**
         * @param {Object} data
         */
        api.render = function (data) {
            var dataRows = [];
            data.forEach(function (row) {
                var dataRow = {};
                dataRow.id = row._id;
                if (row.file_name) {
                    dataRow.fileName = row.file_name;
                    dataRow.resourceUrl = row.file_url;
                    dataRow.fileSize = row.file_size;
                } else {
                    dataRow.colUrl = row.col_url;
                    dataRow.resourceUrl = row.col_url;
                }
                dataRows.push(dataRow);
            });

            this.$container.empty();

            this.$container.append(this._renderTable(dataRows));
        };

        /**
         * @param {Object} data
         * @returns {jQuery}
         * @private
         */
        api._renderRow = function (data) {
            var $row;

            if (data.fileName) {
                $row = $(this.TEMPLATES.FILE_ROW);
                $row.find('.js_subject').text(data.fileName);
                $row.find('.text_color_sub_grn').text(_getSizeString(data.fileSize));
            } else {
                $row = $(this.TEMPLATES.URL_ROW);
                $row.find('.js_subject').text(data.colUrl);
            }

            $row.find('.js_subject').attr('href', data.resourceUrl).attr('target', '_blank');

            return $row;
        };

        /**
         *
         * @param {Object} data
         * @returns {jQuery}
         * @private
         */
        api._renderTable = function (data) {
            var self = this;

            if (typeof data !== "undefined" && data.length > 0) {
                var $table = $('<table></table>');
                $table.append(this._renderHead());
                data.forEach(function (dataRow) {
                    $table.append(self._renderRow(dataRow));
                });
                $table.addClass("list_column");
            }
            return $table;
        };

        api._renderHead = function () {
            var resources = {
                "{{resource_GRN_SY_AP_76}}": this.JS_RESOURCES.COLUMN_SUBJECT
            };
            return $(this._translateResource(this.TEMPLATES.HEAD, resources));
        };

        /**
         * @param {string} html_string
         * @param {Object.<string, string>} expression_list
         * @returns {string}
         * @private
         */
        api._translateResource = function (html_string, expression_list) {
            var result = html_string;

            for (var exp in expression_list) {
                if (expression_list.hasOwnProperty(exp)) {
                    result = result.replace(new RegExp(exp, "g"), expression_list[exp]);
                }
            }

            return result;
        };

        return grn.base.extendClass(Object, 'resourceView', api);
    })();

    /**
     * @param data
     */
    group_view.init = function (data) {
        this.jsView = new ResourceView("#js");
        this.cssView = new ResourceView("#css");

        this.jsView.render(data.resourceJS);
        this.cssView.render(data.resourceCSS);
    };

})(jQuery);

