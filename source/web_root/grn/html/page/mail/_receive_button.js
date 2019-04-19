(function($)
{
    "use strict";
    grn.base.namespace("grn.page.mail._receive_button");

    var _receive_button = grn.page.mail._receive_button;
    _receive_button.do_receive = false;

    _receive_button.showAllReceive = function () {
        var dialog_receive_all_mail = $("#receive_all_mail");
        set_position_dialog_receive_all_mail();
        dialog_receive_all_mail.toggle();
    };

    /**
     * @param cmd string
     */
    _receive_button.receiveAt2pane = function (cmd) {
        if (_receive_button.do_receive) return;
        _receive_button.do_receive = true;
        var form = $("#receive_mail");
        var command = $("#cmd_receive_mail");

        if (cmd == "new_all_mail") {
            $("#receive_all_link").hide();
            command.val(cmd);
            if (grn.browser.safari || /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)) {
                $("#receive_all_disable").show();
                setTimeout(function () {
                    form.submit();
                }, 500);
            }
            else {
                form.submit();
                $("#receive_all_disable").show();
            }
        }
        else if (cmd == 'new_mail') {
            $("#receive_link").hide();
            command.val(cmd);
            if (grn.browser.safari || /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)) {
                $("#receive_disable").show();
                setTimeout(function () {
                    form.submit();
                }, 500);
            }
            else {
                form.submit();
                $("#receive_disable").show();
            }
        }
    };

    /**
     * @param cmd string
     */
    _receive_button.receiveAt3pane = function (cmd) {
        if (_receive_button.do_receive) return;
        _receive_button.do_receive = true;

        var command = $("#cmd_receive_mail");
        $("#pane").val('3');
        if (!start_do(cmd) && !_receive_button.receive_page) {
            return;
        }

        $("#cid_receive_mail").val(grn.page.mail.mail_3pane.cid);

        var form = jQuery("form[id='receive_mail']").eq(0);
        var request = new grn.component.ajax.request({
                url: _receive_button.receive_page,
                dataType: "json",
                data: form.serialize(),
                method: "post"
            }
        );

        request.send()
            .done(function (json_obj) {
                if (_receive_button.check_after_receive_page) {
                    var request_after = new grn.component.ajax.request({
                            url: _receive_button.check_after_receive_page,
                            dataType: "json",
                            data: json_obj,
                            method: "post"
                        }
                    );

                    request_after.send()
                        .done(function (json_obj) {
                            var updater = grn.component.mail.MailPartsUpdater;
                            updater.updateReceiveButtonNumOfRemainsInMailServer(json_obj.numOfRemain);
                            updater.updateEachFolderNumOfUnreadMail(json_obj.numOfUnreadMails);
                            updater.updateNotes(json_obj.notes);
                            grn.page.mail.mail_3pane.resetHeight();
                            set_position_dialog_receive_all_mail();

                            if (json_obj.no_setting) {
                                window.location = _receive_button.index_page + 'no_setting=' + json_obj.no_setting;
                            }
                        });
                }

                $("#list_center").show();
                grn.page.mail.mail_3pane.mid = '';
                grn.page.mail.mail_list.getFolderMailList();

                _receive_button.do_receive = false;
                end_do(cmd);
            })
            .fail(function () {
                _receive_button.do_receive = false;
                end_do(cmd);
            });

        function end_do(cmd) {
            if (cmd == "new_all_mail") {
                $("#receive_all_link").show();
                $("#receive_all_disable").hide();
            }
            else if (cmd == "new_mail") {
                $("#receive_link").show();
                $("#receive_disable").hide();
            }
        }

        function start_do(cmd) {
            if (cmd == "new_all_mail") {
                $("#receive_all_link").hide();
                $("#receive_all_disable").show();
                command.val(cmd);
            }
            else if (cmd == "new_mail") {
                $("#receive_link").hide();
                $("#receive_disable").show();
                command.val(cmd);
            }
            else {
                return false;
            }
            return true;
        }
    };

    $(document).click(function (event) {
        var target = event.target,
            dialog = $("#receive_all_mail"),
            optionSwitch = $("#button_receive_all_mail");

        var not_click = !optionSwitch.is(target) && !dialog.is(target);
        var not_parent = optionSwitch.has(target).length === 0 && dialog.has(target).length === 0;

        if (dialog.length > 0 && dialog.is(":visible") && not_click && not_parent) {
            dialog.hide();
        }
    });

    $(window).resize(function () {
        setTimeout(set_position_dialog_receive_all_mail, 0);
    });

    function set_position_dialog_receive_all_mail() {
        var dialog_receive_all_mail = $("#receive_all_mail"),
            button_receive_all_mail = $("#button_receive_all_mail");

        if (dialog_receive_all_mail.length <= 0 || button_receive_all_mail.length <= 0) {
            return;
        }

        var switchOffset = cumulativeOffset(button_receive_all_mail.get(0)),
            button_left = switchOffset[0],
            button_top = switchOffset[1] + button_receive_all_mail.height();

        dialog_receive_all_mail.css({top: button_top, left: button_left});
    }
})(jQuery);
