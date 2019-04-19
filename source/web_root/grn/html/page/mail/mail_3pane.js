grn.base.namespace("grn.page.mail.mail_3pane");

(function ($) {
    var G = grn.page.mail.mail_3pane;

    var left_default = 150;
    var center_default = 220;
    var right_default = 0;

    var pane_part =
        {
            center_part: null,
            view_part: null,
            splitter1: null,
            splitter2: null
        };

    G.resetWidth = function (leftWidth, centerWidth) {
        var body = document.getElementsByTagName('body')[0];
        var body_object = ((document.documentElement.clientHeight == 0) ? body : document.documentElement);

        var minBodyWidth = 750;
        var bodyWidth = (body_object.clientWidth < minBodyWidth) ? minBodyWidth : body_object.clientWidth;

        var leftWidth = parseInt(leftWidth);
        var centerWidth = parseInt(centerWidth);

        $('#tree_container').css('width', leftWidth - 15);
        $('#tree_view').css('width', leftWidth);
        $('#tree_part').width(leftWidth);

        if (pane_part.center_part.is(':hidden')) {
            var rightWidth = bodyWidth - leftWidth - 1;
        }
        else {
            var rightWidth = bodyWidth - leftWidth - centerWidth - 1;
            pane_part.center_part.css({left: leftWidth}).width(centerWidth);
            G.resetTextWidth(centerWidth);
        }
        pane_part.view_part.width(rightWidth);
        if (pane_part.center_part.is(':hidden')) {
            var x = pane_part.view_part.offset();
            pane_part.splitter1.css({left: x.left,top: x.top});
        }
        else {
            var x = pane_part.center_part.offset();
            pane_part.splitter1.css({left: x.left,top: x.top});
        }
        if (!pane_part.center_part.is(':hidden')) {
            var x = pane_part.view_part.offset();
            pane_part.splitter2.css({left: x.left,top: x.top});
        }
        $('#mail_content_scroll').width(rightWidth);
        $('#mail_content_all').width(rightWidth - 36);
        G.right_fixed = rightWidth;
    };

    G.resetHeight = function () {
        var body = document.getElementsByTagName('body')[0];
        var body_object = ((document.documentElement.clientHeight == 0) ? body : document.documentElement);

        var bodyHeight = body_object.clientHeight;
        var comHeader = $('#header-wrap').outerHeight(true);
        var appMenuHeaderElm = $("#applicationMenu");
        var appMenuHeader = (appMenuHeaderElm.length > 0) ? appMenuHeaderElm.outerHeight(true) : 0;

        if ($('#applicationMenu').is(':hidden')) {
            appMenuHeader = 0;
        }


        var appMenuToggleHeaderElm = $("div.appmenuToggleWrapper");
        var appMenuToggleHeader = (appMenuToggleHeaderElm.length > 0) ? appMenuToggleHeaderElm.outerHeight(true) : 0;

        var mailHeader = $('#mail_navi_index').outerHeight(true);
        var menuPart = $('#menu_part').outerHeight(true);

        var diff = $('.applicationMenu-grn').outerHeight() - appMenuHeader - comHeader - appMenuToggleHeader;
        if (pane_part.center_part.is(':hidden')) {
            var tdHeaderHeight = $('#view_container').outerHeight(true);
        }
        else {
            var tdHeaderHeight = $('#list_container').outerHeight(true);
        }

        var minHeadFooterHeight = comHeader + appMenuHeader + appMenuToggleHeader + mailHeader + menuPart + diff;

        $('table.maincontents_list, table.listtable_scroll_base_grn, #tree_part, #splitter1, #view_part').height(bodyHeight - minHeadFooterHeight);
        $('#tree_view').height(bodyHeight - minHeadFooterHeight - $('#tree_container').outerHeight(true) );
        if (!pane_part.center_part.is(':hidden')) {
            pane_part.center_part.height(bodyHeight - minHeadFooterHeight);
            pane_part.splitter2.height(bodyHeight - minHeadFooterHeight);
            var movingBoxHeight = 0;
            if (!$("#moving_box").is(":hidden")) {
                movingBoxHeight = $("#moving_box").outerHeight(true);
            }
            $('#list_area_scroll').height(bodyHeight - minHeadFooterHeight - tdHeaderHeight - $('#list_center div.list_paging_grn').outerHeight(true) - movingBoxHeight);
            var x = pane_part.center_part.offset();
            pane_part.splitter1.css({left: x.left,top: x.top});
            var x = pane_part.view_part.offset();
            pane_part.splitter2.css({left: x.left,top: x.top});
        }
        else {
            var x = pane_part.view_part.offset();
            pane_part.splitter1.css({left: x.left,top: x.top});
        }
        $('#mail_content_scroll').height(bodyHeight - minHeadFooterHeight - tdHeaderHeight);
    };

    G.resetTextWidth = function (centerWidth) {
        if (centerWidth == undefined) centerWidth = G.center_fixed;
        var mail_list_scroll_area = document.getElementById("list_area_scroll");
        var extra_width = 56;// has x scroll<li> width minus subject width.
        if (mail_list_scroll_area.offsetWidth <= mail_list_scroll_area.clientWidth) {
            extra_width = 40;
        }

        $('#list_area_scroll').css('width', centerWidth);
        $('#select_target span.list_right_grn').css('width', centerWidth - extra_width);
        $('#select_target>li').each(function(){
            if (this.style.display != "none") {
                var item = this;
                var elems = this.getElementsByTagName('li');
                for (var i = 0; i < elems.length; i++) {
                    if (i == 0) {
                        var user_name_area = elems[i].lastChild;
                        var user_name = user_name_area.firstChild;
                        var date_element = user_name_area.lastChild;
                        var cut_extra_width = extra_width;
                        if (typeof date_element !== "undefined") {
                            cut_extra_width += $(date_element).outerWidth(true) + 8;
                        }
                        var classes = user_name.className.split(" ");
                        if (typeof user_name !== "undefined" && user_name.tagName.toLocaleUpperCase() == "SPAN" && classes.indexOf("list_text_overflow_grn") != -1){
                            $(user_name).css({'width': (centerWidth - cut_extra_width), 'height': 18});
                        }
                    }
                    else if (i == 1) {
                        var child = elems[i].lastChild;
                        var subject = child.firstChild;
                        var file_size_status = child.lastChild;
                        var cut_extra_width = extra_width;
                        if (typeof file_size_status !== "undefined") {
                            cut_extra_width += $(file_size_status).outerWidth(true) + 8;
                        }
                        if (typeof subject !== "undefined" && subject.tagName.toLocaleUpperCase() == "SPAN" && subject.className.indexOf("list_text_overflow_grn") != -1) {
                            $(subject).css({'width': (centerWidth - cut_extra_width), 'height': 24});
                        }
                    }
                }
            }
        });
    };

    G.enableOpenClose = function () {
        var body = document.getElementsByTagName('body')[0];
        var body_object = ((document.documentElement.clientHeight == 0) ? body : document.documentElement);

        var minBodyWidth = 750;
        var bodyWidth = (body_object.clientWidth < minBodyWidth) ? minBodyWidth : body_object.clientWidth;

        if (pane_part.center_part.css('display') == 'none') {
            pane_part.center_part.css('display', 'table-cell');
            pane_part.splitter2.css('display', 'table-cell');
            G.resetWidth(G.left_fixed, G.center_fixed);
            G.resetHeight();
            $('#action_icon').attr("title", G.close_message).find('span').removeClass("expand_right_button_grn").addClass("expand_left_button_grn");
            if (G.mid) {
                grn.page.mail.mail_list.scrollTo($('#mail_list-row_' + G.mid));
            }
            $('#list_area_scroll').removeAttr("tabindex");
        }
        else {
            var mail_view = $('#mail_view').find('.content_message_grn');
            if (mail_view.length > 0) {
                return;
            }
            pane_part.center_part.fadeOut('fast').hide('slow', function(){
                var rightWidth = bodyWidth - G.left_fixed - 1;
                pane_part.view_part.animate({width: rightWidth}, 'fast');
                $('#list_area_scroll').attr("tabindex", "-1");
                $('#mail_content_scroll').width(rightWidth).focus();
                $('#mail_content_all').width(rightWidth - 36);
                $('#action_icon').attr("title", G.open_message).find('span').removeClass("expand_left_button_grn").addClass("expand_right_button_grn");
            });
        }
    };

    jQuery(document).ready(function () {
        G.left_fixed = (G.left_db == undefined) ? left_default : G.left_db;
        G.center_fixed = (G.center_db == undefined) ? center_default : G.center_db;
        G.right_fixed = right_default;

        pane_part.center_part = $('#list_center');
        pane_part.view_part = $('#view_part');
        pane_part.splitter1 = $('#splitter1');
        pane_part.splitter2 = $('#splitter2');

        var mail_content_scroll = $('#mail_content_scroll');
        var list_area_scroll = $('#list_area_scroll');

        G.resetWidth(G.left_fixed, G.center_fixed);
        G.resetHeight();

        $(window).bind('resize', function(){
            G.resetWidth(G.left_fixed, G.center_fixed);
            G.resetHeight();
        });

        $('div.appmenuToggleWrapper').click(function(){
            setTimeout( function(){
                G.resetHeight();
            }, 1000);
        });

        mail_content_scroll.bind('mouseover', function(){
            mail_content_scroll.css("overflow-x","auto");
        });
        mail_content_scroll.bind('mouseout', function(){
            mail_content_scroll.css("overflow-x","hidden");
        });

        pane_part.splitter1.splitter({
            _axesElement : "#tree_part,#list_center,#view_part,1"
        });

        pane_part.splitter2.splitter({
            _axesElement : "#tree_part,#list_center,#view_part,2"
        });

        if (pane_part.center_part.is(":hidden")) {
            mail_content_scroll.focus();
        }
        else {
            list_area_scroll.focus();
        }
    });

    //drop down handle
    $(window.document).bind('click', function (event) {
        var target_obj = $(event.target);
        if (!target_obj.attr('id')) {
            target_obj = $(target_obj.parent().get(0));
            if (!target_obj.attr('id')) {
                target_obj = $(target_obj.parent().get(0));
            }
        }

        $('span.mail-dropdownContents-open').each(function (index) {
            var a_obj = $($(this).children('a').get(0));
            if (a_obj.attr('id')) {
                if (a_obj.attr('id') != target_obj.attr('id')) {
                    G.hideDropdown(a_obj);
                }
            }
            else {
                G.hideDropdown(a_obj);
            }
        });

        if (target_obj.attr('id') && target_obj.attr('id').indexOf('menu_dropdown_') >= 0 || target_obj.is('#account_select')) {
            G.clickMenuDropdown(target_obj);
        }
    });

    $(window).bind('resize', function (event) {
        setTimeout(G.changeAllPosition,0);
        G.setDropdownHeight();
    });

    G.hideDropdown = function (a_obj) {
        var span_obj = $(a_obj.parent().get(0));
        span_obj.removeClass('mail-dropdownContents-open');

        var arrow = a_obj.children('span.mail-arrowUp-grn');
        if (arrow) {
            arrow.removeClass('mail-arrowUp-grn').addClass('mail-arrowDown-grn');
        }

        var arrow = a_obj.children('span.arrow_up_small_icon_grn');
        if (arrow) {
            arrow.removeClass('arrow_up_small_icon_grn').addClass('arrow_down_small_icon_grn');
        }
    };

    G.showDropdown = function (a_obj) {
        var span_obj = $(a_obj.parent().get(0));
        span_obj.addClass('mail-dropdownContents-open');

        var arrow = a_obj.children('span.mail-arrowDown-grn');
        if (arrow) {
            arrow.removeClass('mail-arrowDown-grn').addClass('mail-arrowUp-grn');
        }

        var arrow = a_obj.children('span.arrow_down_small_icon_grn');
        if (arrow) {
            arrow.removeClass('arrow_down_small_icon_grn').addClass('arrow_up_small_icon_grn');
        }
    };

    G.changePosition = function (a_obj) {
        if (a_obj.is('#account_select')) {
            if (grn.browser.msie) {
                a_obj.next().css({'left' : 0, 'top' : '24px'});
            }
            else {
                a_obj.next().css({'left' : 0, 'top' : '20px'});
            }
        }
        else {
            var offset = cumulativeOffset(a_obj.get(0));
            var body_height = $(body).height();
            var contents = a_obj.next();
            var contents_height = contents.height();
            var scroll_height = contents.get(0).scrollHeight;
            var footer_height = $('div.credit').outerHeight();
            var usable_height = body_height - offset[1] - footer_height;
            var default_style = {'left' : offset[0] + 1 + "px", 'top' : offset[1] + 25 + "px"};
            var new_style = {'height' : 0.9 * usable_height + "px", 'overflow-y' : "scroll"};
            if (a_obj.is('#menu_dropdown_filter_status')) {
                var switchOffset = cumulativeOffset($('#menu_dropdown_sort_target').get(0));
                contents.css({'left': offset[0] + 1 +"px", 'top':switchOffset[1] + 25 + "px"});
            }
            else if (a_obj.is('#menu_dropdown_folder_option')) {
                if (offset[1] + 25 + contents_height > body_height) {
                    var offset_top = a_obj.offset().top;
                    if (scroll_height != contents.innerHeight()) {
                        contents.css({'left': offset[0] + 1 + "px", 'top': offset_top - scroll_height - 10 + "px"});
                    }
                    else {
                        contents.css({'left': offset[0] + 1 + "px", 'top': offset_top - contents_height - 10 + "px"});
                    }
                }
                else {
                    contents.css(default_style);
                }
            }
            else {
                contents.css(default_style);
            }
            if (!a_obj.is('#menu_dropdown_folder_option') && scroll_height > 0.9 * usable_height) {
                contents.css(new_style);
            }
            else if (scroll_height != contents.innerHeight()) {
                contents.css({'height' : scroll_height + "px" , 'overflow-y' : ""});
            }
        }
    };

    G.clickMenuDropdown = function (a_obj) {
        if ($(a_obj.parent().get(0)).hasClass('mail-dropdownContents-open')) {
            G.hideDropdown(a_obj);
        }
        else {
            G.showDropdown(a_obj);
            G.changePosition(a_obj);
        }
    };

    G.changeAllPosition = function () {
        $('span.mail-dropdownContents-open').each(function (index) {
            var a_obj = $(this).children('a').eq(0);
            G.changePosition(a_obj);
        });
    };

    G.setDropdownHeight = function () {
        var content = $('span.mail-dropdownContents-open').children('.mail-dropdownContents');
        content.each(function(){
            if (!$(this).prev().is('#menu_dropdown_folder_option')) {
                var con_height = content.get(0).scrollHeight;
                var offset = content.offset();
                var footer_height = $('div.credit').outerHeight();
                var usable_height = $(window).height() - offset.top - footer_height;
                if (con_height > 0.9 * usable_height) {
                    content.css({'height':0.9 * usable_height + "px",'overflow-y':"scroll"});
                }
                else if (con_height != content.innerHeight()) {
                    content.css({'height':con_height + "px",'overflow-y':""});
                }
            }
        });
    };

    G.setMailMark = function () {
        if (G.popup_type && G.popup_mid) {
            if (G.popup_type == 'draft') {
                G.mid='';
                grn.page.mail.mail_list.getFolderMailList();
            }
            else {
                var mail_mark_ele = $('#mail_mark_'+G.popup_mid);
                mail_mark_ele.removeClass().addClass('mark_'+G.popup_type+'_grn');
                if (G.popup_type === "reply" || G.popup_type === "reply_all" || G.popup_type === "forward") {
                    mail_mark_ele.show();
                }
                else {
                    mail_mark_ele.hide();
                }
            }
        }
    };

    G.popupSendMail = function (send_page) {
        if (send_page == '') return;
        else if (send_page == G.send_popup) G.popup_type = '';
        else {
            if (send_page == G.reply_popup) G.popup_type = 'reply';
            else if (send_page == G.reply_all_popup) G.popup_type = 'reply_all';
            else if (send_page == G.forward_popup) G.popup_type = 'forward';
            else if (send_page == G.resend_popup) G.popup_type = 'resend';
            else if (send_page == G.draft_modify_popup) G.popup_type = 'draft';
            if (G.mid) {
                send_page = send_page + '&mid=' + G.mid;
                G.popup_mid = G.mid;
            }
        }
        send_page = send_page + '&aid=' + G.aid;
        send_page = send_page + '&cid=' + G.cid;
        popupWin(send_page,'send_mail','850','750',0,0,0,1,0,1);
    };

    G.countCheckedItem = function () {
        G.checked_item = [];

        var index = 0;
        $("input[name$='ids[]']").each(function () {
            if (G.attachment_search === true) {
                if ($(this).prop('checked') && $(this).data().hasAttachment) {
                    G.checked_item[index] = $(this).prop('value');
                    index++;
                }
            } else {
                if ($(this).prop('checked')) {
                    G.checked_item[index] = $(this).prop('value');
                    index++;
                }
            }
        });
        if (index == 0 && G.mid && G.attachment_search === false) {
            G.checked_item[0] = G.mid;
            return 1;
        }
        return index;
    };

    G.clearSelectedClass = function () {
        G.mid = '';
        $("input[name$='ids[]']").each(function () {
            if ($(this).prop('checked') != true) {
                var mid = $(this).prop('value');
                $('#mail_list-row_' + mid).removeClass('list_select_grn');
            }
        });
    };

    G.ajaxCommandIndex = function (command, params, call_back) {
        if (grn.page.mail.mail_list.is_spinner_loading) return;
        var data = 'cmd=' + command + '&' + params;
        $.each(G.checked_item, function (i, v) {
            data += '&ids[]=' + v;
        });
        data += '&aid=' + G.aid + '&cid=' + G.cid + '&csrf_ticket=' + G.csrf_ticket + '&use_ajax=1';
        var spinnerImgElement = $("#command_index_spinner");
        spinnerImgElement.css({'visibility': 'visible'});

        var request = new grn.component.ajax.request({
                url: G.command_index_url,
                dataType: "json",
                data: data,
                method: "post"
            }
        );

        request.send()
            .done(function(json_obj, text_status, transport){
                if (typeof call_back == 'function') {
                    call_back(json_obj);
                }
                var updater = grn.component.mail.MailPartsUpdater;
                updater.updateEachFolderNumOfUnreadMail(json_obj.numOfUnreadMails);
            })
            .fail(function(transport){
                if (call_back && typeof(call_back) == 'function') {
                    call_back(false);
                }
            })
            .always(function(){
                spinnerImgElement.css({'visibility': 'hidden'});
            });
    };

    var do_change_status = false;
    G.changeStatus = function (status, status_class, status_color, status_text) {
        if (do_change_status) return;
        if (! G.countCheckedItem()) return;
        do_change_status = true;
        G.ajaxCommandIndex('change_status', 'cs_value=' + status, changeStatusBack);

        function changeStatusBack(json_obj) {
            if (json_obj) {
                var mail_ids = json_obj.result;
                if (mail_ids) {
                    if (status_class) {
                        $.each(mail_ids, function (i, v) {
                            var mailDetail = $('#mail_view_status_' + v);
                            if (status != 1) {
                                $('#mail_status_'+v).removeClass().addClass(status_class);
                                $('#mail_status_'+v).addClass("status_2line_grn");
                                $('#mail_status_'+v).text(status_text);
                                if (mailDetail) {
                                    mailDetail.removeClass().addClass(status_class);
                                    mailDetail.text(status_text);
                                }

                            }
                            else {
                                $('#mail_status_'+v).removeClass();
                                $('#mail_status_'+v).addClass("status_2line_grn");
                                $('#mail_status_'+v).text('');
                                if (mailDetail) {
                                    mailDetail.removeClass();
                                    mailDetail.text("");
                                }
                            }
                        });
                    }
                    G.resetTextWidth(G.center_fixed);
                }
            }
            do_change_status = false;
        }
    };

    var do_read = false;

    G.read = function () {
        G.changeReadStatus("read", "unread_grn", "read_grn");
    };

    G.unread = function () {
        G.changeReadStatus("unread","read_grn", "unread_grn");
    };

    G.changeReadStatus = function (action, toRemoveClass, toAddClass) {
        if (do_read) return;
        if (! G.countCheckedItem()) return;
        do_read = true;
        G.ajaxCommandIndex(action, '', function(json_obj) {
            if (json_obj) {
                var mail_ids = json_obj.result;
                if (mail_ids) {
                    $.each(mail_ids, function (i, v) {
                        $('#mail_list-row_'+v).removeClass(toRemoveClass).addClass(toAddClass);
                    });
                }
            }
            do_read = false;
        });
    };

    var do_delete_multi = false;
    G.deleteMulti = function () {
        if (do_delete_multi) return;
        if (! G.countCheckedItem()) return;
        do_delete_multi = true;
        var cmd = 'move';
        if (G.cid == G.trash_folder_id) {
            cmd = 'delete';
        }
        $('span.delete_count').text(G.checked_item.length);
        var title = $('#mail_delete_multi_title').html();
        GRN_MsgBox.show($('#mail_delete_multi_content').html(), title, GRN_MsgBoxButtons.yesno,
            {
                ui: [],
                caption: {
                    yes: G.yes_message,
                    no: G.no_message
                },
                callback: function (result) {
                    if (result == GRN_MsgBoxResult.yes) {
                        GRN_MsgBox.close();
                        G.ajaxCommandIndex('delete_multi', 'delete_cmd=' + cmd, deleteMultiBack);
                    }
                    else {
                        do_delete_multi = false;
                    }
                }
            });

        function deleteMultiBack(json_obj) {
            if (json_obj) {
                var mail_ids = json_obj.result;
                if (mail_ids) {
                    $.each(mail_ids, function (i, v) {
                        $('#mail_list-row_'+v).remove();
                    });
                }
                grn.page.mail.mail_list.blankMailView();
                if (!$("#moving_box").is(":hidden")) {
                    $("#list_area_scroll").height($("#list_area_scroll").height() + $("#moving_box").outerHeight(true));
                }
                $('#moving_box').hide();
            }
            do_delete_multi = false;
        }
    };

    var do_delete_all = false;
    G.deleteAll = function () {
        if (do_delete_all) return;
        do_delete_all = true;
        G.checked_item = [];
        var title = $('#mail_delete_all_title').html();
        var content = $('#mail_delete_all_content').html();
        $('#mail_delete_all_content').html('');
        GRN_MsgBox.show(content, title, GRN_MsgBoxButtons.yesno,
            {
                ui: [],
                caption: {
                    yes: G.yes_message,
                    no: G.no_message
                },
                callback: function (result) {
                    if (result == GRN_MsgBoxResult.yes) {
                        var subfolder = 0;
                        if ($('#checkbox_1').prop('checked')) {
                            subfolder = 1;
                        }
                        GRN_MsgBox.close();
                        G.ajaxCommandIndex('delete_all', 'subfolder=' + subfolder, deleteAllBack);
                    }
                    else {
                        do_delete_all = false;
                        $('#mail_delete_all_content').html(content);
                    }
                }
            });

        function deleteAllBack(json_obj) {
            if (json_obj) {
                G.mid='';
                grn.page.mail.mail_list.getFolderMailList();
            }
            do_delete_all = false;
            $('#mail_delete_all_content').html(content);
        }
    };

    var do_delete_multi_files = false;
    G.attachment_search = false;
    G.deleteMultiFiles = function () {
        if (do_delete_multi_files) return;
        G.attachment_search = true;
        G.countCheckedItem();
        G.attachment_search = false;
        do_delete_multi_files = true;
        $('span.multi_files_delete_count').text(G.checked_item.length);
        var title = $('#mail_delete_multi_files_title').html();
        GRN_MsgBox.show($('#mail_delete_multi_files_content').html(), title, GRN_MsgBoxButtons.yesno,
            {
                ui: [],
                caption: {
                    yes: G.yes_message,
                    no: G.no_message
                },
                callback: function (result) {
                    if (result == GRN_MsgBoxResult.yes) {
                        GRN_MsgBox.close();
                        G.ajaxCommandIndex('delete_multi_files', '', deleteMultiFilesBack);
                    }
                    else {
                        do_delete_multi_files = false;
                    }
                }
            });

        function deleteMultiFilesBack(json_obj) {
            if (json_obj) {
                var mail_ids = json_obj.result;
                if (mail_ids) {
                    $.each(mail_ids, function (i, v) {
                        $('#mail_list-row_'+v).removeClass('unread_grn').addClass('read_grn');
                    });
                }
                G.countCheckedItem();
                grn.page.mail.mail_list.blankMailView(G.checked_item.length);
            }
            do_delete_multi_files = false;
        }
    };

    old_hash = null;
    G.changeCategory = function (hash) {
        hash = GRN_Mail_Hash_Util.cutFirstSharp(hash);
        if (hash == old_hash)
            return;
        else
            old_hash = hash;

        GRN_Mail_Hash_Util.updateLocationHash(hash);

        if (grn.browser.msie) {
            window.focus();
        }

        var cid = GRN_Mail_Hash_Util.getValue(hash, 'cid');
        old_cid = G.cid;
        G.cid = cid;
        G.changeCategorySelectStatus(cid);

        $('#smart_rare_menu_part').remove();
        if (!G.use_fts || (cid != G.draft_folder_id && cid != G.trash_folder_id)) {
            G.search_box.prependTo($('.tAlignRight-grn'));
        }

        if (cid == G.trash_folder_id) {
            G.folder_view_hide.prependTo($('#folder_view_li'));
            $('#folder_view_show').remove();
        }
        else {
            G.folder_view_show.prependTo($('#folder_view_li'));
            $('#folder_view_hide').remove();
        }

        if (cid == G.draft_folder_id || cid == G.sent_folder_id) {
            $('#menu_item_reply').hide();
            $('#menu_item_reply_all').hide();
            $('#menu_item_forward').hide();

            if (cid == G.draft_folder_id) {
                $('#menu_item_resend').hide();
                $('#menu_item_draft_modify').show();
            }
            else if (cid == G.sent_folder_id) {
                $('#menu_item_resend').show();
                $('#menu_item_draft_modify').hide();
            }
        }
        else {
            $('#menu_item_reply').show();
            $('#menu_item_reply_all').show();
            $('#menu_item_forward').show();
            $('#menu_item_resend').hide();
            $('#menu_item_draft_modify').hide();
        }

        pane_part.center_part.show();
        G.resetHeight();
        grn.page.mail.mail_list.blankMailView();

        G.mid='';
        grn.page.mail.mail_list.getFolderMailList('check_pane_info=1', call_back);

        function call_back(result) {
            if (result) {
                GRN_Mail_Hash_Util.historyCallback();
                G.cid = cid;
                if (G.has_sibling_folders) {
                    G.folder_order_show.prependTo($('#folder_order_li'));
                    $('#folder_order_hide').remove();
                }
                else {
                    G.folder_order_hide.prependTo($('#folder_order_li'));
                    $('#folder_order_show').remove();
                }
                obj_folder_tree.draw();
                obj_folder_tree.initDrapDropTarget(G.cid);
            }
            else {
                G.cid = old_cid;
                G.changeCategorySelectStatus(G.cid);
            }
        }
    };

    G.changeCategorySelectStatus = function (select_id) {
        $('#folder_tree table.menu_selected_grn').removeClass('menu_selected_grn').addClass('menu_unselect_grn');
        $('#folder_tree div.tree-select-current').removeClass('tree-select-current').addClass('tree-node');
        $('#'+tree_id+'-selected_node').attr('id', '');
        var select_a = $('#'+tree_id+'-node-'+select_id);
        select_a.parent().removeClass('tree-node').addClass('tree-select-current');
        select_a.parent().parent().parent().parent().parent().addClass('menu_selected_grn').removeClass('menu_unselect_grn');
        select_a.parent().attr('id', tree_id+'-selected_node');
    };
})(jQuery);

/////////////////// GRN_MoveEmail_Util ///////////////////

GRN_MoveEmail_Util = {
    list_item : null,
    source_value : null,
    target_id : null,
    url_ajax_move_email : null,
    moving_notice_content : null,

    init : function(option)
    {
        this.source_value = grn.page.mail.mail_3pane.cid;
        this.url_ajax_move_email = grn.page.mail.mail_3pane.command_index_url;
        this.moving_notice_content = option.moving_notice_content;
    },

    move_email : function(target_id)
    {
        if ( target_id == 'none' || target_id == this.source_value || ! grn.page.mail.mail_3pane.countCheckedItem()) return;

        //for undo action
        var post_data_undo = 'cmd=move&cid='+target_id + '&dcid=' + this.source_value + '&csrf_ticket=' + grn.page.mail.mail_3pane.csrf_ticket;
        jQuery.each(grn.page.mail.mail_3pane.checked_item, function(i, v)
        {
            post_data_undo += '&ids[]=' + v;
        });

        this.list_item = document.getElementById("mail_list");
        this.target_id = target_id;
        if(this.list_item.move_item && this.list_item.move_item.rows)
        {
            jQuery.each(this.list_item.move_item.rows, function (key, row) {
                jQuery(row).remove();
            });
        }
        this.list_item.move_item = null;
        this.list_item.move_item = {};
        this.list_item.move_item.url = this.url_ajax_move_email;
        this.list_item.move_item.data_undo = post_data_undo;
        this.list_item.move_item.navi_number_old = {};
        this.list_item.move_item.source_folder = {};
        this.list_item.move_item.des_folder = {};

        grn.page.mail.mail_3pane.ajaxCommandIndex('move', 'dcid='+target_id, this.moveBack);
    },

    moveBack : function(json_obj)
    {
        var me = GRN_MoveEmail_Util;
        if (json_obj)
        {
            var result = json_obj.result;
            if (result.type)
            {
                window.location = result.link;
            }
            else
            {
                mail_ids = result.mail_ids;

                me.removeItem(mail_ids);

                // show message undo
                var moving_box = document.getElementById("moving_box");
                if(moving_box)
                {
                    if (jQuery("#moving_box").is(":hidden"))
                    {
                        jQuery("#list_area_scroll").height(jQuery("#list_area_scroll").height() - jQuery("#moving_box").outerHeight(true));
                    }
                    moving_box.style.display="";
                    var moving_notice = me.moving_notice_content.replace(/&&num_of_items&&/gi, result.count);
                    jQuery("#moving_notice").html(moving_notice);
                }

                // update folder unread
                var move_item = me.list_item.move_item;
                // source
                var source_folder = document.getElementById("folder_tree-selected_node");
                move_item.source_folder.target = source_folder;
                move_item.source_folder.target_id = me.source_value;
                move_item.source_folder.unread = calFolderUnread(source_folder, -move_item.unread);
                obj_folder_tree.setUnreadNumForFolder(move_item.source_folder.target_id, move_item.source_folder.unread.current);
                // des
                move_item.des_folder.target_id = me.target_id;
                if (document.getElementById("folder_tree-node-"+me.target_id) != undefined)
                {
                    var des_folder = jQuery("#folder_tree-node-"+me.target_id).parents().get(0);
                    if(des_folder)
                    {
                        move_item.des_folder.target = des_folder;
                        move_item.des_folder.unread = calFolderUnread(des_folder, move_item.unread);
                        obj_folder_tree.setUnreadNumForFolder(move_item.des_folder.target_id, move_item.des_folder.unread.current);
                    }
                }
                obj_folder_tree.draw();
                obj_folder_tree.initDrapDropTarget(move_item.source_folder.target_id);

                grn.page.mail.mail_list.blankMailView();
            }
        }
    },

    removeItem : function(mail_ids)
    {
        var me = this;
        var rows = new Array();
        var unread_count = 0;
        jQuery.each(mail_ids, function(i, v)
        {
            var row_id = me.list_item.id + "-row_" + v;
            var row = jQuery("#" + row_id);
            if(row.length > 0)
            {
                if( row.attr("class").indexOf('unread_grn') > -1 )
                {
                    unread_count++;
                }
                rows.push(row.get(0));
                fadeOut = new YAHOO.util.Anim(row_id, { opacity: { to: 0 } }, 0.5);
                fadeOut.onComplete.subscribe(function(){
                    var item = jQuery("#item_" + v);
                    item.prop("checked", false);
                    if(row.hasClass('unread_grn'))
                    {
                        row.unread = 1;
                    }
                    row.removeClass("list_select_grn");
                    item.hide();
                    row.hide();
                });
                fadeOut.animate();
            }
        });
        this.list_item.move_item.rows = rows;
        this.list_item.move_item.unread = unread_count;
    }
};

/////////////////// Mail star update ///////////////////
function grn_mail_on_update_star(star_ele, params)
{
    var status = GRN_StarList.getStatus(star_ele);
    var mid = params.mid;
    jQuery.each(GRN_StarList.getItems('mail_list'), function (i, v) {
        var item_params = GRN_StarList.parseParam(v);
        if (item_params.mid == mid) {
            GRN_StarList.setStatus(v, status);
        }
    });
    jQuery.each(GRN_StarList.getItems('star_subject'), function (i, v) {
        var item_params = GRN_StarList.parseParam(v);
        if (item_params.mid == mid) {
            GRN_StarList.setStatus(v, status);
        }
    });
}

/////////////////// GRN_Mail_Hash_Util ///////////////////
GRN_Mail_Hash_Util = {
    callback_history_obj : null,
    mail_3pane : grn.page.mail.mail_3pane,
    current_hash : '',

    // フラグメント(location.hash)を監視
    historyCallback : function()
    {
        var me = this;
        // 二重登録を防ぐ
        if (me.callback_history_obj != null) clearInterval(me.callback_history_obj);
        me.callback_history_obj = setInterval(function()
        {
            if (grn.page.mail.mail_list.is_spinner_loading) return;

            if (me.cutFirstSharp(location.hash) == me.cutFirstSharp(me.current_hash))
            {
                return;
            }

            me.current_hash = me.cutFirstSharp(location.hash);
            me.mail_3pane.changeCategory(me.current_hash);
        }, 100);
    },

    // URLバーのhashを更新
    updateLocationHash : function(hash)
    {
        if (hash.length > 0)
        {
            location.hash = hash;
        }
    },

    // hoge=huga&piyo=hogeなどのパラメータから値を取得
    getValue : function(hash, key)
    {
        if (hash.indexOf('#') == 0) hash = hash.substring(1, hash.length);
        var params = hash.split("&");
        for (i = 0; i < params.length; i++)
        {
            var node = params[i];
            if (node.indexOf(key + "=") == 0)
            {
                return node.substring(key.length + 1, node.length);
            }
        }
        return null;
    },

    cutFirstSharp : function(hash)
    {
        if (hash.indexOf('#') == 0)
            return hash.substring(1, hash.length);
        else
            return hash;
    }
};
