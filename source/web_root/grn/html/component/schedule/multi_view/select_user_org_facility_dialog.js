(function ($) {
    "use strict";
    grn.base.namespace("grn.component.schedule.multi_view.select_user_org_facility_dialog");

    var default_options = {
        url: grn.component.url.page("schedule/ajax_select_user_org_facility_dialog"),
        dialogTitle: grn.component.i18n.cbMsg("grn.schedule", "GRN_SCH-1053"),
        dialogVersion: 2
    };

    grn.component.schedule.multi_view.select_user_org_facility_dialog = function (options) {
        grn.component.pubsub.installTo(this);
        this.options = $.extend({}, default_options, options);
        this.memberList = new grn.component.schedule.multi_view.member_list();

        this._dialog = new grn.component.WindowSimpleDialog({title: this.options.dialogTitle,
            asyncURL: this.options.url,
            asyncParams: {"members": this.memberList.getMembers()},
            version: this.options.dialogVersion});
        this._dialog.on("loaded", this._onLoad.bind(this));
    };

    /**
     * @type {grn.component.schedule.multi_view.select_user_org_facility_dialog}
     */
    var G = grn.component.schedule.multi_view.select_user_org_facility_dialog;

    G.prototype.showDialog = function () {
        this._dialog.options.asyncParams = {
            members: grn.component.schedule.multi_view.util.serializeMembers(
                this.memberList.getMembers(), {id_type_only: true}
            )
        };
        this._dialog.openDialog();
    };

    G.prototype.setMemberList = function (member_list) {
        this.memberList = member_list;
    };

    G.prototype.getMemberList = function () {
        return this.memberList;
    };

    G.prototype._onLoad = function () {
        this._$dialog_container = this._dialog.$container;
        this._$dialog_container.find(".js_button_cancel")
            .on("click", this._dialog.closeDialog.bind(this._dialog));
        this._$dialog_container.find(".js_button_apply")
            .on("click", this._apply.bind(this));
    };

    G.prototype._apply = function () {
        var _membersArray = [];
        var memberSelect = grn.component.member_add.get_instance("member_select");
        var facilitySelect = grn.component.facility_add.get_instance("facility_select");
        var memberLists = memberSelect.memberLists;
        jQuery.each(memberLists, function(listName, memberList) {
            memberList.getList().each(function () {
                var value = $(this).attr("data-value");
                if (value.substring(0, 1) === "g") {
                    _membersArray.push({
                        id: value.substring(1),
                        type: "org"
                    });
                }
                else if (value !== "") {
                    _membersArray.push({
                        id: value.split(":")[0],
                        type: "user"
                    });
                }
            });
        });

        facilitySelect.facilityList.getList().each(function () {
            var value = $(this).attr("data-value");
            if (value === "") {
                return;
            }
            _membersArray.push({
                id: value,
                type: "facility"
            });
        });

        this.memberList = new grn.component.schedule.multi_view.member_list.createFromArray(_membersArray);
        this._dialog.closeDialog();
        this.trigger("apply");
    };
})(jQuery);