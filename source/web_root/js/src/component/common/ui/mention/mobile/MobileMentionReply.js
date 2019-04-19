import {MobileMentionTagItem} from "./MobileMentionList";
import MentionReply from "../MentionReply";

const $ = jQuery;

const DEFAULT_SETTINGS = {
    css: {
        commentCreator: "js_comment_creator",
    },
    mentionItemClass: MobileMentionTagItem,
};

export default class MobileMentionReply extends MentionReply {

    _getDefaultSettings() {
        return $.extend(true, {}, super._getDefaultSettings(), DEFAULT_SETTINGS);
    }

    _getCommentCreatorInfo(comment_id) {
        const $comment_area = this._getCommentArea(comment_id);
        const $user = $comment_area.find(`.${this.settings.css.commentCreator}:first`);

        return {

            id: parseInt($user.data("user-id"), 10) || 0,
            name: $user.text(),
            url: $user.data("user-url") || "",
        };
    }

    replyAllToComment(comment_id) {
        grn.component.mobile_loading.show();
        const promise = super.replyAllToComment(comment_id);
        promise.done(() => {
            grn.component.mobile_loading.remove();
        });
    }
}
