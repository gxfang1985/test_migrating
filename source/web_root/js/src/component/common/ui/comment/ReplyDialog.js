/* global grn_clear_fileselect */
import Control from "../base/Control";
import Locale from "../../locale/Locale";
import KeyCode from "../../constant/KeyCode";

const $ = jQuery;

export default class ReplyDialog extends Control {

    constructor(settings = {}) {
        super(settings);

        $("#" + this.settings.id.dialog).draggable({
            handle: "#" + this.settings.id.dialogHeader,
        });
        const dialog = document.getElementById(this.settings.id.dialog);
        const body = document.getElementsByTagName("body")[0];
        dialog.parentNode.removeChild(dialog);
        body.appendChild(dialog);
    }

    _getDefaultSettings() {
        const settings = $.extend(true, {}, super._getDefaultSettings(), {
            element: "#reply_dialog",
            css: {
                closeButton: "js_close",
                commentItem: "js_comment",
                mentionButtonArea: "js_mention_button_area",
                mentionListArea: "js_mention_list_area",
            },
            id: {
                dialog: "reply_dialog",
                dialogHeader: "reply_dialog_header",
                comment: "cmmt_id_reply_comment",
                commentNo: "cmmt_reply_comment_no",
                isToDo: "cmmt_reply_istodo",
                toDo: "cmmt_reply_todo_id",
                commentList: "thread_comments",
                replyInputText: "reply_comment_text",
                errorMessage: "error_msg_reply_comment",
                replyCommentNo: "reply_comment_no",
                uploadTableSuffix: "reply_comment",
            },
            mentionReply: {
                urlGetMembers: "",
                commentIdParam: "comment_id",
            },
            mentionInstanceName: "reply_comment_mention",
        });
        return settings;
    }

    _findById(id) {
        return this._find("#" + id);
    }

    bindToCommentList(container, buttons = {replySelector: ".js_reply_button", replyAllSelector: ".js_reply_all_button"}) {
        $(container).on("click", buttons.replySelector, (event) => {
            const comment_data = $(event.currentTarget).closest("." + this.settings.css.commentItem).data();
            comment_data.isReplyAll = false;
            this.open(comment_data);
        });

        $(container).on("click", buttons.replyAllSelector, (event) => {
            if (this.$spinner && this.$spinner.is(":visible")) {
                return;
            }

            const comment_data = $(event.currentTarget).closest("." + this.settings.css.commentItem).data();
            comment_data.isReplyAll = true;
            this.open(comment_data);
        });

        this._bindEvents();
    }

    _bindEvents() {
        this._elementOn("keydown", (event) => {
            if (event.keyCode === KeyCode.ESCAPE) {
                this.close();
                return false;
            }
        });

        this._elementOn("click", "." + this.settings.css.closeButton, this.close.bind(this));
    }

    _getTemplates() {
        return {
            spinner: () => {
                return `<div class="spinnerBoxBase-grn spinnerCentered" style="z-index: 9999"><div class="spinnerBox-grn"></div></div>`;
            },
        };
    }

    _showSpinner() {
        if (typeof this.$spinner === "undefined") {
            this.$spinner = $(this._getTemplates().spinner());
            this.$el.after(this.$spinner);
        }
        this.$spinner.show();
    }

    _hideSpinner() {
        this.$spinner.hide();
    }

    open({commentNo, commentId, isToDo, toDoId, isReplyAll}) {
        this.setDataToFormFields({commentNo, commentId, isToDo, toDoId});
        this.setDialogStyle();

        // Add the comment creator to the mention field
        const mention = grn.js.component.common.ui.mention.Mention.getInstance(this.settings.mentionInstanceName);
        if (mention) {
            this._handleMention(mention, commentId, isReplyAll, isToDo);
        } else {
            this.$el.show();
        }
        this._findById(this.settings.id.replyInputText).focus();
    }

    _handleMention(mention, commentId, isReplyAll, isToDo) {
        const mention_reply_settings = $.extend(true, {mention: mention}, this.settings.mentionReply);
        const mention_reply = new grn.js.component.common.ui.mention.MentionReply(mention_reply_settings);

        // If reply to-do comment, hide mention area
        if (isToDo) {
            mention_reply.resetMention();
            this.$el.find("." + this.settings.css.mentionButtonArea).hide();
            this.$el.find("." + this.settings.css.mentionListArea).hide();
            this.$el.show();

            return;
        }

        this.$el.find("." + this.settings.css.mentionButtonArea).show();
        this.$el.find("." + this.settings.css.mentionListArea).show();

        mention_reply.bindToCommentList("#" + this.settings.id.commentList);
        this._showSpinner();

        let promise = null;
        if (isReplyAll) {
            promise = mention_reply.replyAllToComment(commentId);
        } else {
            promise = mention_reply.replyToComment(commentId);
        }

        promise.done(() => {
            this.$el.show();
            this._hideSpinner();
            this._findById(this.settings.id.replyInputText).focus();
        });
    }

    close() {
        this.$el.hide();
        this._findById(this.settings.id.replyInputText).val("");
        this._findById(this.settings.id.errorMessage).empty().hide();
        grn_clear_fileselect(this.settings.id.uploadTableSuffix);
    }

    setDataToFormFields({commentNo, commentId, isToDo, toDoId}) {
        const reply_prefix = Locale.getMessage("grn.grn", "GRN_GRN-1537");

        this._findById(this.settings.id.replyCommentNo).html(reply_prefix + commentNo);

        this._findById(this.settings.id.comment).val(commentId);
        this._findById(this.settings.id.commentNo).val(commentNo);
        if (isToDo !== null) {
            this._findById(this.settings.id.isToDo).val(isToDo);
        }
        if (toDoId !== null) {
            this._findById(this.settings.id.toDo).val(toDoId);
        }
    }

    setDialogStyle() {
        const dialog = this.$el;
        const body = document.documentElement.clientHeight === 0 ? document.getElementsByTagName("body")[0] : document.documentElement;
        const scrollTop = typeof window.pageYOffset !== "undefined" ? window.pageYOffset : body.scrollTop;
        const top = (body.clientHeight - dialog.height()) / 2 + scrollTop + "px";
        const left = (body.clientWidth - dialog.width()) / 2 + "px";

        dialog.css({"top": top, "left": left, "zIndex": 100});
    }
}