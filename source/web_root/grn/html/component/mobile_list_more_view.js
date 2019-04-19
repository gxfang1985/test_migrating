(function()
{
    if (grn.base.isNamespaceDefined("grn.component.mobile_list_more_view"))
    {
        return;
    }

    grn.base.namespace("grn.component.mobile_list_more_view");
    var G = grn.component.mobile_list_more_view;

    if (typeof G.MoreView == "undefined")
    {
        G.MoreView = {};
    }

    G.is_loading = false;

    G.setMoreView = function(options)
    {
        var list_id = options.ul_id || null;
        if (list_id)
        {
            G.MoreView[list_id] = options;
        }
    };

    G.getMoreView = function(list_id, trigger_create)
    {
        var fn = G.MoreView[list_id];
        if (fn && fn.require_url && G.is_loading == false)
        {
            G.is_loading = true;
            var div_see_more = $('#ul_' + list_id + ' div');
            var div_loading=$('<div style="margin: 0.5em 5px;background:url(' + G.spinnerImage + ') no-repeat center;" /></div>');
            $.ajax(
            {
                url : fn.require_url,
                dataType : 'json',
                data : fn.arg + '&sp=' + fn.sp,
                type : 'post',
                beforeSend : function()
                {
                    div_loading.height(div_see_more.height());
                    div_see_more.hide();
                    div_see_more.parent().append(div_loading);
                },
                success : function(json_obj, text_status, transport)
                {
                    if (grn.component.mobile_error_handler.hasCybozuError(transport))
                    {
                        grn.component.mobile_error_handler.show(transport);
                    }
                    else
                    {
                        $('#'+fn.ul_id).html(json_obj.list);
                        if (trigger_create)
                        {
                            var triggerData = { responseData : json_obj };
                            $('#'+fn.ul_id).trigger('create', triggerData);
                        }
                        if (json_obj.offset == -1)
                        {
                            $('#ul_' + list_id).remove();
                        }
                        else
                        {
                            fn.sp = json_obj.offset;
                            div_loading.remove();
                            div_see_more.show();
                        }
                    }
                },
                error : function(transport)
                {
                    // This handling is for Forest environment.
                    if (grn.component.mobile_error_handler.hasCybozuError(transport))
                    {
                        if (typeof transport.responseJSON !== "undefined")
                        {
                            grn.component.mobile_error_handler.show(transport);
                        }
                        else
                        {
                            document.write(transport.responseText);
                            document.close();
                        }
                    }
                    else if (grn.component.mobile_error_handler.hasCybozuLogin(transport))
                    {
                        location.href = location.href;
                    }
                    else
                    {
                        document.write(transport.responseText);
                        document.close();
                    }
                },
                complete : function()
                {
                    $('#'+fn.ul_id).listview('refresh');
                    G.is_loading = false;
                }
            });
        }
    };

    G.updateMoreView = function(list_id, options)
    {
        var fn = G.MoreView[list_id];
        if (fn && typeof options == 'object')
        {
            if(options.require_url)
            {
                fn.require_url = options.require_url;
            }
            if(options.ul_id)
            {
                fn.ul_id = options.ul_id;
            }
            if(options.arg)
            {
                fn.arg = options.arg;
            }
            if(options.sp)
            {
                fn.sp = options.sp;
            }
        }
    };
})();
