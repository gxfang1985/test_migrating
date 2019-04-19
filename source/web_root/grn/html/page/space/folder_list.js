(function ($) {
    "use strict";

    grn.base.namespace("grn.page.space.folder_list");

    var G = grn.page.space.folder_list;

    G.options = {
        url: "space/application/ajax/get_discussion_list",
        urlDetailDiscussion: "#tid=",
        usedSpinner: true
    };

    G.htmlTemplate =
    {
        unreadIcon: "<span class='unreadmark_grn js_unread_icon'></span>",
        discussionList: "<ul class='space_threadlist_tree_children_grn js_discussion_list'></ul>",
        discussionRead: "<li class='js_discussion'>" +
        "   <a href='javascript:void(0);' class='space-threadList-read-grn js_dis_display'>{{resource}}</a>" +
        "</li>",
        discussionUnread: "<li class='js_discussion'>" +
        "   <a href='javascript:void(0);' class='space-threadList-unread-grn js_dis_display'>{{resource}}</a>" +
        "</li>"
    };

    G.cssClass =
    {
        spinner_icon: "icon-spinner-grn"
    };

    G.cssSelectors = {
        container: ".js_folder_list_container",
        thread_read: ".space-threadList-read-grn",
        thread_unread: ".space-threadList-unread-grn",
        coll_exp_icon: ".js_coll_exp_icon",
        folder_list: ".js_folder_list",
        folder: ".js_folder",
        folder_name: ".js_folder_name",
        discussion_list: ".js_discussion_list",
        discussion: ".js_discussion",
        discussion_name: ".js_dis_display",
        expanded: ".ygtvtm",
        collapsed: ".ygtvtp",
        unread_icon: ".js_unread_icon",
        discussion_bold: ".bold",
        hilight: ".hilight",
        left_part: ".js_left_part"
    };

    G.KEY_WORDS = {
        CLICK: "click",
        HASH_CHANGE: "hashchange",
        FOLDER_ID: "data-folder-id",
        SPACE_ID: "data-space-id",
        THREAD_ID: "data-thread-id",
        BEFORE_SHOW_ERROR: "beforeShowError",
        TAG_A: "a",
        FIRST_SELECT: ":first",
        HREF: "href",
        HASH_DISCUSSION_ID: "tid",
        ID: "id",
        SHOW: "show",
        ID_SELECTOR_PREFIX: "#thread_",
        POST: "post",
        EMPTY: "",
        WHITE_SPACE: " "
    };

    G.folderTarget = null;

    G.isExpanded = null;

    G.discussionIdViewed = null;

    G.isPageLoadExpanded = false;

    G.init = function () {
        this.spid = grn.page.space.discussion.index.spid;
        this.htmlTemplate.discussionList = this.htmlTemplate.discussionList.replace(/>\s+</g, "><");
        this.htmlTemplate.discussionUnread = this.htmlTemplate.discussionUnread.replace(/>\s+</g, "><");
        this.htmlTemplate.discussionRead = this.htmlTemplate.discussionRead.replace(/>\s+</g, "><");

        G.cacheElements();
        G._bindEvents();

        G.detectDiscussionViewed();
        G.pageLoadExpandedFolder();
    };

    G.cacheElements = function () {
        this.$container = $(this.cssSelectors.container);
    };

    G._bindEvents = function () {
        this.$container.on(this.KEY_WORDS.CLICK, this.cssSelectors.folder, $.proxy(this.handleCollapseExpand, this));
        $(this.cssSelectors.left_part)
            .off(this.KEY_WORDS.CLICK, this.cssSelectors.discussion)
            .on(this.KEY_WORDS.CLICK, this.cssSelectors.discussion, $.proxy(this.handleClickDiscussion, this));
        $(window).on(this.KEY_WORDS.HASH_CHANGE, $.proxy(this.pageLoadExpandedFolder, this));
    };

    G.handleCollapseExpand = function (e) {
        var self = this;
        var ajaxRequest;
        var folderId;
        var spId;

        if (e) {
            e.preventDefault();
        } else {
            return;
        }

        this.folderTarget = $(e.target).closest(this.cssSelectors.folder_list);
        if (this.folderTarget.find(this.cssSelectors.expanded).length > 0) {
            this.isExpanded = false;
            this.folderTarget.find(this.cssSelectors.expanded)
                .addClass(this.cssSelectors.collapsed.substr(1))
                .removeClass(this.cssSelectors.expanded.substr(1));
            this.options.usedSpinner = false;
        } else {
            this.folderTarget.find(this.cssSelectors.collapsed)
                .addClass(this.cssSelectors.expanded.substr(1))
                .removeClass(this.cssSelectors.collapsed.substr(1));
            this.isExpanded = true;
            this.options.usedSpinner = true;
        }

        folderId = this.folderTarget.attr(this.KEY_WORDS.FOLDER_ID);
        spId = this.spId || this.folderTarget.attr(this.KEY_WORDS.SPACE_ID);
        ajaxRequest = new grn.component.ajax.request({
            grnUrl: this.options.url,
            method: this.KEY_WORDS.POST,
            data: {
                spid: spId,
                folder_id: folderId,
                is_expanded: this.isExpanded
            },
            grnLoadingIndicator: $.proxy(this._loadingIndicator, this)

        });

        return ajaxRequest.send()
            .done($.proxy(self.renderDiscussionList, this));

    };

    G._loadingIndicator = function (option) {
        var target;
        if (!this.options.usedSpinner) {
            return;
        }

        target = this.folderTarget.find(this.cssSelectors.coll_exp_icon).find(this.KEY_WORDS.TAG_A);
        if (option === this.KEY_WORDS.SHOW) {
            target.addClass(this.cssClass.spinner_icon);
        } else {
            target.removeClass(this.cssClass.spinner_icon);
        }
    };

    G.handleClickDiscussion = function (e) {
        var discussionTarget = $(e.target);
        var discussionIdViewed = this.getHashDiscussionId(discussionTarget.prop(this.KEY_WORDS.HREF));

        this.discussionTarget = discussionTarget.closest(this.cssSelectors.discussion);
        this.folderTarget = this.discussionTarget.closest(this.cssSelectors.folder);

        this.discussionIdViewed = discussionIdViewed;
        this.setReadOrUnReadDiscussion(discussionIdViewed);
    };

    G.setReadOrUnReadDiscussion = function (discussionId) {
        var limitRemoveUnreadIcon = 1;
        var unreadClassName = this.cssSelectors.thread_unread.substr(1);
        var readClassName = this.cssSelectors.thread_read.substr(1);
        var discussionTarget = $(this.KEY_WORDS.ID_SELECTOR_PREFIX + discussionId);
        var folderTarget;
        var discussionUnread;

        if (discussionTarget.length === 0) {
            return;
        }

        folderTarget = discussionTarget.closest(this.cssSelectors.folder_list);
        discussionUnread = folderTarget.find(this.cssSelectors.thread_unread);

        if (discussionTarget.hasClass(unreadClassName)) {
            limitRemoveUnreadIcon = 2;
            discussionTarget.removeClass(unreadClassName).addClass(readClassName);
        }

        if (discussionUnread.length < limitRemoveUnreadIcon) {
            folderTarget.find(this.cssSelectors.unread_icon).remove();
        }
    };

    G.setReadOrUnreadFolder = function (xhrData) {
        var self = this;
        var unreadCount = 0;
        var discussionList;

        if (self.isExpanded) {
            unreadCount = this.folderTarget.find(this.cssSelectors.discussion).find(this.cssSelectors.thread_unread).length;
        } else {
            discussionList = xhrData.discussion_list;
            $.each(discussionList, function (key, discussion) {
                if (discussion.is_unread_under === true && discussion.id !== self.discussionIdViewed) {
                    unreadCount += 1;
                }
            });
        }

        this.folderTarget.find(this.cssSelectors.unread_icon).remove();
        if (unreadCount > 0) {
            this.folderTarget.find(this.cssSelectors.coll_exp_icon).prepend(this.htmlTemplate.unreadIcon);
        }
    };

    G.detectDiscussionViewed = function () {
        G.discussionIdViewed = this.getHashDiscussionId();
    };

    G.getHashDiscussionId = function (url) {
        var _url = url || window.location.href;
        var jsonHash;
        jsonHash = grn.component.url.parseHash(_url);
        if (jsonHash.hasOwnProperty(this.KEY_WORDS.HASH_DISCUSSION_ID)) {
            return jsonHash.tid;
        }

        return null;
    };

    G.renderDiscussionList = function (xhrData) {
        var self = this;
        var folder = xhrData.folder;
        var discussion_list = xhrData.discussion_list;
        var targetExpanded = false;

        if (this.folderTarget == null || this.isPageLoadExpanded) {
            this.detectFolderTargetByFolderId(folder.id);
        }

        if (this.folderTarget == null) {
            return;
        }

        if (folder.id === this.KEY_WORDS.EMPTY) {
            this.folderTarget.remove();
            return;
        }

        this.folderTarget.find(this.cssSelectors.folder_name).text(folder.folder_name);

        if (folder.is_unread) {
            this.folderTarget.find(this.cssSelectors.coll_exp_icon).prepend(this.htmlTemplate.unreadIcon);
        } else {
            this.folderTarget.find(this.cssSelectors.unread_icon).remove();
        }

        this.folderTarget.find(this.cssSelectors.discussion_list).detach();
        this.folderTarget.append(this.htmlTemplate.discussionList);

        $.each(discussion_list, function (key, discussion) {
            if (self.isExpanded === false) {
                return;
            }

            if (!targetExpanded) {
                self.folderTarget.find(self.cssSelectors.coll_exp_icon)
                    .removeClass(self.cssSelectors.collapsed.substr(1))
                    .addClass(self.cssSelectors.expanded.substr(1));
                targetExpanded = true;
            }

            self.renderDiscussion(discussion);

            if (discussion.id === self.discussionIdViewed) {
                self.setFocus(discussion.id);
            }
        });

        this.setReadOrUnreadFolder(xhrData);
        this.isPageLoadExpanded = false;
        this.usedSpinner = true;
    };

    G.renderDiscussion = function (discussion) {

        var htmlDiscussion;

        if (discussion.is_unread_under) {
            htmlDiscussion = $(this.htmlTemplate.discussionUnread);
        } else {
            htmlDiscussion = $(this.htmlTemplate.discussionRead);
        }

        htmlDiscussion.find(this.cssSelectors.discussion_name)
            .text(discussion.title)
            .prop(this.KEY_WORDS.HREF, this.options.urlDetailDiscussion + discussion.id)
            .prop(this.KEY_WORDS.ID, "thread_" + discussion.id);

        this.folderTarget.find(this.cssSelectors.discussion_list).append(htmlDiscussion);
    };

    G.setFocus = function (discussionId) {
        var aTag = $(this.KEY_WORDS.ID_SELECTOR_PREFIX + discussionId);
        var boldClass;
        var hilightClass;

        if (aTag.length === 0) {
            return;
        }

        boldClass = this.cssSelectors.discussion_bold.substr(1);
        hilightClass = this.cssSelectors.hilight.substr(1);

        $(this.cssSelectors.left_part)
            .find(this.cssSelectors.discussion_bold)
            .removeClass(boldClass)
            .removeClass(hilightClass);

        aTag.addClass(boldClass + this.KEY_WORDS.WHITE_SPACE + hilightClass);

        this.setReadOrUnReadDiscussion(discussionId);
    };

    G.detectFolderTargetByFolderId = function (folderId) {
        var self = this;

        this.$container.find(this.cssSelectors.folder_list).each(function (index, folder) {
            if ($(folder).attr(self.KEY_WORDS.FOLDER_ID) === folderId) {
                self.folderTarget = $(folder);
                return;
            }
        });
    };

    G.pageLoadExpandedFolder = function () {

        var self = this;
        var ajaxRequest;
        var discussionIdViewed = this.getHashDiscussionId();
        var discussionId;
        var isExistsDiscussion = false;
        var discussionFocus = $(this.cssSelectors.discussion + this.KEY_WORDS.FIRST_SELECT);
        this.isPageLoadExpanded = true;
        this.isExpanded = true;
        this.discussionIdViewed = discussionIdViewed;

        if (!discussionIdViewed) {
            return;
        }

        $(this.cssSelectors.discussion)
            .each(function (index, discussion) {
                if (isExistsDiscussion) {
                    return;
                }

                discussionId = $(discussion).find(self.KEY_WORDS.TAG_A).attr(self.KEY_WORDS.THREAD_ID);
                if (discussionId === discussionIdViewed) {
                    isExistsDiscussion = true;
                    discussionFocus = $(discussion);
                }
            });

        if (!isExistsDiscussion) {
            ajaxRequest = new grn.component.ajax.request({
                grnUrl: this.options.url,
                method: this.KEY_WORDS.POST,
                data: {
                    spid: this.spId,
                    tid: discussionIdViewed
                },
                grnLoadingIndicator: $.proxy(this._loadingIndicator, this)
            });

            ajaxRequest.on(self.KEY_WORDS.BEFORE_SHOW_ERROR, function (e) {
                e.preventDefault();
            });

            this.options.usedSpinner = false;
            ajaxRequest
                .send()
                .done($.proxy(self.renderDiscussionList, this));
        }
    };
})(jQuery);

