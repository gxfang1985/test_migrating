// namespace
grn.base.namespace("grn.page.space.mobile.discussion.index");

(function () {
    "use strict";
    var G = grn.page.space.mobile.discussion.index;

    G.isExpanding = false;

    G.url = grn.component.url.page("space/mobile/application/discussion/ajax/categorized_discussion_list");

    G.init = function () {
        this.$container = $("#categorized_discussion_list");
        G.spaceId = this.$container.attr("data-space-id");
        this._bindEvents();
    };

    G._bindEvents = function () {
        this.$container.on("click", ".folder", this.handleExpanding);
    };

    G.handleExpanding = function () {
        if (G.isExpanding) {
            return;
        }
        G.isExpanding = true;

        var self = this;
        var $_this = $(this);

        var folderId = $_this.attr("data-folder-id");
        var isExpanded = $_this.attr("data-folder-expanded");
        var spaceId = G.spaceId;

        if (isExpanded) {
            //Remove threads of folder
            G.$container.find(".js_parent_folder_" + folderId).remove();

            //Update status data
            $_this.attr("data-folder-expanded", "");

            //Update folder icon
            $_this.find("div").addClass("mobile_folderlist_icon_arrowclose_grn")
                .removeClass("mobile_folderlist_icon_arrowopen_grn");
        }
        else {
            //Update status data
            $_this.attr("data-folder-expanded", "1");

            //Show spinner
            $_this.find(".mobile_folderlist_icon_grn").addClass("mobile_icon_spinner_grn")
                .removeClass("mobile_folderlist_icon_arrowclose_grn");
        }

        $.ajax(
            {
                url: G.url,
                type: "post",
                data: {
                    spid: spaceId,
                    use_ajax: 1,
                    folder_id: folderId,
                    is_expanded: !isExpanded
                },
                success: function (responseData, textStatus, jqXHR) {
                    if (grn.component.mobile_error_handler.hasCybozuError(jqXHR)) {
                        grn.component.mobile_error_handler.show(responseData);
                    }
                    else {
                        //Remove folder if does not exist
                        if (responseData.folder.id < 1) {
                            $_this.remove();
                        }
                        else {
                            //Update folder name
                            $_this.find(".mobile_folderlist_text_overflow_grn").text(responseData.folder.folder_name);

                            //Update unread status of folder
                            if (responseData.folder.is_unread) {
                                $_this.find(".mobile_list_icon_unread_grn").show();
                            }
                            else {
                                $_this.find(".mobile_list_icon_unread_grn").hide();
                            }

                            //Add threads into folder
                            if (!isExpanded) {
                                var threadList = document.createDocumentFragment();

                                $.each(responseData.discussion_list, function (index, thread) {
                                    var $discussion = $($("#template_discussion").html());
                                    $discussion.addClass("js_parent_folder_" + folderId);

                                    if (!thread.is_unread_under) {
                                        $discussion.find(".mobile_list_icon_unread_grn").remove();
                                    }
                                    $discussion.find(".mobile_folderlist_text_overflow_grn").text(thread.title);

                                    var threadURL = grn.component.url.page("space/mobile/application/discussion/" + thread.page,
                                        {spid: spaceId, tid: thread.id});
                                    $discussion.find(".mobile_folderlist_list_text_grn").attr("href", threadURL);
                                    $discussion.find(".mobile_folderlist_icon_grn").attr("onclick", "location.href='" + threadURL + "'");

                                    threadList.appendChild($discussion[0]);
                                });

                                $(threadList).insertAfter(self);
                            }
                        }
                    }
                },
                error: function (jqXHR) {
                    // This handling is for Forest environment.
                    if (grn.component.mobile_error_handler.hasCybozuError(jqXHR)) {
                        if (typeof jqXHR.responseJSON !== "undefined") {
                            grn.component.mobile_error_handler.show(jqXHR);
                        }
                    }
                    else if (grn.component.mobile_error_handler.hasCybozuLogin(jqXHR)) {
                        location.href = location.href;
                    }
                },
                complete: function () {
                    G.isExpanding = false;

                    if (!isExpanded) {
                        //Remove spinner
                        $_this.find(".mobile_folderlist_icon_grn").addClass("mobile_folderlist_icon_arrowopen_grn")
                            .removeClass("mobile_icon_spinner_grn");
                    }
                }
            });
    };

    $(document).ready(function () {
        G.init();
    });
})();