(function()
{
    "use strict";
    if (grn.base.isNamespaceDefined("grn.component.mobile_ajax_submit_wf"))
    {
        return;
    }

    grn.base.namespace("grn.component.mobile_ajax_submit_wf");
    var G = grn.component.mobile_ajax_submit_wf;

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
                    G.afterSuccess(data);
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
            document.getElementById('body').innerHTML = message;
        }
    };

    G.afterSuccess = function(json_obj)
    {
        var link = json_obj.redirect;
        if (typeof json_obj.success_do === 'undefined')
        {
            window.location.href =  link;
        }
        else
        {
            switch(json_obj.success_do)
            {
                case "auto_schedule":
                    G.scheduleRegisterAjax(json_obj.petition_id).done(function(){
                        window.location.href  = link;
                    });
                    break;
                default:
                    window.location.href  = link;
            }
        }
    };

    G.scheduleRegisterAjax = function(petition_id) {
        return jQuery.ajax({
            "type" : "POST",
            "url" : G.commandAutoScheduleURL,
            "dataType" : "json",
            "data" : {
                "use_ajax" : 1,
                "csrf_ticket" : grn.csrfTicket,
                "petition_id" : petition_id
            }
        });
    };
})();