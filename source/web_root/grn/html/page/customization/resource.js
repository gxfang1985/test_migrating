/* global FileUpload, _getSizeString */
(function ($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.page.customization.resource")) {
        return;
    }
    grn.base.namespace("grn.page.customization.resource");

    var resource = grn.page.customization.resource;

    var ResourceView = (function () {
        var api = {};
        var MAX_FILE_SIZE = 1024 * 1024 * 5; // 5MB
        var MIN_FILE_SIZE = 1;
        var MAX_NUMBER_OF_RESOURCE = 30;
        var MAX_URL_BYTE_COUNT = 512;
        var ADD_LINK_BUTTON_TEXT = grn.component.i18n.cbMsg("grn.system.application", "GRN_SY_AP-117");
        var ADD_FILE_BUTTON_TEXT = grn.component.i18n.cbMsg("grn.system.application", "GRN_SY_AP-118");

        /**
         *
         * @param container
         * @private
         */
        api._construct = function (container) {
            this.resourceType = container.substr(1);
            var options = {};
            options.TEMPLATES = {
                ROW: "<tr class='js_row_item'>" +
                "   <td>" +
                "      <input name='selected' class='js_row_checkbox' type='checkbox'>" +
                "   </td>" +
                "   <td>" +
                "       <input name='" + this.resourceType + "_ids[]' type='hidden'>" +
                "       <input class='input_text_grn js_subject' name='" + this.resourceType + "_links[]' type='text' " +
                "value='https://' style='width:500px;'>" +
                "   </td>" +
                "   <td class='move_list_action_grn js_row_action'>" +
                "       <span class='js_delete_row'>" +
                "           <a class='action_base_grn' title='{{resource_GRN_SY_AP_110}}'  href='javascript:void(0)' " +
                "aria-label='{{resource_GRN_SY_AP_110}}'>" +
                "               <span class='icon-delete-grn icon_only_grn'></span>" +
                "           </a>" +
                "       </span>" +
                "   </td>" +
                "</tr>",

                ROW_EXIST: "<tr class='js_row_item'>" +
                "   <td>" +
                "      <input name='selected' class='js_row_checkbox' type='checkbox'>" +
                "   </td>" +
                "   <td>" +
                "       <input class='js_id' name='" + this.resourceType + "_ids[]' type='hidden'>" +
                "       <input class='js_link' name='" + this.resourceType + "_links[]' type='hidden'>" +
                "       <a class='js_subject mRight15'></a>" +
                "   </td>" +
                "   <td class='move_list_action_grn js_row_action'>" +
                "       <span class='js_delete_row'>" +
                "           <a class='action_base_grn' title='{{resource_GRN_SY_AP_110}}'  href='javascript:void(0)' " +
                "aria-label='{{resource_GRN_SY_AP_110}}'>" +
                "               <span class='icon-delete-grn icon_only_grn'></span>" +
                "           </a>" +
                "       </span>" +
                "   </td>" +
                "</tr>",

                ROW_FILE: "<tr class='js_row_item'>" +
                "   <td>" +
                "      <input name='selected' class='js_row_checkbox' type='checkbox'>" +
                "   </td>" +
                "   <td>" +
                "       <input class='js_id' name='" + this.resourceType + "_ids[]' type='hidden'>" +
                "       <input name='" + this.resourceType + "_links[]' type='hidden'>" +
                "       <span class='js_subject mRight15'></span>" +
                "   </td>" +
                "   <td class='move_list_action_grn js_row_action'>" +
                "       <span class='js_delete_row'>" +
                "           <a class='action_base_grn' title='{{resource_GRN_SY_AP_110}}'  href='javascript:void(0)' " +
                "aria-label='{{resource_GRN_SY_AP_110}}'>" +
                "               <span class='icon-delete-grn icon_only_grn'></span>" +
                "           </a>" +
                "       </span>" +
                "   </td>" +
                "</tr>",

                RESOURCE_BUTTON_GROUP: "<div class='mTop15 mBottom7'>" +
                "    <span class='action_text_grn mRight5 js_add_url_row'>" +
                "        <a href='javascript:void(0)' class='action_base_grn'>" +
                "            <span class='icon_add_grn icon_only_grn'></span><span>" + ADD_LINK_BUTTON_TEXT + "</span>" +
                "        </a>" +
                "    </span>" +
                "    <span class='mRight5 js_add_file_row'>" +
                "        <a href='javascript:void(0)' class='action_base_grn'>" +
                "             <span class='icon_inline_grn icon_attachment_grn'></span><span>" + ADD_FILE_BUTTON_TEXT + "</span>" +
                "        </a>" +
                "    </span>" +
                "</div>",

                HEAD: "<tr class='js_row_header'>" +
                "    <th style='min-width:5px; width: 5px;'></th>" +
                "    <th style='min-width:500px;'>{{resource_GRN_SY_AP_76}}</th>" +
                "    <th class='move_list_action_grn js_row_action'></th>" +
                "</tr>",

                WARNING_AREA: "<div class='attention_area_grn inline_block_grn mTop10 js_warning_area'>" +
                "    <div class='icon_attention_grn'><span></span></div>" +
                "    </div>",

                WARNING_ITEM: "<div class='attentionMessage-grn js_warning_item'></div>"
            };

            options.JS_RESOURCES = {
                DELETE: grn.component.i18n.cbMsg("grn.system.application", "GRN_SY_AP-110"),
                COLUMN_SUBJECT: grn.component.i18n.cbMsg("grn.system.application", "GRN_SY_AP-114"),
                WARNING_FILE_TYPE: grn.component.i18n.cbMsg("grn.system.filemanager", "GRN_SY_FI-82"),
                WARNING_FILE_SIZE: grn.component.i18n.cbMsg("grn.system.filemanager", "GRN_SY_FI-83"),
                WARNING_FILE_SIZE_MIN: grn.component.i18n.cbMsg("grn.grn", "grn.upload.zerobyte.file"),
                WARNING_NUMBER_OF_FILES: grn.component.i18n.cbMsg("grn.system.filemanager", "GRN_SY_FI-84"),
                WARNING_URL_BYTE_COUNT: grn.component.i18n.cbMsg("grn.system.application", "GRN_SY_AP-115"),
                WARNING_IS_NOT_URL: grn.component.i18n.cbMsg("grn.system.application", "GRN_SY_AP-116")
            };

            options.SELECTOR = {
                ROW_HEAD: ".js_row_header",
                BUTTON_ADD_FILE_ROW: ".js_add_file_row",
                BUTTON_ADD_URL_ROW: ".js_add_url_row",
                WARNING_AREA: ".js_warning_area",
                WARNING_ITEM: ".js_warning_item"
            };

            options.displayAddItemButtonForEmptyList = false;

            this._super._construct.call(this, container, options);
        };

        /**
         *
         * @param data
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
                    dataRow.fileId = row.col_file;
                } else {
                    dataRow.colUrl = row.col_url;
                    dataRow.resourceUrl = row.col_url;
                }
                dataRows.push(dataRow);
            });

            this.$container.empty();

            this.$container.append(this._renderButtonGroup());
            this.enableUpDownButton(false);

            this.$container.append(this._renderTable(dataRows));
            this.$container.append(this._renderWarningArea());
            this.$container.append(this.options.TEMPLATES.RESOURCE_BUTTON_GROUP.replace(/(>)\s*(<)/g, '$1$2'));

            this._bindEvents();
        };

        api._renderWarningArea = function () {
            return $(this.options.TEMPLATES.WARNING_AREA).hide();
        };

        /**
         *
         * @param data
         * @returns {*}
         * @private
         */
        api._renderRow = function (data) {
            var resources = {
                "{{resource_GRN_SY_AP_110}}": this.js_resources.DELETE
            };
            var $row = null;

            if (typeof data !== "undefined") {
                if (data.fileType === "new") {
                    $row = $(this.translateResource(this.options.TEMPLATES.ROW_FILE.replace(/(>)\s*(<)/g, '$1$2'), resources));
                    $row.find('.js_id').val(data.id);
                } else {
                    $row = $(this.translateResource(this.options.TEMPLATES.ROW_EXIST.replace(/(>)\s*(<)/g, '$1$2'), resources));
                    $row.find('.js_id').val(data.fileId);
                }

                if (data.fileName) {
                    $row.find(this.selector.COLUMN_SUBJECT).text(data.fileName);
                    $row.find('.js_id').after("<img src='" + grn.component.url.image("cybozu/disk20.gif") + "' border='0'>");
                    $row.find(this.selector.COLUMN_SUBJECT)
                        .after('<span class="text_color_sub_grn nowrap-grn">' + _getSizeString(data.fileSize) + '</span>');
                } else {
                    $row.find(this.selector.COLUMN_SUBJECT).text(data.colUrl);
                    $row.find('.js_link').val(data.colUrl);
                }

                if (data.resourceUrl) {
                    $row.find(this.selector.COLUMN_SUBJECT).attr('href', data.resourceUrl).attr('target', '_blank');
                }
            } else {
                $row = $(this.translateResource(this.options.TEMPLATES.ROW.replace(/(>)\s*(<)/g, '$1$2'), resources));
            }

            return $row;
        };

        /**
         *
         * @param data
         * @returns {*|HTMLElement}
         * @private
         */
        api._renderTable = function (data) {
            var self = this;
            var $table = $('<table></table>');
            $table.append(this._renderHead());

            if (typeof data !== "undefined" && data.length > 0) {
                data.forEach(function (dataRow) {
                    $table.append(self._renderRow(dataRow));
                });
            }

            $table.addClass("list_column");
            return $table;
        };

        /**
         *
         * @private
         */
        api._bindEvents = function () {
            this._super._bindEvents.call(this);
            this.$container.on("click", this.selector.BUTTON_ADD_FILE_ROW, $.proxy(this._handleUploadFile, this));
            this.$container.on("click", this.selector.BUTTON_ADD_URL_ROW, $.proxy(this.handleAddNew, this));
        };


        /**
         *
         * @param e
         */
        api.handleAddNew = function (e) {
            this._hideWarningArea();
            var target = $(e.target);
            if (target.closest(this.selector.BUTTON_ADD_ROW).hasClass(this.css_class.ACTION_BASE_DISABLE_GRN)) {
                return;
            }

            var $rowItemEls = this.$container.find(this.selector.ROW_ITEM);
            if ($rowItemEls.length !== 0) {
                this.$container.find(this.selector.ROW_ITEM).filter(":last").after(this._renderRow());
            } else {
                this.$container.find(this.selector.ROW_HEAD).after(this._renderRow());
            }

            if (this.options.NUMBER_ROW_LIMIT > 0 && this.getRowCount() >= this.options.NUMBER_ROW_LIMIT) {
                this.$container.find(this.selector.BUTTON_ADD_ROW).addClass(this.css_class.ACTION_BASE_DISABLE_GRN);
            }
        };

        /**
         *
         * @private
         */
        api._handleUploadFile = function () {
            this._hideWarningArea();
            this.selectFileRow = this.$container.find(this.selector.ROW_ITEM).filter(":last");
            this._initFileUpload();
            $("#file_upload_").trigger("click");
        };

        /**
         *
         * @param message
         * @private
         */
        api._showWarningArea = function (message) {
            var $warningArea = this.$container.find(this.selector.WARNING_AREA);
            $warningArea.find('span').text(message);
            $warningArea.show();
        };

        /**
         *
         * @private
         */
        api._hideWarningArea = function () {
            this.$container.find(this.selector.WARNING_AREA).hide();
        };

        /**
         *
         * @param container
         * @param message
         * @private
         */
        api._showWarningItem = function (container, message) {
            var $warningItem = $(this.options.TEMPLATES.WARNING_ITEM);
            $warningItem.text(message);
            $(container).prepend($warningItem);
        };

        /**
         *
         * @param container
         * @private
         */
        api._hideWarningItem = function (container) {
            $(container).find(this.selector.WARNING_ITEM).remove();
        };

        /**
         *
         * @returns {boolean}
         */
        api.validateResource = function () {
            var self = this;
            var $rowItemEls = this.$container.find(this.selector.ROW_ITEM);
            if ($rowItemEls.length > MAX_NUMBER_OF_RESOURCE) {
                this._showWarningArea(this.js_resources.WARNING_NUMBER_OF_FILES);
                return false;
            }

            var isTrueValue = true;
            $rowItemEls.each(function (index, item) {
                var $textBoxEls = $(item).find('input.js_subject');
                if ($textBoxEls.length > 0) {
                    self._hideWarningItem(item);
                    var urlString = $textBoxEls.val().trim();
                    if (urlString.search('https://') !== 0) {
                        self._showWarningItem($textBoxEls.parent(), self.js_resources.WARNING_IS_NOT_URL);
                        isTrueValue = false;
                    } else if (grn.component.string.getByteCount($textBoxEls.val()) > MAX_URL_BYTE_COUNT) {
                        self._showWarningItem($textBoxEls.parent(), self.js_resources.WARNING_URL_BYTE_COUNT);
                        isTrueValue = false;
                    }
                }
            });

            return isTrueValue;
        };

        /**
         *
         * @param filename
         * @param size
         * @returns {boolean}
         * @private
         */
        api._validateUploadedFile = function (filename, size) {
            var fileNamePath = filename.split('.');
            if (fileNamePath[fileNamePath.length - 1] !== this.resourceType) {
                this._showWarningArea(this.js_resources.WARNING_FILE_TYPE.replace('{0}', filename));
                return false;
            }

            if (size < MIN_FILE_SIZE) {
                this._showWarningArea(this.js_resources.WARNING_FILE_SIZE_MIN);
                return false;
            }

            if (size > MAX_FILE_SIZE) {
                this._showWarningArea(this.js_resources.WARNING_FILE_SIZE.replace('{0}', filename));
                return false;
            }
            return true;
        };

        /**
         *
         * @private
         */
        api._initFileUpload = function () {
            var self = this;

            if (!FileUpload.prototype.sendDatasOld) {
                FileUpload.prototype.sendDatasOld = FileUpload.prototype.sendDatas;
            }

            FileUpload.prototype.sendDatas = function () {
                if (!self._validateUploadedFile(this.file.name, this.file.size)) {
                    return;
                }
                FileUpload.prototype.sendDatasOld.call(this);
            };

            FileUpload.prototype.toggleButtons = function (disabled) {
                self.toggleSpinner(disabled);
            };

            if (!FileUpload.prototype.endProcessOld) {
                FileUpload.prototype.endProcessOld = FileUpload.prototype.endProcess;
            }

            FileUpload.prototype.updateProgress = function(e,fid) {
                // This method is overridden to overcome JS error occurs on Safari 9
                // We don't need to show the progress.
                this.started = true;
            }

            FileUpload.prototype.endProcess = function (control) {
                FileUpload.prototype.endProcessOld.call(this);
                var $newFileRow = self._renderRow({
                    fileType: "new",
                    fileName: this.file.name,
                    fileSize: this.file.size,
                    id: this.fid
                });

                if (self.selectFileRow.length === 0) {
                    self.$container.find(self.selector.ROW_HEAD).after($newFileRow);
                } else {
                    self.selectFileRow.after($newFileRow);
                }

                self.selectFileRow = $newFileRow;
            };

            FileUpload.prototype.onUploadError = function (fileid, errorcode) {
                self._showWarningArea(this._createErrorMessageFromErrorCode(errorcode));
                this.completeUpload(fileid);
            };
        };

        api.toggleSpinner = function (disabled) {
            var zIndex = 900;
            var $spinnerContainer = this.$container.closest("form").css("position", "relative");

            if (!this._$spinner) {
                this._$spinner = $("<div class='spinnerBoxBase-grn spinnerCentered'><div class='spinnerBox-grn'></div></div>")
                    .css("z-index", zIndex);
            }

            if (!this._$overlay) {
                this._$overlay = $("<div />").css({
                    "background-image": "url(" + grn.component.url.image("cybozu/bg_transparent.png") + ")",
                    "position": "absolute",
                    "top": 0,
                    "left": 0,
                    "bottom": 0,
                    "right": 0,
                    "z-index": zIndex
                });
            }

            if (disabled == true) {
                $spinnerContainer.append(this._$overlay).append(this._$spinner);
            } else {
                this._$spinner.remove();
                this._$overlay.remove();
            }
        };

        return grn.base.extendClass(grn.component.EditableTable, 'resourceView', api);
    })();

    /**
     *
     * @param data
     */
    resource.init = function (data) {
        this.jsView = new ResourceView("#js");
        this.cssView = new ResourceView("#css");

        this.jsView.render(data.resourceJS);
        this.cssView.render(data.resourceCSS);
    };


    resource.validateSubmit = function () {

        var $group_name = $("input[name='name']");
        if ($group_name.length === 0) {
            return true;
        }
        if ($group_name.val().trim().length === 0) {
            var $js_validate_area = $(".js_validate_area");
            if( $js_validate_area.is(':hidden') ) {
                var html =
                    "<span class='bold'><span class='nowrap-grn'><span class='subnotify16' name=''#'>" +
                    grn.component.i18n.cbMsg("grn.customization", "customization.group_form.field_group_name_invalid_message") +
                    "</span></span></span>";
                $js_validate_area.append(html);
                $js_validate_area.show();
            }
            return false;
        }
        return true;
    };

    resource.checkHTML5SupportUploadFiles = function () {
        if (!grn.browser.isSupportHTML5) {
            var not_HTML5_upload_element = "<span class='icon_information_sub_grn messageSub-grn'>"
                + grn.component.i18n.cbMsg("grn.grn", "GRN_GRN-1581") + "</span>";
            $(".js_add_file_row").each(function () {
                $(this).removeClass().html(not_HTML5_upload_element);
            });
        }
    };

    $(document).ready(function () {
        $('.js_submit_btn').click(function (e) {
            if ( !resource.validateSubmit() || !resource.jsView.validateResource() || !resource.cssView.validateResource()) {
                e.preventDefault();
            }
        });
    });
})(jQuery);

