import Page from "../../../component/common/ui/base/Page";

const $ = jQuery;

const DEFAULT_SETTINGS = {
    id: {
        commentList: "message_comments",
    },
    selectors: {
        messageCommentContainer: "#message_comments",
        messageComment: ".js_comment",
        dialogLink: ".dialog_link",
    },
    url: {
        ajaxGetRemainingMembersOfMention: "grn/message/ajax/get_remaining_members_of_mention",
        ajaxGetMembersListForDialog: grn.component.url.page("grn/ajax/member_list_dialog"),
    },
};

export default class InspectionView extends Page {
    constructor(settings = {}) {
        super(settings);
    }

    _onRender() {
        this._initMentionMemberField();

        this.memberListDialog = grn.component.member_list_dialog.get_instance("member_list_dialog_mention");
        if (this.memberListDialog === undefined) {
            this._initMemberListDialog();
        }
        this.memberListDialog.bindDialogToMembersContainer($(this.settings.selectors.messageCommentContainer), this.settings.selectors.dialogLink);
    }

    _getDefaultSettings() {
        return DEFAULT_SETTINGS;
    }

    _initMentionMemberField() {
        $(this.settings.selectors.messageComment).each((index, element) => {
            const settings = {
                element: $(element),
                params: {follow_id: $(element).data("comment-id")},
                url: this.settings.url.ajaxGetRemainingMembersOfMention
            };
            new grn.js.component.common.ui.show_more.MemberListShowMore(settings).render();
        });
    }

    _initMemberListDialog() {
        this.memberListDialog = new grn.component.member_list_dialog.MemberListDialog({
            url: this.settings.url.ajaxGetMembersListForDialog,
            dialog_name: "member_list_dialog_mention",
            app_id: "message",
            auto_bind: false,
            access_plugin_encoded: this.settings.accessPluginEncoded
        });
    }
}