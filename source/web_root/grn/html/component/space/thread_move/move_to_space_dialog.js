(function ($) {
    "use strict";

    grn.base.namespace("grn.component.space.thread_move.move_to_space_dialog");

    var MoveToSpaceDialog = grn.component.space.thread_move.move_to_space_dialog;

    var Pager = grn.component.pager;
    var Service = grn.component.space.thread_move.service;
    var ThreadList = grn.component.space.thread_move.thread_list;

    MoveToSpaceDialog.asyncURL = grn.component.url.page("space/ajax/get_space_list_dialog");
    MoveToSpaceDialog.spaceOptions = {
        sp: 0,
        naviInfo: {
            prev: 0,
            next: 0,
            start: 0,
            end: 0,
            limit: 0
        }
    };

    MoveToSpaceDialog.init = function (settings) {
        grn.component.pubsub.installTo(this);
        this.settings = settings;
        this.spid = settings.spid;

        this.dialog = new grn.component.WindowSimpleDialog({
            "title": grn.component.i18n.cbMsg("grn.space", "move_discussion-12"),
            "asyncURL": this.asyncURL,
            "modal": true,
            "asyncParams": {spid: this.spid}
        });

        this.bindEvent();
    };

    MoveToSpaceDialog.show = function (did) {
        this.did = did;
        this.dialog.openDialog();
    };

    MoveToSpaceDialog.bindEvent = function () {
        this.dialog.on("loaded", this.initPager.bind(this));
        this.dialog.$container.on("click", ".js_btn_move", this.handleMoveThread.bind(this));
        this.dialog.$container.on("click", ".js_btn_cancel", this.handleCancel.bind(this));
        this.dialog.$container.on("click", "#space_list", this.toggleMoveBtn.bind(this));
        this.dialog.$container.on("click", "input[name='space_list_radio']", this.handleChooseSpace.bind(this));
    };

    MoveToSpaceDialog.toggleMoveBtn = function () {
        if (this.dialog.$container.find("input[name='space_list_radio']:checked").length > 0) {
            this.btnMove.enable();
        }
        else {
            this.btnMove.disable();
        }
    };

    MoveToSpaceDialog.handleChooseSpace = function (event) {
        // hide all folder select
        this.dialog.$container.find(".js_folder_select").hide();

        var currentTarget = $(event.currentTarget);
        var value = currentTarget.val();
        currentTarget.closest("tr").find("div.js_space_folder" + value).show();
    };

    MoveToSpaceDialog.enableMoveBtn = function () {
        this.btnMove.enable();
    };

    MoveToSpaceDialog.disableMoveBtn = function () {
        this.btnMove.disable();
    };

    MoveToSpaceDialog.initPager = function (event, param) {
        var settingsPager = {limit: param.navi_info.limit};
        this.pager = new Pager(".js_navi_space_dialog", settingsPager);
        this.btnMove = grn.component.button(".js_btn_move");
        this.btnMove.disable();

        this.spaceOptions.naviInfo = {
            prev: param.navi_info.navi.previous_page_start_position,
            next: param.navi_info.navi.next_page_start_position,
            start: param.navi_info.start_count,
            end: param.navi_info.end_count,
            limit: param.navi_info.limit
        };

        this.pager.setState(this.spaceOptions.naviInfo);

        this.pager.on("paging", this.handlePaging.bind(this));
    };

    MoveToSpaceDialog.handlePaging = function (event, param) {
        this.spaceOptions.sp = 0;
        if (param === 'prev') {
            this.spaceOptions.sp = this.spaceOptions.naviInfo.prev;
        }
        else if (param === 'next') {
            this.spaceOptions.sp = this.spaceOptions.naviInfo.next;
        }

        this.btnMove.disable();
        this.getSpaceList();
    };

    MoveToSpaceDialog.getSpaceList = function () {

        var self = this;
        var request = Service.getSpaces(this.spid, this.spaceOptions.sp);

        request.done(function (data) {
                if (data.content.length > 0) {
                    self.dialog.$container.find("#space_list").replaceWith(data.content);
                }

                self.spaceOptions.naviInfo = {
                    prev: data.navi_info.navi.previous_page_start_position,
                    next: data.navi_info.navi.next_page_start_position,
                    start: data.navi_info.start_count,
                    end: data.navi_info.end_count,
                    limit: data.navi_info.limit
                };

                self.pager.setState(self.spaceOptions.naviInfo);
            });
    };

    MoveToSpaceDialog.handleMoveThread = function () {
        var selectedItems = ThreadList.getSelectedItems();
        if (selectedItems.length === 0) {
            return;
        }

        var targetSpaceId = "";
        var spaceSelected = this.dialog.$container.find("input[name='space_list_radio']:checked");
        if(spaceSelected.length > 0)
        {
            targetSpaceId = spaceSelected.val();
        }
        else
        {
            targetSpaceId = -1;
        }

        var targetFolderId = "";
        var folderSelected = spaceSelected.closest("tr").find("select");
        if(folderSelected.length > 0)
        {
            targetFolderId = folderSelected.val();
        }
        else
        {
            targetFolderId = -1;
        }

        var sourceData = {spid: this.spid, did: this.did};
        var destData = {spid: targetSpaceId, did: targetFolderId};
        var moveSpaceNotify = $("#notify_move_space").is(":checked") ? 1 : 0;

        var request = Service.moveThreads(selectedItems, sourceData, destData, moveSpaceNotify);

        var self = this;
        request.done(function () {
                self.dialog.closeDialog();
                self.trigger("move");
            })
            .always(function (){
                self.btnMove.hideSpinner();
            });
    };

    MoveToSpaceDialog.handleCancel = function () {
        this.dialog.closeDialog();
    };

})(jQuery);