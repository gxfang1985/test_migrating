(function ($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.page.mail.rfc822")) {
        return;
    }

    grn.base.namespace("grn.page.mail.rfc822");

    $(document).ready(function () {
        var showInlineImagesButton = $("#mail_show_inline_files_button");
        var hideInlineImagesButton = $("#mail_hide_inline_files_button");
        var inlineFilesContainer = $("#mail_inline_files");

        showInlineImagesButton.click(function () {
            showInlineImagesButton.hide();
            hideInlineImagesButton.show();
            inlineFilesContainer.show();
        });

        hideInlineImagesButton.click(function () {
            hideInlineImagesButton.hide();
            showInlineImagesButton.show();
            inlineFilesContainer.hide();
        });
    });
})(jQuery);
