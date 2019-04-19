(function()
{
    "use strict";

    if (grn.base.isNamespaceDefined("grn.page.mail.mobile.index"))
    {
        return;
    }

    grn.base.namespace("grn.page.mail.mobile.index");
    var G = grn.page.mail.mobile.index;

    G.redirectToIndex = function()
    {
        var aid = $("#selected_account_value").val();
        location.href = G.mobileMailIndexUrl + "aid=" + aid;
    };
})();