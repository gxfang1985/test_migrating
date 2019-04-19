(function()
{
    "use strict";
    if (grn.base.isNamespaceDefined("grn.page.space.mobile.todo.index"))
    {
        return;
    }

    grn.base.namespace("grn.page.space.mobile.todo.index");
    var G = grn.page.space.mobile.todo.index;

    $(document).ready(function()
    {
        G.setUserNameWidth();
        G.setFilterRowDiscussionNameWidth();
        $(window).bind("resize", function()
        {
            G.setUserNameWidth();
            G.setFilterRowDiscussionNameWidth();
        });
    });

    G.setUserNameWidth = function()
    {
        $(".mobile-list-contents-todo-grn").each(function(){
            var userTodoDiv = $(this).find(".mobile-user-todo-grn");
            var todoDateDiv = $(this).find(".mobile-date-todo-grn");
            var rightBlankWidth = 45;
            var userAndDateBlank = 10;

            var newWidth = $(this).width() - todoDateDiv.outerWidth() - rightBlankWidth - userAndDateBlank;
            userTodoDiv.width(newWidth);
        });
    };

    G.setFilterRowDiscussionNameWidth = function()
    {
        var filterRow = $("#mobile_todoFilter_div");
        var filterRowChildren = filterRow.children();
        var filterThridChildrenWith = filterRow.width()-filterRowChildren.eq(0).outerWidth(true)-filterRowChildren.eq(1).outerWidth(true)-10;

        filterRowChildren.eq(2).width( filterThridChildrenWith );
    };

})();