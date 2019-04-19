(function()
{
    "use strict";
    if (grn.base.isNamespaceDefined("grn.page.mail.mobile._receive_button"))
    {
        return;
    }

    grn.base.namespace("grn.page.mail.mobile._receive_button");
    var G = grn.page.mail.mobile._receive_button;

    var doReceive = false;
    G.receive = function(cmd)
    {
        if ( doReceive )
        {
            return;
        }
        doReceive = true;

        $("#cmd_receive_mail").val(cmd);
        grn.component.mobile_ajax_submit.ajaxSubmit("receive_mail", G.beforeSendFn, G.afterSendFn);
    };

    G.beforeSendFn = function(){
        $("#receive_button").addClass("mobile_base_disable_grn");
    };

    G.afterSendFn = function(){
        $("#receive_button").removeClass("mobile_base_disable_grn");
        doReceive = false;
    };
})();
