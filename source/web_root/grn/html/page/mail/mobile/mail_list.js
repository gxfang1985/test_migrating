(function()
{
    "use strict";

    if (grn.base.isNamespaceDefined("grn.page.mail.mobile.mail_list"))
    {
        return;
    }

    grn.base.namespace("grn.page.mail.mobile.mail_list");
    var G = grn.page.mail.mobile.mail_list;
    var checkOn = "mobile_list_btn_checkboxon_grn";
    var checkOff = "mobile_list_btn_checkboxoff_grn";
    var checkedBackground = "mobile_list_link_checkboxon_grn";

    $(document).ready(function(){
        var footer = $("#mobile_footer_bar").parent();
        footer.append($("#mail_list_checkboxon"));

        G.bindCheckAction();
        G.adjustUserNameWidth();

        $(document).on("touchstart", ".mobile_list_navbar_grn a", function(){
            $(this).css("background-color","#a6a6a6");
        });
        $(document).on("touchend", ".mobile_list_navbar_grn a", function(){
            $(this).css("background-color","inherit");
        });
    });

    $(window).bind("resize", function(){
        G.adjustUserNameWidth();
        G.adjustOperationBarWidth();
    });

    G.adjustOperationBarWidth = function()
    {
        var left = $(".mobile_list_navbar_left_grn").outerWidth(true);
        var right = $(".mobile_list_navbar_right_grn").outerWidth(true);
        var rightLink = $(".mobile_list_navbar_rightlink_grn").outerWidth(true);
        var center = $(".mobile_list_navbar_grn").width()-left-right-rightLink;
        $(".mobile_list_navbar_center_grn").width(center);
    };

    G.adjustUserNameWidth = function()
    {
        $(".mobile_list_users_grn").each(function(){
            var textWidth = $(this).parent("li").width() - $(this).next().width() - 5;
            $(this).width(textWidth);
        });
    };

    G.bindCheckAction = function()
    {
        // uncheck
        $(document).on("click", "."+checkOn, function(){
            $(this).addClass(checkOff).removeClass(checkOn);
            $(this).closest("li").removeClass(checkedBackground);
            $(this).next().find("input[type=checkbox]").removeAttr("checked");

            if ( $("#mobile_footer_bar").is(":hidden") && $("#mobile_mail_list").find("input[type=checkbox]:checked").length === 0)
            {
                $("#mail_list_checkboxon").hide();
                $("#mobile_footer_bar").show();
            }
        });

        // check
        $(document).on("click", "."+checkOff, function(){
            $(this).addClass(checkOn).removeClass(checkOff);
            $(this).closest("li").addClass(checkedBackground);
            $(this).next().find("input[type=checkbox]").prop("checked", "checked");

            if ($("#mail_list_checkboxon").is(":hidden") && $("#mobile_mail_list").find("input[type=checkbox]:checked").length > 0)
            {
                $("#mobile_footer_bar").hide();
                $("#mail_list_checkboxon").show();
                G.adjustOperationBarWidth();
            }
        });
    };

    G.clearCheck = function()
    {
        $("#mobile_mail_list").find("input[type=checkbox]:checked").each(function(){
            $(this).removeAttr("checked");
            $(this).closest("span").prev().addClass(checkOff).removeClass(checkOn);
            $(this).closest("li").removeClass(checkedBackground);
        });
        $("#mail_list_checkboxon").hide();
        $("#mobile_footer_bar").show();
    };

    G.countCheckedItem = function()
    {
        G.checkedItem = [];

        var index = 0;
        $("#mobile_mail_list").find("input[type=checkbox]:checked").each(function(i){
            G.checkedItem[i] = $(this).prop("value");
            index++;
        });
        return index;
    };

    G.unread = function()
    {
        G.changeReadStatus("unread");
    };

    G.read = function()
    {
        G.changeReadStatus("read");
    };

    var doRead = false;
    G.changeReadStatus = function(action)
    {
        if (doRead || ! G.countCheckedItem())
        {
            return;
        }
        doRead = true;
        G.ajaxCommandMailList(action, "", function(jsonObj) {
            if (jsonObj)
            {
                var mailIds = jsonObj.result;
                if (mailIds)
                {
                    $.each(mailIds, function(i,v)
                    {
                        $("#"+v).find(".mobile_list_icon_unread_grn").remove();
                        if (action === "unread")
                        {
                            $("#"+v).find("li:first").prepend("<span class=\"mobile_list_icon_unread_grn\"></span>");
                        }
                    });
                }
            }
            doRead = false;
        });
    };

    G.ajaxCommandMailList = function(command, params, callBack)
    {
        var data = "cmd=" + command + "&" + params;
        $.each(G.checkedItem, function(i, v){
            data += "&ids[]=" + v;
        });
        data += "&aid=" + G.aid + "&cid=" + G.cid + "&csrf_ticket=" + grn.data["CSRF_TICKET"];

        grn.component.mobile_loading.show();

        $.ajax({
            url : G.commandMailListUrl,
            dataType : "json",
            data : data,
            type : "post",
            success : function(jsonObj, textStatus, transport)
            {
                if (grn.component.mobile_error_handler.hasCybozuError(transport))
                {
                    grn.component.mobile_error_handler.show(transport);
                    if (typeof callBack === "function")
                    {
                        callBack(false);
                    }
                }
                else
                {
                    if (typeof callBack === "function")
                    {
                        callBack(jsonObj);
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
                grn.component.mobile_loading.remove();
            }
        });
    };

    G.beforeMailDelete = function()
    {
        G.deleteMid = $("form[name='mail/mobile/mail_list'] input[name='ids[]']").filter(function(){
            return this.checked;
        });
    };

    G.afterMailDelete = function()
    {
        if(G.deleteMid.length > 0)
        {
            G.deleteMid.each(function(i,ele){
                $("li#" + ele.value).fadeOut("slow",function(){
                    $("li#" + ele.value).remove();
                });
            });
        }
        $("#mail_list_checkboxon").hide();
        $("#mobile_footer_bar").show();
        G.deleteMid = null;
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