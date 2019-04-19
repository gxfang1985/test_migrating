(function()
{
    "use strict";
    if (grn.base.isNamespaceDefined("grn.page.space.mobile.todo.member_select_breadcrumb"))
    {
        return;
    }

    grn.base.namespace("grn.page.space.mobile.todo.member_select_breadcrumb");
    var G = grn.page.space.mobile.todo.member_select_breadcrumb;

    $(document).ready(function()
    {
        $(window).bind("resize", function()
        {
            G.setBreadcrumbWidth();
        });

        $(document).on("pageshow", "#_select", function(){ // When entering pagetwo
            G.setBreadcrumbWidth();
        });
    });

    G.setBreadcrumbWidth = function()
    {
        $("#left_text_member").css("max-width", ($(document.body).width() * 0.3) + "px");
        G.setRightTextWidth();
    };

    G.setRightTextWidth = function()
    {
        var rightText = $("#right_text_member");
        var bodyWidth = $(document.body).width();

        var leftTextWidth = $("#left_text_member").width();
        var rightTextWidth = bodyWidth - leftTextWidth - 32;

        rightText.css("width", rightTextWidth + "px");
    };
}());