// namespace
grn.base.namespace("grn.page.space.todo.todo_edit");

(function () {
    var G = grn.page.space.todo.todo_edit;

    G.init = function(buttonId, formName) {
        this._formName = formName;
        this._buttonSend = grn.component.button("#" + buttonId);

        this._buttonSend.on("click", this._handleSend.bind(this));
    };

    G.validate = function (form) {
        var validators = new grn.component.validator(form, document.getElementById("FieldToShowErrorMessage"));
        validators.addValidator(new grn.component.validator.TextLengthLongerThan("title", G.ERRMSG_TITLE_IS_REQUIRED, 0) );
        validators.addValidator(new grn.component.validator.CustomValidate(
            function(form) {
                var start = grn.component.validator.util.getDate('start_', form);
                var end = grn.component.validator.util.getDate('end_', form);

                if (G.checkDisableDate(form)) return true;
                if (!start || !end) return false;

                return (start.getTime() <= end.getTime());
            }, G.ERRMSG_INVALID_START_DATE) );

        validators.clearErrorMessage();

        if (validators.validateAll()) {
            grn_onsubmit_common(form);
            return true;
        }
        else {
            return false;
        }
    };

    /**
     * This function validates the date which that provided by user that is valid or not
     * This function return a jQuery.Deferred object
     * @param {Object} form
     * @returns {Object}
     */
    G.validateOnEditScreen = function (form) {
        var deferred_async = jQuery.Deferred();
        var result_valid = G.validate(form);

        if (!result_valid) {
            deferred_async.reject();
            return deferred_async;
        }
        G._buttonSend.showSpinner();
        G._checkDatetimeAsync(form)
            .then(function () {
                grn_onsubmit_common(form);
                deferred_async.resolve();
            })
            .fail(function () {
                deferred_async.reject();
            });

        return deferred_async;
    };

    /**
     * The function checks the values which that provides is valid or not
     * This function return a jQuery.Deferred object
     * @param  {Object} form
     * @returns {Object}
     * @private
     */
    G._checkDatetimeAsync = function (form) {
        var data_checked = G._prepareDataForValidate(form, "end_");
        var request = new grn.component.ajax.request({
            grnUrl: "space/ajax/command_validator_edit_todo",
            method: "post",
            data: data_checked
        });

       return request.send();
    };

    /**
     * The function uses for getting dada to validate at the server-side
     * @param  {Object} form
     * @param {string} prefix
     * @returns {{year, month, day, spid, csrf_ticket: *}}
     * @private
     */

    G._prepareDataForValidate = function (form, prefix) {

        var result_data = {
            "year": jQuery("#" + prefix + "year").val(),
            "month": jQuery("#" + prefix + "month").val(),
            "day": jQuery("#" + prefix + "day").val(),
            "spid": form.elements["spid"].value,
            "no_limit": jQuery(form.elements["nolimit"]).prop("checked"),
            "csrf_ticket": grn.data.CSRF_TICKET
        };

        return result_data;
    };

    G.checkDisableDate = function (form) {
        var prefix = ['start_', 'end_'];
        var suffix = ['year', 'month', 'day'];

        if (!form) return true;
        for (var i = 0; i < prefix.length; i++) {
            for (var j = 0; j < suffix.length; j++) {
                if (form.elements[prefix[i] + suffix[j]].disabled) return true;
            }
        }
        return false;
    };

    G._handleSend = function (event) {

        var todo_assignees = grn.component.member_add.get_instance('todo_assignees');
        todo_assignees.prepareSubmit();

        var form = document.forms[this._formName];
        grn.page.space.todo.todo_edit.validateOnEditScreen(form)
            .then(function () {
                form.submit();
            })
            .always(function () {
                event.stopImmediatePropagation();
                G._buttonSend.hideSpinner();
            })
    };
})();
