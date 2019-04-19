// namespace
grn.base.namespace("grn.component.mail.confirm_show_html");

(function($)
{
    "use strict";

    var G = grn.component.mail.confirm_show_html;

    G.dialogMessage = null;
    G.getDataUrl = null;

    G.showConfirmDialog = function (isNewTab) {
        var confirmDialog = confirm( G.dialogMessage );
        if (confirmDialog === true) {
            var url = G.getDataUrl + G.param;
            if (isNewTab) {
                window.open(url);
            }
            else {
                window.location.href = url;
            }
        }
    };

})(jQuery);
