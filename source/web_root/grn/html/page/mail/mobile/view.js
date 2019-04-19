(function ()
{
    "use strict";
    if (grn.base.isNamespaceDefined("grn.page.mail.mobile.view"))
    {
        return;
    }
    grn.base.namespace("grn.page.mail.mobile.view");
    var G = grn.page.mail.mobile.view;

    G.maxScale = 3;

    G.setFrameContent = function (bodyContents)
    {
        var f = $("#the_iframe");
        f.html(bodyContents);

        G.upheight(G.transform.scale);
    };

    G.showFullMailContent = function (evt)
    {
        if (evt.preventDefault)
        {
            evt.preventDefault();
        }
        else
        {
            evt.returnValue = false;
        }
        $("#display_image").hide();
        $.ajax(
            {
                type: "post",
                data: G.htmlPostData,
                url: G.htmlMailUrl,
                success: function (data, textStatus, jqXHR)
                {
                    //checking error
                    if (grn.component.mobile_error_handler.hasCybozuError(jqXHR))
                    {
                        return false;
                    }
                    // response success
                    G.setFrameContent(data);
                },
                error: function ()
                {
                }
            });
    };

    $(document).bind("pageinit", function (e)
    {
        if ( $("#footer_bar_a").hasClass("mobile_icon_tool_reply_grn") )
        {
            var mailReplyOperateMenu = $("#mail_reply_operate_menu");
            var operateMenu = $("#operate_menu");
            var mailReplyOperateMenuTriangle = $("#mail_reply_operate_menu_triangle");

            operateMenu.parent().append(mailReplyOperateMenu);
            $("#footer_bar_a").append(mailReplyOperateMenuTriangle);

            $("#footer_bar_a").bind("tap", function ()
            {
                if (mailReplyOperateMenu.is(":visible"))
                {
                    $("#mail_reply_operate_menu").hide();
                    mailReplyOperateMenuTriangle.hide();
                }
                else
                {
                    $("#mail_reply_operate_menu").toggle();
                    mailReplyOperateMenuTriangle.toggle();
                }
            });

            $(document).bind("tap", function (e)
            {
                var target = e.target;
                if (!$(target).parents().is("#mail_reply_operate_menu") && !$(target).is("#mail_reply_operate_menu") && !$(target).parents().is("#footer_bar_a") && !$(target).is("#footer_bar_a"))
                {
                    G.closeReplyOperateMenu();
                }
            });
        }
    });

    G.closeReplyOperateMenu = function ()
    {
        grn.component.mobile_appmenu.closeOperateMenu("mail_reply_operate_menu", "#mail_reply_operate_menu_triangle");
    };

    G.sendReadMail = function (action, name)
    {
        var form = $("form[name=" + name + "]").get(0);
        form.cmd.value = action;

        $.ajax(
            {
                url: form.action,
                dataType: "json",
                data: $(form).serialize(),
                type: "post",
                beforeSend: function ()
                {
                    grn.component.mobile_loading.show();
                },
                success: function (data, textStatus, jqXHR)
                {

                    if (grn.component.mobile_error_handler.hasCybozuError(jqXHR))
                    {
                        grn.component.mobile_error_handler.show(jqXHR);
                    }
                    else
                    {
                        $(form).remove();
                        $("#mail_confirm_separation").remove();
                    }
                },
                error: function (jqXHR, textStatus)
                {
                    if (textStatus !== "abort")
                    {
                        var s = jqXHR.responseText;
                        if (s !== undefined)
                        {
                            document.write(s);
                            document.close();
                        }
                    }
                },
                complete: function ()
                {
                    grn.component.mobile_loading.remove();
                }
            });
    };

    G.upheight = function (startScale)
    {
        var spanHeight,
            scrollWidth,
            scrollHeight;

        var f = $("#the_iframe");

        spanHeight = $("#body_title").height();
        scrollWidth = document.getElementById("the_iframe").scrollWidth;
        scrollHeight = f.get(0).scrollHeight;
        var linkHeight = $('#the_link').outerHeight(true);

        if (startScale !== 1)
        {
            f.width(scrollWidth);
            f.get(0).style.webkitTransform =
                "scale(" + startScale  + ")";
        }
        f.parent().height(scrollHeight*startScale+spanHeight+linkHeight+2);

        if (startScale < 1 && /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent))
        {
            if (navigator.userAgent.match(/OS 7_1_\d[_\d]* like Mac OS X/i))
            {
                f.height(scrollHeight*startScale+spanHeight+linkHeight+2);
            }
        }
    };
    G.transform =
    {
        scale: 1
    };

    G.scale=function()
    {
        var scrollWidth,
            clientWidth,
            startScale;

        var f = $("#the_iframe");

        scrollWidth = document.getElementById("the_iframe").scrollWidth;
        clientWidth = f.width();

        startScale = clientWidth / scrollWidth;
        G.transform.scale = startScale;

        G.upheight(startScale);

        var element,
            touching;

        element = f.get(0);
        touching = false;

        element.addEventListener("touchstart", function(e)
        {
            getXy(e);
        });

        element.addEventListener("touchmove", function(e)
        {
            if (!touching)
            {
                getXy(e);
                return;
            }
            if (e.touches.length === 2)
            {
                getScale(e);
                e.preventDefault();
            }

        });

        element.addEventListener("touchend touchcancel",function(e)
        {
            touching = false;
        });

        var tmpScale,
            oldFingerDistance;

        var getXy = function (e)
        {
            var oneX,
                oneY,
                sedX,
                sedY,
                disX,
                disY;

            if (e.touches.length === 2)
            {
                oneX = e.touches.item(0).pageX;
                oneY = e.touches.item(0).pageY;
                sedX = e.touches.item(1).pageX;
                sedY = e.touches.item(1).pageY;
                disX = sedX - oneX;
                disY = sedY - oneY;
                oldFingerDistance = Math.sqrt(Math.pow(disX, 2) + Math.pow(disY, 2));
            }
            touching = true;
            tmpScale = G.transform.scale;
        };

        var getScale = function (e)
        {
            var sOneX,
                sOneY,
                sSedX,
                sSedY,
                newDisX,
                newDisY,
                newFingerDistance,
                newScale;

            sOneX = e.touches.item(0).pageX;
            sOneY = e.touches.item(0).pageY;
            sSedX = e.touches.item(1).pageX;
            sSedY = e.touches.item(1).pageY;
            newDisX = sSedX - sOneX;
            newDisY = sSedY - sOneY;
            newFingerDistance = Math.sqrt(Math.pow(newDisX, 2) + Math.pow(newDisY, 2));
            newScale = newFingerDistance/ oldFingerDistance;

            G.transform.scale  =tmpScale * newScale;
            G.transform.scale = Math.min(Math.max(G.transform.scale,startScale), G.maxScale);

            G.upheight(G.transform.scale);
        };
    };

    $(window).on( "load", function()
    {
        G.scale();
    });
}());