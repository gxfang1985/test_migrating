(function(){
    "use strict";
    if(grn.base.isNamespaceDefined("grn.page.workflow.mobile.operate_menu"))
    {
        return;
    }
    grn.base.namespace("grn.page.workflow.mobile.operate_menu");
    var G = grn.page.workflow.mobile.operate_menu;
    $(document).bind("pageinit",function(){
        var menu = $("#operate_menu_workflow").appendTo("#mobile_footer");
        $("#footer_bar_b").append("<div class='mobile_triangle_e_grn'></div>");
        var triangle = $("#footer_bar_b .mobile_triangle_e_grn");
        $("#footer_bar_b").bind("tap",function(event){
            if(menu.is(":visible") || triangle.is(":visible"))
            {
                menu.hide();
                triangle.hide();
            }
            else
            {
                triangle.show();
                var offset = triangle.offset();
                menu.show();
                menu.css({left : offset.left - 12 + "px", right : "auto"});
            }
            event.stopPropagation();
        });
        $(window).resize(function(){
            if(menu.is(":visible") || triangle.is(":visible"))
            {
                var offset = triangle.offset();
                menu.css({left : offset.left - 12 +"px", right : "auto"});
            }
        });
        $("#mobile_footer").tap(function(event)
        {
            if($(event.target).closest("#operate_menu_workflow").length < 1)
            {
                if(menu.is(":visible") || triangle.is(":visible"))
                {
                    menu.hide();
                    triangle.hide();
                }
            }
        });
    });
    G.closeMenu = function(){
        grn.component.mobile_appmenu.closeOperateMenu("operate_menu_workflow", "#footer_bar_b .mobile_triangle_e_grn");
    };
})();