(function()
{
    "use strict";

    if (grn.base.isNamespaceDefined("grn.component.mobile_folder_tree"))
    {
        return;
    }

    grn.base.namespace("grn.component.mobile_folder_tree");
    var G = grn.component.mobile_folder_tree;
    var openClass = "mobile_folderlist_icon_arrowopen_grn";
    var closeClass = "mobile_folderlist_icon_arrowclose_grn";
    var spinnerClass = "mobile_icon_spinner_grn";

    $(document).ready(function(){
        G.bindExpandAction();
        G.adjustTextOverflow();
    });

    $(window).bind("resize", function(){
        G.adjustTextOverflow();
    });

    G.adjustTextOverflow = function()
    {
        $("#"+G.treeName).find("li[id^='parent_child_']").each(function(i){
            var divH = $(this).height();
            var aLink = $(this).children("a");
            var text = aLink.children().eq(0);

            var ellipsisDiv = aLink.find("div.mobile_ellipsis_mark_grn");
            if (text.outerHeight() > divH + 1)
            {
                if (ellipsisDiv.length === 0)
                {
                    aLink.append("<div class=\"mobile_ellipsis_mark_grn\">...</div>");
                }
            }
            else
            {
                if (ellipsisDiv.length > 0)
                {
                    ellipsisDiv.remove();
                }
            }
        });
    };

    G.bindExpandAction = function()
    {
        $(document).on("click", "." + openClass, function(){
            var parentId = this.id;
            G.collapse(parentId);
            if ($("#"+parentId).hasClass(openClass))
            {
                $("#"+parentId).removeClass(openClass);
                $("#"+parentId).addClass(closeClass);
            }
        });
        $(document).on("click", "." + closeClass, function(){
            G.expand(this);
        });
        $(document).on("touchstart", "." + openClass + ", ." + closeClass, function(){
            $(this).css("background-color","#dddddd");
        });
        $(document).on("touchend", "." + openClass + ", ." + closeClass, function(){
            $(this).css("background-color","inherit");
        });
    };

    G.expand = function(item)
    {
        var paramName = G.paramName;
        var paramId = item.id;

        var deepInfo= $(item).next().children().first().attr("id").split("_");
        var deep = parseInt(deepInfo[1], 0);

        var requestData = G.linkUrlParams + "&" + paramName + "=" + paramId + "&deep=" + deep;

        $(item).removeClass(closeClass).addClass(spinnerClass);
        $.ajax(
        {
            url : G.asyncUrl,
            dataType : "json",
            data : requestData,
            type : "post",
            success : function(jsonObj, textStatus, transport)
            {
                if (grn.component.mobile_error_handler.hasCybozuError(transport))
                {
                    grn.component.mobile_error_handler.show(transport);
                }
                else
                {
                    if (jsonObj.subFolderList !== "none")
                    {
                        var tree = jsonObj.subFolderList;
                        $(item).parent().after(tree);
                        $("#"+G.treeName).listview("refresh");
                        G.adjustTextOverflow();
                        $(item).addClass(openClass);
                    }
                }
            },
            error : function(transport, textStatus)
            {
                if (textStatus !== "abort")
                {
                    G.showErrorMessage(transport);
                }
            },
            complete : function()
            {
                $(item).removeClass(spinnerClass);
            }
        });
    };

    G.collapse = function(parentId)
    {
        var child = $("#"+G.treeName).find("li[id^='parent_child_"+ parentId +"']");
        $.each(child, function()
        {
            var childIdInfo = $(this).attr("id").split("parent_child_" + parentId+ "_");
            var childId = parseInt(childIdInfo[1], 0);
            if (typeof childId !== "undefined")
            {
                G.collapse(childId);
            }
        });
        child.remove();
    };

    G.showErrorMessage = function(request)
    {
        var s = request.responseText;
        if (s !== undefined)
        {
            document.write(s);
            document.close();
        }
    };

})();