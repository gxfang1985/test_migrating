// namespace
grn.base.namespace("grn.page.space.discussion._send");

(function () {
    var G = grn.page.space.discussion._send;

    G.init = function(buttonId, formName) {
        this._formName = formName;
        this._buttonSend = grn.component.button("#" + buttonId);

        this._buttonSend.on("click", this._handleSend.bind(this));
    };

    G.validate = function (form) {
        if (!confirmIfExistFailedFile()) return false;

        var validators = new grn.component.validator(form, document.getElementById("FieldToShowErrorMessage"));
        validators.addValidator(new grn.component.validator.TextLengthLongerThan("title", G.ERRMSG_TITLE_IS_REQUIRED, 0) );
        validators.clearErrorMessage();
        return validators.validateAll();
    };

    G._handleSend = function(event) {
        var form = document.forms[this._formName];
        if(grn.page.space.discussion._send.validate(form)) {
            form.submit();
        }else{
            event.stopImmediatePropagation();
        }
    };
})();
