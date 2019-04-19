/*global $:false */
(function()
{
    "use strict";
    if (grn.base.isNamespaceDefined("grn.component.mobile_appmenu"))
    {
        return;
    }

    grn.base.namespace("grn.component.mobile_appmenu");
    var G = grn.component.mobile_appmenu;
    var lastTapTime;
    var testTap = false;

    $(document).bind("pageinit", function()
    {
        G.setPanelHeight();

        var mobileFooter = $("#mobile_footer");
        var mobileFooterBar = $("#mobile_footer_bar");
        var operateMenu = $("#operate_menu");
        var panelDismiss = $("div.ui-panel-dismiss");
        var appmenu = $("#appmenu");

        mobileFooterBar.find("li a").bind("touchstart", function()
        {
            $(this).next().css("display", "block");
        });

        mobileFooterBar.find("li a").bind("touchend", function()
        {
            $(this).next().css("display", "none");
        });

        $("#footer_bar_d.mobile_icon_tool_menu_grn").bind("tap", function()
        {
            testTap = G.tapTime();
            if (testTap) {return false;}

            G.closePanel();
            G.closeOperateMenu("mail_reply_operate_menu", "#mail_reply_operate_menu_triangle");
            G.closeOperateMenu("operate_menu_workflow", "div.mobile_triangle_e_grn");
            if (operateMenu.is(":visible"))
            {
                operateMenu.hide();
                $("div.mobile_triangle_d_grn").hide();
                G.delMaskDiv();
            }
            else
            {
                operateMenu.toggle();
                $("div.mobile_triangle_d_grn").toggle();
                G.addMaskDiv("operate_menu");
                G.setOperateRight();
            }

            return false;
        });

        $("#footer_bar_b.mobile_icon_tool_comment_grn").bind("tap", function()
        {
            G.closePanel();
            G.closeOperateMenu("operate_menu");
            return false;
        });

        $("#footer_bar_a.mobile_icon_tool_reply_grn").bind("tap", function()
        {
            testTap = G.tapTime();
            if (testTap) {return false;}

            G.closePanel();
            G.closeOperateMenu("operate_menu");
            var mailOperate = $("#mail_reply_operate_menu");
            if (mailOperate.is(":visible"))
            {
                G.delMaskDiv();
            }
            else
            {
                G.addMaskDiv("mail_reply_operate_menu", "#mail_reply_operate_menu_triangle");
            }
            return false;
        });

        $("#footer_bar_b.mobile_icon_tool_workflow_grn").bind("tap", function()
        {
            testTap = G.tapTime();
            if (testTap) {return false;}

            G.closePanel();
            G.closeOperateMenu("operate_menu");
            var workflowOperate = $("#operate_menu_workflow");
            if (workflowOperate.is(":visible"))
            {
                G.delMaskDiv();
            }
            else
            {
                G.addMaskDiv("operate_menu_workflow", "div.mobile_triangle_e_grn");
            }

            return false;
        });


        appmenu.on( "panelbeforeclose", function()
        {
            mobileFooter.removeAttr("style");
        });

        appmenu.on( "panelbeforeopen", function()
        {
            var index = panelDismiss.css("z-index");
            index++;
            mobileFooter.css("z-index", index);
            G.setPanelHeight();
        });

        $(document).bind("tap", function(e)
        {
            var target = e.target;
            if (!$(target).parents().is("#operate_menu") && !$(target).is("#operate_menu") &&
                !$(target).parents().is("#mask") && !$(target).is("#mask"))
            {
                G.closeOperateMenu("operate_menu");
            }

            if (!$(target).parents().is("div.ui-panel-dismiss") && !$(target).is("div.ui-panel-dismiss") &&
                !$(target).parents().is("#appmenu") && !$(target).is("#appmenu"))
            {
                var index = panelDismiss.css("z-index");
                index--;
                mobileFooter.css("z-index", index);
            }
        });

        $(window).resize(function()
        {
            G.setOperateRight();
            G.setPanelHeight();
        });
    });

    G.setOperateRight = function()
    {
        var operateMenu = $("#operate_menu");
        var appListLiWidth = $("#footer_bar_e").parent().width();
        var footerBarD = $("#footer_bar_d");
        var operateMenuLiWidth = footerBarD.parent().width();
        var operateMenuAWidth = footerBarD.width();
        var operateMenuWidth = operateMenu.width();

        var operateMenuRight = appListLiWidth + operateMenuLiWidth / 2 - operateMenuAWidth / 2 - operateMenuWidth / 7;
        operateMenu.css("right", operateMenuRight + "px");
    };

    G.setPanelHeight = function()
    {
        var innerPanel = $("div.ui-panel-inner");
        var bodyHeight = $("#panelUl").height();
        if ( bodyHeight !== 0 )
        {
            innerPanel.css("height", (bodyHeight+170) + "px");
            $("#appmenu").css("height", "0px");
        }
    };

    G.closePanel = function()
    {
        var appmenu = $("#appmenu");
        if ( appmenu.hasClass("ui-panel-open") )
        {
            appmenu.panel( "close" );
        }
    };

    G.closeOperateMenu = function(operate, triangle)
    {
        if (typeof triangle === "undefined" || triangle === null)
        {
            triangle = "div.mobile_triangle_d_grn";
        }

        var operateMenu = $("#" + operate);
        var triangleD = $(triangle);
        if (operateMenu.is(":visible"))
        {
            operateMenu.hide();
            triangleD.hide();
            G.delMaskDiv();
        }
    };

    G.addMaskDiv = function(operate, triangle)
    {
        if (typeof triangle === "undefined" || triangle === null)
        {
            triangle = "div.mobile_triangle_d_grn";
        }

        if ( $("#mask").length === 0 )
        {
            var section = "<div id='mask' style='z-index: 900; height: 100%; width: 100%; position: absolute; left: 0px; top: 0px;'></div>";
            $(section).appendTo($("[data-role='page']"));
            $("#mask").bind("tap", function()
            {
                G.closeOperateMenu(operate, triangle);
            });
        }
    };

    G.delMaskDiv = function()
    {
        var mask = $("#mask");
        if ( mask.length )
        {
            mask.remove();
        }
    };

    G.mobile_logout = function()
    {
        var form = $("#form_logout");
        form.submit();
    };

    G.mobile_reload = function()
    {
        G.closeOperateMenu("operate_menu");
        location.reload();
    };

    G.tapTime = function()
    {
        var currTapTime = new Date().getTime();

        if(lastTapTime == null || currTapTime > (lastTapTime + 450)) {
            lastTapTime = currTapTime;
            return false;
        }
        else {
            return true;
        }
    };

}());

