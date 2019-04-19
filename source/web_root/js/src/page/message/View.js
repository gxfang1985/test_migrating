/* global confirmIfExistFailedFile */
import Page from "../../component/common/ui/base/Page";
import Locale from "../../component/common/locale/Locale";
import ReplyDialog from "../../component/common/ui/comment/ReplyDialog";

const $ = jQuery;

const DEFAULT_SETTINGS = {
    id: {
        mentionArea: "data_mention",
        commentList: "message_comments",
    },
    selectors: {
        commentForm: "#follow_form_message_comment",
        commentButton: "#message_comment_button_save",
        messageCommentContainer: "#message_comments",
        messageComment: ".js_comment",
        dialogLink: ".dialog_link",
        errorMessageFieldID: "#error_msg_follow_comment",
        tableUpload: "#upload_table_message_comment",
    },
    url: {
        commandView: grn.component.url.page("message/command_view"),
        ajaxGetRemainingMembersOfMention: "grn/message/ajax/get_remaining_members_of_mention",
        ajaxGetMembersListForDialog: grn.component.url.page("grn/ajax/member_list_dialog"),
    },
    mentionReply: {
        urlGetMembers: "grn/message/ajax/get_members_of_mention",
        commentIdParam: "follow_id",
    },
    formName: "follow_form",
    commentField: "data",
};

export default class View extends Page {
    constructor(settings = {}) {
        super(settings);
    }

    _onRender() {
        this.form = document.forms[this.settings.formName];
        if ($("#" + this.settings.id.commentList).length > 0) {
            this._initReplyDialog();
        }
        return false;
    }

    _initReplyDialog() {
        const reply_dialog = new ReplyDialog(this._getDefaultSettings());
        reply_dialog.bindToCommentList("#" + this.settings.id.commentList);
    }

    _getDefaultSettings() {
        return DEFAULT_SETTINGS;
    }

    _bindEvents() {
        this._bindEventToPostMessage();
        this._initMentionMemberField();
        this._initMentionMemberDialog();
    }

    _postMessage() {
        const comment_button = grn.component.button(this.settings.selectors.commentButton);
        if (comment_button.isDisabled()) {
            return;
        }

        const $form = $(this.settings.selectors.commentForm);
        $form.find("input[name='cmd']").val("follow");

        if (!confirmIfExistFailedFile()) {
            return;
        }

        // save content from rich text before submit
        grn.component.editor.Editor.getInstanceById("data_editor_id").save();

        if (!this._validateBeforeSubmit()) {
            return;
        }

        comment_button.showSpinner();

        const mention = grn.js.component.common.ui.mention.Mention.getInstance(this.settings.id.mentionArea);
        if (mention) {
            $form.find("input[name='mention']").val(mention.getMentionData());
        }

        const request = new grn.component.ajax.request({
            url: this.settings.url.commandView,
            method: "post",
            dataType: "json",
            data: $form.serialize()
        });

        request.send()
            .done(() => (location.href = location.href.replace(location.hash, "")))
            .fail(() => comment_button.hideSpinner());
    }

    _bindEventToPostMessage() {
        $(this.settings.selectors.commentButton).on("click", this._postMessage.bind(this));
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

    _initMentionMemberDialog() {
        const $message_comment = $(this.settings.selectors.messageCommentContainer);
        let dialog = grn.component.member_list_dialog.get_instance("member_list_dialog_mention");
        if (dialog === undefined) {
            dialog = new grn.component.member_list_dialog.MemberListDialog({
                url: this.settings.url.ajaxGetMembersListForDialog,
                dialog_name: "member_list_dialog_mention",
                app_id: "message",
                auto_bind: false,
                access_plugin_encoded: this.settings.accessPluginEncoded
            });
        }
        dialog.bindDialogToMembersContainer($message_comment, this.settings.selectors.dialogLink);
    }

    _validateBeforeSubmit() {
        const validators = new grn.component.validator(this.form, $(this.settings.selectors.errorMessageFieldID)[0]);
        let has_file_upload = false;
        const $table_upload = $(this.settings.selectors.tableUpload);
        if ($table_upload.children.length >= 1) {
            const checkbox_arr = $table_upload.find("input[type=checkbox]");
            checkbox_arr.each((index, element) => {
                if (element.checked) {
                    has_file_upload = true;
                    return false;
                }
            });
        }
        if (!has_file_upload) {
            const error_message = Locale.getMessage("grn.message", "GRN_MSG-425");
            validators.addValidator(new grn.component.validator.TextLengthLongerThan(this.settings.commentField, error_message, 0));
        }
        validators.clearErrorMessage();
        return validators.validateAll();
    }
}
