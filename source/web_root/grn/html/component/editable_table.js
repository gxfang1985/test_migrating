(function ($) {
    "use strict";

    if (grn.base.isNamespaceDefined("grn.component.EditableTable")) {
        return;
    }

    var DEFAULT_OPTIONS = {};

    DEFAULT_OPTIONS.TEMPLATES = {
        BUTTON_GROUP: "<div class='list_menu'>" +
        "   <span class='small_button_base_grn mRight10 js_checkbox_all'>" +
        "       <span class='aButtonStandard-grn'>" +
        "           <a href='javascript:void(0);' title='{{resource_GRN_SY_AP_96}}' aria-label='{{resource_GRN_SY_AP_96}}' >" +
        "               <span class='listcheck_button_grn'>" +
        "               </span>" +
        "           </a>" +
        "       </span>" +
        "   </span>" +
        "   <span class='aButtonStandard-grn mRight10 js_move_row_up ' aria-disabled='true'>" +
        "       <a class='button_min_width1_grn' href='javascript:void(0);'>" +
        "           <span>{{resource_GRN_SY_AP_90}}</span>" +
        "       </a>" +
        "   </span>" +
        "   <span class='aButtonStandard-grn js_move_row_down '  aria-disabled='true'>" +
        "       <a class='button_min_width1_grn' href='javascript:void(0);'>" +
        "           <span>{{resource_GRN_SY_AP_91}}</span>" +
        "       </a>" +
        "   </span>" +
        "</div>",

        HEAD: "<tr>" +
        "   <th style='min-width:5px; width: 5px;'></th>" +
        "   <th>{{resource_GRN_SY_AP_76}}" +
        "       <span class='attention'>*</span>" +
        "   </th>" +
        "   <th class='move_list_action_grn js_row_action'></th>" +
        "</tr>",

        ROW: "<tr class='js_row_item'>" +
        "   <td>" +
        "      <input name='selected' class='js_row_checkbox' type='checkbox'>" +
        "   </td>" +
        "   <td>" +
        "       <input  maxlength='50' class='input_text_grn js_subject' name='colName' type='text' style='width:120px;'>" +
        "   </td>" +
        "   <td class='move_list_action_grn js_row_action'>" +
        "       <span class='mRight5 js_add_row'>" +
        "           <a href='javascript:void(0)' title='{{resource_GRN_SY_AP_109}}' class='action_base_grn'" +
        "aria-label='{{resource_GRN_SY_AP_109}}'>" +
        "               <span class='icon_add_grn icon_only_grn'></span>" +
        "           </a>" +
        "       </span>" +
        "       <span class='js_delete_row'>" +
        "           <a class='action_base_grn' title='{{resource_GRN_SY_AP_110}}'  href='javascript:void(0)'" +"" +
        "aria-label='{{resource_GRN_SY_AP_110}}'>" +
        "               <span class='icon-delete-grn icon_only_grn'></span>" +
        "           </a>" +
        "       </span>" +
        "   </td>" +
        "</tr>",

        EMPTY_MESSAGE: "<tr class='js_empty_message'>" +
        "   <td colspan='5'>" +
        "     <div style='width: 350px;' class='list_message_grn'>" +
        "           <div class='list_message_balloon_grn list_message_balloon_action_grn'>" +
        "               <span class='bold_grn'>{{resource_GRN_SY_AP_94}}</span>" +
        "               <div class='mTop7'>" +
        "                   <a href='javascript:void(0)' class='js_add_row'>" +
        "                       <span class='icon_add_grn'></span>{{resource_GRN_SY_AP_95}}" +
        "                   </a>" +
        "               </div>" +
        "           </div>" +
        "       <div class='balloon_arrow_down_grn'></div>" +
        "       <div class='list_message_icon_grn'>" +
        "           <span class='message_middle_icon_size_grn information_message_middle_icon_grn'></span>" +
        "       </div>" +
        "    </div>" +
        "   </td>" +
        "   <td class='move_list_action_grn'></td>" +
        "</tr>"
    };

    DEFAULT_OPTIONS.SELECTOR = {
        COLUMN_SUBJECT: ".js_subject",
        BUTTON_MOVE_ROW_UP: ".js_move_row_up",
        BUTTON_MOVE_ROW_DOWN: ".js_move_row_down",
        BUTTON_DELETE_ROW: ".js_delete_row",
        BUTTON_ADD_ROW: ".js_add_row",
        ROW_ITEM: ".js_row_item",
        EMPTY_MESSAGE: ".js_empty_message",
        ROW_CHECKBOX: ".js_row_checkbox",
        CHECKBOX_ALL: ".js_checkbox_all",
        ROW_HIGHLIGHT: ".row_highlight",
        ROW_CHECKED: "input[type='checkbox']:checked",
        ROW_ACTION: ".js_row_action"
    };

    DEFAULT_OPTIONS.CSS_CLASS = {
        ACTION_BASE_DISABLE_GRN: "action_base_disable_grn",
        BUTTON_DISABLE_FILTER_GRN: "button_disable_filter_grn",
        DISABLE_FILTER_GRN: "disable_filter_grn",
        ROW_HIGHLIGHT: "row_highlight"
    };

    DEFAULT_OPTIONS.JS_RESOURCES = {
        DELETE: grn.component.i18n.cbMsg("grn.system.application", "GRN_SY_AP-110"),
        ADD: grn.component.i18n.cbMsg("grn.system.application", 'GRN_SY_AP-109'),
        EMPTY_MESSAGE: grn.component.i18n.cbMsg("grn.system.application", "GRN_SY_AP-94"),
        EMPTY_MESSAGE_LINK: grn.component.i18n.cbMsg("grn.system.application", "GRN_SY_AP-95"),
        UP: grn.component.i18n.cbMsg("grn.system.application", "GRN_SY_AP-90"),
        DOWN: grn.component.i18n.cbMsg("grn.system.application", "GRN_SY_AP-91"),
        COLUMN_SUBJECT: grn.component.i18n.cbMsg("grn.system.application", "GRN_SY_AP-76"),
        SELECT_ALL: grn.component.i18n.cbMsg("grn.system.application", "GRN_SY_AP-96")
    };

    DEFAULT_OPTIONS.NUMBER_ROW_LIMIT = 0;//unlimited
    DEFAULT_OPTIONS.displayAddItemButtonForEmptyList = true;

    function EditableTable(container, options) {
        this._construct(container, options);
    }

    EditableTable.prototype._construct = function (container, options) {

        this.options = $.extend(true, {}, DEFAULT_OPTIONS, options);

        this.selector = this.options.SELECTOR;
        this.css_class = this.options.CSS_CLASS;
        this.js_resources = this.options.JS_RESOURCES;

        this.$container = $(container);
    };

    EditableTable.prototype.render = function (data) {
        this.$container.empty();
        this.$container.append(this._renderButtonGroup());
        this.$container.append(this._renderTable(data));
        this.$container.append(this._renderButtonGroup());

        this._bindEvents();
    };

    EditableTable.prototype._renderButtonGroup = function () {
        var resources = {
            "{{resource_GRN_SY_AP_90}}": this.js_resources.UP,
            "{{resource_GRN_SY_AP_91}}": this.js_resources.DOWN,
            "{{resource_GRN_SY_AP_96}}": this.js_resources.SELECT_ALL
        };
        return $(this.translateResource(this.options.TEMPLATES.BUTTON_GROUP.replace(/(>)\s*(<)/g, '$1$2'), resources));
    };

    EditableTable.prototype._renderTable = function (data) {
        var self = this;
        var $table = $('<table></table>');
        $table.append(this._renderHead());

        if (typeof data !== "undefined" && data.length > 0) {
            data.forEach(function (dataRow) {
                $table.append(self._renderRow(dataRow));
            });
        } else {
            $table.append(self._renderRow());
        }

        return $table;
    };

    EditableTable.prototype.translateResource = function (htmlString, expressionList) {
        var result = htmlString;

        for (var exp in expressionList) {
            if (expressionList.hasOwnProperty(exp)) {
                result = result.replace(new RegExp(exp, "g"), expressionList[exp]);
            }
        }

        return result;
    };

    EditableTable.prototype._renderHead = function () {
        var resources = {
            "{{resource_GRN_SY_AP_76}}": this.js_resources.COLUMN_SUBJECT
        };
        return $(this.translateResource(this.options.TEMPLATES.HEAD, resources));
    };

    EditableTable.prototype._renderRowForEmptyList = function () {
        var resources = {
            "{{resource_GRN_SY_AP_94}}": this.js_resources.EMPTY_MESSAGE,
            "{{resource_GRN_SY_AP_95}}": this.js_resources.EMPTY_MESSAGE_LINK
        };
        return $(this.translateResource(this.options.TEMPLATES.EMPTY_MESSAGE, resources));
    };

    EditableTable.prototype._renderRow = function (data) {
        var resources = {
            "{{resource_GRN_SY_AP_109}}": this.js_resources.ADD,
            "{{resource_GRN_SY_AP_110}}": this.js_resources.DELETE
        };
        var $row = $(this.translateResource(this.options.TEMPLATES.ROW.replace(/(>)\s*(<)/g, '$1$2'), resources));
        if (typeof data !== "undefined") {
            $row.find(this.selector.ROW_CHECKBOX).attr('checked', data.selected);
            $row.find(this.selector.COLUMN_SUBJECT).val(data.subject);
        }

        return $row;
    };

    EditableTable.prototype.getTableData = function () {
        var self = this;
        var data = {};
        this.$container
            .find(this.selector.ROW_ITEM)
            .each(function (index, row) {
                data[index] = self._getRowData($(row));
            });

        return data;
    };

    EditableTable.prototype._getRowData = function ($row) {
        return {
            selected: $row.find(this.selector.ROW_CHECKBOX).prop("checked"),
            subject: $row.find(this.selector.COLUMN_SUBJECT).val()
        };
    };

    EditableTable.prototype.getRowCount = function () {
        var row_number = 0;
        var $rows = this.$container.find(this.selector.ROW_ITEM);
        if ($rows.length > 0) {
            row_number = $rows.length;
        }
        return row_number;
    };

    EditableTable.prototype._bindEvents = function () {
        this.$container.on("click", this.selector.ROW_CHECKBOX, $.proxy(this.handleSelectedRow, this));
        this.$container.on("click", this.selector.BUTTON_ADD_ROW, $.proxy(this.handleAddNew, this));
        this.$container.on("click", this.selector.BUTTON_DELETE_ROW, $.proxy(this.handleRemoveRow, this));
        this.$container.on("click", this.selector.CHECKBOX_ALL, $.proxy(this.handleCheckUncheckedAll, this));
        this.$container.on("click", this.selector.BUTTON_MOVE_ROW_UP, $.proxy(this._moveUpRow, this));
        this.$container.on("click", this.selector.BUTTON_MOVE_ROW_DOWN, $.proxy(this._moveDownRow, this));
    };

    EditableTable.prototype._moveUpRow = function () {
        var target = this.$container.find(this.selector.BUTTON_MOVE_ROW_UP);
        if (target.hasClass(this.css_class.BUTTON_DISABLE_FILTER_GRN)) {
            return;
        }

        var self = this;
        var $rowPrev;
        var $rows = $(this.$container)
            .find(this.selector.ROW_CHECKED)
            .closest(this.selector.ROW_ITEM);
        var preventMove = false;

        $rows.find("td").addClass(this.css_class.ROW_HIGHLIGHT);
        $rows.find("td:last-child").removeClass(this.css_class.ROW_HIGHLIGHT);

        $.each($rows, function (index, row) {
            $rowPrev = $(row).prev();
            if (!$rowPrev.hasClass(self.selector.ROW_ITEM.substr(1))) {
                preventMove = true;
                return;
            }

            if (!preventMove) {
                $(row).insertBefore($rowPrev);
            }
        });
    };

    EditableTable.prototype._moveDownRow = function () {
        var target = this.$container.find(this.selector.BUTTON_MOVE_ROW_DOWN);
        if (target.hasClass(this.css_class.BUTTON_DISABLE_FILTER_GRN)) {
            return;
        }

        var $rows = $(this.$container)
            .find("input:checked")
            .closest(this.selector.ROW_ITEM);

        $rows.find("td").addClass(this.css_class.ROW_HIGHLIGHT);
        $rows.find("td:last-child").removeClass(this.css_class.ROW_HIGHLIGHT);
        var $rowNext;
        var preventMove = false;
        var $row;

        for (var i = $rows.length - 1; i > -1; i--) {
            $row = $($rows[i]);
            $rowNext = $row.next();

            if ($rowNext.length < 1) {
                preventMove = true;
                return;
            }

            if (!preventMove) {
                $row.insertAfter($rowNext);
            }
        }

    };

    EditableTable.prototype.handleRemoveRow = function (e) {
        var self = this;
        var target = $(e.target);
        if (target.closest(this.selector.BUTTON_DELETE_ROW).hasClass(this.css_class.ACTION_BASE_DISABLE_GRN)) {
            return;
        }

        $(e.currentTarget).closest("tr").fadeOut("slow", function () {
            var $prev = $(this).prev();
            var $rowData = $prev.parent().find(self.selector.ROW_ITEM + ":visible");
            if ($rowData.length < 1 && self.options.displayAddItemButtonForEmptyList) {
                var $emptyRow = $(self._renderRowForEmptyList());
                $(this).before($emptyRow);
            }
            $(this).remove();

            self.enableUpDownButton(true);

        });

        if (this.options.NUMBER_ROW_LIMIT > 0 && this.getRowCount() <= this.options.NUMBER_ROW_LIMIT) {
            this.$container.find(this.selector.BUTTON_ADD_ROW).removeClass(this.css_class.ACTION_BASE_DISABLE_GRN);
        }
    };

    EditableTable.prototype.handleAddNew = function (e) {
        var target = $(e.target);
        if (target.closest(this.selector.BUTTON_ADD_ROW).hasClass(this.css_class.ACTION_BASE_DISABLE_GRN)) {
            return;
        }

        var $emptyMessage = this.$container.find(this.selector.EMPTY_MESSAGE);
        if ($emptyMessage.length !== 0) {
            $emptyMessage.prev().after(this._renderRow());
            this.$container.find(this.selector.EMPTY_MESSAGE).remove();
        } else {
            $(e.currentTarget).closest("tr").after(this._renderRow());
        }

        if (this.options.NUMBER_ROW_LIMIT > 0 && this.getRowCount() >= this.options.NUMBER_ROW_LIMIT) {
            this.$container.find(this.selector.BUTTON_ADD_ROW).addClass(this.css_class.ACTION_BASE_DISABLE_GRN);
        }
    };

    EditableTable.prototype.handleEnableMoveButton = function () {
        var target = this.$container.find(this.selector.CHECKBOX_ALL);
        if (target.hasClass(this.css_class.ACTION_BASE_DISABLE_GRN)) {
            return;
        }

        this.enableUpDownButton(true);
    };

    EditableTable.prototype.handleSelectedRow = function (e) {
        var target = this.$container.find(this.selector.ROW_CHECKBOX);
        if (target.hasClass(this.css_class.ACTION_BASE_DISABLE_GRN)) {
            return;
        }

        this.handleEnableMoveButton();

        var $row = $(e.currentTarget).closest("tr");
        $row.find("td").toggleClass(this.css_class.ROW_HIGHLIGHT);
        $row.find("td:last-child").removeClass(this.css_class.ROW_HIGHLIGHT);
    };

    EditableTable.prototype.handleCheckUncheckedAll = function () {

        var target = this.$container.find(this.selector.CHECKBOX_ALL);
        if (target.hasClass(this.css_class.BUTTON_DISABLE_FILTER_GRN)) {
            return;
        }

        var list = this.$container.find(this.selector.ROW_CHECKBOX);
        var listSelected = this.$container.find(this.selector.ROW_CHECKED);

        if (list.length < 1) {
            return;
        }

        if (listSelected.length === list.length) {
            listSelected.prop("checked", false);
            this.$container.find(this.selector.BUTTON_MOVE_ROW_UP).addClass(this.css_class.BUTTON_DISABLE_FILTER_GRN);
            this.$container.find(this.selector.BUTTON_MOVE_ROW_DOWN).addClass(this.css_class.BUTTON_DISABLE_FILTER_GRN);
            this.$container.find(this.selector.ROW_HIGHLIGHT)
                .removeClass(this.css_class.ROW_HIGHLIGHT);
        } else {
            list.prop("checked", true);
            this.$container.find(this.selector.BUTTON_MOVE_ROW_UP).removeClass(this.css_class.BUTTON_DISABLE_FILTER_GRN);
            this.$container.find(this.selector.BUTTON_MOVE_ROW_DOWN).removeClass(this.css_class.BUTTON_DISABLE_FILTER_GRN);
            var $rows = this.$container.find(this.selector.ROW_ITEM);
            $rows.find("td").removeClass(this.css_class.ROW_HIGHLIGHT);
            $rows.find("td").toggleClass(this.css_class.ROW_HIGHLIGHT);
            $rows.find("td:last-child").removeClass(this.css_class.ROW_HIGHLIGHT);
        }
    };

    EditableTable.prototype.enable = function (enable) {

        var action = enable ? 'removeClass' : 'addClass';

        this.$container.find("table")[action](this.css_class.DISABLE_FILTER_GRN);
        this.$container.find(this.selector.CHECKBOX_ALL)[action](this.css_class.BUTTON_DISABLE_FILTER_GRN);
        this.$container.find(this.selector.DISABLE_FILTER_GRN)[action](this.css_class.DISABLE_FILTER_GRN);
        this.$container.find(this.selector.BUTTON_ADD_ROW)[action](this.css_class.ACTION_BASE_DISABLE_GRN);
        this.$container.find(this.selector.BUTTON_DELETE_ROW)[action](this.css_class.ACTION_BASE_DISABLE_GRN);
        this.$container.find("input[type=text]").prop("disabled", !enable);
        this.$container.find(this.selector.ROW_CHECKBOX).prop("disabled", !enable);

        this.showTooltip(enable);
        this.enableUpDownButton(enable);

        if (this.options.NUMBER_ROW_LIMIT > 0 && this.getRowCount() >= this.options.NUMBER_ROW_LIMIT){
            this.$container.find(this.selector.BUTTON_ADD_ROW).addClass(this.css_class.ACTION_BASE_DISABLE_GRN);
        }

        return action;
    };

    EditableTable.prototype.enableUpDownButton = function (enable) {
        var action = "addClass";
        var $buttons = this.$container.find(this.selector.BUTTON_MOVE_ROW_UP + ", " + this.selector.BUTTON_MOVE_ROW_DOWN);

        if (enable) {
            var selector = this.selector.ROW_CHECKBOX + ":checked";
            var selected_rows = this.$container.find(selector);

            if (selected_rows.length > 0) {
                action = "removeClass";
                $buttons.removeAttr("aria-disabled");
            } else {
                $buttons.attr("aria-disabled", "true");
            }
        } else {
            $buttons.attr("aria-disabled", "true");
        }

        $buttons[action](this.css_class.BUTTON_DISABLE_FILTER_GRN);
    };

    EditableTable.prototype.showTooltip = function (enable) {
        if (!enable) {
            this.$container.find(this.selector.CHECKBOX_ALL)
                .find("a").removeAttr('title');
            this.$container.find(this.selector.BUTTON_ADD_ROW).removeAttr('title')
                .find("a").removeAttr('title');
            this.$container.find(this.selector.BUTTON_DELETE_ROW).removeAttr('title')
                .find("a").removeAttr('title');
        } else {
            this.$container.find(this.selector.CHECKBOX_ALL)
                .find("a").attr('title', this.js_resources.SELECT_ALL);
            this.$container.find(this.selector.BUTTON_ADD_ROW).attr('title', this.js_resources.ADD)
                .find("a").attr('title', this.js_resources.ADD);
            this.$container.find(this.selector.BUTTON_DELETE_ROW).attr('title', this.js_resources.DELETE)
                .find("a").attr('title', this.js_resources.DELETE);
        }
    };

    grn.base.namespace("grn.component.EditableTable");
    grn.component.EditableTable = EditableTable;

})(jQuery);

