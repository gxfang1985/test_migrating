// namespace
grn.base.namespace("grn.page.space.todo.index");

(function($)
{
    "use strict";
    var G = grn.page.space.todo.index;
    G.remainingMemberUrl = null;
    G.spid = null;
    G.tid = null;
    G.uid = null;
    G.search_text = null;
    G.search_bits = null;
    G.spinner = null;

    G.getLeftRemainingMember = function () {
        $.ajax({
            url: G.remainingMemberUrl,
            dataType: "json",
            data: "spid=" + G.spid + "&tid=" + G.tid + "&uid=" + G.uid + "&search_text=" + G.search_text + "&search_bits=" + G.search_bits,
            type: "post",
            beforeSend: function () {
                $("#remain_span").html("<img style='margin-left: 90px;' src='" + G.spinner + "'>");
            },
            success: function (data, textStatus, jqXHR) {
                if (grn.component.error_handler.hasCybozuError(jqXHR)) {
                    grn.component.error_handler.show(jqXHR);
                }
                else {
                    $("#left_member_list").append(data.leftRemainingMember);
                }
            },
            error: function (jqXHR) {
                if (grn.component.error_handler.hasCybozuError(jqXHR)) {
                    if (typeof jqXHR.responseJSON !== "undefined") {
                        grn.component.error_handler.show(jqXHR);
                    }
                    else {
                        G._showErrorMessage(jqXHR);
                    }
                }
                else if (grn.component.error_handler.hasCybozuLogin(jqXHR)) {
                    location.href = location.href;
                }
                else {
                    G._showErrorMessage(jqXHR);
                }
            },
            complete: function () {
                $("#remain_span").remove();
            }
        });
    };

    G._showErrorMessage = function (jqXHR) {
        var s = jqXHR.responseText;
        if (typeof s !== "undefined") {
            document.write(s);
            document.close();
        }
    };
})(jQuery);
