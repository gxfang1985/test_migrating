/*global GRN_MsgBox, GRN_MsgBoxButtons, GRN_MsgBoxResult */
grn.base.namespace("grn.component.ajax_submit_wf");

(function()
{
    "use strict";
    var G = grn.component.ajax_submit_wf;
    var check_submit = false;
    var cmd_value = "";
    G.init = function () {
        if(grn.component.pubsub) {
            grn.component.pubsub.installTo(G);
        }
    };
    G.ajax_submit = function(f, submit_page, before_submit, after_submit)
    {
        if (f.cmd) {
            cmd_value = f.cmd.value;
        }

        if (check_submit || typeof(f) === "undefined" || typeof(submit_page) === "undefined")
        {
            return false;
        }

        // set ajax flag element
        if(!G._setAjaxElement(f))
        {
            return false;
        }

        check_submit = true;
        jQuery('#show_validation_errors').hide();

        if (before_submit)
        {
            before_submit();
        }

        var request = new grn.component.ajax.request(
            {
                url: submit_page,
                method: "post",
                dataType: "json",
                data: jQuery(f).serialize()
            }
        );

        request.on('beforeShowError', function (e, jqXHR)
        {
            if (typeof jqXHR.responseJSON !== "undefined")
            {
                var json_obj = jqXHR.responseJSON;
                if (typeof json_obj.validation !== "undefined" && json_obj.validation === false)
                {
                    e.preventDefault();
                    jQuery('#show_validation_errors').html(json_obj.error_message).show();
                    window.scrollTo(0, 0);
                }
            }
        });

        request.send().done(
            function (json_obj)
            {
                G.afterSuccess(json_obj);
            }
        )
        .always(
            function (jqXHR)
            {
                G._removeAjaxElement(f);
                check_submit = false;
                if (after_submit) {
                    after_submit(jqXHR);
                }
            }
        );
    };

    G._setAjaxElement = function(f)
    {
        if( document.getElementById('use_ajax') )
        {
            return false;
        }

        var element = document.createElement("input");
        element.setAttribute("type", "hidden");
        element.setAttribute("id", "use_ajax");
        element.setAttribute("name", "use_ajax");
        element.setAttribute("value", "1");
        f.appendChild(element);
        return true;
    };

    G._removeAjaxElement = function(f)
    {
        var use_ajax = jQuery("#use_ajax");
        if( use_ajax )
        {
            use_ajax.remove();
        }
    };

    G.afterSuccess = function(json_obj)
    {
        var link = json_obj.link;
        if (typeof json_obj.success_do === 'undefined') {
            G._handleAfterSuccess(json_obj, link);
        }
        else
        {
            switch(json_obj.success_do)
            {
                case "pop_up":
                    var message = jQuery('#auto_schedule_register_pop_up').html();
                    GRN_MsgBox.show(message, '', GRN_MsgBoxButtons.yesno, {
                        ui : [],
                        caption : {
                            yes : grn.msg.YES,
                            no  : grn.msg.NO
                        },
                        callback : function(result, form)
                        {
                            if (result === GRN_MsgBoxResult.yes)
                            {
                                G._handleAfterSuccess(json_obj, link);
                            }
                        }
                    });
                    break;

                case "auto_schedule":
                    G.scheduleRegisterAjax(json_obj.petition_id)
                        .always(function(){
                          G._handleAfterSuccess(json_obj, link);
                        })
                    break;
                default:
                    G._handleAfterSuccess(json_obj,link);
            }
        }

    };

    G.scheduleRegisterAjax = function (petition_id) {
        var request = new grn.component.ajax.request({
                url: G.commandAutoScheduleURL,
                method: "post",
                dataType: "json",
                data: {
                    "use_ajax": 1,
                    "csrf_ticket": grn.csrfTicket,
                    "petition_id": petition_id
                }
            }
        );

        request.on('beforeShowError', function (e, jqXHR) {
            e.preventDefault();
        });
        return request.send();
    };

    G._handleAfterSuccess = function (json_object, link) {
        if (!G.trigger) {
            window.location = link;
            return;
        }
        var event = G.trigger("afterSuccess", {"command": cmd_value, "response": json_object});
        var is_promise = event.result instanceof garoon.Promise;
        if (!is_promise) {
            window.location = link;
            return;
        }
        event.result.then(function () {
            window.location = link;
        });
    }
})();
