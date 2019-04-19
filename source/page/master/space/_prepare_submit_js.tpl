<script>{literal}
    (function($){
        var submit_button = grn.component.button("#buttonSubmit");
        submit_button.on("click", function(event){
            var form = document.forms["{/literal}{$form_name|escape}{literal}"];

            if (grn.base.isNamespaceDefined("grn.component.member_add")) {
                var member_select_list = grn.component.member_add.get_instance("sUID");
                if (member_select_list) {
                    member_select_list.prepareSubmit();
                }
                var operator_select_list = grn.component.member_add.get_instance("sUID_o");
                var operator_checked = form["operator-set"].checked;
                if (operator_select_list && operator_checked) {
                    operator_select_list.prepareSubmit();
                }
            }

            var validators = new grn.component.validator(form, document.getElementById("errorMessageField"));
            if( typeof form["name-def"] != "undefined")
                validators.addValidator(new grn.component.validator.TextLengthLongerThan("name-def", "{/literal}{cb_msg module="grn.space" key="validate-space-1" replace="true"}{literal}", 0));
            validators.addValidator(new grn.component.validator.SelectMoreThan("selected_users_sUID", "{/literal}{cb_msg module="grn.space" key="validate-space-2" replace="true"}{literal}", 0));
            validators.addValidator(new grn.component.validator.CheckedAndSelectMoreThan("operator-set","selected_users_sUID_o", "{/literal}{cb_msg module="grn.space" key="space-member-set-4" replace="true"}{literal}", 0));
            if( typeof form["isPublic"] != "undefined")
                validators.addValidator(new grn.component.validator.CheckedOnlyOne("isPublic", "{/literal}{cb_msg module="grn.space" key="validate-space-3" replace="true"}{literal}"));
            if( typeof form["id-cid"] != "undefined")
                validators.addValidator(new grn.component.validator.TextLengthLongerThan("id-cid", "{/literal}{cb_msg module="grn.space" key="validate-space-4" replace="true"}{literal}", 0));

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
                document.forms["{/literal}{$form_name|escape}{literal}"].submit();
            }).fail(function () {
                submit_button.hideSpinner();
            });

            event.stopImmediatePropagation();
        });
    })(jQuery);
    {/literal}</script>
