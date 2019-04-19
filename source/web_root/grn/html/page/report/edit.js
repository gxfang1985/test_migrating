(function ($) {
    "use strict";

    grn.base.namespace("grn.page.report.edit");

    grn.page.report.edit.init = function () {
        this.cacheElements();
        this.bindEvent();
    };

    grn.page.report.edit.cacheElements = function () {
        this.$container = $(".mainarea> form");
        this.$button_next = grn.component.button("#report_button_next");
        this.$button_save = grn.component.button("#report_button_save");
    };

    grn.page.report.edit.bindEvent = function () {
        this.$button_next.on("click", $.proxy(this.sendFormDetail, this));
        this.$button_save.on("click", $.proxy(this.saveDraft, this));
    };

    grn.page.report.edit.sendFormDetail = function () {
        if (this.$button_next.isDisabled()) {
            return false;
        }
        var form = this.$container[0];
        form.cmd.value = "next";
        if (confirmIfExistFailedFile() && report_file_validate(false)) {
            grn_onsubmit_common(form);
        } else {
            return false;
        }
        this.$button_next.showSpinner();
        form.submit();
    };

    grn.page.report.edit.saveDraft = function () {
        if (this.$button_save.isDisabled()) {
            return false;
        }
        var form = this.$container[0];
        form.cmd.value = "save";
        if (confirmIfExistFailedFile() && report_file_validate(true)) {
            grn_onsubmit_common(form);
        } else {
            return false;
        }
        this.$button_save.showSpinner();
        form.submit();
    };

    $(document).ready(function () {
        grn.page.report.edit.init();
    });

})(jQuery);
