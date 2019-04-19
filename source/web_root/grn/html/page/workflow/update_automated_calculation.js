grn.base.namespace("grn.page.workflow.update_automated_calculation");

(function ($) {

    "use strict";
    var G = grn.page.workflow.update_automated_calculation;

    $(function () {
        $(".number_type").keydown(function (e) {
            var key = e.which;
            if (key === 13) {
                G.update_automated_calculation();
                return false;
            }
        }).blur(function () {
            G.update_automated_calculation();
        });
    });

    G.update_automated_calculation = function () {
        var request = new grn.component.ajax.request({
                grnUrl: "workflow/ajax/get_automated_calculation_item_data",
                method: "post",
                dataType: "json",
                data: $("#wf_request").serialize()
            }
        );

        request.send().done(function (json_obj) {
            for (var item_id in json_obj) {
                if (json_obj.hasOwnProperty(item_id)) {
                    $("#" + item_id).html(json_obj[item_id]['display_value']);
                    $("#" + item_id).data("calc", json_obj[item_id]['value']);
                }
            }
        });
    };
})(jQuery);