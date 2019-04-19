grn.base.namespace("grn.page.workflow.auto_schedule_register");

(function ($) {

    var G = grn.page.workflow.auto_schedule_register;

    $(document).ready(function () {
        if (!jQuery("#active").prop("checked")) {
            $("dl.event_menu_grn").css("pointerEvents", "none");
            $("#regular").prop("disabled", true);
            $("#all_day").prop("disabled", true);
            $("#schedule_start_item").prop("disabled", true);
            $("#schedule_end_item").prop("disabled", true);
        }

        BuilderDropdownColorControl();
    });

    G.check_disable = function () {
        var active_check = $("#active");
        if (!active_check.prop("checked")) {
            $("#regular").prop("disabled", true);
            $("#all_day").prop("disabled", true);
            $("#schedule_start_item").prop("disabled", true);
            $("#schedule_end_item").prop("disabled", true);
            $("dl.event_menu_grn").css("pointerEvents", "none");
        }
        else {
            $("#regular").prop("disabled", false);
            $("#all_day").prop("disabled", false);
            $("#schedule_start_item").prop("disabled", false);
            $("#schedule_end_item").prop("disabled", false);
            $("dl.event_menu_grn").css("pointerEvents", "auto");
        }
    };
})(jQuery);
