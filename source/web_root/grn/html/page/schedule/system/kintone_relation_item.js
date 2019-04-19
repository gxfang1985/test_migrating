grn.base.namespace("grn.page.schedule.system.kintone_relation_item");
(function ($) {
    "use strict";
    var G = grn.page.schedule.system.kintone_relation_item;

    /**
     *
     * @param overlayId overlayElementId
     * @constructor
     */
    G.DialogOverlay = function (overlayId) {
        this.overlayElement = $("#" + overlayId);
        this.setBrowserResize();
    };

    G.DialogOverlay.prototype.setBrowserResize = function () {
        var self = this;
        $(window).resize(function () {
            self.resizeElement();
        });
    };

    G.DialogOverlay.prototype.resizeElement = function () {
        var bodyHeight = document.body.clientHeight;
        var bodyWidth = document.body.clientWidth;
        var bodyScrollHeight = Math.max(document.documentElement.scrollHeight,document.body.scrollHeight);
        var bodyScrollWidth = Math.max(document.documentElement.scrollWidth,document.body.scrollWidth);

        this.overlayElement.css("width", Math.max(bodyWidth, bodyScrollWidth));
        this.overlayElement.css("height", Math.max(bodyHeight, bodyScrollHeight));
        this.overlayElement.css("z-index",1000);
        this.overlayElement.css("position", "absolute");
        this.overlayElement.css("top","0px");
        this.overlayElement.css("left","0px");

    };

    /**
     *
     * @param popupId
     * @param radioName
     * @param selectElement
     * @param overlayObject
     * @param errorElement
     * @constructor
     */
    G.TypeDialog = function (popupId, radioName, selectElement, overlayObject, errorElement, radiolabelName) {
        this.popupElement = $("#" + popupId);
        this.overlayObject = overlayObject;
        this.selectElement = $("#" + selectElement);
        this.errorElement = $("#" + errorElement);

        var self = this;
        $("input[type='radio'][name='" + radioName + "']").change(function () {
            var existAppointmentElement = $("input[name='appointment_types[]']");
            for (var i = 0; i < existAppointmentElement.length; i++) {
                if ($(this).val() === existAppointmentElement.eq(i).val()) {
                    self.errorElement.show();
                    break;
                }
                else {
                    self.errorElement.hide();
                }
            }
            self.selectElement.val($(this).val());
        });

        $("label[name='"+ radiolabelName +"']").click(function(){
            $(this).prev().click();
        });

    };


    G.TypeDialog.prototype.resizeElement = function () {

        var hrefPopupViewWidth = this.popupElement.outerWidth(true) / 2;
        var hrefPopupViewHeight = this.popupElement.outerHeight(true) / 2;

        var scrollTop = Math.max(document.documentElement.scrollTop,document.body.scrollTop);
        var scrollLeft = Math.max(document.documentElement.scrollLeft,document.body.scrollLeft);

        this.popupElement.css("left", $(window).width() / 2 - hrefPopupViewWidth + scrollLeft);
        this.popupElement.css("top", $(window).height() / 2 - hrefPopupViewHeight + scrollTop);
    };

    G.TypeDialog.prototype.show = function () {
        if ($("#types_area").hasClass("disable_filter_grn") === false && $("#appointment_type_all").is(":checked") === false) {
            this.overlayObject.overlayElement.show();
            this.overlayObject.resizeElement();
            this.errorElement.hide();
            this.popupElement.show();
            this.resizeElement();
        }
    };

    G.TypeDialog.prototype.hide = function () {
        this.overlayObject.overlayElement.hide();
        this.popupElement.hide();
    };

    G.TypeDialog.prototype.setCancelClick = function (cancelId) {
        var self = this;
        $("#" + cancelId).click(function () {
            self.hide();
        });
    };

    G.SelectAppointmentType = function (dialog) {
        var selectValue = dialog.selectElement.val();

        var existAppointmentElement = $("input[name='appointment_types[]']");
        for (var i = 0; i < existAppointmentElement.length; i++) {
            if (selectValue === existAppointmentElement.eq(i).val()) {
                dialog.errorElement.show();
                return;
            }
        }

        var showDialogElement = $("#show_type_dialog");

        var typeRecordDiv = document.createElement("div");
        typeRecordDiv.setAttribute("class", "item_list_base_grn");

        var typeHiddenInput = document.createElement("input");
        typeHiddenInput.setAttribute("type", "hidden");
        typeHiddenInput.setAttribute("name", "appointment_types[]");
        typeHiddenInput.setAttribute("value", selectValue);

        typeRecordDiv.appendChild(typeHiddenInput);

        var typeSpan1 = document.createElement("span");
        typeSpan1.setAttribute("class", "item_list_block_grn");

        var typeSpan2 = document.createElement("span");
        typeSpan2.setAttribute("class", "nowrap-grn float_left");
        if (typeof selectValue !== "undefined") {
            selectValue = selectValue.escapeHTML();
        }
        else {
            selectValue = "";
        }
        typeSpan2.innerHTML = selectValue;
        typeSpan1.appendChild(typeSpan2);

        var typeA = document.createElement("a");
        typeA.setAttribute("title", G.delete_word);
        typeA.setAttribute("href", "javascript:void(0)");
        $(typeA).click(function () {
            G.delectAppointmentTypeRecord(this);
        });

        var typeSpan3 = document.createElement("span");
        typeSpan3.setAttribute("class", "icon-close-sub-grn v-allign-middle mLeft10 float_right");

        typeA.appendChild(typeSpan3);
        typeSpan1.appendChild(typeA);
        typeRecordDiv.appendChild(typeSpan1);

        showDialogElement.before(typeRecordDiv);

        dialog.hide();
    };

    G.KintoneRecord = function (kintoneid, deleteW, idExplain, fieldCode, addFieldCode) {
        this.kintone_id_word = kintoneid;
        this.delete_word = deleteW;
        this.id_explain_word = idExplain;
        this.field_code_word = fieldCode;
        this.add_field_code_word = addFieldCode;
    };

    G.KintoneRecord.prototype.addKintoneRecordElements = function (addElement) {
        if ($(addElement).parent().hasClass("disable_filter_grn")) {
            return;
        }
        var self = this;

        var divA = document.createElement("div");
        divA.setAttribute("name", "k_record_items");

        var table = document.createElement("table");
        table.setAttribute("class", "setting_base_type1_grn");
        table.setAttribute("style", "min-width:550px;");
        divA.appendChild(table);

        var tr = document.createElement("tr");
        table.appendChild(tr);

        var tdA = document.createElement("td");
        tr.appendChild(tdA);

        var tdB = document.createElement("td");
        tdB.setAttribute("class", "setting_base_type1_action_grn");
        tr.appendChild(tdB);

        var aA = document.createElement("a");
        aA.setAttribute("href", "javascript:void(0)");
        aA.setAttribute("class", "icon-delete-grn");
        aA.innerHTML = this.delete_word;
        tdB.appendChild(aA);

        $(aA).click(function () {
            self.deleteKintoneRecordElements(this);
        });

        var divB = document.createElement("div");
        divB.setAttribute("class", "mBottom5");
        tdA.appendChild(divB);

        var spanA = document.createElement("span");
        spanA.setAttribute("class", "sub_title");
        spanA.innerHTML = this.kintone_id_word;
        divB.appendChild(spanA);

        var divC = document.createElement("div");
        divC.setAttribute("class", "mBottom10");
        tdA.appendChild(divC);

        var inputA = document.createElement("input");
        inputA.setAttribute("name", "k_app_id_edit");
        inputA.setAttribute("value", "");
        inputA.setAttribute("size", "50");
        inputA.setAttribute("maxlength", "100");
        inputA.setAttribute("type", "text");
        inputA.setAttribute("style", "width:305px;");
        divC.appendChild(inputA);
        $(inputA).change(function () {
            G.changeIdElment(this);
        });
        $(inputA).keyup(function(){
            G.changeIdElment(this);
        });
        var  interval_app_id_edit;
        $(inputA).focus(function () {
            G.focusAppIdEditElement = this;
            interval_app_id_edit = setInterval("grn.page.schedule.system.kintone_relation_item.changeIdElmentHandle()",1000);
        });
        $(inputA).blur(function(){
            clearInterval(interval_app_id_edit);
            G.changeIdElment(this);
        });

        var inputB = document.createElement("input");
        inputB.setAttribute("name", "k_app_id_value[]");
        inputB.setAttribute("type", "hidden");
        divC.appendChild(inputB);

        var divD = document.createElement("div");
        divD.setAttribute("class", "icon_information_sub_grn mTop5");
        divC.appendChild(divD);

        var spanB = document.createElement("span");
        spanB.setAttribute("class", "messageSub-grn text_color_sub_grn");
        spanB.innerHTML = this.id_explain_word;
        divD.appendChild(spanB);

        var divE = document.createElement("div");
        tdA.appendChild(divE);

        var divF = document.createElement("div");
        divF.setAttribute("class", "mBottom5");
        divE.appendChild(divF);

        var spanC = document.createElement("span");
        spanC.setAttribute("class", "sub_title");
        spanC.innerHTML = this.field_code_word;
        divF.appendChild(spanC);

        var divG = document.createElement("div");
        divG.setAttribute("class", "disable_filter_grn");
        divG.setAttribute("name", "add_kintone_app_btn");
        divE.appendChild(divG);

        var aB = document.createElement("a");
        aB.setAttribute("href", "javascript:void(0)");
        aB.setAttribute("class", "icon_add_grn");
        aB.innerHTML = this.add_field_code_word;
        divG.appendChild(aB);
        $(aB).click(function () {
            G.kDialog.show(this);
        });

        $(addElement).parent().before(divA);

        G.kintoneAppIsMore($(addElement).parent());
    };

    G.KintoneRecord.prototype.deleteKintoneRecordElements = function (deleteElement) {
        if ($(deleteElement).parent().parent().parent().parent().is("table")) {
            $(deleteElement).parent().parent().parent().parent().parent().remove();
        }
        else {
            $(deleteElement).parent().parent().parent().parent().remove();
        }

        G.kintoneAppIsMore($("div[name='add_k_app']"));
    };

    G.kintoneAppIsMore = function (addElement) {
        if ($("div[name='k_record_items']").length >= 10) {
            addElement.addClass("disable_filter_grn");
        }
        else {
            addElement.removeClass("disable_filter_grn");
        }
    };

    G.delectAppointmentTypeRecord = function (self) {
        if ($("#types_area").hasClass("disable_filter_grn") === false && $("#appointment_type_all").is(":checked") === false) {
            $(self).parent().parent().remove();
        }
    };

    G.deleteFieldCode = function (deleteElement) {
        var recordElement = $(deleteElement).parent().parent();
        var recordElementParent = recordElement.parent();
        recordElement.remove();
        G.kintoneFieldIsMore(recordElementParent);
    };

    G.kintoneFieldIsMore = function (element) {
        if (element.children().length >= 12) {
            element.children().last().addClass("disable_filter_grn");
        }
        else {
            element.children().last().removeClass("disable_filter_grn");
        }

        if (element.children().length === 2) {
            element.parent().children().eq(1).children().eq(0).prop("disabled", false);
        }
        else {
            element.parent().children().eq(1).children().eq(0).prop("disabled", "disabled");
        }
    };

    /**
     *
     * @param popupId
     * @param contentId
     * @param overlayObject
     * @param okId
     * @param errorId
     * @constructor
     */
    G.KintoneDialog = function (popupId, contentId, overlayObject, okId, errorId) {
        this.popupElement = $("#" + popupId);
        this.contentElement = $("#" + contentId);
        this.overlayObject = overlayObject;
        this.okElement = $("#" + okId);
        this.errorElement = $("#" + errorId);
        this.setOkClick(okId);
    };

    G.KintoneDialog.prototype.resizeElement = function () {
        var hrefPopupViewWidth = this.popupElement.outerWidth(true) / 2;
        var hrefPopupViewHeight = this.popupElement.outerHeight(true) / 2;

        var scrollTop = Math.max(document.documentElement.scrollTop,document.body.scrollTop);
        var scrollLeft = Math.max(document.documentElement.scrollLeft,document.body.scrollLeft);

        this.popupElement.css("left", $(window).width() / 2 - hrefPopupViewWidth + scrollLeft);
        this.popupElement.css("top", $(window).height() / 2 - hrefPopupViewHeight + scrollTop);
    };

    /**
     *
     * @param showDialogElement
     */
    G.KintoneDialog.prototype.show = function (showDialogElement) {
        if ($(showDialogElement).parent().hasClass("disable_filter_grn")) {
            return;
        }
        this.overlayObject.overlayElement.show();
        this.overlayObject.resizeElement();
        this.okElement.hide();
        this.errorElement.hide();
        this.popupElement.show();
        this.resizeElement();
        this.contentElement.children().remove();
        this.showDialogElement = showDialogElement;
        this.appId = $(showDialogElement).parent().parent().parent().children().eq(1).children().eq(0).val();
        G.doAjaxGetDialogData(this, showDialogElement);
        this.resizeElement();
    };

    G.KintoneDialog.prototype.hide = function () {
        this.contentElement.children().remove();
        this.overlayObject.overlayElement.hide();
        this.popupElement.hide();
    };

    /**
     *
     * @param cancelId
     */
    G.KintoneDialog.prototype.setCancelClick = function (cancelId) {
        var self = this;
        $("#" + cancelId).click(function () {
            self.hide();
        });
    };

    G.KintoneDialog.prototype.setOkClick = function (okId) {
        var self = this;
        $("#" + okId).click(function () {
            var existFieldCodeElement = $("input[name='field_code"+ self.appId+"[]']");
            for (var i = 0; i < existFieldCodeElement.length; i++) {
                if ($("#k_dialog_selected_val").val() === existFieldCodeElement.eq(i).val()) {
                    self.errorElement.show();
                    return;
                }
            }
            G.addFieldElement(self);
            self.hide();
        });
    };

    G.addFieldElement = function (dialog) {

        var div = document.createElement("div");
        div.setAttribute("class", "item_list_base_grn");

        var input = document.createElement("input");
        input.setAttribute("type", "hidden");
        input.setAttribute("name", "field_code" + dialog.appId + "[]");
        input.setAttribute("value", $("#k_dialog_selected_val").val());
        div.appendChild(input);

        var spanA = document.createElement("span");
        spanA.setAttribute("class", "item_list_block_grn");
        div.appendChild(spanA);

        var spanB = document.createElement("span");
        spanB.setAttribute("class", "nowrap-grn float_left");
        spanB.innerHTML = $("#k_dialog_selected_val").val();
        spanA.appendChild(spanB);

        var a = document.createElement("a");
        a.setAttribute("title", G.delete_word);
        a.setAttribute("onclick", "__itemJS.deleteFieldCode(this);");
        a.setAttribute("href", "javascript:void(0)");
        spanA.appendChild(a);

        var spanC = document.createElement("span");
        spanC.setAttribute("class", "icon-close-sub-grn v-allign-middle mLeft10 float_right");
        a.appendChild(spanC);

        $(dialog.showDialogElement).parent().before(div);
        G.kintoneFieldIsMore($(div).parent());

    };

    var deleteIllegalChar = function (string) {
        return string.replace(/[<>&"'\\]/gi, "a");
    };

    // check field type is supported
    var isSupportedFieldType = function (type) {
        var type_list = ["SINGLE_LINE_TEXT", "NUMBER", "CALC","MULTI_LINE_TEXT","RICH_TEXT",
            "CHECK_BOX", "RADIO_BUTTON", "DROP_DOWN", "MULTI_SELECT", "FILE",
            "DATE", "TIME", "DATETIME", "LINK", "USER_SELECT"];
        return $.inArray(type, type_list) > -1;
    };

    G.doAjaxGetDialogData = function (dialog, showDialogBtn) {
        var targeturl = "/k/v1/form.json";

        var errorDiv = document.createElement("div");
        errorDiv.setAttribute("class","icon_attention_grn mTop10 mLeft10 mRight10");
        var errorSpan = document.createElement("span");
        errorSpan.setAttribute("class","attentionMessage-grn");
        errorDiv.appendChild(errorSpan);

        var optdata = '{ "app":"' + deleteIllegalChar(dialog.appId) + '"}';

        var request = new grn.component.ajax.request({
                url: targeturl,
                dataType: "json",
                data: JSON.parse(optdata),
                method: "GET"
            }
        );

        request.send()
            .done(function(data, status, xhr){
                var data_count = data.properties.length;
                if (data_count < 1) {
                    errorSpan.innerHTML = "no data";
                    dialog.contentElement.append(errorDiv);
                    return;
                }
                var table = document.createElement("table");
                table.setAttribute("class", "table_grn");

                var tbody = document.createElement("tbody");
                table.appendChild(tbody);

                for (var i = 0; i < data_count; i++) {
                    if (typeof data.properties[i].code !== "undefined" && typeof data.properties[i].type !== "undefined") {
                        if (!isSupportedFieldType(data.properties[i].type)) {
                            continue;
                        }

                        var tr = document.createElement("tr");
                        var tdA = document.createElement("td");
                        tr.appendChild(tdA);
                        var input = document.createElement("input");
                        input.setAttribute("type", "radio");
                        input.setAttribute("value", data.properties[i].code);
                        input.setAttribute("name", "field_value");
                        input.setAttribute("class", "radiobutton_grn");
                        if (i === 0) {
                            $("#k_dialog_selected_val").val(data.properties[i].code);
                            input.setAttribute("checked", "true");
                        }
                        tdA.appendChild(input);
                        G.setFieldRadioChange(input, dialog);

                        var label = document.createElement("label");
                        label.setAttribute("onmouseout", "this.style.color=''");
                        label.setAttribute("onmouseover", "this.style.color='#ff0000'");
                        label.innerHTML = data.properties[i].code;
                        G.setFieldLabelClick(label);
                        tdA.appendChild(label);

                        var tdB = document.createElement("td");
                        if (typeof data.properties[i].label !== "undefined") {
                            tdB.innerHTML = data.properties[i].label.escapeHTML();
                        }
                        else {
                            tdB.innerHTML = "";
                        }
                        tr.appendChild(tdB);
                        table.appendChild(tr);
                    }
                }

                dialog.contentElement.append(table);
                dialog.okElement.show();
            });

        request.on('beforeShowError', function (e, xhr) {
            e.preventDefault();

            if (typeof xhr.responseJSON !== "undefined") {
                if (xhr.responseJSON.code === "GAIA_IL23") {
                    var error_word = G.k_app_error_part_one + dialog.appId.escapeHTML() + G.k_app_error_part_two;
                    errorSpan.innerHTML = error_word;
                }
                else {
                    errorSpan.innerHTML = xhr.responseJSON.message;
                }
                dialog.contentElement.append(errorDiv);
            }
            else {
                dialog.contentElement.html(xhr.responseText);
            }
        });
    };

    G.setFieldRadioChange = function (radio, dialog) {
        $(radio).change(function () {
            $("#k_dialog_selected_val").val($(this).val());
            var existFieldCodeElement = $("input[name='field_code"+ dialog.appId+"[]']");
            for (var i = 0; i < existFieldCodeElement.length; i++) {
                if ($("#k_dialog_selected_val").val() === existFieldCodeElement.eq(i).val()) {
                    dialog.errorElement.show();
                    break;
                }
                else{
                    dialog.errorElement.hide();
                }
            }
        });
    };

    G.setFieldLabelClick = function(label){
        $(label).click(function(){
            $(this).prev().click();
        });
    };

    G.saveData = function (formName, overlay) {
        var $form = $("form[name='" + formName + "']");

        var spinner = $("#save_spinner");
        spinner.show();
        overlay.overlayElement.show();
        overlay.resizeElement();

        var request = new grn.component.ajax.request({
                url: $form.attr("action"),
                dataType: "json",
                data: $form.serialize(),
                method: "post"
            }
        );

        request.send()
            .done(function(json_obj, text_status, transport){
                spinner.hide();
                overlay.overlayElement.hide();
                G.toParentPage();
            })
            .fail(function(transport){
                spinner.hide();
                overlay.overlayElement.hide();
            });
    };

    G.toParentPage = function(){
        window.location.href = G.parent_url;
    };


    G.changeIdElment = function(self){
        if ($(self).val() === "") {
            $(self).parent().parent().children().last().children().last().addClass("disable_filter_grn");
        }
        else{
            $(self).parent().parent().children().last().children().last().removeClass("disable_filter_grn");
        }
        $(self).next().eq(0).val( $(self).val() );
    };

    G.changeIdElmentHandle = function () {
        if ($(G.focusAppIdEditElement).val() === "") {
            $(G.focusAppIdEditElement).parent().parent().children().last().children().last().addClass("disable_filter_grn");
        }
        else{
            $(G.focusAppIdEditElement).parent().parent().children().last().children().last().removeClass("disable_filter_grn");
        }
        $(G.focusAppIdEditElement).next().eq(0).val( $(G.focusAppIdEditElement).val() );
    };

    G.focusAppIdEditElement = null;

    $(document).ready(function () {
        $("#appointment_type_all").change(function () {
            if ($("#appointment_type_all").is(":checked")) {
                $("#types_area").addClass("disable_filter_grn");
            }
            else {
                $("#types_area").removeClass("disable_filter_grn");
            }
        });

        $("input[name='k_app_id_edit']").change(function () {
            G.changeIdElment(this);
        });

        $("input[name='k_app_id_edit']").keyup(function(){
            G.changeIdElment(this);
        });

        var  interval_app_id_edit;
        $("input[name='k_app_id_edit']").focus(function () {
            G.focusAppIdEditElement = this;
            interval_app_id_edit = setInterval("grn.page.schedule.system.kintone_relation_item.changeIdElmentHandle()",1000);
        });

        $("input[name='k_app_id_edit']").blur(function(){
            clearInterval(interval_app_id_edit);
            G.changeIdElment(this);
        });
    });
})(jQuery);
