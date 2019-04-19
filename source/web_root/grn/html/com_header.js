grn.base.namespace('grn.html.com_header');
(function ($) {
    'use strict';

    var G = grn.html.com_header;

    /**
     * @param {jQuery} element
     * @param {string|number} count
     * @param {number} limit
     */
    function updateNumberText(element, count, limit) {
        if (element.length === 0 || !String(count).match(/[0-9]+/g)) {
            return;
        }

        count = parseInt(count, 10);

        if (count === 0) {
            element.hide();
        }
        else {
            var number = count > limit ? limit + '+' : count;
            element.show();
            element.text(number);
        }
    }

    /**
     *
     * @param {number} num
     * @param {number} MAX_NUM
     * @param {jQuery} $menu_title_button
     * @param {string} menu_title
     * @param {string} left_parenthesis
     * @param {string} right_parenthesis
     */
    function updateNumberTitle(num, MAX_NUM, $menu_title_button, menu_title, left_parenthesis, right_parenthesis) {
        if (num > MAX_NUM) {
            num = MAX_NUM + "+";
        }

        menu_title += left_parenthesis + num + right_parenthesis;

        $menu_title_button.attr('title', menu_title);
        $menu_title_button.attr('aria-label', menu_title);
    }

    /**
     * @param {string|number} num
     */
    G.updateNotificationNumber = function (num) {
        var MAX_NOTIFICATION_NUM = 99;
        updateNumberText($('#notification_number'), num, MAX_NOTIFICATION_NUM);
        updateNumberTitle(num, MAX_NOTIFICATION_NUM, $('#cloudHeader-grnNotificationTitle-grn'),
            grn.component.i18n.cbMsg('grn.notification', 'notification_header_menu_title'),
            grn.component.i18n.cbMsg('grn.notification', 'notification_header_menu_left_parenthesis'),
            grn.component.i18n.cbMsg('grn.notification', 'notification_header_menu_right_parenthesis')
        );
    };

    /**
     * @param {string|number} num
     */
    G.updateFavourNumber = function (num) {
        var MAX_FAVOUR_NUM = 20;
        updateNumberText($('#favour_notify_number'), num, MAX_FAVOUR_NUM);
        updateNumberTitle(num, MAX_FAVOUR_NUM, $('#cloudHeader-grnFavourTitle-grn'),
            grn.component.i18n.cbMsg('grn.favour', 'favour_header_menu_title'),
            grn.component.i18n.cbMsg('grn.favour', 'favour_header_menu_left_parenthesis'),
            grn.component.i18n.cbMsg('grn.favour', 'favour_header_menu_right_parenthesis')
        );
    };

    function doAjaxGetNumberNotification() {
        $.ajax({
            url: get_number_notification_url,
            type: 'POST',
            dataType: 'text',
            headers: {'X-Cybozu-Session-No-Prolonging': 'true'},

            success: function (data, textStatus, jqXHR) {
                //checking error
                if (comHeaderUtil.is_XCybozuError_Exists(jqXHR)) {
                    return;
                }
                // response success
                var data_number_notify = JSON.parse(data);

                G.updateNotificationNumber(data_number_notify.number);
                G.updateFavourNumber(data_number_notify.favour_notify_number);

                G.setNextUpdateNotification(data_number_notify.time_update);
            },
            error: comHeaderUtil.onFailure
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
    // For Android
    $(window).bind('load resize', function () {
        G.setDropDownHeight();
    });

    // adjust height of opened contents
    // Choose the smaller of the height of the content or the height of the 90% of the window
    G.setDropDownHeight = function () {
        $("#header").find('.cloudHeader-dropdownMenu-open-grn').each(function () {
            var contents = $(this).find('div.cloudHeader-dropdownContents-grn');
            var max_height = ($(window).height() - $("#header").height()) * 0.9;
            contents.css("max-height", max_height + "px");
        });
    };

    G.addEventListenerForResizeWindow = function () {
        $(window).bind('load resize', function () {
            G.setMaxWidthOfHeaderUsername();
            G.setWidthOfHeader();
        });

        $(window).bind('scroll', function () {
            // Adjust the "com-header" for accessibility
            if (typeof $("#container-wrap").offset() !== "undefined") {
                $('#header-wrap').offset({
                    left: $("#container-wrap").offset().left
                });
            }
        });
    };

    /**
     * Adjust the max-width of Header - Username
     *
     * Header : 1000px
     * Username : max-width = 150px
     *
     * Header : 1000 + Npx
     * Username : max-width = 150 + Npx
     *
     * If max-width is greater than 300px, it will be set to 300px.
     */
    G.setMaxWidthOfHeaderUsername = function () {
        var width = 150;
        if ($(window).width() > 1000) {
            width += $(window).width() - 1000;
            width = width < 300 ? width : 300;
        }
        $("#cloudHeader-userName-grn span").css("max-width", width + "px");
    };

    G.setWidthOfHeader = function () {
        $('#header-wrap').css({
            width: $("body").width()
        });
    };

    var comHeaderUtil = {
        is_XCybozuError_Exists: function (jqXHR) {
            return jqXHR.getAllResponseHeaders().match(new RegExp(/X-Cybozu-Error/i));
        },
        onFailure: function (jqXHR) {
            try {
                var errorJSON = JSON.parse(jqXHR.responseText);
                if (typeof errorJSON.code == 'undefined') {
                    return;
                }
                if (errorJSON.code == 'GRN_CMMN_00105') {
                    location.href = location.href;
                }
            }
            catch (e) { /* do Nothnig */
            }
        }
    };

    $(window.document).bind('click', function (e) {
        // if not left click
        if (e.which != 0 && e.which != 1) {
            return;
        }

        var target = $(e.target);
        var header = $('#header');
        var openMenu = header.find('.cloudHeader-dropdownMenu-open-grn');
        var openedTargetParent = target.parents('.cloudHeader-dropdownMenu-open-grn');
        var update = target.hasClass('cloudHeader-grnNotification-update-grn') ? target : target.parents('.cloudHeader-grnNotification-update-grn');

        var spinnerSet = function (element) {
            element.html('<div align="center">' + link_spiner + '</div>');
            element.height('20px');
            element.prev('iframe').height(element.height() + 'px').width(element.width() + 'px');
        };

        var getContents = function (url, contentElm) {
            $.ajax({
                url: url,
                type: 'POST',
                dataType: 'text',
                success: function (data, textStatus, jqXHR) {
                    //checking error
                    if (comHeaderUtil.is_XCybozuError_Exists(jqXHR)) {
                        comHeaderUtil.onFailure(jqXHR);
                        return;
                    }
                    contentElm.html(data);
                    contentElm.height('');
                    setTimeout('grn.html.com_header.setDropDownHeight()', 100);
                },
                error: comHeaderUtil.onFailure
            });
        };

        /**
         *
         * @param {jQuery} $dropDownMenu
         */
        var openDropDownMenu = function ($dropDownMenu) {
            $dropDownMenu.addClass('cloudHeader-dropdownMenu-open-grn');
            $dropDownMenu.find('button').attr('aria-expanded', true);
            $dropDownMenu.find('.cloudHeader-dropdownContents-grn').attr('aria-hidden', false);
        };

        /**
         *
         * @param {jQuery} $dropDownMenu
         */
        var closeDropDownMenu = function ($dropDownMenu) {
            $dropDownMenu.removeClass('cloudHeader-dropdownMenu-open-grn');
            $dropDownMenu.find('button').attr('aria-expanded', false);
            $dropDownMenu.find('.cloudHeader-dropdownContents-grn').attr('aria-hidden', true);
        };

        if (update.length > 0) {
            var updateElm = update.parent();
            var isNotification = (updateElm.get(0).id == 'popup_notification_header');
            var url = isNotification ? get_data_notification_url : get_favour_notify_list_url;
            var updateIcon = update.find('span.icon-reload-grn');
            updateIcon.removeClass('icon-reload-grn');
            updateIcon.addClass('icon-spinner-grn');
            getContents(url, updateElm);
            return;
        }

        if (openMenu.length > 0 && target.parents('div.cloudHeader-dropdownContents-grn').length == 0) {
            closeDropDownMenu(openMenu);
        }

        // click com_header menu opened contents
        if (openedTargetParent.length > 0) {
            return;
        }

        // target is not com_header
        if (target.parents('div.cloudHeader-grn').length == 0) {
            return;
        }

        try {
            if (target.parents('.cloudHeader-spaceApplication-grn').length > 0) {
                if (ajax_my_space_list_url) {
                    var $space_application = $('#popup_spaceApplication');
                    spinnerSet($space_application);
                    openDropDownMenu($('#cloudHeader-dropdownContents-spaceApplication'));
                    getContents(ajax_my_space_list_url, $space_application);
                }
            }
            else if (target.parents('.cloudHeader-startMenu-grn').length > 0 || target.parents('.header_appmenu_grn').length > 0) {
                if (ajax_app_menu_url) {
                    var $start_application = $('#cloudHeader-startApplicationmenu-grn');
                    //This is element for new more modern ui theme
                    if ($start_application.length < 1) {
                        $start_application = $('#header_pulldown_appmenu_base_grn');
                    }
                    spinnerSet($start_application);
                    var $dropdown_content = $('#cloudHeader-dropdownContents-startMenu');
                    if ($dropdown_content.length < 1) {
                        $dropdown_content = $('#header_pulldown_appmenu_grn')
                    }
                    openDropDownMenu($dropdown_content);
                    getContents(ajax_app_menu_url, $start_application);
                }
            }
            else if (target.parents('.cloudHeader-userProfile-grn').length > 0) {
                var $user_name = $('#cloudHeader-userName-grn');
                var $user_profile_contents = $('#cloudHeader-userProfile-grn');
                openDropDownMenu(target.parents('.cloudHeader-dropdownMenu-grn'));
                if ($user_profile_contents.width() < $user_name.width()) {
                    $user_profile_contents.css('width', $user_name.width() + 'px');
                }
                G.setDropDownHeight();
            }
            else if (target.parents('.cloudHeader-admin-grn').length > 0) {
                openDropDownMenu(target.parents('.cloudHeader-dropdownMenu-grn'));
                G.setDropDownHeight();
            }
            else if (target.parents('#tag-grnFavour-grn').length > 0) {
                var $favour_contents = $('#popup_favour_header');
                spinnerSet($favour_contents);
                openDropDownMenu(target.parents('.cloudHeader-dropdownMenu-grn'));
                //Prototype.Browser.Android && favourContents.css({'right': null, 'left': '0px'});
                getContents(get_favour_notify_list_url, $favour_contents);
            }
            else if (target.parents('#tag-grnNotification-grn').length > 0) {
                var $notification_contents = $('#popup_notification_header');
                spinnerSet($notification_contents);
                openDropDownMenu(target.parents('.cloudHeader-dropdownMenu-grn'));
                getContents(get_data_notification_url, $notification_contents);
            }
        }
        catch (err) {
        }
    });
})(jQuery);
