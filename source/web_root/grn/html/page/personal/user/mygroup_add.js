(function ($) {
    "use strict";

    grn.base.namespace("grn.page.personal.user.mygroup");

    var MyGroup = grn.page.personal.user.mygroup;
    var i18n = grn.component.i18n;
    var request;

    MyGroup.init = function () {
        this.form = $("form[name='personal/user/mygroup_add']");
        this.mgid = '';
        this.mygroupName = $("input[name='name']");
        this.mygroupNotes = $("#textarea_id");
        this.mygroupMembers = $("input[name='selected_users_sUID']");
        this.mygroupFacilities = $("input[name='selected_users_sITEM']");
        this.mygroup_add_submit_bt = $("#mygroup_add_submit");
        this.validation_field = $("#errorMessageField");

        this.bindEvent();
    };

    MyGroup._prepareSubmit = function () {
        if (grn.base.isNamespaceDefined("grn.component.member_add")) {
            var member_select = grn.component.member_add.get_instance("member_select");
            if (member_select) {
                member_select.prepareSubmit();
            }
        }
        if (grn.base.isNamespaceDefined("grn.component.facility_add")) {
            var facility_select = grn.component.facility_add.get_instance("facility_select");
            if (facility_select) {
                facility_select.prepareSubmit();
            }
        }
    };

    MyGroup._processAddMyGroup = function () {
        var self = this;
        request = new grn.component.ajax.request({
            grnUrl: "personal/user/ajax/command_create_mygroup",
            method: "post",
            data: {
                name: this.mygroupName.val(),
                description: this.mygroupNotes.val(),
                csrf_ticket: grn.data["CSRF_TICKET"]
            }
        });

        var request_result = request.send();

        request_result.done(function (json_obj) {
            self.mgid = json_obj.mgid;
            if (self.mygroupMembers.val() !== "" || self.mygroupFacilities.val() !== "") {
                self._processAddMygroupMembers(json_obj.mgid);
            }
            else {
                var mygroup_list_url = grn.component.url.page("personal/user/mygroup_list", {mgid: json_obj.mgid});
                self._handleAfterAddedMygroup(mygroup_list_url);
            }
        });
    };

    MyGroup._processAddMygroupMembers = function (mygroup_id) {
        var self = this;
        request = new grn.component.ajax.request({
            grnUrl: "personal/user/ajax/command_add_members_to_mygroup",
            method: "post",
            data: {
                mygroup_id: mygroup_id,
                members: this.mygroupMembers.val(),
                facilities: this.mygroupFacilities.val(),
                csrf_ticket: grn.data["CSRF_TICKET"]
            }
        });

        request.on("errorClosed", this._handleAfterAddedMygroup.bind(this));
        var request_result = request.send();

        request_result.done(function (json_obj) {
            self._handleAfterAddedMygroup(json_obj.redirect_link);
        });
    };

    MyGroup._handleAfterAddedMygroup = function (redirect_link) {
        if (typeof redirect_link !== 'undefined') {
            window.location = redirect_link;
        }

        window.location = grn.component.url.page("personal/user/mygroup_list", {mgid: this.mgid});
    };

    MyGroup.processAddMyGroup = function () {
        if (this._validationData()) {
            this._prepareSubmit();
            this._processAddMyGroup();
        }
    };

    MyGroup.bindEvent = function () {
        this.mygroup_add_submit_bt.on("click", this.processAddMyGroup.bind(this));
    };

    MyGroup._validationData = function () {
        var validators = new grn.component.validator(this.form[0], this.validation_field[0]);
        var error_string = i18n.cbMsg("grn.personal.user", "GRN_PRS_US-61");

        validators.addValidator(new grn.component.validator.TextLengthLongerThan("name", error_string, 0));
        validators.clearErrorMessage();

        return validators.validateAll();
    };

})(jQuery);