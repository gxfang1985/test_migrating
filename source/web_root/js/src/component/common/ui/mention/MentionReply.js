import MemberType from "../../constant/MemberType";
import {MentionTagItem} from "./MentionList";
import Control from "../base/Control";
import HttpRequest from "../../ajax/HttpRequest";

const $ = jQuery;

const DEFAULT_SETTINGS = {
    css: {
        comment: "js_comment",
        commentCreator: "username_grn",
        commentRecipients: "mention_comment_base_grn"
    },
    mentionItemClass: MentionTagItem,
    urlGetMembers: "",
    commentIdParam: "comment_id"
};

export default class MentionReply extends Control {
    constructor(settings) {
        super(settings);
        this.mention = settings.mention;
    }

    /**
     * @param list The comment list (selector or HTML element)
     */
    bindToCommentList(list) {
        this.$commentList = $(list);
    }

    /**
     * Add the comment creator to the mention field
     * @param comment_id
     */
    replyToComment(comment_id) {
        const promise = $.Deferred().resolve().promise();
        this.mention.reset();

        const comment_creator = this._getCommentCreatorInfo(comment_id);
        comment_creator.type = MemberType.USER;

        // Do not add the deleted user or logged-in user to mention field
        if (!comment_creator.id ||
            comment_creator.id.toString() === grn.data.login.id.toString()) {
            return promise;
        }

        const mention_member = new this.settings.mentionItemClass({data: comment_creator});
        this.mention.mentionList.addTagItem(mention_member);
        this.mention.mentionButton.setExpand(true);
        this.mention.mentionList.show({addMentionSymbol: false});

        return promise;
    }

    /**
     * Check whether the comment has mention
     * @param comment_id
     * @returns {boolean}
     */
    hasMentionMember(comment_id) {
        const $comment_area = this._getCommentArea(comment_id);
        const $recipients = $comment_area.find(`.${this.settings.css.commentRecipients}`);
        const comment_creator = this._getCommentCreatorInfo(comment_id);
        return !($recipients.length === 0 && comment_creator.id.toString() === grn.data.login.id.toString());
    }

    /**
     * Add the comment creator and recipients to the mention field
     * @param comment_id
     */
    replyAllToComment(comment_id) {
        this.mention.reset();

        if (!this.hasMentionMember(comment_id)) {
            return $.Deferred().resolve().promise();
        }

        return this._getCommentRecipients(comment_id).done(data => {
            const recipients = data.members;
            $.each(recipients, (index, recipient) => {
                const mention_member = new this.settings.mentionItemClass({data: recipient});
                this.mention.mentionList.addTagItem(mention_member);
            });

            if (Object.keys(recipients).length) {
                this.mention.mentionButton.setExpand(true);
                this.mention.mentionList.show({addMentionSymbol: false});
            }
        });
    }

    _getDefaultSettings() {
        return $.extend(true, {}, super._getDefaultSettings(), DEFAULT_SETTINGS);
    }

    _getCommentArea(comment_id) {
        return this.$commentList.find(`.${this.settings.css.comment}[data-comment-id="${comment_id}"]`);
    }

    _getCommentCreatorInfo(comment_id) {
        const $comment_area = this._getCommentArea(comment_id);
        const $user = $comment_area.find(`.${this.settings.css.commentCreator}:first`);
        const $user_link = $user.find("a");

        return {
            id: parseInt($user.data("user-id"), 10) || 0,
            name: $user.text(),
            url: $user_link.attr("href") || "",
        };
    }

    _getCommentRecipients(comment_id) {
        const comment_creator = this._getCommentCreatorInfo(comment_id);
        const post_data = {creator_id: comment_creator.id};
        post_data[this.settings.commentIdParam] = comment_id;
        const request = new HttpRequest({
            grnUrl: this.settings.urlGetMembers,
            grnRedirectOnLoginError: true,
            method: "post",
            dataType: "json",
            data: post_data
        });
        return request.send();
    }

    resetMention() {
        this.mention.reset();
    }
}
