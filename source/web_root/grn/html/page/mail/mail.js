(function($)
{
    "use strict";
    grn.base.namespace("grn.page.mail.mail");
    var mail = grn.page.mail.mail;

    mail.setDivContentDocument = function (div, bodyContent) {
        if (div.length <= 0) {
            return;
        }
        div.html(bodyContent);
    };

    mail.ToggleSummary = function (mail_id) {
        var toggle_link = $("#toggle_link_" + mail_id);
        var status = toggle_link.attr("status");
        var toggle_image = toggle_link.find("img")[0];
        var summary_row = $("#summary_row_" + mail_id);
        // get data
        var summary_item = $("#summary_item_" + mail_id);
        var has_data = summary_item.attr("has_data");
        if (has_data == "false") {
            var post_data = 'mail_id=' + mail_id + '&csrf_ticket=' + mail.csrf_ticket;
            if (mail.from_portlet) {
                post_data += '&from_portlet=true';
            }

            var ajax_request = new grn.component.ajax.request(
                {
                    url: mail.ajax_mail_preview_url,
                    method: "post",
                    dataType: "json",
                    data: post_data,
                    grnRedirectOnLoginError: true
                });

            ajax_request.send().done(function (json_obj) {
                // response success
                var data = json_obj.content;
                summary_item.html(data);
                var mail_content_item = $("#div_" + mail_id);
                var mail_content_item_height = mail_content_item.height();
                var iframe = $("#iframe_summary_item_" + mail_id);
                iframe.show();
                mail.setDivContentDocument(iframe, mail_content_item.html());
                mail_content_item.html("");
                mail_content_item.css({'display': 'none'});
                var note = $("#note_" + mail_id);
                var flag = $("#flag_" + mail_id);
                var iframe_height = iframe[0].scrollHeight;
                if (note.length > 0) {
                    iframe_height = iframe_height + note.height();
                }
                if (iframe_height > 400) {
                    flag.css({display: 'inline'});
                    if (note.length > 0) {
                        iframe_height = 400 - note.height();
                    }
                    else {
                        iframe_height = 400;
                    }
                }
                else
                {
                    flag.css({display:'none'});
                    iframe_height = iframe_height > mail_content_item_height ? iframe_height : mail_content_item_height;
                }
                if (note.length > 0) {
                    var tmpNode = document.createElement("div");
                    tmpNode.className = "summaryText";
                    tmpNode.appendChild(note.get(0));
                    iframe[0].parentNode.insertBefore(tmpNode, iframe[0]);
                }
                iframe.height(iframe_height);
            }.bind(this));

            // update status
            summary_item.attr("has_data", "true");
            //GRN2-4027
            var mail_list_row = $("#mail_list-row_" + mail_id) || toggle_link.parent().parent();
            if(mail_list_row.length > 0 && mail_list_row.hasClass("unread_color"))
            {
                mail_list_row.removeClass("unread_color");
                summary_item.parent().removeClass("unread_color");
            }
            var mail_unread_id = $("#mail_unread_" + mail_id);
            if(mail_unread_id.length > 0 && mail_unread_id.hasClass("bold"))
            {
                mail_unread_id.removeClass("bold");
                //GRN2-4208
                if (typeof mail.selected_node !== 'undefined')
                {
                    var number_unread = $("#tree-unread-num-" + mail.selected_node);
                    number_unread[0].innerHTML = number_unread[0].innerHTML - 1;
                    if(number_unread[0].innerHTML == 0)
                    {
                        number_unread.hide();
                    }
                }
                //GRN2-4208
            }
            //GRN2-4027
        }

        // hiding summary
        if (status == 'off') {
            summary_row.show();
            toggle_link.attr("status", "on");
            toggle_image.src = mail.IMG_PATH + 'minus.gif';
        }
        else // showing summary
        {
            summary_row.hide();
            toggle_link.attr("status", "off");
            toggle_image.src = mail.IMG_PATH + 'plus.gif';
        }
    };
})(jQuery);
