/* global GRN_MsgBox, GRN_MsgBoxButtons, GRN_MsgBoxResult, applyShiftClick */
(function ($) {
    "use strict";

    grn.base.namespace("grn.page.space.thread_move");

    var ThreadMove = grn.page.space.thread_move;

    var Pager = grn.component.pager;
    var URL = grn.component.url;
    var PullDownMenu = grn.component.pulldown_menu.pulldown_menu;
    var Service = grn.component.space.thread_move.service;
    var ThreadList = grn.component.space.thread_move.thread_list;
    var FolderTree = grn.component.space.thread_move.folder_tree;
    var MoveToSpaceDialog = grn.component.space.thread_move.move_to_space_dialog;

    ThreadMove.isLoading = false;
    ThreadMove.threadOptions = {
        sp: 0,
        naviInfo: {
            prev: 0,
            next: 0,
            start: 0,
            end: 0,
            limit: 0
        }
    };

    ThreadMove.getURLParams = function () {
        var urlParams = URL.parseQueryString(window.location.search);
        var hashParams = URL.parseHash(window.location.hash);
        var inputParams = $.extend(urlParams, hashParams);

        this.spid = inputParams.spid;
        this.did = inputParams.did || -1;
    };

    ThreadMove.init = function (settings) {
        this.ignoreNextHashChange = false;
        this.getURLParams();

        this.spinner = $("#spinner");
        this.containerThreadList = $("#view_part_content");

        FolderTree.init(settings);
        ThreadList.init(settings);

        // navigation
        var settingsPager = {limit: settings.limit};
        this.pagerTop = new Pager(".js_naviTop", settingsPager);
        this.pagerBottom = new Pager(".js_naviBottom", settingsPager);

        // pulldown menu
        this.moveFolderTop = $("#move_folder_top");
        this.moveFolderBottom = $("#move_folder_bottom");

        var pulldown_options = {
            onSelect: this.handleMove.bind(this),
            autoClose: true
        };
        PullDownMenu.initWithOptions(this.moveFolderTop, pulldown_options);
        PullDownMenu.initWithOptions(this.moveFolderBottom, pulldown_options);

        // dialog move to another space
        this.moveAnotherSpaceBtn = $(".js_button_change_to_other_space");
        var settingsDialog = {spid: this.spid, limit: settings.limit};
        MoveToSpaceDialog.init(settingsDialog);

        this.handleCheckBoxClick();

        this.handleMoveAnotherSpaceButtonClick();

        this.bindEvent();

        FolderTree.handleSelectFolder(this.did);
    };

    ThreadMove.bindEvent = function () {
        this.pagerTop.on("paging", this.handlePaging.bind(this));
        this.pagerBottom.on("paging", this.handlePaging.bind(this));
        FolderTree.on("folder_change", this.handleChangeFolder.bind(this));
        this.moveAnotherSpaceBtn.on("click", this.handleMoveAnotherSpaceButtonClick.bind(this));

        var self = this;
        Service.on("error", function(){
            var url = URL.page("space/thread_move", {spid:self.spid} );
            location.replace(url);
        });

        MoveToSpaceDialog.on("move", $.proxy(this.handleAfterMove, this));

        $(window).on("hashchange", $.proxy(this._onHashChange, this));
    };

    ThreadMove.handleChangeFolder = function (event, folderId) {
        this.did = folderId;
        this.threadOptions.sp = 0;
        this.getThreadList();
        this.saveState();
    };

    ThreadMove.handlePaging = function (event, param) {
        this.threadOptions.sp = 0;
        if (param === 'prev') {
            this.threadOptions.sp = this.threadOptions.naviInfo.prev;
        }
        else if (param === 'next') {
            this.threadOptions.sp = this.threadOptions.naviInfo.next;
        }

        this.getThreadList();
    };

    ThreadMove.getThreadList = function () {
        this.spinner.show();
        this.containerThreadList.css('visibility', 'hidden');

        var self = this;
        var request = Service.getThreads(this.spid, this.did, this.threadOptions.sp);

        return request.done(function (data) {
                if (data.thread_move_list.length > 0) {
                    ThreadList.setContent(data.thread_move_list);
                }
                else {
                    ThreadList.setEmptyList();
                }

                self.threadOptions.naviInfo = {
                    prev: data.navi_info.navi.previous_page_start_position,
                    next: data.navi_info.navi.next_page_start_position,
                    start: data.navi_info.start_count,
                    end: data.navi_info.end_count,
                    limit: data.navi_info.limit
                };

                self.pagerTop.setState(self.threadOptions.naviInfo);
                self.pagerBottom.setState(self.threadOptions.naviInfo);

                // apply shift click
                applyShiftClick();

                ThreadList.disableMoveFunction();

                self.spinner.hide();
                self.containerThreadList.css('visibility', 'visible');
            });

    };

    ThreadMove.handleMove = function (element, data) {
        var selectedItems = ThreadList.getSelectedItems();

        if (selectedItems.length === 0) {
            return;
        }

        if(this.did.toString() === data.value.toString()){
            return;
        }

        var self = this;
        var content = $($("#thead_move_folder_content_template").html());
        content.find("span.destination_folder_name").html($(data.name).clone());
        content.find("span.thread_move_count").text(selectedItems.length);

        var title = grn.component.i18n.cbMsg("grn.space", "move_discussion-9");
        var yesCaption = grn.component.i18n.cbMsg("grn.common", "yes");
        var noCaption = grn.component.i18n.cbMsg("grn.common", "no");

        GRN_MsgBox.show(content.get(0), title, GRN_MsgBoxButtons.yesno,
            {
                caption : {
                    yes : yesCaption,
                    no : noCaption
                },
                callback: function (result) {
                    if (result === GRN_MsgBoxResult.yes) {
                        self.processMoveToFolder(data);
                        GRN_MsgBox.close();
                    }
                }
            });
    };

    ThreadMove.processMoveToFolder = function (data) {
        if (this.isLoading) {
            return;
        }
        this.isLoading = true;

        var selectedItems = ThreadList.getSelectedItems();
        var sourceData = {spid: this.spid, did: this.did};
        var destData = {spid: this.spid, did: data.value};
        var moveFolderNotify = $("#notify_move_folder").is(":checked") ? 1 : 0;

        var request = Service.moveThreads(selectedItems, sourceData, destData, moveFolderNotify);

        var self = this;
        request.done(function () {
                ThreadMove.handleAfterMove();
            })
            .always(function () {
                self.isLoading = false;
            });

    };

    ThreadMove.handleAfterMove = function()
    {
        ThreadList.removeSelectedItems();
        ThreadList.disableMoveFunction();
        ThreadMove.getThreadList();
    };

    ThreadMove.handleCheckBoxClick = function () {
        $(document).on("click", "input[name='ids[]'], .js_checkall", function () {
            if ($("input[name='ids[]']:checked").length > 0) {
                ThreadList.enableMoveFunction();
            }
            else {
                ThreadList.disableMoveFunction();
            }
        });
    };

    ThreadMove.handleMoveAnotherSpaceButtonClick = function () {
        var selectedItems = ThreadList.getSelectedItems();

        if (selectedItems.length === 0) {
            return;
        }

        MoveToSpaceDialog.show(this.did);
    };

    ThreadMove._onHashChange = function () {
        if (this.ignoreNextHashChange) {
            this.ignoreNextHashChange = false;
            return;
        }

        this.getURLParams();
        this.threadOptions.sp = 0;
        FolderTree.highlightFolder(this.did);
        this.getThreadList();
    };

    ThreadMove.saveState = function () {
        var hash_params = {};

        hash_params.did = this.did;

        this.ignoreNextHashChange = true;
        URL.changeCurrentLocationHash(hash_params);
    };

})(jQuery);