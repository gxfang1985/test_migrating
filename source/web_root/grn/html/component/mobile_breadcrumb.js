(function()
{
    "use strict";
    if (grn.base.isNamespaceDefined("grn.component.mobile_breadcrumb"))
    {
        return;
    }

    grn.base.namespace("grn.component.mobile_breadcrumb");
    var G = grn.component.mobile_breadcrumb;

    $(document).ready(function()
    {
        G.setBreadcrumbWidth();

        $(window).bind("resize", function()
        {
            G.setBreadcrumbWidth();
        });
    });

    G.setBreadcrumbWidth = function()
    {
        $("#left_text").css("max-width", ($(document.body).width() * 0.3) + "px");
        $("#right_include.mobile_select_area_div_grn").css("max-width", ($(document.body).width() * 0.4) + "px");
        G.setRightTextWidth();
    };

    G.setRightTextWidth = function()
    {
        var rightText = $("#right_text");
        var rightTextWidth = rightText.width();
        if (null !== rightTextWidth)
        {
            var bodyWidth = $(document.body).width();

            var leftTextWidth = $("#left_text").width();
            if (null !== leftTextWidth)
            {
                rightTextWidth = bodyWidth - leftTextWidth - 32;
            }
            else
            {
                rightTextWidth = bodyWidth - 8;
            }

            var rightIncludeWidth = $("#right_include").width();
            if (null !== rightIncludeWidth)
            {
                rightTextWidth = rightTextWidth - rightIncludeWidth - 8;
            }

            rightText.css("width", rightTextWidth + "px");
        }
    };
}());