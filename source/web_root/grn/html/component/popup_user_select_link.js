(function ($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.component.popup_member_select_link")) {
        return;
    }

    grn.base.namespace("grn.component.popup_member_select_link");

    var popup_member_select_link = grn.component.popup_member_select_link;

    var default_options = {
        name: "popup_member_select",
        width: 800,
        height: 600,
        toolbar: 0,
        location: 0,
        status: 0,
        scroll: 1,
        menu: 0,
        resize: 1
    };

    /**
     *
     * @param {string} iframe_id
     * @param {string} url
     * @param {object} post_params
     * @param {object} options
     */
    popup_member_select_link.openPopupWindowWithPostData = function (iframe_id, url, post_params, options) {
        var popup_options = $.extend({}, default_options, options);

        var iframe_url = $("#" + iframe_id).attr("src");
        popupWin(iframe_url, popup_options.name, popup_options.width, popup_options.height, popup_options.toolbar, popup_options.location, popup_options.status, popup_options.scroll, popup_options.menu, popup_options.resize);

        var inner_html = '<!DOCTYPE html><html lang="en"><body><form method="post" target="' + popup_options.name + '" action="' + url + '">';
        var post_data = "";
        $.each(post_params, function (key, value) {
            post_data += '<input type="hidden" name="' + key + '" value="' + value + '">';
        });
        inner_html += post_data;
        inner_html += '</form></body></html>';

        var $iframe = $("#" + iframe_id)[0].contentWindow.document;
        $iframe.write(inner_html);
        $iframe.close();

        $iframe.forms[0].submit();
    };

})(jQuery);

