// namespace
grn.base.namespace("grn.page.space.discussion.index");

(function ($) {
    var G = grn.page.space.discussion.index;
    // 先頭の#を切り取る
    G.cutFirstSharp = function (hash) {
        if (hash.indexOf('#') == 0)
            return hash.substring(1, hash.length);
        else
            return hash;
    };
    var callback_history_obj = null;
    var newer_comment_obj = null;
    var isLoading = false;
    var current_hash = '';

    //新しいコメントを確認する間隔(default)
    G.update_discussion_comment_count_time = 30000;

    // フラグメント(location.hash)を監視
    G.history_callback = function () {
        // 二重登録を防ぐ
        if (callback_history_obj != null) clearInterval(callback_history_obj);
        callback_history_obj = setInterval(function () {
            if (isLoading) return;

            // フラグメントに変更がなければ終了
            if (G.cutFirstSharp(location.hash) == G.cutFirstSharp(current_hash)) {
                return;
            }

            current_hash = G.cutFirstSharp(location.hash);
            G.loadThreadDetail(current_hash);
        }, 100);
    };
    // URLバーのhashを更新
    G.update_location_hash = function (hash) {
        if (hash.length > 0) {
            location.hash = hash;
        }
    };
    // hoge=huga&piyo=hogeなどのパラメータから値を取得
    G.getValue = function (hash, key) {
        if (hash.indexOf('#') == 0) hash = hash.substring(1, hash.length);
        var params = hash.split("&");
        for (i = 0; i < params.length; i++) {
            var node = params[i];
            if (node.indexOf(key + "=") == 0) {
                return node.substring(key.length + 1, node.length);
            }
        }
        return null;
    };

    G.getSelectedNode = function (hash) {
        var fid = G.getValue(hash, 'tid');
        var node = null;
        if (fid != null && $("#thread_" + fid).length) {
            node = $("#thread_" + fid).get(0);
        }
        else {
            var sysThrd = document.getElementsByName("system_thread");
            if (sysThrd.length > 0) {
                node = sysThrd[0];
            }
        }
        return node;
    };
    // hashを元に選択されたリンクをハイライト
    G.setHilight = function (hash) {
        // 既存のハイライトを全て消す
        $("a.hilight").each(function (index, node) {
            YAHOO.util.Dom.removeClass(node, 'hilight');
            YAHOO.util.Dom.removeClass(node, 'bold');
        });

        var node = G.getSelectedNode(hash);
        if (node) {
            YAHOO.util.Dom.addClass(node, 'hilight bold');
        }
    };
    G.setUnread = function (hash, unread) {
        var node = G.getSelectedNode(hash);
        if (node) {
            var className = 'space-threadList-unread-grn';
            var readClassName = 'space-threadList-read-grn';
            YAHOO.util.Dom.removeClass(node, className);
            YAHOO.util.Dom.addClass(node, readClassName);
            if (unread) {
                YAHOO.util.Dom.removeClass(node, readClassName);
                YAHOO.util.Dom.addClass(node, className);
            }
        }
    };
    var old_hash = null;
    G.loadThreadDetail = function (hash) {
        // 先頭に#がついている場合があるので切り取る
        hash = G.cutFirstSharp(hash);

        // 前回と同じhashの場合は受け付けない
        if (hash == old_hash)
            return;
        else
            old_hash = hash;

        // ハイライト設定
        // G.setHilight(hash);
        grn.page.space.folder_list.setFocus(G.getValue(hash, "tid"));

        if (newer_comment_obj != null) clearInterval(newer_comment_obj);

        isLoading = true;
        G.update_location_hash(hash);

        // ローディング画像を表示
        $("#thread_body").html("<img src='" + G.spinnerImage + "' />");
        $("#right_list").html("");
        $("#thread_comments").html("");
        $("#thread-follows").css("display","none");
        G.windowTitle = '';

        var request = new grn.component.ajax.request({
                url: G.threadDetailUrl,
                method: 'post',
                dataType: 'json',
                grnRedirectOnLoginError: true,
                data : hash + '&spid=' + G.spid
            }
        );

        request.on('errorClosed', function (e, jqXHR) {
            var errorKey = request.getErrorHandler().getCybozuError(jqXHR);
            if ( errorKey == 'GRN_SPACE_DISCUSSION_00007' ) {
                var tid = G.getValue(hash, 'tid');
                location.replace(G.threadIndex + 'spid=' + G.spid + '#tid=' + tid);
            }
            else {
                location.replace(G.threadIndex + 'spid=' + G.spid);
            }
        });

        request.send().done(
            function (json_obj) {
                var mention = grn.js.component.common.ui.mention.Mention.getInstance("thread_comment_add_mention");
                if (mention) {
                    mention.reset();
                }

                G.history_callback();

                isLoading = false;

                if (json_obj.space_id !== G.spid) {
                    window.location.href = G.threadIndex + "tid=" + json_obj.thread_id + "#tid=" + json_obj.thread_id;
                    return;
                }
                G.windowTitle = json_obj.window_title;
                $("#thread_body").html(json_obj.thread_body);
                $("#right_list").html(json_obj.right_list);
                $("#thread_comments").html(json_obj.thread_comments);
                $("#thread-follows").css("display","block");
                $("#spid_reply_comment").val(json_obj.space_id);
                G.tid = json_obj.thread_id;
                $("#tid_for_comment").val(json_obj.thread_id);
                $("#tid_reply_comment").val(json_obj.thread_id);
                $("#tid_todo").val(json_obj.thread_id);
                if ( $("#tid_search").length ) {
                    $("#tid_search").val(json_obj.thread_id);
                }
                $("#error_msg_thread_comment").html("");
                $("#error_msg_thread_comment").css("display","none");
                var threadAdd = $('#thread_add');
                if (threadAdd.length) {
                    threadAdd.find('a').attr('href', G.threadAddUrl + "&tid=" + json_obj.thread_id);
                }

                G.initThreadMenu();
                G.initSubscribeButton();
                G.threadCommentFormClear('thread_comment');
                G.last_comment_no = json_obj.last_comment_no;
                if (G.update_discussion_comment_count_time > 0) {
                    newer_comment_obj = setInterval( function(){G.getNewerCommentCount();}, G.update_discussion_comment_count_time );
                }
                //G.setUnread(hash, json_obj.is_unread);

                G.jumpToComment(hash);

                grn.page.space.folder_list.setFocus(json_obj.thread_id);

                G.resetThreadWidth();
                G.initMentionMemberField();
            }
        ).always(
            function () {
                isLoading = false;
                setTimeout(G.changeTitle,"20");
                if (grn.browser.msie) {
                    if (document.title != G.windowTitle) {
                        G.changeTitle();
                    }
                }
            }
        );
    };

    G.changeTitle = function () {
        document.title = G.windowTitle;
    };

    G.showErrorMessage = function (request) {
        var s = request.responseText;
        if (s != undefined) {
            $("#body").html(request.responseText);
        }
    };

    G.jumpToComment = function (hash) {
        var cmid = hash.match(/^(|#|.+&)cmid=(\d)/);
        var cmno = hash.match(/^(|#|.+&)cmno=(\d)/);
        var sp = hash.match(/^(|#|.+&)sp=(\d)/);
        if (cmid == undefined && cmno == undefined) {
            if (sp == undefined) return;
        }
        var comments = 'thread_comments';
        var $comments = $("#" + comments);

        if ($comments) {
            var pos = $comments.offset();
            window.scrollTo(0, pos.top - 28)
        }
    };

    G.deleteThread = function (title, form) {
        var content = $("<div>");
        content.html(form);
        // get form element
        var f = content.find("form");
        if (!f.length) return;
        var ui_options = {};
        var message = content.html();
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
                    $("#msgbox").find('input[type="button"]').each(function (idx, ele) {
                        ele.disabled = true;
                    });
                    document.body.style.cursor = 'progress';
                    form.submit();
                    //form.select('input[type="checkbox"]').each(function(i){i.disabled = true});
                }
            }
        });
    };

    G.deleteThreadComment = function (title, commentNo) {
        var form = $("#threadCommentDelete" + commentNo);
        var content = $("#thread_comment_content_" + commentNo).find(".js_thread_comment_body");
        var follow_data = grn_split_tags(content.html());

        var msgbox_follow = form.find('span#msgbox_follow');
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
                    $("#msgbox").find('input[type="button"]').each(function (idx, ele) {
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
        var elm = $("#thread_comment_" + id);
        elm.addClass("selected-comment-grn");

        var delete_link = elm.find(".js_delete_link");
        delete_link.css("opacity", 1);

        var replay_all = elm.find(".js_reply_all_button");
        replay_all.css("opacity", 1);

        var permalink = elm.find(".js_permalink");
        permalink.css("opacity", 1);
    };

    G.unselectComment = function (id) {
        var elm = $("#thread_comment_" + id);
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

    G.threadCommentAdd = function (id) {
        var formId = "follow_form_" + id;
        var commentButton = grn.component.button("#" + id + "_button");

        if (commentButton.isDisabled()) {
            return;
        }

        if (!G.threadCommentValidate(id)) {
            return;
        }

        commentButton.showSpinner();

        var mention_name_map = {
            thread_comment: "thread_comment_add_mention",
            reply_comment: "reply_comment_mention"
        };

        var mention = grn.js.component.common.ui.mention.Mention.getInstance(mention_name_map[id]);
        if (mention) {
            document.getElementById(formId).elements['mention'].value = mention.getMentionData();
        }

        var request = new grn.component.ajax.request({
                url: G.threadCommentAddUrl,
                method: 'post',
                dataType: 'json',
                data : jQuery("#"+formId).serialize()
            }
        );

        request.send().done(
            function(json_obj){
                if(mention){
                    mention.reset();
                }

                $("#thread_comments").html(json_obj.thread_comments);
                G.last_comment_no = json_obj.last_comment_no;
                G.initMentionMemberField();
                if (id == 'thread_comment') {
                    G.threadCommentFormClear(id);
                    G.threadCommentFormInitialize(id);
                }
                if (id === 'reply_comment') {
                    var reply_dialog = new grn.js.component.common.ui.comment.ReplyDialog();
                    reply_dialog.close();
                }
            }
        ).always(
            function () {
                commentButton.hideSpinner();
            }
        );
    };

    G.threadCommentValidate = function (id) {
        var grnEditor, formId = "follow_form_" + id;
        var form = document.forms[formId];
        if (id === 'thread_comment') {
            grnEditor = grn.component.editor.Editor.getInstanceById('thread_comment_add_editor_id');
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
            validators.addValidator(new grn.component.validator.TextLengthLongerThan("thread_comment_add", G.ERRMSG_COMMENT_CONTENTS_IS_REQUIRED, 0) );
        }
        validators.clearErrorMessage();
        if (validators.validateAll()) {
            grn_onsubmit_common(form);
            $("#error_msg_" + id).css("display","none");
            return true;
        }
        else {
            return false;
        }
    };

    G.threadCommentFormClear = function (id) {
        var textareaId = 'thread_comment_add_editor_id';
        var grnEditor = grn.component.editor.Editor.getInstanceById(textareaId);
        if (grnEditor) {
            grnEditor.clear();
        }
        else {
            // when a page is loaded,
            // instance of Editor may not exist.
            $("#" + textareaId).val("");
            $("#" + textareaId).trigger('grn.textarea:resize');
        }

        grn_clear_fileselect(id);
    };

    G.threadCommentFormInitialize = function (id) {
        var textareaId = id + '_add_editor_id';
        var grnEditor = grn.component.editor.Editor.getInstanceById(textareaId);
        grnEditor.changePlainText(true);
        grnEditor.clear();

        $("#" + textareaId).css({
            width: "",
            height: G.textareaHeight + 'px'
        });
        grnEditor.resize();
    };

    G.getCommentListPage = function (sp) {
        G.sp = sp;
        G.getCommentList();
    };

    G.getCommentList = function () {
        $("#thread_comments").html("<img src='" + G.spinnerImage + "' />");

        var request = new grn.component.ajax.request({
                url: G.threadCommentListUrl,
                method: 'post',
                dataType: 'json',
                grnRedirectOnLoginError: true,
                data : 'spid=' + G.spid + '&tid=' + G.tid + '&sp=' + G.sp
            }
        );

        request.on('beforeShowError', function (e, jqXHR) {
            $("#thread_comments").html("");
        });

        request.send().done(
            function(json_obj){
                $("#thread_comments").html(json_obj.thread_comments);
                G.last_comment_no = json_obj.last_comment_no;
                G.initMentionMemberField();
            }
        );
    };

    G.getNewerCommentCount = function () {
        if (isLoading) return;
        var tid = G.tid;
        var last_comment_no = G.last_comment_no;

        var request = new grn.component.ajax.request({
                url: G.newerCommentCountUrl,
                method: 'post',
                dataType: 'json',
                data : 'spid=' + G.spid + '&tid=' + tid + '&comment_no=' + last_comment_no,
                headers: { 'X-Cybozu-Session-No-Prolonging': 'true'}
            }
        );

        request.on('beforeShowError', function (e, jqXHR) {
            e.preventDefault();
        });

        request.send().done(
            function(json_obj){
                if (tid !== G.tid || last_comment_no !== G.last_comment_no) {
                    return;
                }
                var count = json_obj.newer_comment_count;
                if (count == 0) {
                    $("#realtime").hide();
                }
                else {
                    $("#realtime").html(count);
                    $("#realtime").show();
                }
            }
        );
    };

    G.MIN_WIDTH = 530;
    G.LEFT_WIDTH = 220;
    G.RIGHT_WIDTH = 230;
    G.RIGHT_WIDTH_CLOSED = 22;
    if (!(navigator.userAgent.indexOf('Gecko') > -1 && navigator.userAgent.indexOf('KHTML') === -1)) G.RIGHT_WIDTH_CLOSED = G.RIGHT_WIDTH_CLOSED + 10;
    G.CENTER_WIDTH = G.MIN_WIDTH;
    G.CENTER_WIDTH_CLOSED = G.CENTER_WIDTH + G.RIGHT_WIDTH - G.RIGHT_WIDTH_CLOSED;

    G.right_parts_visible = true;

    G.resetThreadWidth = function () {
        var margin = 50;
        var userAgent = window.navigator.userAgent.toLowerCase();
        if (userAgent.indexOf("webkit") > -1) margin = margin + 24;

        var width = G.body.clientWidth - G.LEFT_WIDTH - G.RIGHT_WIDTH - margin;
        if (width < G.MIN_WIDTH) {
            width = G.MIN_WIDTH;
        }
        G.CENTER_WIDTH = width;
        G.CENTER_WIDTH_CLOSED = G.CENTER_WIDTH + G.RIGHT_WIDTH - G.RIGHT_WIDTH_CLOSED;

        var center_cell = document.getElementById("space-thread-container");
        if (center_cell == null) return;
        center_cell.style.width = (G.right_parts_visible? G.CENTER_WIDTH: G.CENTER_WIDTH_CLOSED) + "px";
    };

    G.changeRightListStatus = function () {
        var right_link = document.getElementById("right_link");
        var discussion_area = document.getElementById("discussion_area");
        var center_cell = document.getElementById("space-thread-container");
        var right_cell = document.getElementById("space-thread-right-container");

        if (G.right_parts_visible) {
            var rightAnim = new YAHOO.util.Anim( right_cell );
            rightAnim.duration = 0.3;
            rightAnim.method = YAHOO.util.Easing.easeOut;

            var mainAnim = new YAHOO.util.Anim( center_cell );
            mainAnim.duration = 0.3;
            mainAnim.method = YAHOO.util.Easing.easeOut;

            rightAnim.attributes.width = { to : G.RIGHT_WIDTH_CLOSED };
            rightAnim.animate();
            mainAnim.attributes.width = { to : G.CENTER_WIDTH_CLOSED };
            mainAnim.onComplete.subscribe( hideRightList );
            mainAnim.animate();
        }
        else {
            showRightList();
            G.resetThreadWidth();
            right_cell.style.width = G.RIGHT_WIDTH + "px";
        }

        function hideRightList() {
            YAHOO.util.Dom.replaceClass(right_link, 'space-threadRightList-gripClose-grn', 'space-threadRightList-gripOpen-grn');
            YAHOO.util.Dom.addClass(discussion_area, 'space-threadRightList-close-grn');
            G.right_parts_visible = false;
        }

        function showRightList() {
            YAHOO.util.Dom.replaceClass(right_link, 'space-threadRightList-gripOpen-grn', 'space-threadRightList-gripClose-grn');
            YAHOO.util.Dom.removeClass(discussion_area, 'space-threadRightList-close-grn');
            G.right_parts_visible = true;
        }
    };

    G.chooseRightListTab = function (key) {
        var key_array = new Array('my_todo', 'all_todo', 'all_file');
        switch (key) {
            case 'my_todo':
            case 'all_todo':
            case 'all_file':
                for (var i = 0; i < key_array.length; i++) {
                    var el = $("#select_tab_" + key_array[i]);
                    if (el.length) {
                        if (key == key_array[i]) {
                            el.show();
                        }
                        else {
                            el.hide();
                        }
                    }
                }
                break;
        }
        G._getRightList(key);
    };

    G._getRightList = function (key) {
        var request = new grn.component.ajax.request({
                url: G.threadRightListUrl,
                method: 'post',
                dataType: 'json',
                grnRedirectOnLoginError: true,
                data : 'spid=' + G.spid + '&tid=' + G.tid + '&key=' + key
            }
        );

        request.send().done(
            function(json_obj){
                var right_list = json_obj.right_list;
                if (key != 'my_todo' && key != 'all_todo' && key != 'all_file') {
                    $("#right_list").html(right_list);
                }
                else {
                    $("#" + key).html(right_list);
                }
            }
        );
    };

    G.showEntireComment = function (cid) {
        var cmt = $("#thread_comment_content_" + cid);
        var entire_cmt = $("#thread_comment_entire_content_" + cid);
        cmt.css("display","none");
        entire_cmt.css("display","block");
        $("#lnk_url_more_" + cid).remove();
    };

    YAHOO.util.Event.onDOMReady(function () {
        G.body = document.getElementsByTagName('body')[0];
        G.resetThreadWidth();
        $(window).on("resize", G.resetThreadWidth);
    });

    G.setDialogPosition = function () {
        var switchElement = $("#thread_menu");
        var dialogElement = $("#thread_operation");
        if (!switchElement.length || !dialogElement.length) return;

        var switchOffset = switchElement.position();
        dialogElement.css({left:"",top:""});
        var left = switchOffset.left - dialogElement.width() + switchElement.width() + 12;
        var top = switchOffset.top;
        dialogElement.css({left:left,top:top});
    };

    G.clickThreadMenu = function () {
        var dialogElement = $("#thread_operation");
        G.toggleArrow();
        G.setDialogPosition();
        dialogElement.toggle();

        if (dialogElement.is(":visible")) {
            G.setDialogPosition();
            var width = 0;
            if ($("#follower_list_link").length) {
                width = $("#follower_list_link").outerWidth();
            }
            if ($("#thread_edit_link").length && width < $("#thread_edit_link").outerWidth()) {
                width = $("#thread_edit_link").outerWidth();
            }
            if ($("#lnk_delete").length && width < $("#lnk_delete").outerWidth()) {
                width = $("#lnk_delete").outerWidth();
            }
            dialogElement.css("width", width + 9 + "px");
        }
    };

    G.toggleArrow = function () {
        var class_switch_on  = "icon-showMenu-grn";
        var class_switch_off = "icon-hideMenu-grn";
        var switchElement = document.getElementById("thread_menu");
        if (YAHOO.util.Dom.hasClass(switchElement, class_switch_off)) {
            YAHOO.util.Dom.addClass(switchElement, class_switch_on);
            YAHOO.util.Dom.removeClass(switchElement, class_switch_off);
        }
        else {
            YAHOO.util.Dom.removeClass(switchElement, class_switch_on);
            YAHOO.util.Dom.addClass(switchElement, class_switch_off);
        }
    };

    var isInitThreadMenu = false;
    G.initThreadMenu = function () {
        var switchElement = $("#thread_menu");

        if (!switchElement.length) return;

        switchElement.on( 'click', function(e){
            G.clickThreadMenu();
        });

        if (isInitThreadMenu) return;
        isInitThreadMenu = true;
        $(window.document).on("click", function(e){
            var target = $(e.target);
            if (!target.is("#thread_menu") && !$("#thread_menu").has(e.target).length && !target.is("#thread_operation") && !$("#thread_operation").has(e.target).length && $("#thread_operation").is(":visible")) {
                G.clickThreadMenu();
            }
        });

        $(window).on("resize", function(){
            setTimeout(function(){
                G.setDialogPosition();
            }, 0);
        });
        G.initMentionMemberDialog();
    };

    var CLASS_FOLLOW_ON      = "buttonFollowOn-grn";
    var CLASS_FOLLOW_OFF     = "buttonFollowOff-grn";
    var CLASS_FOLLOW_RELEASE = "buttonFollowRelease-grn";
    G.initSubscribeButton = function () {
        var follow_button = $("#follow_button");
        if (!follow_button.length) return;

        if (follow_button.hasClass(CLASS_FOLLOW_OFF)) {
            follow_button.unbind("mouseover", G.overSubscribeButton).unbind("mouseout", G.outSubscribeButton);
        }
        else {
            follow_button.bind("mouseover", G.overSubscribeButton).bind("mouseout", G.outSubscribeButton);
        }
    };

    G.overSubscribeButton = function () {
        var follow_button = $("#follow_button");
        var follow_link = $("#follow_link");
        if (follow_button.hasClass(CLASS_FOLLOW_ON)) {
            follow_button.removeClass(CLASS_FOLLOW_ON);
            follow_button.addClass(CLASS_FOLLOW_RELEASE);
            follow_link.html(G.text_switch_release);
        }
    };

    G.outSubscribeButton = function () {
        var follow_button = $("#follow_button");
        var follow_link = $("#follow_link");
        if (follow_button.hasClass(CLASS_FOLLOW_RELEASE)) {
            follow_button.addClass(CLASS_FOLLOW_ON);
            follow_button.removeClass(CLASS_FOLLOW_RELEASE);
            follow_link.html(G.text_switch_on);
        }
    };

    var isSubscribeLoading = false;
    G.subscribe = function () {
        if (isSubscribeLoading) return;
        isSubscribeLoading = true;
        var follow_button = $("#follow_button");
        var follow_link = $("#follow_link");
        var key = 0;
        if (follow_button.hasClass(CLASS_FOLLOW_OFF)) {
            key = 1;
        }

        var loading = $("#thread_follow_loading");
        loading.html("<img src='" + G.spinnerImage + "' />");
        follow_button.unbind('mouseover', G.overSubscribeButton).unbind('mouseout', G.outSubscribeButton);

        var request = new grn.component.ajax.request({
                url: G.enable_follow_url,
                method: 'post',
                dataType: 'json',
                grnRedirectOnLoginError: true,
                data : 'spid=' + G.spid + '&tid=' + G.tid + '&key=' + key + '&csrf_ticket=' + grn.csrfTicket
            }
        );

        request.send().done(
            function(json_obj){
                var status = json_obj.is_subscribe;
                if (status === 'subscribe') {
                    follow_button.removeClass(CLASS_FOLLOW_OFF).removeClass(CLASS_FOLLOW_RELEASE).addClass(CLASS_FOLLOW_ON);
                    follow_link.html(G.text_switch_on);
                }
                else {
                    follow_button.removeClass(CLASS_FOLLOW_ON).removeClass(CLASS_FOLLOW_RELEASE).addClass(CLASS_FOLLOW_OFF);
                    follow_link.html(G.text_switch_off);
                }
            }
        ).always(
            function(){
                loading.html("");
                G.initSubscribeButton();
                isSubscribeLoading = false;
            }
        );
    };
    G.initMentionMemberField = function () {
        $(".js_comment").each(function () {
            var settings = {
                element: $(this),
                params: {comment_id: $(this).data('comment-id')},
                url: "grn/space/ajax/get_remaining_members_of_mention"
            };
            new grn.js.component.common.ui.show_more.MemberListShowMore(settings).render();
        });
    };
    G.initMentionMemberDialog = function () {
        var thread_comment_obj = $("#thread_comments");
        var access_plugin_encoded = thread_comment_obj.data("mention-access-plugin");
        var dialog = grn.component.member_list_dialog.get_instance("member_list_dialog_mention");
        if (dialog === undefined) {
            dialog = new grn.component.member_list_dialog.MemberListDialog({
                url: grn.component.url.page("grn/ajax/member_list_dialog"),
                dialog_name: "member_list_dialog_mention",
                app_id: "space",
                auto_bind: false,
                access_plugin_encoded: access_plugin_encoded
            });
        }
        dialog.bindDialogToMembersContainer(thread_comment_obj, ".dialog_link");
    };

})(jQuery);
