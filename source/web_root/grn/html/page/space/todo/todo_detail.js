// namespace
grn.base.namespace("grn.page.space.todo.todo_detail");

(function ($) {
    var G = grn.page.space.todo.todo_detail;
    var isLoading = false;

    YAHOO.util.Event.onDOMReady(function () {
        G.getCommentList();
    });

    G.showErrorMessage = function (request) {
        var s = request.responseText;
        if (s != undefined) {
            $("#body").html(request.responseText);
        }
    };
    G.deleteTodoComment = function (title, commentNo) {
        var form = $("#todoCommentDelete" + commentNo);
        var content = $("#todo_comment_content_" + commentNo);
        var follow_data = grn_split_tags(content.html());

        var msgbox_follow = form.find("span#msgbox_follow");
        if( msgbox_follow.length ){
            msgbox_follow.html(follow_data);
        }
        var ui_options = {};
        var message = form.html();
        // show message box
        GRN_MsgBox.show(message, title, GRN_MsgBoxButtons.yesno, {
            ui : ui_options,
            caption : {
                ok : grn.msg.OK,
                cancel : grn.msg.CANCEL,
                yes : grn.msg.YES,
                no : grn.msg.NO
            },
            callback: function (result, form) {
                if (result == GRN_MsgBoxResult.yes) {
                    // submit form
                    $("#msgbox").find("input[type='button']").each(function (idx, ele) {
                        ele.disabled = true;
                    });
                    document.body.style.cursor = 'progress';
                    form.submit();
                    //form.select('input[type="checkbox"]').each(function(i){i.disabled = true});
                }
            }
        });
    };

    G.selectComment = function (id) {
        var elm = $("#todo_comment_" + id);
        elm.addClass("selected-comment-grn");

        var delete_link = elm.find(".js_delete_link");
        delete_link.css("opacity", 1);

        var replay_all = elm.find(".js_reply_all_button");
        replay_all.css("opacity", 1);

        var permalink = elm.find(".js_permalink");
        permalink.css("opacity", 1);
    };

    G.unselectComment = function (id) {
        var elm = $("#todo_comment_" + id);
        elm.removeClass("selected-comment-grn");

        var delete_link = elm.find(".js_delete_link");
        delete_link.css("opacity", 0);

        var replay_all = elm.find(".js_reply_all_button");
        replay_all.css("opacity", 0);

        var permalink = elm.find(".js_permalink");
        var plinkbox = jQuery("#PermanentLinkBox");

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

    G.todoCommentAdd = function (id) {
        var todoCommentButton = grn.component.button("#" + id + "_button");

        if (todoCommentButton.isDisabled()) {
            return;
        }

        var formId = "follow_form_" + id;

        if (!G.todoCommentValidate(id)) {
            return;
        }

        todoCommentButton.showSpinner();

        var request = new grn.component.ajax.request({
                url: G.todoCommentAddUrl,
                method: 'post',
                dataType: 'json',
                data : jQuery("#"+formId).serialize()
            }
        );
        request.send().done(
            function(json_obj){
                $("#todo_comments").html(json_obj.todo_comments);
                G.last_comment_no = json_obj.last_comment_no;
                if (id == 'todo_comment') {
                    G.todoCommentFormClear(id);
                    G.todoCommentFormInitialize(id);
                }
                if (id === 'reply_comment') {
                    var reply_dialog = new grn.js.component.common.ui.comment.ReplyDialog();
                    reply_dialog.close();
                }
            }
        ).always(
            function () {
                todoCommentButton.hideSpinner();
            }
        );
    };

    G.todoCommentValidate = function (id) {
        var grnEditor, formId = "follow_form_" + id;
        var form = document.forms[formId];
        if (id === 'todo_comment') {
            grnEditor = grn.component.editor.Editor.getInstanceById('todo_comment_add_editor_id');
            grnEditor.save();
        }

        var validators = new grn.component.validator(form, document.getElementById("error_msg_" + id));
        var hasFileUpload = false;
        var uploadTable = $("#upload_table_" + id);
        if (uploadTable.children().length >= 1) {
            var checkboxs = $('#upload_table_' + id + ' input[type="checkbox"]');
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
            validators.addValidator(new grn.component.validator.TextLengthLongerThan("todo_comment_add", G.ERRMSG_COMMENT_CONTENTS_IS_REQUIRED, 0) );
        }
        validators.clearErrorMessage();
        if (validators.validateAll()) {
            grn_onsubmit_common(form);
            return true;
        }
        else {
            return false;
        }
    };

    G.todoCommentFormInitialize = function (id) {
        var textareaId = id + '_add_editor_id';
        var grnEditor = grn.component.editor.Editor.getInstanceById(textareaId);
        grnEditor.changePlainText(true);

        $("#" + textareaId).css({
            width: G.textareaWidth + 'px',
            height: G.textareaHeight + 'px'
        });
        grnEditor.resize();
    };

    G.todoCommentFormClear = function (id) {
        var grnEditor = grn.component.editor.Editor.getInstanceById('todo_comment_add_editor_id');
        if (grnEditor) {
            grnEditor.clear();
        }
        else {
            $("#todo_comment_add_editor_id").val("");
        }
        grn_clear_fileselect(id);
    };

    G.getCommentListPage = function (sp) {
        G.sp = sp;
        G.cmno = '';
        G.cmid = '';
        G.jump = 1;
        G.getCommentList();
    };

    G.getCommentList = function () {
        $('#todo_comments').html("<img src='" + G.spinnerImage + "' />");
        G.windowTitle = '';

        var para_str = '';
        var para_arr = Array( "cmid", "cmno", "sp", "from" );
        while (value = para_arr.pop()) {
            if ( G[value] ) para_str += '&'+ value + '=' + G[value];
        }

        var request = new grn.component.ajax.request({
                url: G.todoCommentListUrl,
                method: 'post',
                dataType: 'json',
                grnRedirectOnLoginError: true,
                data : "spid=" + G.spid + "&tdid=" + G.tdid + para_str
            }
        );
        request.on('errorClosed', function (e, jqXHR) {
            location.replace(G.todoView+'spid=' + G.spid + '&tdid=' + G.tdid);
        });

        request.send().done(
            function(json_obj){
                G.windowTitle = json_obj.window_title;
                $("#todo_comments").html(json_obj.todo_comments);
                G.last_comment_no = json_obj.last_comment_no;
                G.jumpToComment();
            }
        ).always(
            function () {
                setTimeout(G.changeTitle,"20");
                if (grn.browser.msie) {
                    if (document.title != G.windowTitle) {
                        G.changeTitle();
                    }
                }
            }
        );
    };

    G.jumpToComment = function (hash) {
        if ( !G.jump && !G.cmno && !G.cmid ) return;

        window.location.href = "#follow";
    };

    G.changeTitle = function () {
        document.title = G.windowTitle;
    };
})(jQuery);
