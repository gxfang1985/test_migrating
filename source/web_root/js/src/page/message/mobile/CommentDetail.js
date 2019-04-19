import MobilePage from "../../../component/common/ui/base/MobilePage";
import MobileMemberListShowMore from "../../../component/common/ui/show_more/mobile/MobileMemberListShowMore";
import CommentAdd from "./CommentAdd";

const $ = jQuery;

const DEFAULT_SETTINGS = {
    selectors: {
        commentContainer: "#comment_container",
        comment: "js_comment",
        commentFieldID: "comment_data",
    },
    element: ".mobile-content-grn",
    memberListDialogName: "member_list_dialog"
};

export default class CommentDetail extends MobilePage {

    _getDefaultSettings() {
        const settings = $.extend(true, {}, super._getDefaultSettings(), DEFAULT_SETTINGS);

        return settings;
    }

    _onRender() {
        this._initCommentAdd();
        this._initMemberListShowMore();

        this.memberListDialog = grn.js.component.common.ui.dialog.MobileMemberListDialog.getInstance(this.settings.memberListDialogName);
        if (this.memberListDialog === undefined) {
            this._initMemberListDialog();
        }
        this.memberListDialog.bindDialogToMembersContainer(this.settings.selectors.commentContainer);
        this._find(`#${this.settings.selectors.commentFieldID}`).focus();
    }

    _initCommentAdd() {
        new CommentAdd(this.settings);
    }

    _initMemberListShowMore() {
        this.$commentList = this._findByClassName(this.settings.selectors.comment);
        this.$commentList.each((index, element) => {
            const settings = {
                element: $(element),
                params: {follow_id: $(element).data("comment-id")},
                url: "grn/message/ajax/get_remaining_members_of_mention"
            };
            new MobileMemberListShowMore(settings).render();
        });
    }

    _initMemberListDialog() {
        this.memberListDialog = new grn.js.component.common.ui.dialog.MobileMemberListDialog({
            name: this.settings.memberListDialogName,
            element: `#${this.settings.memberListDialogName}`,
            accessPluginEncoded: this.settings.accessPluginEncoded
        });
        this.memberListDialog.render();
    }
}