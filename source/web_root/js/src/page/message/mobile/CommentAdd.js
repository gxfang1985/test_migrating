import MobilePage from "../../../component/common/ui/base/MobilePage";
import MobileMentionReply from "../../../component/common/ui/mention/mobile/MobileMentionReply";
import Locale from "../../../component/common/locale/Locale";
import MobileValidator from "../../../component/common/validator/MobileValidator";

const $ = jQuery;

const DEFAULT_SETTINGS = {
    selectors: {
        submitButton: "js_submit_button",
        commentFieldID: "comment_data",
        attachmentFieldName: "attached_file",
        errorMessageFieldID: "#error_message_field",
    },
    mentionReply: {
        commentRecipients: "mobile_mention_comment_base_grn",
        urlGetMembers: "grn/message/ajax/get_members_of_mention",
        commentIdParam: "follow_id",
    },
    isReplyAll: false,
};

export default class CommentAdd extends MobilePage {
    _onRender() {
        this.mention = grn.js.component.common.ui.mention.mobile.MobileMention.getInstance(this.settings.name);

        if (this.settings.commentId) {
            const mention_reply_settings = {
                mention: this.mention,
                urlGetMembers: this.settings.mentionReply.urlGetMembers,
                css: {
                    commentRecipients: this.settings.mentionReply.commentRecipients,
                },
                commentIdParam: this.settings.mentionReply.commentIdParam,
            };
            const mention_reply = new MobileMentionReply(mention_reply_settings);
            mention_reply.bindToCommentList(this.settings.commentContainer);
            if (this.settings.isReplyAll) {
                mention_reply.replyAllToComment(this.settings.commentId);
            } else {
                mention_reply.replyToComment(this.settings.commentId);
            }
        }

        this.form = document.forms[this.settings.formName];
        this.$submitButton = this._findByClassName(this.settings.selectors.submitButton);
        this.$validationField = this._find(this.settings.selectors.errorMessageFieldID);
        this._find(`#${this.settings.selectors.commentFieldID}`).focus();
    }

    _getDefaultSettings() {
        const settings = $.extend(true, {}, super._getDefaultSettings(), DEFAULT_SETTINGS);

        return settings;
    }

    _bindEvents() {
        this.$submitButton.on("click", this._submitButtonOnClick.bind(this));
    }

    _validateBeforeSubmit() {
        const validators = new MobileValidator(this.form, this.$validationField[0]);

        let has_file_upload = false;
        const $attachment_field = this._find(`input[name="${this.settings.selectors.attachmentFieldName}"]`);
        if ($attachment_field !== undefined && $attachment_field.prop("checked")) {
            has_file_upload = true;
        }

        if (has_file_upload === false) {
            const error_message = Locale.getMessage("grn.message", "GRN_MSG-425");
            validators.addValidator(new MobileValidator.TextLengthLongerThan(this.settings.selectors.commentFieldID, error_message, 0));
        }

        validators.clearErrorMessage();
        return validators.validateAll();
    }

    _submitButtonOnClick(event) {
        if (!this._validateBeforeSubmit()) {
            event.stopImmediatePropagation();
            return;
        }

        this.form.elements.mention.value = this.mention.getMentionData();
        this.form.submit();
    }
}