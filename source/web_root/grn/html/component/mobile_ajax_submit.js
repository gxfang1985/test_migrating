(function()
{
    "use strict";
    if (grn.base.isNamespaceDefined("grn.component.mobile_ajax_submit"))
    {
        return;
    }

    grn.base.namespace("grn.component.mobile_ajax_submit");
    var G = grn.component.mobile_ajax_submit;

    var checkSubmit = false;
    G.ajaxSubmit = function(formId, beforeSendFn, afterSendFn)
    {
        if (checkSubmit || typeof formId === "undefined")
        {
            return false;
        }

        var form = $("#" + formId);
        var submitPage = form.attr("action");
        if (typeof submitPage === "undefined")
        {
            return;
        }

        $.ajax({type: "POST",
            url: submitPage,
            data: form.serialize(),
            dataType: "json",
            beforeSend: function()
            {
                checkSubmit = true;
                grn.component.mobile_loading.show();
                if (typeof beforeSendFn === "function")
                {
                    beforeSendFn();
                }
            },
            success: function(data, textStatus, jqXHR)
            {
                if (grn.component.mobile_error_handler.hasCybozuError(jqXHR))
                {
                    grn.component.mobile_error_handler.show(jqXHR);
                }
                else
                {
                    var redirect = data.redirect;
                    if (typeof redirect !== "undefined")
                    {
                        window.location.href = redirect;
                        return;
                    }
                }
            },
            error: function(jqXHR)
            {
                // This handling is for Forest environment.
                if (grn.component.mobile_error_handler.hasCybozuError(jqXHR))
                {
                    if (typeof jqXHR.responseJSON !== "undefined")
                    {
                        grn.component.mobile_error_handler.show(jqXHR);
                    }
                    else
                    {
                        G._showErrorMessage(jqXHR);
                    }
                }
                else if (grn.component.mobile_error_handler.hasCybozuLogin(jqXHR))
                {
                    location.href = location.href;
                }
                else
                {
                    G._showErrorMessage(jqXHR);
                }
            },
            complete: function(jqXHR)
            {
                checkSubmit = false;
                if (typeof afterSendFn === "function")
                {
                    afterSendFn(jqXHR);
                }
                grn.component.mobile_loading.remove();
            }
        });
    };

    G._showErrorMessage = function(jqXHR)
    {
        var message = jqXHR.responseText;
        if (typeof message !== "undefined")
        {
            document.write(message);
            document.close();
        }
    };
})();