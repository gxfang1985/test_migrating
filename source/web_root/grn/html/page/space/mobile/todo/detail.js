// namespace
grn.base.namespace("grn.page.space.mobile.todo.detail");

(function () {
    var G = grn.page.space.mobile.todo.detail;
    G.complete = function (spid, tdid, csrf_ticket, callback) {
        if (callback) {
            csrf_ticket += '&from=detail';
        }
        var checkbox = $("a:jqmData(id='checkbox_"+tdid+"')");
        var checkon = checkbox.hasClass('mobile-checkbox-todo-grn');
        checkbox.css({"background":"url('" + G.spinnerImage + "') no-repeat center center","background-size":"auto"});

        $.ajax(
            {
                url: G.complete_url,
                dataType: 'json',
                data: 'spid=' + spid + '&tdid=' + tdid + '&csrf_ticket=' + csrf_ticket,
                type: 'post',
                success: function (json_obj, text_status, transport) {
                    if (grn.component.mobile_error_handler.hasCybozuError(transport)) {
                        grn.component.mobile_error_handler.show(json_obj, G.checkbox_on_off(tdid));
                    }
                    else {
                        checkbox.removeAttr('style');
                        if (checkon) {
                            checkbox.attr('class', 'mobile-checkboxOff-todo-grn');
                        }
                        else {
                            checkbox.attr('class', 'mobile-checkbox-todo-grn');
                        }
                        if (callback) {
                            callback(tdid, json_obj);
                        }
                    }
                },
                error: function (transport) {
                    // This handling is for Forest environment.
                    if (grn.component.mobile_error_handler.hasCybozuError(transport)) {
                        if (typeof transport.responseJSON !== "undefined") {
                            grn.component.mobile_error_handler.show(transport);
                        }
                        else {
                            document.write(transport.responseText);
                            document.close();
                        }
                    }
                    else if (grn.component.mobile_error_handler.hasCybozuLogin(transport)) {
                        location.href = location.href;
                    }
                    else {
                        document.write(transport.responseText);
                        document.close();
                    }
                }
            });
    };
    G.updateCompleteUser = function (todo_id, todo_users) {
        $("div:jqmData(id='users_"+todo_id+"')").html(todo_users);
    };
    G.checkbox_on_off = function (tdid) {
        var checkbox = $("a:jqmData(id='checkbox_"+tdid+"')");
        var checkon = checkbox.hasClass('mobile-checkbox-todo-grn');
        checkbox.removeAttr('style');
        if (checkon) {
            checkbox.attr('class','mobile-checkbox-todo-grn');
        }
        else {
            checkbox.attr('class','mobile-checkboxOff-todo-grn');
        }
    };
})();
