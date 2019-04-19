(function ($) {
    var submit_button = grn.component.button("#buttonSubmit");
    submit_button.on("click", function (event) {
        var form = document.forms["space/config_expiration_date"];
        var validators = new grn.component.validator(form, document.getElementById("errorMessageField"));

        var $container_exp_date = $(".js_expiration_date");
        if ($container_exp_date.find("#expiration_date_month").length > 0) {
            //When the General setting of space does not allow used unlimited
            var is_need_check = $container_exp_date.find("#unlimited").length < 1 && $container_exp_date.find("#limited").length < 1;
            if (is_need_check || $container_exp_date.find("#limited").prop("checked")) {
                validators.addValidator(new grn.component.validator.DatetimeAsync("expiration_date_", "space/ajax/command_validator_create_space"));
            }
        }
        validators.clearErrorMessage();
        submit_button.showSpinner();
        validators.validateAllAsync().then(function () {
            form.submit();
        }).fail(function () {
            submit_button.hideSpinner();
        });

        event.stopImmediatePropagation();
    });
})(jQuery);

