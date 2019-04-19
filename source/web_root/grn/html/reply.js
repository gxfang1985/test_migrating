grn.base.namespace("grn.page.comment.reply");

(function () {
    var G = grn.page.comment.reply;
    var i18n = grn.component.i18n;
    G.selectors = {
        mention_value: "#cmmt_reply_mention"
    };

    G.selectComment = function (id) {
        var elm = jQuery("#thread_comment_" + id);
        elm.addClass("selected-comment-grn");

        var delete_link = elm.find(".js_delete_link");
        delete_link.css("opacity", 1);

        var replay_all = elm.find(".js_reply_all_button");
        replay_all.css("opacity", 1);

        var permalink = elm.find(".js_permalink");
        permalink.css("opacity", 1);
    };

    G.unselectComment = function (id) {
        var elm = jQuery("#thread_comment_" + id);
        elm.removeClass("selected-comment-grn");

        var delete_link = elm.find(".js_delete_link");
        delete_link.css("opacity", 0);

        var replay_all = elm.find(".js_reply_all_button");
        replay_all.css("opacity", 0);

        var permalink = elm.find(".js_permalink");
        var plinkbox = jQuery('#PermanentLinkBox');

        if ((!plinkbox) || (plinkbox.css("display") != "none")) {
            var comment_id = plinkbox.data("comment_id");
            if (comment_id != id) {
                permalink.css("opacity", 0);
            }
        }
        else {
            permalink.css("opacity", 0);
        }

    };

    G.toggleCommentPosting = function (id, loading) {
        var comment_button = grn.component.button("#" + id + "_button");

        if (!loading) {
            comment_button.hideSpinner();
        }
        else {
            comment_button.showSpinner();
        }
    };

    /**
     * This function uses for the reply comment has been mentioned
     * @param {Object} $form
     */
    G.prepareMentionData = function ($form) {
        var mention_instance = grn.js.component.common.ui.mention.Mention.getInstance("reply_comment_mention");
        var $mentioned_value = $form.find(this.selectors.mention_value);
        var has_mention = $mentioned_value && mention_instance;
        if (has_mention) {
            $mentioned_value.val(mention_instance.getMentionData());
        }
    };

    G.threadCommentAdd = function (id) {
        var comment_button = grn.component.button("#" + id + "_button");

        if (comment_button.isDisabled()) {
            return;
        }

        var formId = "follow_form_" + id;
        if (!G.threadCommentValidate(id)) {
            return;
        }

        var $form = jQuery("form[id='" + formId + "']");
        var data_value = $form.find("textarea[name='thread_comment_add']").val();
        var reply_comment_num = $form.find("#cmmt_reply_comment_no").val();
        var reply_symbol = grn.component.i18n.cbMsg("grn.grn", "GRN_GRN-1537");
        $form.find("input[name='data']").val(reply_symbol + reply_comment_num + "\n" + data_value);

        G.toggleCommentPosting(id, true);
        G.prepareMentionData($form);
        var request = new grn.component.ajax.request({
                url: G.threadCommentAddUrl,
                dataType: "json",
                data: $form.serialize(),
                method: "post"
            }
        );

        request.send()
            .done(function (request) {
                G.toggleCommentPosting(id, false);

                if (id === 'reply_comment') {
                    var reply_dialog = new grn.js.component.common.ui.comment.ReplyDialog();
                    reply_dialog.close();
                }

                G.redirect(location.href);
            })
            .fail(function () {
                G.toggleCommentPosting(id, false);
            });
    };

    G.redirect = function (url) {
        var arr = url.split("?");
        if (arr.length < 2) {
            location.href = url;
        }
        else {
            url = arr[0] + "?";
            var url_length = url.length;
            var tmp = arr[1].split("&");
            for (var i = 0; i < tmp.length; i++) {
                if (tmp[i].match(/sp=/gi)) continue;
                if (url.length == url_length) {
                    url = url + tmp[i];
                }
                else {
                    url = url + "&" + tmp[i];
                }
            }
            location.href = url.replace(/#follow/gi, "");
        }
    };

    G.threadCommentValidate = function (id) {
        var formId = "follow_form_" + id;
        var form = document.getElementById(formId);

        var validators = new grn.component.validator(form, document.getElementById('error_msg_' + id));
        var hasFileUpload = false;
        var uploadTable = jQuery("#upload_table_" + id);
        if (uploadTable.children.length >= 1) {
            var checkboxs = jQuery('#upload_table_' + id + ' input[type="checkbox"]');
            var any = false;
            checkboxs.each(function(idx, el){
                if(el.checked){
                    any = true;
                    return false;
                }
            });
            hasFileUpload = any;
        }

        if (hasFileUpload == false) {
            var empty_comment_message = G.ERRMSG_COMMENT_CONTENTS_IS_REQUIRED || i18n.cbMsg("grn.grn", "GRN_GRN-1542");
            validators.addValidator(
                new grn.component.validator.TextLengthLongerThan("thread_comment_add", empty_comment_message, 0) );
        }
        validators.clearErrorMessage();
        if (validators.validateAll()) {
            grn_onsubmit_common(form);
            jQuery("#error_msg_" + id).css("display","none");
            return true;
        }
        else {
            return false;
        }
    };

})();
