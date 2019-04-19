grn.base.namespace("grn.page.bulletin.system.common_set");

(function ($) {
    "use strict";
    $(function () {
        $("#enable_manually_enter_sender").click(function () {
            if ($("#enable_manually_enter_sender").prop("checked")) {
                enableRadio();
            }
            else {
                disableRadio();
            }
        });
    });

    function disableRadio() {
        $("#default_value_from_label").addClass("form_disable");
        $("#user_name").prop("disabled", true);
        $("#user_name_label").addClass("form_disable").removeAttr("onmouseover").removeAttr("onmouseout").off("mouseover").off("mouseout");
        $("#input_manually").prop("disabled", true);
        $("#input_manually_label").addClass("form_disable").removeAttr("onmouseover").removeAttr("onmouseout").off("mouseover").off("mouseout");
    }

    function enableRadio() {
        $("#default_value_from_label").removeClass("form_disable");
        $("#user_name").prop("disabled", false);
        $("#user_name_label").removeClass("form_disable").mouseover(function () {
            this.style.color = '#ff0000';
        }).mouseout(function () {
            this.style.color = '';
        });
        $("#input_manually").prop("disabled", false);
        $("#input_manually_label").removeClass("form_disable").mouseover(function () {
            this.style.color = '#ff0000';
        }).mouseout(function () {
            this.style.color = '';
        });
    }
})(jQuery);
