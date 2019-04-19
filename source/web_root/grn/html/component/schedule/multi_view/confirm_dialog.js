(function ($) {
    "use strict";

    grn.base.namespace("grn.component.schedule.multi_view.confirm_dialog");

    var G = grn.component.schedule.multi_view.confirm_dialog;
    var multi_view = grn.component.schedule.multi_view;
    var i18n = grn.component.i18n;
    var loading_stt = i18n.cbMsg('grn.schedule', 'GRN_SCH-923'),
        btn_yes_stt = i18n.cbMsg('grn.schedule', 'GRN_SCH-924'),
        btn_cancel_stt = i18n.cbMsg('grn.schedule', 'cancel_button'),
        detail_modify_stt = i18n.cbMsg('grn.schedule', 'GRN_SCH-926');

    var url_component = grn.component.url;
    var detail_modify_url = url_component.page('schedule/modify'),
        detail_repeat_modify_url = url_component.page('schedule/repeat_modify');

    G.defaultHTML = '<div class="dialog_base_grn">' +
        '<div class="daialog_mainarea_grn">' +
        '<form method="post" action="">' +
        '<div class="mBottom15 tAlignCenter-grn">' +
        '<div class="bold"></div>' +
        '<div class="spinnerBoxBase-grn mTop15">' +
        '<div class="spinnerBox-grn"></div>' +
        '</div>' +
        '</div>' +
        '<div class="daialog_indent_grn">' +
        '<div class="mTop20 nowrap-grn buttonArea-grn">' +
        '<span id="schedule_submit_button_loading"></span>' +
        '<span class="mRight15 aButtonStandardDisable-grn"><span class="btn_yes buttonSpacePlus-grn"></span></span>' +
        '<span class="aButtonStandard-grn mRight15"><a class="btn_cancel" href="javascript:void(0);"><span ></span></a></span>' +
        '<span class="nowrap-grn mLeft15"><a class="btn_edit_detail icon-advance-grn"></a></span>' +
        '</div>' +
        '</div>' +
        '</form>' +
        '</div>' +
        '</div>';

    G.init = function (el, ev, response_data, onEventUpdate) {
        var self = this;
        var dialog;
        this.el = el;
        this.ev = ev;
        this.enable_btn_yes = true;
        this.enable_link_facilities = true;
        var bdate = el.data('bdate');
        var btn_yes;

        if (typeof response_data !== 'undefined') {
            this.dialog = $($.parseHTML(response_data)).filter("*");
            dialog = this.dialog;
            btn_yes = dialog.find('a.btn_yes');
            btn_yes.prop("onclick", null);
            var disable_btn = dialog.find('#span_update.aButtonStandardDisable-grn');
            if (disable_btn.length > 0) {
                this.enable_btn_yes = false;
                var usingPurposeElement = dialog.find('div.using_purpose_element');
                var defaultUsingPurpose = dialog.find('#using_purpose').val();
                dialog.click(function () {
                    if (dialog.find('input[type=checkbox][class*=alter_fid]:checked').length > 0 ||
                        dialog.find('input[type=checkbox][id=chk_not]:checked').length > 0) {
                        self.enable_btn_yes = true;
                        disable_btn.removeClass('aButtonStandardDisable-grn').addClass('aButtonStandard-grn');
                    }
                    else {
                        self.enable_btn_yes = false;
                        disable_btn.addClass('aButtonStandardDisable-grn').removeClass('aButtonStandard-grn');
                    }

                    if (dialog.find('input[type=checkbox][class*=approval_facility_item]:checked').length > 0) {
                        usingPurposeElement.show();
                    }
                    else {
                        dialog.find('#using_purpose').val(defaultUsingPurpose);
                        usingPurposeElement.hide();
                    }
                });
                dialog.find('input[type=checkbox][id=chk_not]').click(function () {
                    var candidacy_grn = dialog.find('.candidacy_grn');
                    if ($(this).is(':checked')) {
                        dialog.find('input[type=checkbox][class*=alter_fid]:checked').prop('checked', false);
                        candidacy_grn.addClass('candidacy_disable_grn');
                        self.enable_link_facilities = false;
                    }
                    else {
                        candidacy_grn.removeClass('candidacy_disable_grn');
                        self.enable_link_facilities = true;
                    }
                });
                dialog.find('input[type=checkbox][class*=alter_fid]').click(function () {
                    if ($(this).is(':checked')) {
                        dialog.find('input[type=checkbox][id=chk_not]:checked').prop('checked', false);
                        dialog.find('.candidacy_grn').removeClass('candidacy_disable_grn');
                        self.enable_link_facilities = true;
                    }
                });
                dialog.find('.vAlignMiddle-grn > a').each(function () {
                    $(this).click(function () {
                        return self.enable_link_facilities;
                    });
                });

                dialog.find('.more_grn > a').click(function () {
                    var flag = 0;
                    var div_content_more_link = $(this).parent().parent();

                    div_content_more_link.find('div.hidden_facility').each(function () {
                        if (flag === 5) // every time click show 5 facilities
                        {
                            return;
                        }
                        flag++;
                        $(this).removeClass('hidden_facility');
                        if (div_content_more_link.find('div.hidden_facility').length < 1) {
                            div_content_more_link.find('div.more_grn').remove();
                        }
                    });
                    return false;
                });
            }

            btn_yes.click(function () {
                if (!self.enable_btn_yes) {
                    return;
                }
                var usingPurposeElement = dialog.find('div.using_purpose_element');
                if (usingPurposeElement.length > 0 && usingPurposeElement.is(":visible")) {
                    var usingPurpose = usingPurposeElement.find('#using_purpose');
                    if (usingPurpose.val().trim().length === 0) {
                        usingPurposeElement.find('div.using_purpose_error').show();
                        return;
                    }
                    else {
                        usingPurposeElement.find('div.using_purpose_error').hide();
                    }
                }
                self.enable_btn_yes = false;
                var form = dialog.find('form');
                var data = form.serialize();
                var alter_fids = '';
                dialog.find('input[type=checkbox][class*=alter_fid]:checked').each(function () {
                    alter_fids += $(this).val() + ",";
                });
                if (alter_fids.length > 0) {
                    data += '&alter_fids=' + alter_fids;
                }

                // Update event
                var request = new grn.component.ajax.request({
                    url: $(form).attr("action"),
                    method: "POST"
                });

                var promise = request.send(data);

                // Hide the dialog
                promise.done(function(){
                    if (typeof onEventUpdate !== "function") {
                        return;
                    }

                    $('#ddoverlay').remove();
                    dialog.remove();

                    onEventUpdate();
                }).fail(function(){
                    self.enable_btn_yes = true;
                });
            });
        }
        else {
            this.dialog = $(this.defaultHTML);
            this.enable_btn_yes = false;
            dialog = this.dialog;
            dialog.find('div.bold').html(loading_stt);
            btn_yes = dialog.find('span.btn_yes');
            btn_yes.html(btn_yes_stt);

            var btn_edit_detail = dialog.find('a.btn_edit_detail');
            btn_edit_detail.html(detail_modify_stt);
            var url = detail_modify_url;
            if (el.data('type') === 'repeat') {
                url = detail_repeat_modify_url;
            }
            var href_link_to_detail = multi_view.util.createModifyDetailEventUrl(url,
                bdate,
                $.datepicker.formatDate('yy-mm-dd', multi_view.util.timeAfterDragDrop.bdate),
                $.datepicker.formatDate('yy-mm-dd', multi_view.util.timeAfterDragDrop.edate),
                el.data('uid'),
                el.data('gid'),
                el.data('referer_key'));
            btn_edit_detail.attr('href', href_link_to_detail);
        }

        var btn_cancel = dialog.find('a.btn_cancel');
        btn_cancel.find('span').html(btn_cancel_stt);
        btn_cancel.prop("onclick", null);
        btn_cancel.click(function () {
            $('div.ddoverlay').remove();
            dialog.remove();
            invokeCallback('cancel');
        });

        setTimeout(function () {
            if (self.enable_btn_yes) {
                btn_yes.focus();
            }
            else {
                btn_cancel.focus();
            }
        }, 0);

        function invokeCallback(result) {
            if (typeof self.callback === 'function') {
                self.callback(result);
            }
        }
    };

    G.show = function () {
        var div_overlay = $('<div class="ddoverlay" id="ddoverlay"/>').css({
            'width': $(document).width() + 'px',
            'height': $(document).height() + 'px',
            'z-index': '1000'
        });
        var $body = $("body");
        $body.append(div_overlay);

        var dialog = this.dialog;
        $body.append(dialog);
        var viewportW = $(window).width() + $(window).scrollLeft();
        var viewportH = $(window).height() + $(window).scrollTop();
        var scrollTop = $(window).scrollTop();
        var maxLeft = (this.ev.pageX > viewportW) ? viewportW : this.ev.pageX,
            maxTop = (this.ev.pageY > viewportH) ? viewportH : this.ev.pageY;

        var dialog_width = dialog.width();
        var left = maxLeft - dialog_width / 2,
            top = maxTop - dialog.height();

        if (left + dialog_width >= viewportW) {
            left = viewportW - dialog_width - 2;
        }
        if (left < 0) {
            left = 0;
        }
        if (top < scrollTop + 30) {
            top = scrollTop + 30;
        }
        if (top > viewportH) {
            top = viewportH - dialog.height() - 10;
        }

        dialog.css({'position': 'absolute', 'z-index': '1001', "left": left + "px", "top": top + "px"});
    };

    G.hide = function () {
        $('div.ddoverlay').remove();
        this.dialog.remove();
    };

    $(window).resize(function () {
        var $overlay = $('div.ddoverlay');

        if ($overlay.length > 0) {
            $overlay.css({
                'width': $(document).width() + 'px',
                'height': $(document).height() + 'px',
                'z-index': '1000'
            });
        }
    });

})(jQuery);

