// namespace
grn.base.namespace("grn.page.space.mobile.discussion._send");

(function () {
    var G = grn.page.space.mobile.discussion._send;

    G.validate = function (e, form) {
        //if (!confirmIfExistFailedFile()) return false;

        var validators = new grn.component.validator_mobile(form, document.getElementById("FieldToShowErrorMessage"));
        validators.addValidator(new grn.component.validator_mobile.TextLengthLongerThan("title", G.ERRMSG_TITLE_IS_REQUIRED, 0) );
        validators.clearErrorMessage();
        if (validators.validateAll()) {
            return true;
        }
        else {
            e.preventDefault();
            e.stopPropagation();
            location.href = '#';
            return false;
        }
    };
})();
