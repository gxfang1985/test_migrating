grn.base.namespace("grn.page.mail.mail_list");

(function ($) {
    var G = grn.page.mail.mail_list;
    var MP = grn.page.mail.mail_3pane;
    var _rows = "li[id^='mail_list-row_']";//rows
    var _checkbox_filter = "input[type=checkbox]";//checkbox filter
    var _selected_class = "list_select_grn";//selected class
    var _selected_target = '#select_target';//select target

    if (G.is_loaded) {
        return;
    }

    G.ajax_object = null;
    var mail_loading_options = {};
    G.is_spinner_loading = false;

    G.history = {
        shortcut : {
            previous : new Date(0),
            latest : new Date(),
            eventFired : false
        },
        shouldDisplayMailDetail : function() {
            if (G.history.shortcut.eventFired === false) {
                return true;
            }
            return G.history.shortcut.latest.getTime() - G.history.shortcut.previous.getTime() > 800;
        },
        mailItemFocusKept : function() {
            var now = new Date();
            return now.getTime() - G.history.shortcut.latest.getTime() >= 800 && G.history.shortcut.eventFired;
        },
        update : function() {
            G.history.shortcut.eventFired = true;
            G.history.shortcut.previous = G.history.shortcut.latest;
            G.history.shortcut.latest = new Date();
        }
    };

    G.getMailView = function (param) {
        // check whether it's the same request.
        var diff = false;
        if (mail_loading_options['aid'] != MP.aid || mail_loading_options['cid'] != MP.cid || mail_loading_options['mid'] != MP.mid) {
            diff = true;
        }

        if (G.requireMailViewUrl && (diff || !G.ajax_object)) {
            mail_loading_options['aid'] = MP.aid;
            mail_loading_options['cid'] = MP.cid;
            mail_loading_options['mid'] = MP.mid;

            if (G.ajax_object) {
                G.ajax_object.jqXHR.abort();
            }

            var request_data = 'aid=' + MP.aid + '&cid=' + MP.cid + '&mid=' + MP.mid;
            if (param) {
                request_data = request_data + '&' + param;
            }

            $('#mail_view').html('&nbsp;<img src="' + G.spinnerImage + '" />');

            G.ajax_object = new grn.component.ajax.request({
                    url: G.requireMailViewUrl,
                    dataType: "json",
                    data: request_data,
                    method: "post"
                }
            );

            G.ajax_object.send()
                .done(function(json_obj, text_status, transport){
                    if (json_obj.mail_view) {
                        G.unbindEventsForMailView();
                        $('#mail_view').html(json_obj.mail_view);
                        $('#mail_list-row_'+MP.mid).removeClass('unread_grn').addClass('read_grn');
                        MP.resetWidth(MP.left_fixed, MP.center_fixed);
                        MP.resetHeight();
                        G.ajax_object = null;
                        var updater = grn.component.mail.MailPartsUpdater;
                        updater.updateEachFolderNumOfUnreadMail(json_obj.numOfUnreadMails);
                        G.bindEventsForMailView();
                    }
                })
                .always(function(){
                    if ($('#list_center').css('display') == 'none') {
                        $('#action_icon').attr("title", MP.open_message).find('span').removeClass('expand_left_button_grn').addClass('expand_right_button_grn');
                        $('#mail_content_scroll').focus();
                    } else {
                        $('#list_area_scroll').focus();
                    }
                    G.toggleMenu(1);
                    G.ajax_object = null;
                    $("#mail_credit").hide();
                });
        }
    };

    G.unbindEventsForMailView = function () {
        $("#menu_option_delete_file").unbind();
    };

    G.bindEventsForMailView = function () {
        var showInlineImagesButton = $("#mail_show_inline_files_button");
        var hideInlineImagesButton = $("#mail_hide_inline_files_button");
        var inlineFilesContainer = $("#mail_inline_files");

        showInlineImagesButton.click(function () {
            showInlineImagesButton.hide();
            hideInlineImagesButton.show();
            inlineFilesContainer.show();
        });

        hideInlineImagesButton.click(function () {
            hideInlineImagesButton.hide();
            showInlineImagesButton.show();
            inlineFilesContainer.hide();
        });
    };

    G.attachFileDelete = function () {
        if (G.requireFileDeleteUrl && G.is_spinner_loading == false) {
            G.is_spinner_loading = true;

            G.ajax_object = new grn.component.ajax.request({
                    url: G.requireFileDeleteUrl,
                    dataType: "json",
                    data: {aid: MP.aid, cid: MP.cid, mid: MP.mid, csrf_ticket: MP.csrf_ticket},
                    method: "post"
                }
            );

            G.ajax_object.send()
                .done(function(json_obj, text_status, transport){
                    G.is_spinner_loading = false;
                    G.ajax_object = null;
                    G.getMailView();
                })
                .always(function(){
                    G.is_spinner_loading = false;
                    G.ajax_object = null;
                });
        }
    };

    G.changeCharset = function (action, name) {
        var form = $('form[name='+ name +']').get(0);
        G.ajaxPost(action, name, function(){
            G.getMailView($(form).serialize());
        });
    };

    G.sendReadMail = function (action, name) {
        var form = $('form[name='+ name +']').get(0);
        G.ajaxPost(action, name, function(){
            $('#open_send').html('').hide();
            if (action == 'open') {
                G.getMailView();
            }
        });
    };

    G.ajaxPost = function (action, name, callBack) {

        var form = $('form[name='+ name +']').get(0);
        if (form && form.action && G.is_spinner_loading == false) {
            G.is_spinner_loading = true;

            var elem = $('#'+name+'_loading');
            var targetBtn = (action == 'open') ? elem.prevAll('span.aButtonStandard-grn').eq(1) : elem.prev('span.aButtonStandard-grn').eq(0);
            targetBtn.after(elem);
            elem.css({'margin-left':'-3px', 'position':'absolute'});
            elem.html('<img src="' + G.spinnerImage + '" />');

            form.cmd.value = action;

            var request = new grn.component.ajax.request({
                    url: form.action,
                    dataType: "json",
                    data: $(form).serialize(),
                    method: "post"
                }
            );

            request.send()
                .done(function(json_obj, text_status, transport){
                    if (typeof callBack == 'function') {
                        callBack();
                    }
                })
                .always(function(){
                    G.is_spinner_loading = false;
                    elem.html('');
                });
        }
    };

    G.saveSplitterPosition = function () {
        if (G.requireSplitterPositionUrl && G.is_spinner_loading == false) {
            G.is_spinner_loading = true;

            var left = $('#splitter1').css('left').split('px');
            var middle = $('#splitter2').css('left').split('px');
            left = parseInt(left[0]);
            middle = parseInt(middle[0]) - left;

            G.ajax_object = new grn.component.ajax.request({
                    url: G.requireSplitterPositionUrl,
                    dataType: "json",
                    data: {left: left, middle: middle, csrf_ticket: MP.csrf_ticket},
                    method: "post"
                }
            );

            G.ajax_object.send()
                .always(function(){
                    G.is_spinner_loading = false;
                    G.ajax_object = null;
                });
        }
    };

    G.pageNavigation = function (para) {
        if (para == 'prev') {
            var str = G.options.prev;
        }
        else if (para == 'next') {
            var str = G.options.next;
        }
        else {
            var str = '0';
        }
        MP.mid = '';
        G.getFolderMailList('sp=' + str + "&" +G.getSortURLParamters());
    };

    G.changeNavigationStatus = function () {
        $('#top_page_on, #prev_page_on, #next_page_on').show();
        $('#top_page_off, #prev_page_off, #next_page_off').hide();
        if (G.options.prev == '-1') {
            $('#top_page_off, #prev_page_off').show();
            $('#top_page_on, #prev_page_on').hide();
        }
        if (G.options.next == '-1') {
            $('#next_page_off').show();
            $('#next_page_on').hide();
        }
        $('#start_num').html(G.options.start);
        $('#end_num').html(G.options.end);
    };

    G.getFolderMailList = function (param, call_back) {
        if (G.requireUrl && G.is_spinner_loading == false) {
            G.is_spinner_loading = true;

            G.blankMailView();

            var elem = $('#list_area_scroll');
            elem.html('<img src="' + G.spinnerImage + '" />');
            $('#moving_box').hide();

            setFilterStatusSelectMark();

            var request_data = 'aid=' + MP.aid + '&cid=' + MP.cid;
            if (MP.mid) {
                request_data = request_data + '&mid=' + MP.mid;
            }
            if (param) {
                request_data = request_data + '&' + param;
            }

            var request = new grn.component.ajax.request({
                    url: G.requireUrl,
                    dataType: "json",
                    data: request_data,
                    method: "post"
                }
            );

            request.send()
                .done(function(json_obj, text_status, transport){
                    if (json_obj.redirect) {
                        window.location = json_obj.redirect;
                        return;
                    }
                    if (json_obj.mail_list) {
                        $('#list_area_scroll').html(json_obj.mail_list);

                        //reset sort
                        $('#sort_filter_td').children('#sort_reverse').remove();
                        $('#sort_filter_td').children('#sort_key').remove();
                        $($('#reset_sort_span').html()).prependTo($('#sort_filter_td'));
                        $('#reset_sort_span').remove();

                        setFilterStatusSelectMark();

                        G.changeNavigationStatus();
                        if (call_back && typeof(call_back) == 'function') {
                            call_back(true);
                        }
                    }

                    if (json_obj.numOfUnreadMails) {
                        var updater = grn.component.mail.MailPartsUpdater;
                        updater.updateEachFolderNumOfUnreadMail(json_obj.numOfUnreadMails);
                    }
                })
                .fail(function(transport){
                    if (call_back && typeof(call_back) == 'function') {
                        call_back(false);
                    }
                })
                .always(function(){
                    G.is_spinner_loading = false;
                });
        }
    };

    G.enableMultiSelect = function () {
        var selectTarget = $(_selected_target);
        $(_rows).each(function () {
            var item = $(this);
            item.find("span.list_right_grn, li.list_property_grn").bind('click', function (e) {
                if (item == undefined) return;

                if (e.shiftKey) {
                    item.addClass(_selected_class);
                    var first = selectTarget.find("li."+_selected_class).first().index(_rows);
                    var last = selectTarget.find("li."+_selected_class).last().index(_rows);
                    G.multiSelect(first, last);
                }
                else if (e.ctrlKey) {
                    if (item.hasClass(_selected_class)) {
                        item.removeClass(_selected_class);
                        item.find(_checkbox_filter).prop("checked", false);
                    }
                    else {
                        item.addClass(_selected_class);
                    }
                }
                else {
                    selectTarget.find("li."+_selected_class).removeClass(_selected_class);
                    item.addClass(_selected_class);
                    //Load mail Detail
                    MP.mid = item.find(_checkbox_filter).val();
                }
                G.multiCheck(e);
            });

            item.find("span.list_right_grn, li.list_property_grn").bind('dblclick', G.displayFullDetailMail);
        });
    };

    G.enableShortcutKeySelect = function () {
        var first = 0;
        var last = 0;

        document.onkeydown = function (e) {
            e = (e == undefined) ? event : e;
            var fg = false;
            var arr = new Array(38, 40, 74, 75, 46, 9);
            for (var i = 0; i < arr.length; i++) {
                if (GRN_Event.keyCode(e) == arr[i]) fg = true;
            }
            if (! fg) return;

            if ($('#searchbox-keyword-cybozu>input').is(":focus")) {
                return;
            }

            var mail_content_scroll = $('#mail_content_scroll');
            var list_area_scroll = $('#list_area_scroll');

            if (e.shiftKey && GRN_Event.keyCode(e) == 9) {
                if (mail_content_scroll.get(0) == undefined) return;
                if (mail_content_scroll.is(":focus") && !$('#list_center').is(":hidden")) {
                    list_area_scroll.focus();
                    return false;
                }
                return;
            }

            if (GRN_Event.keyCode(e) == 9) {
                if (mail_content_scroll.get(0) == undefined) return;
                if (list_area_scroll.is(":focus")) {
                    mail_content_scroll.focus();
                    return false;
                }
                return;
            }

            var rows = $(_selected_target).find("li[id^='mail_list-row_']:visible");
            if (rows.length == 0) {
                return;
            }
            var selected_list = $(_selected_target).find("li."+_selected_class);
            if (selected_list.get(0) != undefined) {
                first = rows.index(selected_list.first());
                last = rows.index(selected_list.last());
            }
            if (rows.eq(first).length == 0) {
                // If the selected mails nor the last selected mail don't exist, the last mail become state of selected.
                first = rows.length - 1;
                last = first;
            }

            if (GRN_Event.keyCode(e) == 46) {
                if (first == -1 || last == -1 || last >= rows.length) {
                    return;
                }
                $('#menu_item_delete_multi a').click();
                return;
            }

            if ($('#mail_content_scroll').is(":focus")) {
                return;
            }

            if (e.shiftKey) {
                if (GRN_Event.keyCode(e) != 40 && GRN_Event.keyCode(e) != 38) return;
                // shortcut key: 'shift' and '↓'
                if (GRN_Event.keyCode(e) == 40) {
                    if (last < rows.length - 1 && selected_list.get(0) != undefined) {
                        last++;
                    }
                }
                // shortcut key: 'shift' and '↑'
                else if (GRN_Event.keyCode(e) == 38) {
                    if (first > 0 && selected_list.get(0) != undefined) {
                        first--;
                    }
                }
                G.multiSelect(first, last);
            }
            else {
                // shortcut key: 'j' or '↓'
                if (GRN_Event.keyCode(e) == 74 || GRN_Event.keyCode(e) == 40) {
                    if (first < rows.length - 1 && selected_list.get(0) != undefined) {
                        first++;
                        G.history.update();
                    }
                }
                // shortcut key: 'k' or '↑'
                else if (GRN_Event.keyCode(e) == 75 || GRN_Event.keyCode(e) == 38) {
                    if (first > 0 && selected_list.get(0) != undefined) {
                        first--;
                        G.history.update();
                    }
                }
                $(_selected_target).find("li."+_selected_class).removeClass(_selected_class);
                rows.eq(first).addClass(_selected_class);
                //Load mail Detail
                MP.mid = rows.eq(first).find(_checkbox_filter).val();
            }
            G.multiCheck(e);
            //Let the selected item on the top;
            var oj = (e.shiftKey && GRN_Event.keyCode(e) == 40) ? rows.eq(last) : rows.eq(first);
            G.scrollTo(oj);
            return false;
        };
    };

    G.multiSelect = function (first, last) {
        var rows = $(_rows);
        if (last < first) {
            var firstHolder = first;
            first = last;
            last = firstHolder;
        }

        if (first == -1 || last == -1 || last >= rows.length) {
            return false;
        }

        $(_selected_target).find("li." + _selected_class).removeClass(_selected_class);

        var num = last - first;
        var x = first;

        for (i = 0; i <= num; i++) {
            rows.eq(x).addClass(_selected_class);
            x++;
        }
    };

    G.multiCheck = function (e) {
        var selectTarget = $(_selected_target);
        selectTarget.find(_checkbox_filter).prop("checked", false);

        if (e.type === "click") {
            G.history.shortcut.eventFired = false;
        }

        var list = selectTarget.find("li." + _selected_class);
        if (list.length > 1) {
            list.find(_checkbox_filter).prop("checked","checked");
            if (G.ajax_object) {
                G.ajax_object.jqXHR.abort();
                G.ajax_object = null;
            }
            G.blankMailView(list.length);
        }
        else if (list.length == 1 && G.history.shouldDisplayMailDetail()) {
            var id_arr = list.attr("id").split('_');
            MP.mid = id_arr[2];
            G.getMailView();
        }
        else {
            $('#mail_view').html('<div class="content_message_grn"><span><span class="mail_message_middle_icon_grn mRight7"></span></span><span>' + G.loadingMessage + '</span></div>');
            G.toggleMenu();
            setTimeout(function () {
                if (!G.history.mailItemFocusKept() || !MP.mid) {
                    return;
                }
                G.getMailView();
            }, 800 );
        }
    };

    G.clickCheckBox = function () {
        MP.clearSelectedClass();
        var count = MP.countCheckedItem();
        if (count > 0) {
            G.blankMailView(count);
        }
        else {
            G.blankMailView();
        }
    };

    G.blankMailView = function (count) {
        if (count) {
            $('#mail_view').html('<div class="content_message_grn"><span><span class="mail_message_middle_icon_grn mRight7"></span></span><span>' + G.multiCheckedMessage.replace(/&&num_of_items&&/gi, count) + '</span></div>');
        }
        else {
            $('#mail_view').html('<div class="content_message_grn"><span><span class="mail_message_middle_icon_grn mRight7"></span></span><span>' + G.noCheckedMessage + '</span></div>');
        }
        $("#mail_credit").show();
        G.toggleMenu(count);
    };

    G.scrollTo = function (oj) {
        var x = oj.offset();
        if (!x) return;
        var lx = $("#list_area_scroll").offset();
        var h = $("#list_area_scroll").height();
        if (x.top - lx.top >= h || x.top - lx.top < 0) {
            var oh = oj.outerHeight(true)*(oj.index() - 3);
            $("#list_area_scroll").scrollTop(oh);
        }
    };

    G.toggleMenu = function (count) {
        $('#smart_main_menu_part').children('span').each(function (index) {
            if (index > 0) {
                var id = $(this).attr('id');
                if (id && MP.disable_menu_list[id] && $(this).children('a').eq(0).hasClass('menu_item_grn')) {
                    $(this).children('a').eq(0).remove();
                    $(MP.disable_menu_list[id]).prependTo($(this));
                }
            }
        });

        $('#menu_option_dropdown_list').children('li').each(function () {
            if ($(this).attr('id') && $(this).attr('id').indexOf('menu_option_') >= 0) {
                $(this).hide();
            }
        });

        $("#delete_file_extra_border").show();
        $("#delete_multi_files").hide();
        $("#delete_multi_files_disabled").show();
        if (MP.cid == MP.draft_folder_id) {
            $("#delete_file_extra_border").hide();
            $("#delete_multi_files_disabled").hide();
        }
        if (count && count > 0) {
            $("#delete_multi_files_disabled").hide();
            if (MP.cid != MP.draft_folder_id) {
                $("#delete_multi_files").show();
            }
            $('#smart_main_menu_part').children('span').each(function (index) {
                if (index > 5) {
                    var id = $(this).attr('id');
                    if (id && MP.enable_menu_list[id] && $(this).children('span').eq(0).hasClass('menu_item_disable_grn')) {
                        $(this).children('span').eq(0).remove();
                        $(MP.enable_menu_list[id]).prependTo($(this));
                    }
                }
            });
            if (count == 1 && G.mail_info && G.mail_info.reset != 1) {
                $("#delete_multi_files").hide();
                $("#delete_multi_files_disabled").hide();
                var sent = G.mail_info.sent;
                var draft = G.mail_info.draft;
                var no_source = G.mail_info.no_source;
                var html_data = G.mail_info.html_data;
                G.mail_info.reset = 1;
                if (draft && draft == '1') {
                    $("#delete_file_extra_border").hide();
                    $('#menu_item_reply').hide();
                    $('#menu_item_reply_all').hide();
                    $('#menu_item_forward').hide();
                    $('#menu_item_resend').hide();
                    $('#menu_item_draft_modify').show();
                    if (MP.enable_menu_list['menu_item_draft_modify'] && $('#menu_item_draft_modify').children('span').eq(0).hasClass('menu_item_disable_grn') && !MP.is_account_disabled) {
                        $('#menu_item_draft_modify').children('span').eq(0).remove();
                        $(MP.enable_menu_list['menu_item_draft_modify']).prependTo($('#menu_item_draft_modify'));
                    }
                }
                else {
                    $('#menu_item_draft_modify').hide();

                    $('#menu_option_dropdown_list').children('li').each(function () {
                        if ($(this).attr('id') && $(this).attr('id').indexOf('menu_option_') >= 0) {
                            $(this).show();
                        }
                    });

                    if (G.mail_info.has_files === '1' && G.mail_info.attach_file_type === '1') {
                        $("#delete_file_extra_border").show();
                        $("#menu_option_delete_file").show();
                    }
                    else {
                        $("#delete_file_extra_border").hide();
                        $("#menu_option_delete_file").hide();
                    }

                    $('#menu_option_charset_disabled').hide();
                    $('#menu_option_source_disabled').hide();

                    if (sent == '1') {
                        $('#menu_item_reply').hide();
                        $('#menu_item_reply_all').hide();
                        $('#menu_item_forward').hide();
                        $('#menu_item_resend').show();

                        if (MP.enable_menu_list['menu_item_resend'] && $('#menu_item_resend').children('span').eq(0).hasClass('menu_item_disable_grn') && !MP.is_account_disabled) {
                            $('#menu_item_resend').children('span').eq(0).remove();
                            $(MP.enable_menu_list['menu_item_resend']).prependTo($('#menu_item_resend'));
                        }

                        $('#menu_option_charset').hide();
                        if (no_source) {
                            $('#menu_option_source').hide();
                            $('#menu_option_source_disabled').show();
                        }
                    }
                    else {
                        if (no_source) {
                            $('#menu_option_charset').hide();
                            $('#menu_option_charset_disabled').show();
                            $('#menu_option_source').hide();
                            $('#menu_option_source_disabled').show();
                        }
                        $('#menu_item_reply').show();
                        $('#menu_item_reply_all').show();
                        $('#menu_item_forward').show();
                        $('#menu_item_resend').hide();
                        if (MP.enable_menu_list['menu_item_reply'] && $('#menu_item_reply').children('span').eq(0).hasClass('menu_item_disable_grn') &&
                            MP.enable_menu_list['menu_item_reply_all'] && $('#menu_item_reply_all').children('span').eq(0).hasClass('menu_item_disable_grn') &&
                            MP.enable_menu_list['menu_item_forward'] && $('#menu_item_forward').children('span').eq(0).hasClass('menu_item_disable_grn') && !MP.is_account_disabled) {
                            $('#menu_item_reply').children('span').eq(0).remove();
                            $(MP.enable_menu_list['menu_item_reply']).prependTo($('#menu_item_reply'));
                            $('#menu_item_reply_all').children('span').eq(0).remove();
                            $(MP.enable_menu_list['menu_item_reply_all']).prependTo($('#menu_item_reply_all'));
                            $('#menu_item_forward').children('span').eq(0).remove();
                            $(MP.enable_menu_list['menu_item_forward']).prependTo($('#menu_item_forward'));
                        }
                    }
                    if (!html_data) {
                        $('#menu_option_text_contents').hide();
                    }
                }
            }
        }
    };

    G.displayFullDetailMail = function () {
        if (typeof(MP.enableOpenClose) == 'function') {
            MP.enableOpenClose();
        }
    };

    G.getSortURLParamters = function (sort, sort_time) {
        if (sort != undefined) {
            G.sort = sort;
        }
        var param = "";
        if (sort_time != undefined) {
            param = 'sid=' + G.status_id + '&sort=' + G.sort + '&sort_time=' + sort_time + '&reverse=' + G.reverse;
        }
        else {
            param = 'sid=' + G.status_id + '&sort=' + G.sort + '&reverse=' + G.reverse;
        }

        if (G.filter === "unread") {
            param += '&filter=unread';
        }
        return param;
    };

    G.sortAndFilterMailList = function (sort, sort_time) {
        MP.mid = '';
        G.getFolderMailList(G.getSortURLParamters(sort,sort_time));
    };

    var setFilterStatusSelectMark = function () {
        $("span[id^='filter_status_'].pulldown_menu_select_mark_grn").removeClass("pulldown_menu_select_mark_grn").addClass("pulldown_menu_select_mark_none_grn");
        if (G.filter === "unread") {
            $("#filter_status_unread").removeClass("pulldown_menu_select_mark_none_grn").addClass("pulldown_menu_select_mark_grn");
        }
        else if (typeof G.status_id === "undefined" || G.status_id == "" || G.status_id == "0") {
            $("#filter_status_all").removeClass("pulldown_menu_select_mark_none_grn").addClass("pulldown_menu_select_mark_grn");
        }
        else {
            $("#filter_status_" + G.status_id).removeClass("pulldown_menu_select_mark_none_grn").addClass("pulldown_menu_select_mark_grn");
        }
    };

    G.is_loaded = true;

})(jQuery);
