grn.base.namespace("grn.page.schedule.system.kintone_relation");
(function($)
{
    "use strict";
    var G = grn.page.schedule.system.kintone_relation;

    G.Dialog =  function(overlayId, popupId, okId, cancelId, spinnerId, formId){
        this.overlayElement = $("#"+overlayId);
        this.popupElement = $("#"+popupId);
        this.okElement = $("#"+okId);
        this.cancelElement= $("#"+cancelId);
        this.spinnerELement = $("#"+spinnerId);
        this.formElement = $("#"+formId).eq(0);

        this.setBrowserResize();
        this.setOnClickCancel();
        this.setOnClickOk();
    };

    G.Dialog.prototype.show = function(){
        this.initDialogElement();
        this.spinnerHide();
        this.overlayElement.show();
        this.popupElement.show();
    };

    G.Dialog.prototype.hide = function(){
        this.overlayElement.hide();
        this.popupElement.hide();
    };

    G.Dialog.prototype.spinnerShow = function(){
        this.okElement.hide();
        this.spinnerELement.show();
        this.cancelElement.hide();
    };

    G.Dialog.prototype.spinnerHide = function(){
        this.okElement.show();
        this.cancelElement.show();
        this.spinnerELement.hide();
    };

    G.Dialog.prototype.initDialogElement = function () {
        var bodyHeight = document.body.clientHeight;
        var bodyWidth = document.body.clientWidth;
        var bodyScrollHeight = Math.max(document.documentElement.scrollHeight,document.body.scrollHeight);
        var bodyScrollWidth = Math.max(document.documentElement.scrollWidth,document.body.scrollWidth);

        this.overlayElement.css("width", Math.max(bodyWidth,bodyScrollWidth));
        this.overlayElement.css("height", Math.max(bodyHeight,bodyScrollHeight));

        var hrefPopupViewWidth = this.popupElement.outerWidth(true)/2;
        var hrefPopupViewHeight = this.popupElement.outerHeight(true)/2;

        var scrollTop = Math.max(document.documentElement.scrollTop,document.body.scrollTop);
        var scrollLeft = Math.max(document.documentElement.scrollLeft,document.body.scrollLeft);

        this.popupElement.css("left", $(window).width() / 2 - hrefPopupViewWidth + scrollLeft);
        this.popupElement.css("top", $(window).height() / 2 - hrefPopupViewHeight + scrollTop);

    };

    G.Dialog.prototype.setBrowserResize = function () {
        var self = this;
        $(window).resize(function(){
            self.initDialogElement();
        });
    };

    G.Dialog.prototype.setOnClickCancel = function(){
        var self = this;
        this.cancelElement.click(function(){
            self.hide();
        });
    };

    G.Dialog.prototype.setOnClickOk = function(){
        var self = this;
        this.okElement.click(function(){
            G.doAjaxDeleteRelation(self, self.formElement);
        });

    };

    G.Dialog.prototype.setHiddenInputValue = function(elementId, value){
        $("#"+elementId).val(value);
    };

    G.Dialog.prototype.setElementHtml = function(elementId, itemId){
        var data = $("#relation_name"+itemId).val();
        if (typeof data !== "undefined") {
            data = data.escapeHTML();
        }
        else {
            data = "";
        }
        $("#"+elementId).html(data);
    };

    G.doAjaxDeleteRelation = function(dialog, form){

        dialog.spinnerShow();

        var request = new grn.component.ajax.request({
                url: form.attr("action"),
                dataType: "json",
                data: $(form).serialize(),
                method: "post"
            }
        );

        request.send()
            .done(function(json_obj, text_status, transport){
                window.location.reload();
            })
            .always(function(){
                dialog.hide();
            });
    };

})(jQuery);
