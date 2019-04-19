/*global GRN_Event*/

grn.base.namespace("grn.component.favour");

(function($)
{
    "use strict";
    var G = grn.component.favour;

    var is_favour_loading = false;
    G.favour = function( module , sub_module , type , value , params )
    {
        if (is_favour_loading) {
            return;
        }
        is_favour_loading = true;

        var unique_id = type + '_' + value;
        var favour_link_jq = $("#favour_link_" + unique_id);
        var favour_count_jq = $("#favour_count_" + unique_id);
        var favour_loading = $("#favour_loading_" + unique_id);
        favour_loading.html(G.spinner);
        var csrf_ticket = grn.csrfTicket || grn.data.CSRF_TICKET;
        var request = new grn.component.ajax.request({
                url: G.favour_url,
                method: 'post',
                dataType: 'json',
                grnRedirectOnLoginError: true,
                data : "module=" + module + "&sub_module=" + sub_module + "&type=" + type + "&value=" + value + params + "&csrf_ticket=" + csrf_ticket
            }
        );

        request.send().done(
            function(json_obj){
                favour_link_jq.html(json_obj.f_word);
                favour_count_jq.html(json_obj.f_count);
                if (json_obj.count > 0)
                {
                    favour_count_jq.show();
                    if (favour_count_jq.hasClass("icon_reaction_sub_grn"))
                    {
                        favour_link_jq.removeClass("icon_reaction_sub_grn");
                    }
                }
                else
                {
                    if (favour_count_jq.hasClass("icon_reaction_sub_grn"))
                    {
                        favour_link_jq.addClass("icon_reaction_sub_grn");
                    }
                    favour_count_jq.hide();
                }
            }
        ).always(
            function () {
                favour_loading.html("");
                is_favour_loading = false;
            }
        );
    };

    var isFavourerListLoading = false;
    G.getFavourerList = function( module , sub_module , type , value, params )
    {
        if (isFavourerListLoading) {
            return;
        }
        isFavourerListLoading = true;
        var favourer_list = document.getElementById("favourer_list");

        var request = new grn.component.ajax.request({
                url: G.get_favourer_list_url,
                method: 'post',
                dataType: 'json',
                grnRedirectOnLoginError: true,
                data : "module=" + module + "&sub_module=" + sub_module + "&type=" + type + "&value=" + value + params
            }
        );

        request.on('beforeShowError', function () {
            favourer_list.innerHTML = "";
            G.closeFavourerDialog();
        });

        request.send().done(
            function(json_obj){
                favourer_list.innerHTML = json_obj.favourer_list;
                G.changeFavourerDialogStyle(type, value);
            }
        ).always(
            function () {
                isFavourerListLoading = false;
            }
        );
    };

    YAHOO.util.Event.onDOMReady(function()
    {
        var fd = new YAHOO.util.DD('favourer_dialog');
        fd.setHandleElId('favourer_dialog_header');

        var dialog = document.getElementById("favourer_dialog");
        var body = document.getElementsByTagName('body')[0];
        dialog.parentNode.removeChild(dialog);
        body.appendChild(dialog);
    });

    G.openFavourerList = function( module , sub_module , type , value, params )
    {
        G.disableOnKeyDown(G.closeFavourerDialog);
        var dialog = $("#favourer_dialog");
        var favourer_list = $("#favourer_list");
        favourer_list.html(G.spinner);

        dialog.click(function (event) {
            event.stopPropagation();
        });

        dialog.show();
        G.changeFavourerDialogStyle(type, value);
        G.getFavourerList(module , sub_module , type , value, params);
    };

    var old_onkeydown_handler = null;

    G.disableOnKeyDown = function( closeHandler )
    {
        if( ! old_onkeydown_handler )
        {
            old_onkeydown_handler = document.onkeydown;
        }
        document.onkeydown = function(e)
        {
            e = (e === undefined) ? event : e;
            if( GRN_Event.keyCode(e) === 27 ) {//ESC key
                return closeHandler();
            }
        };
    };

    G.enableOnKeyDown = function()
    {
        document.onkeydown = old_onkeydown_handler;
        old_onkeydown_handler = null;
    };

    G.closeFavourerDialog = function()
    {
        var dialog = $("#favourer_dialog");
        dialog.hide();
        G.enableOnKeyDown();
    };

    G.changeFavourerDialogStyle = function(type, value)
    {
        var scrollTop;
        var dialog = $("#favourer_dialog");

        if (typeof window.pageYOffset !== "undefined")
        {
            scrollTop = window.pageYOffset;
        }
        else
        {
            var body = ((document.documentElement.clientHeight===0)? document.getElementsByTagName('body')[0] : document.documentElement);
            scrollTop = body.scrollTop;
        }
        var element = document.getElementById("favour_count_" + type + "_" + value);
        var bounds = element.getBoundingClientRect();
        var top = bounds.top + scrollTop + 21 + 'px'; // 21 = element.height + 6px - margin
        var left = bounds.left + 3 + 'px'; // 3 = element.marginLeft

        dialog.css({top: top, left: left});
    };

    $(document).on("click", function closeDialog(e){
        var $target = $(e.target);

        if ($target.hasClass(".icon_reaction_sub_grn") || $target.closest(".icon_reaction_sub_grn").length > 0) {
            return;
        }

        G.closeFavourerDialog();
    });

})(jQuery);