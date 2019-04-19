grn.base.namespace("grn.page.bulletin._send");

(function () {
    var G = grn.page.bulletin._send;

    G.stermYear      = jQuery("#sterm_year");
    G.stermMonth     = jQuery("#sterm_month");
    G.stermDay       = jQuery("#sterm_day");
    G.stermHour      = jQuery("#sterm_hour");
    G.stermMinute    = jQuery("#sterm_minute");
    G.etermYear      = jQuery("#eterm_year");
    G.etermMonth     = jQuery("#eterm_month");
    G.etermDay       = jQuery("#eterm_day");
    G.etermHour      = jQuery("#eterm_hour");
    G.etermMinute    = jQuery("#eterm_minute");
    G.calendarWidget = jQuery("a[name='calendar_w']");

    G.senderOrgCheckEle = jQuery('#choose_group');
    G.senderOrgCheckLable = jQuery('#choose_group_label');
    G.senderOrgSelectEle = jQuery('#select_group');
    G.senderManuallyTextEle = jQuery('#manually_sender');

    G.bulletin_submit = function (button_name, form_name, submit_page, button_obj) {
        var button = grn.component.button( button_obj );
        if (!button || button.isDisabled()) {
            return;
        }

        if (typeof form_name == "undefined" || typeof submit_page == "undefined") {
            return;
        }

        if (grn.base.isNamespaceDefined("grn.component.member_add")) {
            var maintainer = grn.component.member_add.get_instance("bulletin_maintainer");
            if (maintainer) {
                maintainer.prepareSubmit();
            }
        }

        if (button_name != 'save' && button_name != 'send') {
            return;
        }

        if (!confirmIfExistFailedFile()) {
            return;
        }

        var form_object = document.forms[form_name];
        form_object.elements[button_name].value = 1;

        grnEditor = grn.component.editor.Editor.getInstanceById('data_editor_id');
        grnEditor.save();
        grn.component.ajax_submit.ajax_submit(form_object, submit_page, before_send, after_send);

        function before_send() {
            button.showSpinner();
        }

        function after_send(xhr) {
            if (xhr && !grn.component.ajax.error_handler.hasCybozuError( xhr )) {
                return;
            }
            form_object.save.value = '';
            form_object.send.value = '';
            button.hideSpinner();
        }
    };

    G.disableDateSelectEles = function(){
        G.stermYear.prop("disabled", "disabled");
        G.stermMonth.prop("disabled", "disabled");
        G.stermDay.prop("disabled", "disabled");
        G.stermHour.prop("disabled", "disabled");
        G.stermMinute.prop("disabled", "disabled");
        G.etermYear.prop("disabled", "disabled");
        G.etermMonth.prop("disabled", "disabled");
        G.etermDay.prop("disabled", "disabled");
        G.etermHour.prop("disabled", "disabled");
        G.etermMinute.prop("disabled", "disabled");
        G.calendarWidget.attr("style","");
        G.calendarWidget.parent().addClass("disable_filter_grn");

        for (i = 0; i < openIds.length; i++) {
            e = document.getElementById(openIds[i]);
            jQuery(e).hide();
        }
    };

    G.enableDateSelectEles = function(){
        G.stermYear.prop("disabled", false);
        G.stermMonth.prop("disabled", false);
        G.stermDay.prop("disabled", false);
        G.stermHour.prop("disabled", false);
        G.stermMinute.prop("disabled", false);
        G.etermYear.prop("disabled", false);
        G.etermMonth.prop("disabled", false);
        G.etermDay.prop("disabled", false);
        G.etermHour.prop("disabled", false);
        G.etermMinute.prop("disabled", false);
        G.calendarWidget.attr("style","cursor:pointer;");
        G.calendarWidget.parent().removeClass("disable_filter_grn");
    };

    G.enableSenderCreatorEles = function(){
        G.senderOrgCheckLable.removeClass("form_disable").mouseover(function () {
            this.style.color = '#ff0000';
        }).mouseout(function () {
            this.style.color = '';
        });
        if (jQuery("option", G.senderOrgSelectEle).length > 0) {
            G.senderOrgCheckEle.prop("disabled", false);
            if (G.senderOrgCheckEle.is(":checked")) {
                G.senderOrgSelectEle.prop("disabled", false);
            }
        }
        else {
            G.senderOrgCheckEle.prop("disabled", "disabled");
            G.senderOrgSelectEle.prop("disabled", "disabled");
        }

        G.senderManuallyTextEle.prop("disabled", "disabled");
    };

    G.disableSenderCreatorEles = function(){
        G.senderOrgCheckEle.prop("disabled", "disabled");
        G.senderOrgCheckLable.addClass("form_disable").removeAttr("onmouseover").removeAttr("onmouseout").off("mouseover").off("mouseout");
        G.senderOrgSelectEle.prop("disabled", "disabled");
        G.senderManuallyTextEle.prop("disabled", false);
    };

    jQuery(function(){

        G.stermYear.addClass("mRight5");
        G.stermMonth.addClass("mRight5");
        G.stermDay.addClass("mRight3");
        G.stermHour.addClass("mRight5 mLeft10");
        G.stermMinute.addClass("mRight5");
        G.etermYear.addClass("mRight5");
        G.etermMonth.addClass("mRight5");
        G.etermDay.addClass("mRight3");
        G.etermHour.addClass("mRight5 mLeft10");
        G.etermMinute.addClass("mRight5");

        var checkedPeriodRadio = jQuery("input[type='radio'][name='enable_term']:checked");

        if (checkedPeriodRadio.val() !== "1") {
            G.disableDateSelectEles();
        }
        else {
            G.enableDateSelectEles();
        }

        jQuery("input[type='radio'][name='enable_term']").change(function(e){
            if (jQuery(this).val() === "1" && jQuery(this).is(":checked")) {
                G.enableDateSelectEles();
            }
            else {
                G.disableDateSelectEles();
            }
        });


        jQuery("input[type='radio'][name='operator_set']").change(function(e){
            var otherOperatorArea = jQuery("#other_operator_area");
            if (jQuery(this).val() === "1" && jQuery(this).is(":checked")) {
                otherOperatorArea.show();
            }
            else {
                otherOperatorArea.hide();
            }
        });

        var checkedSenderRadio = jQuery("input[type='radio'][name='sender_set']:checked");
        if (checkedSenderRadio.length > 0) {
            if (checkedSenderRadio.val() === "1") {
                G.disableSenderCreatorEles();
            }
            else {
                G.enableSenderCreatorEles();
            }
        }

        jQuery("input[type='radio'][name='sender_set']").change(function(e){
            if (jQuery(this).val() === "1" && jQuery(this).is(":checked")) {
                G.disableSenderCreatorEles();
            }
            else {
                G.enableSenderCreatorEles();
            }
        });
    });
})();
