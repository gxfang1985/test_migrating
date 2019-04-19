// namespace
grn.base.namespace("grn.page.space.todo.todo");

(function ($) {
    var G = grn.page.space.todo.todo;
    G.loaded = false;
    G.duedate_html = null;
    G.assignees_html = null;
    G.pageurl = null;
    G.form = null;

    G.openTodoAddDialog = function(from){
        G.disableOnKeyDown(G.closeTodoAddDialog);

        var body = document.getElementsByTagName('body')[0];
        G.$body = ((document.documentElement.clientHeight==0)?body:document.documentElement);

        var overlay = $("<div>").attr("id", "overlay").addClass("overlay");
        G.$overlay = overlay;

        //Draw the over layer only when another over layer does not exist.
        if ($('.overlay').length === 0) {
            body.appendChild(overlay.get(0));
        }

        var dialog = $("#todo_add_dialog");
        G.$dialog = dialog;

        $("input#todo_add_from").val(from);

        if (!G.loaded) {
            G.duedate_html = $("#space-todo-addDialog-date-col").html();
            G.assignees_html = $("#space-todo-addDialog-assignees-col").html();
            G.loaded = true;
        }

        grn.component.member_add.get_instance('todo_assignees').search();

        dialog.show();

        G.setPosition('auto');
        $("#space-todo-addDialog-name").focus();

        $(window).on("resize", G.setPosition);

    };

    G.submit = function(action) {

        var todo_assignees = grn.component.member_add.get_instance('todo_assignees');
        todo_assignees.prepareSubmit();

        var form_name = 'todo_add';

        var commentButton = grn.component.button("#" + form_name + "_submit");
        commentButton.showSpinner();

        if (!grn.page.space.todo.todo_edit.validate(document.forms[form_name])){
            commentButton.hideSpinner();
            return false;
        }

        var request = new grn.component.ajax.request({
                url: action,
                method: 'post',
                dataType: 'json',
                data : jQuery("#"+form_name).serialize()
            }
        );

        request.send().done(
            function(json_obj){
                if (json_obj.from == 1) {
                    G.closeTodoAddDialog();
                    location.hash = G.getNewHash(location.hash, json_obj.todo_id);
                }
                else {
                    if (grn.browser.msie) {
                        G.closeTodoAddDialog();
                    }

                    var sp = location.hash.match(/^(|#|.+&)sp=(\d)/);
                    if (sp == undefined || sp[2] == 0) {
                        location.reload(true);
                    }
                    else {
                        if (typeof callback_history_obj != 'undefined') {
                            clearInterval(callback_history_obj);
                        }
                        window.location.replace(json_obj.redirect);
                        if (!grn.browser.msie) {
                            location.reload(true);
                        }
                    }
                }
            }
        ).always(
            function () {
                commentButton.hideSpinner();
            }
        );

        return false;
    };
    G.setPosition = function(px) {

        G.$overlay.css({width : Math.max(G.$body.clientWidth, G.$body.scrollWidth), height : Math.max(G.$body.clientHeight, G.$body.scrollHeight)});

        G.$dialog.css("width", px);

        if (grn.browser.android) {
            var top = G.$body.scrollTop + 'px';
            var left = G.$body.scrollLeft + 'px';
        }
        else {
            if (typeof window.pageYOffset != 'undefined') {
                var scrollTop = window.pageYOffset;
            }
            else {
                var scrollTop = G.$body.scrollTop;
            }
            var top = (G.$body.clientHeight - G.$dialog.height())/2 + scrollTop + 'px';
            var left = (G.$body.clientWidth - G.$dialog.width())/2 + 'px';
        }

        G.$dialog.css({top: top, left: left});
    };

    G.closeTodoAddDialog = function(){
        G.$dialog.hide();

        G.reinitializeTodoDialog();

        G.$overlay.remove();
        G.clearDialogFocus('todo_add_dialog');
        G.enableOnKeyDown();
        $(window).unbind("resize", G.setPosition);
    };

    G.reinitializeTodoDialog = function () {
        $("#space-todo-addDialog-date-col").html(G.duedate_html);
        $("#space-todo-addDialog-assignees-col").html(G.assignees_html);
        $("#space-todo-addDialog-name").val("");
        $("#space-todo-addDialog-memo").val("");

        if ($("#space-todo-addDialog-memo-row").css('display') !== 'none') {
            grn.page.space.todo.todo_edit.display_item();
        }

        new grn.component.search_box.SearchBox('todo-dialog-search-user');

        grn_clear_fileselect('todo_add');
    };

    var old_onkeydown_handler = null;

    G.disableOnKeyDown = function(closeHandler){
        if( ! old_onkeydown_handler )
            old_onkeydown_handler = document.onkeydown;
        document.onkeydown = function(e){
            e = (e == undefined) ? event : e;
            if( GRN_Event.keyCode(e) == 27 ){ //ESC key
                return closeHandler();
            }
            return true;
        };
    };

    G.enableOnKeyDown = function(){
        document.onkeydown = old_onkeydown_handler;
        old_onkeydown_handler = null;
    };

    G.updateDialogFocus = function(dialogId, closeHandler){
        var dialogItems = $("div#"+dialogId+" input, div#"+dialogId+" label, div#"+dialogId+" a");
        dialogItems.each(function(i, ele){
            $(ele).focus(function(e){
                G.enableOnKeyDown();
            });
            $(ele).blur(function(e){
                if(!$("#dialogId").is(":visible"))
                    return false;
                G.disableOnKeyDown( closeHandler );
                return true;
            });
        });
    };

    G.showErrorMessage = function(request){
        G.$dialog.hide();
        grn.component.error_handler.show(request, function(){G.$dialog.show();});
    };

    G.getWindowWidth = function(){
        if(window.innerWidth) return window.innerWidth; // Mozilla, Opera, NN4
        if(document.documentElement && document.documentElement.clientWidth){ // 以下 IE
            return document.documentElement.clientWidth;
        }
        else if(document.body && document.body.clientWidth){
            return document.body.clientWidth;
        }
        return 0;
    };

    G.getWindowHeight = function(){
        if(window.innerHeight) return window.innerHeight; // Mozilla, Opera, NN4
        if(document.documentElement && document.documentElement.clientHeight){ // 以下 IE
            return document.documentElement.clientHeight;
        }
        else if(document.body && document.body.clientHeight){
            return document.body.clientHeight;
        }
        return 0;
    };

    G.displaySpinner = function(displaySpinner){
        $("#spinner-loading-cid").css({height:"16px", width:"16px"}).show();
        var spinner_img = document.createElement( 'div' );
        spinner_img.id = 'spinner-loading';
        spinner_img.style.position = 'absolute';
        spinner_img.style.margin = '3px 0pt 0pt 3px';
        spinner_img.style.zIndex = '2';
        spinner_img.style.height = '16px';
        spinner_img.style.width = '16px';
        spinner_img.style.background = 'url(' + G.spinnerImage + ')';
        var form = document.forms[G.form];
        var parent_form = form.elements[displaySpinner].parentNode;
        parent_form.insertBefore( spinner_img, document.getElementById(displaySpinner) );
    };

    G.initSelectOptions = function(selected_item){
        var form = document.forms[G.form];
        var options = form.elements[selected_item];
        while(options.length > 1){
            options[0] = null;
        }
    };

    G.clearDialogFocus = function(dialogId){
        var dialogItems = $("div#"+dialogId+" input, div#"+dialogId+" label, div#"+dialogId+" a");
        dialogItems.each(function(i, ele){
            $(ele).focus(function(){});
            $(ele).blur(function(){});
        });
    };

    G.getNewHash = function (hash, todo_id) {
        if (hash.indexOf('#') == 0) hash = hash.substring(1, hash.length);
        var params = hash.split("&");
        var none_flag = true;
        for (i = 0; i < params.length; i++) {
            var node = params[i];
            if (node.indexOf('tdid=') == 0) {
                params[i] = 'tdid=' + todo_id;
                none_flag = false;
            }
            if (node.indexOf('sp=') == 0) {
                params.splice(i, 1);
                i--;
            }
        }
        if (none_flag) params[i] = 'tdid=' + todo_id;
        return '#' + params.join('&');
    };
})(jQuery);
