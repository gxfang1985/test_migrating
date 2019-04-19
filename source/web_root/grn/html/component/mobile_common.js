(function()
{
    if (grn.base.isNamespaceDefined("grn.component.mobile_common"))
    {
        return;
    }

    grn.base.namespace("grn.component.mobile_common");
    var G = grn.component.mobile_common;

    G.toCommentDetail = function(page, newWindow)
    {
        func = G.toCommentDetail.caller;
        /*jshint -W024 */ /* W024: Expected an identifier and instead saw '{a}' (a reserved word). */
        var arg_0 = func.arguments[0];
        /*jshint +W024 */
        var element = arg_0.target;
        if (element.tagName === "A" || element.tagName === "SPAN")
        {
            return;
        }
        if (newWindow !== undefined)
        {
            window.open(page);
        }
        else
        {
            window.location.href = page;
        }
    };

    G.add_comment_args = {};
    G.toAddComment = function()
    {
        if (G.comment_add_url)
        {
            var url = "";
            $.each(G.add_comment_args, function(key, value)
            {
                if (url === "")
                {
                    url = key + "=" + value;
                }
                else
                {
                    url = url + "&" + key + "=" + value;
                }
            });
            url = G.comment_add_url + url;
            window.location.href = url;
        }
    };

    G.productTerm = "";
    G.copyright = "";
    $(document).ready(function()
    {
        $("a.mobile_icon_tool_comment_grn").tap(function()
        {
            G.scrollTo($("#comment_top"), true);
            return false;
        });

        G.footerCopyrightWidth = $("#footer_copyright").width();
        G.setCopyright();
        $(window).bind("resize", function()
        {
            G.setCopyright();
        });

        // Bind click event of CSS class to show overlay.
        $(document).on("click", ".mobile_show_overlay_js", function()
        {
            grn.component.mobile_loading.showOverlay();
            if (-1 != navigator.userAgent.search(/iPhone|iPad/))
            {
                setTimeout(function()
                {
                    grn.component.mobile_loading.remove();
                }, 1000);
            }
        });
    });

    $(window).on( "load", function()
    {
        setTimeout(function()
        {
            var hash = location.hash;
            var hashId = hash.indexOf("#");
            if (0 === hashId)
            {
                var targetObject = $("#" + hash.substring(1, hash.length));
                G.scrollTo(targetObject, false);
                return false;
            }
        }, 0);
    });

    G.setCopyright = function()
    {
        var footerCopyright = $("[data-role='footer']").children("h6");
        if (G.footerCopyrightWidth && G.footerCopyrightWidth > ($(document.body).width() - 30))
        {
            footerCopyright.html("<div>" + G.productTerm + "</div>" + G.copyright);
        }
        else
        {
            footerCopyright.html(G.productTerm + "&nbsp;&nbsp;&nbsp;" + G.copyright);
        }
    };

    G.scrollTo = function(targetObject, needAnimation)
    {
        if (targetObject.offset())
        {
            if (needAnimation)
            {
                $("html,body").animate({ scrollTop: (targetObject.offset().top - 15) }, "fast");
            }
            else
            {
                $.mobile.silentScroll(targetObject.offset().top - 15);
            }
        }
    };

    /**
     * @param {jQuery} element
     * @param {string|number} count
     * @param {number} limit
     */
    function updateNumberText(element, count, limit) {
        "use strict";
        if (element.length === 0 || !String(count).match(/[0-9]+/g)) {
            return;
        }

        count = parseInt(count, 10);

        if (count === 0) {
            element.hide();
        }
        else {
            var number = count > limit ? limit + "+" : count;
            element.show();
            element.text(number);
        }
    }

    function doAjaxGetNumberNotification() {
        "use strict";
        var mobileFooterBarNumElement = $("#mobile_footer_bar_notify_num");
        jQuery.ajax({
            url: getNumberNotificationUrl,
            type: "POST",
            dataType: "json",
            headers: { "X-Cybozu-Session-No-Prolonging": "true" },

            success: function (data, textStatus, jqXHR) {
                //checking error
                if (jqXHR.getAllResponseHeaders().match(new RegExp(/X-Cybozu-Error/i))) {
                    if (typeof data.code === "undefined") {
                        return;
                    }

                    if (data.code === "GRN_CMMN_00105") {
                        location.href = location.href;
                    }
                    return;
                }

                // set footer bar bell mark number
                updateNumberText(mobileFooterBarNumElement, data.number, 99);

                if (data.eachNumberOfApps === 0) {
                    updateNumberText($(".mobile_notify_num_grn"), 0, 99);
                }
                else {
                    $.each(data.eachNumberOfApps, function (key, value) {
                        var appsNumElement = $("#" + key + "_notify_num");
                        if (appsNumElement.length > 0) {
                            updateNumberText(appsNumElement, value, 99);
                        }
                    });
                }

                var appsNumNotifyElement = $("#notification_notify_num");
                if (appsNumNotifyElement.length > 0) {
                    updateNumberText(appsNumNotifyElement, data.number, 99);
                }

                G.setNextUpdateNotification(data.time_update);
            },
            error: function (jqXHR) {
            }
        });
    }

    /**
     * @param {number} delay
     */
    G.setNextUpdateNotification = function (delay) {
        if (delay !== 0) {
            setTimeout(doAjaxGetNumberNotification, delay);
        }
    };
})();
