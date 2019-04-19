import MobilePage from "../../../../../component/common/ui/base/MobilePage";
import MobileMentionReply from "../../../../../component/common/ui/mention/mobile/MobileMentionReply";
import Locale from "../../../../../component/common/locale/Locale";
import MobileValidator from "../../../../../component/common/validator/MobileValidator";

const DEFAULT_SETTINGS = {
    css: {
        submitButton: "js_submit_button",
        commentFieldID: "comment_data",
        attachmentFieldName: "attached_file",
        errorMessageFieldID: "errorMessageField",
    },
    element: ".mobile-content-grn",
    isReplyAll: false,
};

export default class CommentAdd extends MobilePage {
    _onRender() {
        this.mention = grn.js.component.common.ui.mention.mobile.MobileMention.getInstance(this.settings.name);

        if (this.settings.commentId) {
            const mentionReplySettings = {
                mention: this.mention,
                urlGetMembers: "grn/space/ajax/get_members_of_mention",
                css: {
                    commentRecipients: "mobile_mention_comment_base_grn"
                }
            };
            const mentionReply = new MobileMentionReply(mentionReplySettings);
            mentionReply.bindToCommentList(this.settings.commentContainer);
            if (this.settings.isReplyAll) {
                mentionReply.replyAllToComment(this.settings.commentId);
            } else {
                mentionReply.replyToComment(this.settings.commentId);
            }

        }

        this.submitButton = this._findByClassName(this.settings.css.submitButton);
        this.form = document.forms[this.settings.formName];
        this.validation_field = $(`#${this.settings.css.errorMessageFieldID}`);
        this._find(`#${this.settings.css.commentFieldID}`).focus();
    }

    _getDefaultSettings() {
        const settings = $.extend(true, {}, super._getDefaultSettings(), DEFAULT_SETTINGS);

        return settings;
    }

    _bindEvents() {
        this.submitButton.on("click", this._submitButtonOnClick.bind(this));
    }

    _validateBeforeSubmit() {
        const validators = new MobileValidator(this.form, this.validation_field[0]);

        let hasFileUpload = false;
        if ($(`input[name=${this.settings.css.attachmentFieldName}]`).prop("checked")) {
            hasFileUpload = true;
        }

        if (!hasFileUpload) {
            const error_message = Locale.getMessage("grn.space.discussion", "GRN_SP_DISC-61");
            validators.addValidator(new MobileValidator.TextLengthLongerThan(this.settings.css.commentFieldID, error_message, 0));
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