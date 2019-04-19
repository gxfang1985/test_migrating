/* global JSON */

(function ($) {
    "use strict";

    grn.base.namespace("grn.page.space.folder_setting");

    var G = grn.page.space.folder_setting;

    G.options = {
        url: "space/application/ajax/folder_setting",
        urlSubmit: "space/application/ajax/command_folder_setting",
        useSpinner: false
    };

    G.htmlTemplate =
    {
        rowAddTemplate: "<tr class='js_rows_data'>" +
        "   <td>" +
        "      <input type='checkbox' class='js_folder_selected' name='selected' />" +
        "   </td>" +
        "   <td>" +
        "       <input name='FolderName' type='text' class='input_text_grn js_folder_name' size='50' maxlength='100'/>" +
        "   </td>" +
        "   <td class='move_list_action_grn'>" +
        "       <span class='mRight5'>" +
        "           <a href='javascript:void(0)' class='action_base_grn js_row_add'>" +
        "               <span class='icon_add_grn icon_only_grn'></span>" +
        "           </a>" +
        "       </span>" +
        "       <span class='js_deletion_row'>" +
        "           <a class='action_base_grn' href='javascript:void(0)'>" +
        "               <span class='icon-delete-grn icon_only_grn'></span>" +
        "           </a>" +
        "       </span>" +
        "   </td>" +
        "</tr>",

        emptyMessage: "<div id='empty_thread_list' class='list_message_grn js_empty_message' style='width: 420px; margin-left: 10px;'>" +
        "   <div class='list_message_balloon_grn list_message_balloon_action_grn'>" +
        "       <span class='bold_grn'>{{resource}}</span>" +
        "       <div class='mTop7'>" +
        "           <a href='javascript:void(0)' class='js_row_add'><span class='icon_add_grn'></span>{{resourceLink}}</a>" +
        "       </div>" +
        "   </div>" +
        "   <div class='balloon_arrow_down_grn'></div>" +
        "   <div class='list_message_icon_grn'>" +
        "       <span class='message_middle_icon_size_grn space_message_middle_icon_grn'></span>" +
        "   </div>" +
        "</div>",

        spinner:
        "<tr class='js_spinner'>" +
        "   <td>" +
        "   </td>" +
        "   <td>" +
        "       <div class='cloudHeader-grnNotification-update-grn' style='background: transparent'>" +
        "           <span class='icon-spinner-grn'>&nbsp;&nbsp;&nbsp;&nbsp;</span>" +
        "       </div>" +
        "   </td>" +
        "   <td class='move_list_action_grn'>" +
        "   </td>" +
        "</tr>"
    };

    G.cssSelectors = {
        container: ".mainarea",
        container_folder_setting: ".js_folder_setting_container",
        folder_name: ".js_folder_name",
        up_row: ".js_up_row",
        down_row: ".js_down_row",
        deletion_row: ".js_deletion_row",
        row_add: ".js_row_add",
        rows_submit: ".js_rows_submit",
        rows_cancel: ".js_rows_cancel",
        app_path: ".js_app_path",
        rows_data: ".js_rows_data",
        empty_message: ".js_empty_message",
        folder_selected: ".js_folder_selected",
        check_unchecked_all: ".js_check_unchecked_all",
        row_highlight: ".row_highlight",
        required_folder_name: ".js_required_folder_name",
        folder_checked: "input[type='checkbox']:checked",
        select_checkbox: "input[type='checkbox']",
        spinner: ".js_spinner",
        folder_deleted: ".js_folder_deleted"
    };

    G.cssClass = {
        disable: "action_base_disable_grn",
        disable_order_button: "button_disable_filter_grn"
    };

    G.KEY_WORDS = {
        TITLE: "title",
        CLICK: "click",
        ID_TO_ADD_NEW: "0",
        SLOW: "slow",
        TD: "td",
        SRC: "src",
        SPACE_PATH: "space/top",
        IS_HIDDEN: ":hidden",
        DATA_ATTR: {
            FOLDER_NAME: "col_folder_name",
            NUMBER_THREAD: "number_thread"
        },
        FOLDER_DATA: "folder_data",
        REQUIRED_FOLDER_NAME: "REQUIRED_FOLDER_NAME",
        UNDEFINED: "undefined",
        CHECKED: "checked",
        SHOW: "show",
        ERROR_CLOSED: "errorClosed",
        EMPTY: ""
    };

    G.JS_RESOURCES = {
        DELETE: grn.component.i18n.cbMsg("grn.space.folder", "GRN_SP_FOLDER-4"),
        ADD_ROW: grn.component.i18n.cbMsg("grn.space.folder", 'GRN_SP_FOLDER-8'),
        EMPTY_MESSAGE: grn.component.i18n.cbMsg("grn.space.folder", "GRN_SP_FOLDER-6"),
        EMPTY_MESSAGE_LINK: grn.component.i18n.cbMsg("grn.space.folder", "GRN_SP_FOLDER-15")
    };

    G.targetAdd = null;

    G.backPage = null;

    G.init = function () {

        this.htmlTemplate.rowAddTemplate = this.htmlTemplate.rowAddTemplate.replace(/>\s+</g, "><");
        this.htmlTemplate.emptyMessage = this.htmlTemplate.emptyMessage.replace(/>\s+</g, "><");
        this.backPage = grn.component.url.page(this.KEY_WORDS.SPACE_PATH, {spid: this.spId});
        G.cacheElements();
        G._bindEvents();
    };

    G.cacheElements = function () {
        this.$container = $(this.cssSelectors.container);
        this.$folderList = this.$container.find(this.cssSelectors.container_folder_setting);
        this.$folderDeleted = this.$container.find(this.cssSelectors.folder_deleted);
    };

    /**
     *
     * @private
     */
    G._bindEvents = function () {
        this.$container.on(this.KEY_WORDS.CLICK, this.cssSelectors.row_add, $.proxy(this.handleClickAddNew, this));
        this.$container.on(this.KEY_WORDS.CLICK, this.cssSelectors.deletion_row, $.proxy(this._removeRow, this));
        this.$container.on(this.KEY_WORDS.CLICK, this.cssSelectors.rows_submit, $.proxy(this.submitRows, this));
        this.$container.on(this.KEY_WORDS.CLICK, this.cssSelectors.rows_cancel, $.proxy(this._cancel, this));
        this.$container
            .off(this.KEY_WORDS.CLICK, this.cssSelectors.up_row)
            .on(this.KEY_WORDS.CLICK, this.cssSelectors.up_row, $.proxy(this._moveUpRow, this));
        this.$container
            .off(this.KEY_WORDS.CLICK, this.cssSelectors.down_row)
            .on(this.KEY_WORDS.CLICK, this.cssSelectors.down_row, $.proxy(this._moveDownRow, this));
        this.$container
            .off(this.KEY_WORDS.CLICK, this.cssSelectors.folder_selected)
            .on(this.KEY_WORDS.CLICK, this.cssSelectors.folder_selected, $.proxy(this.handleSelectedFolder, this));

        this.$container.on(this.KEY_WORDS.CLICK, this.cssSelectors.check_unchecked_all, $.proxy(this.handleCheckUncheckedAll, this));

    };

    /**
     *
     * @private
     */
    G._moveUpRow = function (e) {
        e.preventDefault();

        var self = this;
        var rowPrev;
        var rows = $(this.cssSelectors.container_folder_setting)
            .find(this.cssSelectors.folder_checked)
            .closest(this.cssSelectors.rows_data);
        var preventMove = false;

        rows.find(this.KEY_WORDS.TD + ":lt(2)").addClass(this.cssSelectors.row_highlight.substr(1));

        $.each(rows, function (index, row) {
            rowPrev = $(row).prev();
            if (!rowPrev.hasClass(self.cssSelectors.rows_data.substr(1))) {
                preventMove = true;
                return;
            }

            if (!preventMove) {
                $(row).insertBefore(rowPrev);
            }
        });
    };

    /**
     *
     * @private
     */
    G._moveDownRow = function (e) {
        e.preventDefault();

        var rows = $(this.cssSelectors.container_folder_setting)
            .find("input:checked")
            .closest(this.cssSelectors.rows_data);

        rows.find(this.KEY_WORDS.TD + ":lt(2)").addClass(this.cssSelectors.row_highlight.substr(1));
        var rowNext;
        var preventMove = false;
        var row;

        for (var i = rows.length - 1; i > -1; i--) {
            row = $(rows[i]);
            rowNext = row.next();

            if (rowNext.length < 1) {
                preventMove = true;
                return;
            }

            if (!preventMove) {
                $(row).insertAfter(rowNext);
            }
        }

    };

    /**
     *
     * @param e
     * @private
     */
    G._removeRow = function (e) {
        var target = $(e.target);
        var parentTarget = target.closest(this.cssSelectors.rows_data);
        var self = this;

        if (target.closest(this.cssSelectors.deletion_row).hasClass(this.cssClass.disable)) {
            return;
        }

        parentTarget.fadeOut(this.KEY_WORDS.SLOW, function () {
            parentTarget.find(self.cssSelectors.select_checkbox).remove();
            self.$folderDeleted.append(parentTarget);
            if (self.$container.find(self.cssSelectors.rows_data + ":visible").length < 1) {
                self.$container.find(self.cssSelectors.empty_message).remove();
                self.$container.find(self.cssSelectors.container_folder_setting).after(self.createEmptyMessage());
            }
            self.handleEnableMoveButton();
        });

    };

    G.pageLoadRenderInputControllerList = function () {
        var request;
        var self = this;

        request = new grn.component.ajax.request({
            grnUrl: this.options.url,
            method: "post",
            data: {
                spid: this.spId
            },
            grnLoadingIndicator: $.proxy(this._loadingIndicator, this)
        });

        return request.send().
            done($.proxy(this._renderInputControllerList, this)).
            then(function () {
                if (self.folderListLength === 0) {
                    self.renderInputController();
                }
            });
    };

    G._loadingIndicator = function (option) {
        if (!this.options.useSpinner) {
            return;
        }

        if (option === this.KEY_WORDS.SHOW) {
            this.$container.find(this.cssSelectors.container_folder_setting).append(this.htmlTemplate.spinner);
        } else {
            $(this.cssSelectors.spinner).remove();
        }
    };
    /**
     *
     * @returns {*}
     */
    G.handleClickAddNew = function (e) {
        this.$folderList.show();
        this.$container.find(this.cssSelectors.empty_message).remove();
        var target = $(e.target).closest(this.cssSelectors.rows_data);

        if (target.length > 0) {
            this.targetAdd = target;
        }
        else {
            this.targetAdd = this.cssSelectors.container_folder_setting;
        }
        return this.renderInputController();
    };

    /**
     *
     * @param folder_data
     */
    G.renderInputController = function (folder_data) {

        var folderData = folder_data || false;
        var template;
        var $folderName;

        template = $(this.htmlTemplate.rowAddTemplate);
        template.find(this.cssSelectors.deletion_row).prop(this.KEY_WORDS.TITLE, this.JS_RESOURCES.DELETE);
        template.find(this.cssSelectors.row_add).prop(this.KEY_WORDS.TITLE, this.JS_RESOURCES.ADD_ROW);
        $folderName = template.find(this.cssSelectors.folder_name);

        if (folderData) {
            template.data(this.KEY_WORDS.FOLDER_DATA, folder_data);
            if (folderData.hasOwnProperty(this.KEY_WORDS.DATA_ATTR.FOLDER_NAME)) {
                $folderName.val(folder_data.col_folder_name);
            }

            if (folderData[this.KEY_WORDS.DATA_ATTR.NUMBER_THREAD] > 0) {
                template.find(this.cssSelectors.deletion_row).addClass(this.cssClass.disable);
                template.find(this.cssSelectors.deletion_row).removeAttr(this.KEY_WORDS.TITLE);
            }
        }

        if (this.targetAdd != null && typeof this.targetAdd === "object") {
            this.targetAdd.after(template);
        } else {
            this.$container.find(this.cssSelectors.container_folder_setting).append(template);
        }

        this.targetAdd = null;

        if (!folderData) {
            $folderName.focus();
        }
    };

    /**
     *
     * @private
     */
    G.submitRows = function (e) {
        e.preventDefault();

        var folderDataList = {};
        var oldFolderData;
        var displayOrder = 0;
        var folderRow;
        var isDeleted;
        var self = this;
        var request;
        var newFolderData;

        this.$container
            .find(this.cssSelectors.rows_data)
            .each(function (index, _row) {
                folderRow = $(_row);
                isDeleted = folderRow.is(self.KEY_WORDS.IS_HIDDEN);
                oldFolderData = folderRow.data(self.KEY_WORDS.FOLDER_DATA);
                newFolderData = {};
                if (folderRow.find(self.cssSelectors.folder_name).val() === self.KEY_WORDS.EMPTY &&
                    isDeleted && typeof oldFolderData === self.KEY_WORDS.UNDEFINED) {
                    return;
                }

                if (!isDeleted) {
                    ++displayOrder;
                }

                if (typeof oldFolderData === self.KEY_WORDS.UNDEFINED) {
                    newFolderData._id = self.KEY_WORDS.ID_TO_ADD_NEW;

                } else {
                    newFolderData._id = oldFolderData._id;
                }

                newFolderData.col_display_order = displayOrder;
                newFolderData.col_folder_name = folderRow.find(self.cssSelectors.folder_name).val();
                newFolderData.is_deleted = isDeleted;

                folderDataList[index] = newFolderData;
            });

        request = new grn.component.ajax.request({
            grnUrl: this.options.urlSubmit,
            method: "post",
            data: {
                spid: this.spId,
                folder_list: JSON.stringify(folderDataList),
                csrf_ticket: grn.data.CSRF_TICKET
            }
        });

        request.send()
            .done(
            function (jQxhr) {
                if (jQxhr.result === self.KEY_WORDS.REQUIRED_FOLDER_NAME) {
                    $(self.cssSelectors.required_folder_name).show();
                    grn.component.button(self.cssSelectors.rows_submit).hideSpinner();
                    return;
                }
                window.location.href = G.backPage;
            }
        );

        request.on(this.KEY_WORDS.ERROR_CLOSED, function () {
            grn.component.button(self.cssSelectors.rows_submit).hideSpinner();
        });
    };

    /**
     *
     * @param xhr_data
     * @param text_status
     * @param jqXHR
     * @private
     */
    G._renderInputControllerList = function (xhr_data, text_status, jqXHR) {

        var self = this;
        var folderListLength = 0;

        this.$container.find(this.cssSelectors.rows_data).detach();
        $.map(xhr_data.folder_list, function (folder) {
            ++folderListLength;
            if (folder[self.KEY_WORDS.DATA_ATTR.FOLDER_NAME] !== self.KEY_WORDS.EMPTY) {
                self.renderInputController(folder);
            }
        });

        G.folderListLength = folderListLength;
    };

    /**
     *
     * @returns {string}
     */
    G.createEmptyMessage = function () {
        var regexp = new RegExp("{{resource}}");
        var regexpLink = new RegExp("{{resourceLink}}");

        return this.htmlTemplate.emptyMessage
            .replace(regexp, this.JS_RESOURCES.EMPTY_MESSAGE)
            .replace(regexpLink, this.JS_RESOURCES.EMPTY_MESSAGE_LINK);
    };

    /**
     *
     * @param e
     * @private
     */
    G._cancel = function (e) {
        e.preventDefault();

        window.location.href = G.backPage;
    };

    G.handleEnableMoveButton = function () {
        var selector = this.cssSelectors.folder_selected + ":checked";
        var folderListSelected = this.$container.find(selector);

        if (folderListSelected.length > 0) {
            this.$container.find(this.cssSelectors.up_row).removeClass(this.cssClass.disable_order_button);
            this.$container.find(this.cssSelectors.down_row).removeClass(this.cssClass.disable_order_button);

        } else {
            this.$container.find(this.cssSelectors.up_row).addClass(this.cssClass.disable_order_button);
            this.$container.find(this.cssSelectors.down_row).addClass(this.cssClass.disable_order_button);

        }
    };

    G.handleSelectedFolder = function (e) {
        var highlightClass;

        this.handleEnableMoveButton();

        highlightClass = this.cssSelectors.row_highlight.substr(1);
        if ($(e.target).prop(this.KEY_WORDS.CHECKED) === true) {
            $(e.target)
                .closest(this.cssSelectors.rows_data)
                .find(this.KEY_WORDS.TD + ":lt(2)")
                .addClass(highlightClass);
        } else {
            $(e.target)
                .closest(this.cssSelectors.rows_data)
                .find(this.cssSelectors.row_highlight)
                .removeClass(highlightClass);
        }
    };

    G.handleCheckUncheckedAll = function (e) {
        e.preventDefault();

        var folderList = this.$container.find(this.cssSelectors.folder_selected);
        var folderListSelected = this.$container.find(this.cssSelectors.folder_checked);

        if (folderList.length < 1) {
            return;
        }

        if (folderListSelected.length === folderList.length) {
            folderListSelected.prop(this.KEY_WORDS.CHECKED, false);
            this.$container.find(this.cssSelectors.up_row).addClass(this.cssClass.disable_order_button);
            this.$container.find(this.cssSelectors.down_row).addClass(this.cssClass.disable_order_button);
            this.$container.find(this.cssSelectors.row_highlight)
                .removeClass(this.cssSelectors.row_highlight.substr(1));
        } else {
            folderList.prop(this.KEY_WORDS.CHECKED, true);
            this.$container.find(this.cssSelectors.up_row).removeClass(this.cssClass.disable_order_button);
            this.$container.find(this.cssSelectors.down_row).removeClass(this.cssClass.disable_order_button);
            this.$container
                .find(this.cssSelectors.rows_data)
                .find(this.KEY_WORDS.TD + ":lt(2)")
                .addClass(this.cssSelectors.row_highlight.substr(1));
        }
    };
    /**
     *
     */
    $(document).ready(function () {

        var spaceId = grn.component.url.parseQueryString(window.location.href);

        G.spId = spaceId.spid;
        G.init();
        G.pageLoadRenderInputControllerList();

    });
})(jQuery);

