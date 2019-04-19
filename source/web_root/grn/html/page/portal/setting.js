grn.base.namespace("grn.page.portal.setting");

(function(){
    "use strict";
    var G = grn.page.portal.setting;
    G.ajaxUrl = null;
    G.commandPrefix = null;
    G.msgResource = {
        'delete_portlet_title': null,
        'delete_portlet_explain': null,
        'portal_open_explain': null,
        'portal_close_explain': null,
        'portal_open_title': null,
        'portal_modify_title': null,
        'portlet_modify_title': null,
        'portlet_open_all_title': null,
        'portlet_open_all_explain': null,
        'portal_init_title': null,
        'portal_init_explain': null,
        'validate_error': null,
        'yes': grn.msg.YES,
        'no': grn.msg.NO,
        'open': null,
        'close': null,
        'save': null,
        'ok': grn.msg.OK,
        'cancel': grn.msg.CANCEL,
        'toggleButtonMsg': null
    };
    G.targetPortletIndex = 0;
    G.startElement = null;
    G.isPortletOrder = false;
    G.isMobile = (navigator.userAgent.search(/iPhone|iPad|Android/) != -1);
    G.msgBox = GRN_MsgBox;
    G.isFirstStart = true;
    G.checkValid = false;

    jQuery(window).on( "load", function() {
        setTimeout(function() {
            var leftSide = jQuery("#portal_setting_left_area");
            var portalLayoutTable = jQuery("#portal_layout_table");
            var handler = jQuery("#portal_setting_left_area_handler");

            if (! G.isMobile) {
                setDraggable(leftSide);
                setSortable(portalLayoutTable);
                setPortletFilterAction();
            }
            var clickEventObserver = ClickEventObserver.prototype.create();
            jQuery(document).click(clickEventObserver.handle.bind(clickEventObserver));

            if (! G.isMobile) {
                G.handlerOffsetTop = handler.offset().top;
                leftSide.width(leftSide.find("div.portlet_parts_area_grn").outerWidth());
                handler.css("left", leftSide.outerWidth() + leftSide.position().left);
                ensureDroppableAreaMinHeight();
                fixPortletArea();
                setPortletAreaHeight();
            }
            initToggleButton();
            checkPortletExisting();
            wrapPortletsFrame();
        }, 0);
    });

    /**
     * @param targetObj
     */
    var setDraggable = function(targetObj) {
        targetObj.find('li.portlet_parts_list_grn').draggable({
            appendTo: "body",
            connectToSortable: ".portlet_setting_droppable_area",
            cursor: 'move',
            distance: 10,
            helper: 'clone',
            tolerance: 'pointer',
            zIndex: 101,
            start: function(event, ui) {
                ui.helper.addClass('portlet_parts_list_move_grn');
                G.isFirstStart = false;
                validatePortletLayout();
            },
            drag: function(event, ui) {
                ui.position.top = event.pageY - 10;
            },
            stop: function() {
                G.isFirstStart = true;
            }
        });
    };

    /**
     * @param targetObj
     */
    var setSortable = function(targetObj) {
        targetObj.find(".portlet_setting_droppable_area").sortable({
            cancel: ".setting_portlet_frame_grn",
            connectWith: ".portlet_setting_droppable_area",
            cursor: 'move',
            distance: 10,
            items: "li.portlet_row",
            placeholder: "drop_portlet_div_grn",
            tolerance: 'pointer',
            zindex: 101,
            beforeStop: function(event, ui) {
                if (ui.item.hasClass('portlet_parts_list_grn')) {
                    // add portlet
                    ui.item.remove();
                    G.isPortletOrder = false;
                } else {
                    // sort portlet
                    G.isPortletOrder = (ui.placeholder.parent().get(0) == G.startElement);
                }
                G.targetPortletIndex = ui.placeholder.index();
            },
            receive: function(event, ui) {
                if (!G.checkValid) {
                    return;
                }

                if (ui.sender.hasClass('portlet_parts_list_grn')) {
                    ajaxPortletAdd(jQuery(this), ui);
                } else {
                    ajaxPortletMove(ui);
                }
            },
            start: function(event, ui) {
                if (G.isFirstStart == true) {
                    G.startElement = (ui.item.hasClass('portlet_parts_list_grn')) ? null : this;
                    validatePortletLayout();
                    ensureDroppableAreaMinHeight();
                }
            },
            update: function(event, ui) {
                if (G.isPortletOrder) {
                    ajaxPortletOrder(ui);
                }
            },
            stop: function() {
                checkPortletExisting();
                ensureDroppableAreaMinHeight();
            }
        });
    };

    /**
     * @constructor
     */
    var SpinnerFilter = function() {
        var body = jQuery("body");
        var spinnerBox = jQuery('<div class="spinnerBoxBase-grn mTop15"><div class="spinnerBox-grn"></div></div>');
        var spinnerFilter = jQuery('<div id="spinner_filter_grn"></div>');

        var setSpinnerFilterSize = function() {
            var documentObj = jQuery(document);
            spinnerFilter.width(documentObj.width()).height(documentObj.height());
        };

        this.create = function() {
            var windowObj = jQuery(window);
            setSpinnerFilterSize();
            body.append(spinnerFilter.append(spinnerBox));
            spinnerBox.css({
                'position': "absolute",
                'top': Math.floor((windowObj.height() - spinnerBox.height()) / 2 + windowObj.scrollTop()),
                'left': Math.floor((windowObj.width() - spinnerBox.width()) / 2 + windowObj.scrollLeft())
            });
        };

        this.remove = function() {
            jQuery("#spinner_filter_grn").remove();
        };
    };
    G.spinnerFilter = new SpinnerFilter();

    /**
     * @param {jQuery} obj
     * @constructor
     */
    var ReloadPolicy = function(obj) {
        var isPhpPortlet = function() {
            return (obj.find("div.portal_frame_php_grn").length > 0);
        };

        var isHtmlPortlet = function() {
            return (obj.find("div.portal_frame_html_grn").length > 0);
        };

        var isPersonalDayPortlet = function() {
            return (obj.find("[id^='view_personal_day']").length > 0);
        };

        var isPersonalWeekPortlet = function() {
            return (obj.find("[id^='view_personal_week']").length > 0);
        };

        /**
         * @returns {bool}
         */
        this.shouldReload = function() {
            return (isPersonalDayPortlet() || isPersonalWeekPortlet() || isHtmlPortlet() || isPhpPortlet());
        };
    };

    /**
     * @param {Function[]} listeners
     * @constructor
     */
    var ClickEventObserver = function(listeners) {
        this.handle = function(e) {
            jQuery.each(listeners, function(index, listner){
                listner(e);
            });
        };
    };

    /**
     * @returns {ClickEventObserver}
     */
    ClickEventObserver.prototype.create = function() {
        var leftAreaHandler = new LeftAreaHandler();
        var accessInfoHandler = new AccessInfo();
        var layoutSettingHandler = new LayoutSetting();
        var portletSettingsHandler = new PortletSettings();
        var portletFilterHandler = new PortletFilter();
        return new ClickEventObserver([
            leftAreaHandler.eventListener,
            accessInfoHandler.eventListener,
            layoutSettingHandler.eventListener,
            portletSettingsHandler.eventListener,
            portletFilterHandler.eventListener
        ]);
    };

    /**
     * @constructor
     */
    var LayoutSetting = function() {
        var menuObj = jQuery("#portal_layout_setting_menu");
        var pullDownObj = jQuery("#portal_layout_setting_pulldown");
        var layoutItem = pullDownObj.find("span.portal_layout_item_grn");
        var submitObj = jQuery('#portal_layout_setting_submit');
        var currentSettingObj = jQuery('#portal_layout_setting_current');

        /**
         * @returns {boolean}
         */
        var isExist = function() {
            return menuObj.length != 0 && pullDownObj.length != 0 && submitObj.length != 0;
        };

        /**
         * @param {Event} e
         * @returns {boolean}
         */
        var isClickedMenu = function(e) {
            return menuObj.has(e.target).length != 0;
        };

        /**
         * @returns {boolean}
         */
        var isOpenedPullDown = function() {
            return pullDownObj.is(":visible");
        };

        /**
         * @returns {boolean}
         */
        var isClickedPullDown = function(e) {
            return pullDownObj.has(e.target).length != 0;
        };

        /**
         * @returns {boolean}
         */
        var isClickedLayoutItem = function(e) {
            return layoutItem.has(e.target).length != 0;
        };

        var openPullDown = function() {
            pullDownObj.css('left', menuObj.position().left).show();
            menuObj.find("span.pulldownbutton_arrow_down_grn")
                .removeClass("pulldownbutton_arrow_down_grn")
                .addClass("pulldownbutton_arrow_up_grn");
        };

        var closePullDown = function() {
            pullDownObj.hide();
            menuObj.find("span.pulldownbutton_arrow_up_grn")
                .removeClass("pulldownbutton_arrow_up_grn")
                .addClass("pulldownbutton_arrow_down_grn");
        };

        var togglePullDown = function() {
            if (isOpenedPullDown()) {
                closePullDown();
            } else {
                openPullDown();
            }
        };

        /**
         * @param {Event} e
         */
        var setLayoutSetting = function(e) {
            var targetItem = layoutItem.has(e.target);
            var targetLabel = targetItem.find("label");
            targetItem.find("input").prop("checked", true);
            currentSettingObj.text(targetLabel.text().replace(/%/g, "%  "));
            closePullDown();
            if (submitObj.hasClass('button_standard_disable_grn')) {
                submitObj.removeClass('button_standard_disable_grn').addClass('aButtonStandard-grn');
                submitObj.click(function(){jQuery(this).parents('form').submit();return false;});
            }
        };

        /**
         * @param {Event} e
         */
        this.eventListener = function(e) {
            if (isExist()) {
                if (isClickedMenu(e)) {
                    togglePullDown();
                } else if (isClickedPullDown(e)) {
                    if (isClickedLayoutItem(e)) {
                        setLayoutSetting(e);
                    }
                } else {
                    if (isOpenedPullDown()) {
                        closePullDown();
                    }
                }
            }
        };
    };

    /**
     * @constructor
     */
    var AccessInfo = function() {
        var infoIconObj = jQuery("#access_list_info");
        var toolTipObj = jQuery("#access_info_tooltip");
        var iconPosition = infoIconObj.position();

        /**
         * @returns {boolean}
         */
        var isExist = function() {
            return infoIconObj.length != 0 && toolTipObj.length != 0;
        };

        /**
         * @param {Event} e
         * @returns {boolean}
         */
        var isClickedIcon = function(e) {
            return infoIconObj.has(e.target).length != 0;
        };

        /**
         * @returns {boolean}
         */
        var isOpenedToolTip = function() {
            return toolTipObj.is(":visible");
        };

        var closeToolTip = function() {
            toolTipObj.hide();
        };

        var toggleToolTip = function() {
            toolTipObj.css({
                'top': iconPosition.top + 20,
                'left': iconPosition.left - 200
            }).toggle().find("div.top-prong").css('left', iconPosition.left - toolTipObj.position().left);
        };

        /**
         * @param {Event} e
         */
        this.eventListener = function(e) {
            if (isExist()) {
                if (isOpenedToolTip()) {
                    closeToolTip();
                } else if (isClickedIcon(e)) {
                    toggleToolTip();
                }
            }
        };
    };

    /**
     * @constructor
     */
    var LeftAreaHandler = function() {
        var barObj = jQuery("#portal_setting_left_area_handler");
        var leftArea = jQuery("#portal_setting_left_area");

        /**
         * @returns {boolean}
         */
        var isExist = function() {
            return barObj.length != 0;
        };

        /**
         * @param {Event} e
         * @returns {boolean}
         */
        var isClicked = function(e) {
            return barObj.get(0) == e.target;
        };

        /**
         * @returns {boolean}
         */
        var isOpenLeftArea = function() {
            return leftArea.is(":visible");
        };

        var closeLeftArea = function() {
            barObj.css("left", leftArea.position().left);
            leftArea.hide();
            barObj.removeClass('left_area_handler_open_grn')
                .addClass('left_area_handler_close_grn');
        };

        var openLeftArea = function() {
            leftArea.show();
            barObj.removeClass('left_area_handler_close_grn')
                .addClass('left_area_handler_open_grn')
                .css("left", leftArea.outerWidth() + leftArea.position().left);
        };

        /**
         * @param {Event} e
         */
        this.eventListener = function(e) {
            if (isExist() && isClicked(e)) {
                if (isOpenLeftArea()) {
                    closeLeftArea();
                } else {
                    openLeftArea();
                }
                wrapPortletsFrame();
            }
        };
    };

    /**
     * @constructor
     */
    var PortletSettings = function() {
        /**
         * @param {Event} e
         * @returns {boolean}
         */
        var isClickedSettingIcon = function(e) {
            return (
                jQuery(e.target).hasClass("setting_icon_grn") ||
                jQuery("#portal_layout_table").find("a.setting_icon_grn").has(e.target).length != 0
            );
        };

        /**
         * @param {Event} e
         */
        var closeOtherMenu = function(e) {
            var openedMenu = jQuery("[id^=portlet_setting_tab_]:visible");
            var targetParent = jQuery(e.target).parents("td.portlet_frame_action_grn");
            openedMenu.filter(function(){return targetParent.has(this).length == 0;}).hide();
        };

        var closeOpenedSetting = function() {
            jQuery("[id^=portlet_setting_tab_]:visible").hide();
        };

        /**
         * @param obj
         * @returns {{height: (*|string), width: *}}
         */
        var getSettingAreaSize = function(obj) {
            obj.css({'position': 'absolute', 'visibility': 'hidden', 'display': 'block', 'width': '', 'height': ''});
            var height = obj.height();
            var width = obj.width();
            obj.css({'position': '', 'visibility': '', 'display': ''});
            return {'height': height, 'width': width};
        };

        /**
         * @param {jQuery} settingIcon
         * @param {jQuery} settingArea
         * @param {{height: (*|string), width: *}} settingAreaSize
         */
        var adjustSettingAreaSize = function(settingIcon, settingArea, settingAreaSize) {
            settingArea.css({
                "top" : settingIcon.offset().top + settingIcon.outerHeight(),
                "left" : settingIcon.offset().left - settingAreaSize.width + settingIcon.outerWidth(),
                "height" : settingAreaSize.height,
                "width" : settingAreaSize.width
            });
        };

        /**
         * @param {Event} e
         */
        var toggleTargetMenu = function(e) {
            var targetIconObj = jQuery("#portal_layout_table").find("div.portlet_frame").has(e.target).find("a.setting_icon_grn");
            var targetSettingObj = targetIconObj.next();
            if (! targetSettingObj.is(":visible")) {
                var size = getSettingAreaSize(targetSettingObj);
                adjustSettingAreaSize(targetIconObj, targetSettingObj, size);
            }
            targetSettingObj.toggle();
        };

        /**
         * @param {Event} e
         */
        this.eventListener = function(e) {
            if (isClickedSettingIcon(e)) {
                toggleTargetMenu(e);
                closeOtherMenu(e);
            } else {
                closeOpenedSetting();
            }
        };
    };

    /**
     * @constructor
     */
    var PortletFilter = function() {
        var filterObj = jQuery("#portel_filter_pulldown_menu");
        var pullDownObj = filterObj.find("div.pulldown_menu_grn");

        /**
         * @returns {boolean}
         */
        var isExist = function() {
            return filterObj.length != 0 && pullDownObj.length != 0;
        };

        /**
         * @returns {boolean}
         */
        var isOpenedPullDown = function() {
            return pullDownObj.is(":visible");
        };

        /**
         * @param {Event} e
         * @returns {boolean}
         */
        var isClickOther = function(e) {
            return filterObj.has(e.target).length == 0;
        };

        /**
         * @param {Event} e
         */
        this.eventListener = function(e) {
            if (isExist() && isOpenedPullDown() && isClickOther(e)) {
                grn.component.pulldown_menu.pulldown_menu.closePullDownMenu(filterObj.find("dt"), pullDownObj);
            }
        };
    };

    var setPortletFilterAction = function() {
        var callback = function(element) {
            var filterValue = jQuery(element).find('input').prop('value');
            jQuery('#portal_setting_left_area').find('div.portlet_parts_list_base_grn').find('li').each(function(index, item){
                if (filterValue != 'all' && ! jQuery(item).hasClass(filterValue)) {
                    jQuery(item).hide();
                } else {
                    jQuery(item).show();
                }
            });
        };
        grn.component.pulldown_menu.pulldown_menu.init(jQuery('#portel_filter_pulldown_menu'), callback);
    };

    var setPortletAreaHeight = function() {
        if (G.isMobile) { return ; }
        var portletArea = jQuery("#portal_setting_left_area").find("div.portlet_parts_area_grn");
        var portletList = portletArea.find("div.portlet_parts_list_base_grn");
        var handler = jQuery("#portal_setting_left_area_handler");
        var tmpHeight = (handler.hasClass("fixed_portlet_area")) ?
            jQuery(window).height() - handler.position().top :
            jQuery(window).height() + jQuery(window).scrollTop() - handler.offset().top;
        var mainarea = jQuery("div.mainarea");
        var layout_setting = jQuery("#portal_setting_right_area").children('div.layout_setting_grn');
        var height = Math.min(
            tmpHeight,
            (layout_setting.length > 0 ? layout_setting.outerHeight() : 0 )+ jQuery("#portal_layout_table").outerHeight() + 10,
            mainarea.offset().top + mainarea.height() - handler.offset().top
        );
        portletArea.outerHeight(height);
        portletList.outerHeight(portletArea.innerHeight() - jQuery("#portlet_filter").outerHeight() - 10);
        handler.height(portletArea.outerHeight());
    };

    var fixPortletArea = function() {
        if (G.isMobile) { return ; }
        var leftArea = jQuery("#portal_setting_left_area");
        var handler = jQuery("#portal_setting_left_area_handler");
        var portletArea = leftArea.find("div.portlet_parts_area_grn");
        if (jQuery(window).scrollTop() > G.handlerOffsetTop - 30) {
            portletArea.addClass("fixed_portlet_area");
            handler.addClass("fixed_portlet_area");
        }
        else {
            portletArea.removeClass("fixed_portlet_area");
            handler.removeClass("fixed_portlet_area");
        }
    };

    var wrapPortletsFrame = function() {
        jQuery("table[id^='portlet_row_table_']").find("div.setting_portlet_frame_grn").each(function(index, element){
            wrapPortletFrame(element);
        });
    };

    var wrapPortletFrame = function(element) {
        var wrappingDiv = jQuery(element).find("div.wrapping_portlet_frame");
        if (wrappingDiv.length == 0) {
            wrappingDiv = jQuery("<div class='wrapping_portlet_frame'></div>");
            wrappingDiv.prependTo(element);
        } else {
            wrappingDiv.width("");
        }
        wrappingDiv.width(element.scrollWidth - 1); // "1" is necessary for hidden scroll bar in IE
    };

    var checkAjaxError = function(jqXHR) {
        if (grn.component.error_handler.hasCybozuError(jqXHR)) {
            var errorJsonResponse = jqXHR.responseJSON;
            if (typeof errorJsonResponse === 'undefined') {
                destroyDragAndDrop();
                var on_close = function () {
                    location.reload();
                };
                grn.component.error_handler.show(jqXHR, on_close);
            }
            else {
                var errorCode = errorJsonResponse.code;
                if (typeof errorCode !== 'undefined') {
                    if (errorCode.toString().length > 0) {
                        location.reload();
                    }
                }
            }
            return true;
        } else {
            return false;
        }
    };

    G.openPortalTitleModify = function(portal_id) {
        var jsonData = {
            'command': G.commandPrefix + 'show_portal_title_modify',
            'portal_id': portal_id
        };
        jQuery.ajax({
            type: 'POST',
            url: G.ajaxUrl,
            data: {
                'csrf_ticket': grn.csrfTicket,
                'use_ajax': 1,
                'json': YAHOO.lang.JSON.stringify(jsonData)
            },
            dataType: 'html'
        }).done(function(data, textStatus, jqXHR) {
            if (checkAjaxError(jqXHR)) {return;}
            openPortalTitleModifyDialog(data, portal_id);
        }).fail(function(jqXHR) {
            grn.component.error_handler.show(jqXHR);
        });
    };

    var openPortalTitleModifyDialog = function(data, portal_id) {
        G.msgBox.show(data, G.msgResource.portal_modify_title, GRN_MsgBoxButtons.yesno, {
            caption : {
                "yes": G.msgResource.save,
                "no": G.msgResource.cancel
            },
            "ui" : {
                "width" : "680px",
                "height": null
            },
            callback : function(result) {
                if (result == GRN_MsgBoxResult.yes) {
                    var input = {
                        'command': G.commandPrefix + 'post_portal_title_modify',
                        'portal_id': portal_id
                    };
                    var settingPortalName = jQuery("#setting_portal_name");
                    var requirementValue = jQuery("#portalName-label-line-value-def").prop("value");
                    if (requirementValue.length == 0) {
                        jQuery("#error_msg_portal_name_modify").show();
                    } else {
                        settingPortalName.find("input[type!='button']").each(function(index, element){
                            input[element.name] = element.value;
                        });
                        settingPortalName.find("select").each(function(index, element){
                            input[element.name] = element.value;
                        });
                        G.msgBox.close();
                        ajaxPostPortalModify(input);
                    }
                }
            },
            enableKey: true
        });
    };

    var ajaxPostPortalModify = function(input) {
        jQuery.ajax({
            type: 'POST',
            url: G.ajaxUrl,
            data: {
                'csrf_ticket': grn.csrfTicket,
                'use_ajax': 1,
                'json': YAHOO.lang.JSON.stringify(input)
            },
            dataType: 'json'
        }).done(function(data, textStatus, jqXHR) {
            if (checkAjaxError(jqXHR)) {return;}
            jQuery("#portal_setting_portal_name").html("").text(data.title).html();
        }).fail(function(jqXHR) {
            grn.component.error_handler.show(jqXHR);
        });
    };

    /**
     * @param {grn.component.toggle_button.ToggleButton} button
     */
    G.changePortalOpenStatus = function(button) {
        var message;
        var portal_name = jQuery("#portal_setting_portal_name").html();
        if (button.status == grn.component.toggle_button.buttonStateList.OFF || button.status == grn.component.toggle_button.buttonStateList.TURN_ON) {
            message = G.msgResource.portal_open_explain.replace('%%PORTAL_NAME%%', portal_name);
        } else {
            message = G.msgResource.portal_close_explain.replace('%%PORTAL_NAME%%', portal_name);
        }
        G.msgBox.show(message, G.msgResource.portal_open_title, GRN_MsgBoxButtons.yesno, {
            caption : {
                yes: G.msgResource.yes,
                no: G.msgResource.no
            },
            callback : function(result) {
                if (result == GRN_MsgBoxResult.yes) {
                    G.msgBox.close();
                    ajaxPortalOpen(getPortalId(), button);
                }
            }
        });
    };

    var ajaxPortalOpen = function(portal_id, button) {
        var jsonData = {
            'command': G.commandPrefix + 'portal_open',
            'portal_id': portal_id
        };
        return jQuery.ajax({
            type: 'POST',
            url: G.ajaxUrl,
            data: {
                'csrf_ticket': grn.csrfTicket,
                'use_ajax': '1',
                'json': YAHOO.lang.JSON.stringify(jsonData)
            }
        }).done(function(data, textStatus, jqXHR) {
            if (checkAjaxError(jqXHR)) {return;}
            if (button.status == grn.component.toggle_button.buttonStateList.OFF || button.status == grn.component.toggle_button.buttonStateList.TURN_ON) {
                button.turnOn();
            } else {
                button.turnOff();
            }
        }).fail(function(jqXHR) {
            grn.component.error_handler.show(jqXHR);
        });
    };

    G.changePortletOpenStatus = function(button) {
        var layout_id = button.obj.attr("id").match(/[0-9]+$/g)[0];
        var jsonData = {
            'command': G.commandPrefix + 'portlet_open',
            'portal_id': getPortalId(),
            'layout_id': layout_id
        };
        var portletFrame = jQuery("#portlet_row_table_" + layout_id).parent();
        jQuery.ajax({
            type: 'POST',
            url: G.ajaxUrl,
            data: {
                'csrf_ticket': grn.csrfTicket,
                'use_ajax': 1,
                'json': YAHOO.lang.JSON.stringify(jsonData)
            }
        }).done(function(data, textStatus, jqXHR) {
            if (checkAjaxError(jqXHR)) {return;}
            if (portletFrame.hasClass('private')) {
                portletFrame.removeClass('private').addClass('public');
                button.turnOn();
            } else {
                portletFrame.removeClass('public').addClass('private');
                button.turnOff();
            }
        }).fail(function(jqXHR) {
            grn.component.error_handler.show(jqXHR);
        });
    };

    G.openPortletTitleModify = function(portal_id, layout_id, portlet_id) {
        var jsonData = {
            'command': G.commandPrefix + 'show_portlet_title_modify',
            'portal_id': portal_id,
            'layout_id': layout_id
        };

        jQuery.ajax({
            type: 'POST',
            url: G.ajaxUrl,
            data: {
                'csrf_ticket': grn.csrfTicket,
                'use_ajax': 1,
                'json': YAHOO.lang.JSON.stringify(jsonData)
            },
            dataType: 'html'
        }).done(function(data, textStatus, jqXHR) {
            if (checkAjaxError(jqXHR)) {return;}
            openPortletTitleModifyDialog(data, portal_id, layout_id, portlet_id);
        }).fail(function(jqXHR) {
            grn.component.error_handler.show(jqXHR);
        }).always(function() {
            jQuery('#portlet_setting_tab_' + layout_id).hide();
        });
    };

    var openPortletTitleModifyDialog = function(data, portal_id, layout_id, portlet_id) {
        G.msgBox.show(data, G.msgResource.portlet_modify_title, GRN_MsgBoxButtons.yesno, {
            caption : {
                "yes": G.msgResource.save,
                "no": G.msgResource.cancel
            },
            "ui" : {
                "width" : "680px",
                "height": null
            },
            callback : function(result) {
                if (result == GRN_MsgBoxResult.yes) {
                    var input = {
                        'command': G.commandPrefix + 'post_portlet_title_modify',
                        'portal_id': portal_id,
                        'layout_id': layout_id,
                        'portlet_id': portlet_id
                    };
                    var settingPortletName = jQuery("#setting_portlet_name");
                    settingPortletName.find("input[type!='button']").each(function(index, element){
                        if (element.type == 'radio') {
                            if (element.checked) {
                                input[element.name] = element.value;
                            }
                        }
                        else {
                            input[element.name] = element.value;
                        }
                    });
                    settingPortletName.find("select").each(function(index, element){
                        input[element.name] = element.value;
                    });
                    G.msgBox.close();
                    ajaxPostPortletModify(input);
                }
            },
            enableKey: true
        });
        var isCategory = jQuery('#radio_category').prop('checked');
        if (isCategory) {
            changeStatus(true);
        }
        jQuery("input[name='display_name_mode']").change(function(){
            if (this.id == 'radio_category') {
                changeStatus(true);
            }
            else if (this.id == 'radio_normal') {
                changeStatus(false);
            }
        });
    };

    var changeStatus = function (disabled) {
        jQuery('#setting_portlet_name').find(':input').each(function(){
            if (this.type == 'radio' || this.type == 'hidden') {
                return ;
            }

            jQuery(this).prop('disabled', disabled);
        });
    }

    var ajaxPostPortletModify = function (input) {
        jQuery.ajax({
            type: 'POST',
            url: G.ajaxUrl,
            data: {
                'csrf_ticket': grn.csrfTicket,
                'use_ajax': 1,
                'json': YAHOO.lang.JSON.stringify(input)
            }
        }).done(function(data, textStatus, jqXHR) {
            if (checkAjaxError(jqXHR)) {return;}
            var titleArea = jQuery("#portlet_row_table_" + input.layout_id).find("span.portlet_title_grn");
            var titleSpan = titleArea.find("span.portlet_title_name_grn");
            var titleSymbol = titleArea.find("span.portlet_title_symbol_grn");
            var titleLink = titleArea.find("a");

            // Set title name
            if (titleSpan.length > 0) {
                titleSpan.text(data.title);
            }
            else if (titleLink.length > 0) {
                titleLink.text(data.title);
            }
            else {
                titleArea.text(data.title);
            }

            if (titleSpan.length > 0) {
                if (data.display_name_mode != 'category') {
                    // Show title name and category name.
                    titleSpan.show();
                    titleSymbol.show();
                }
                else {
                    // Hide title name and brackets of category name. (= Show only category name.)
                    titleSpan.hide();
                    titleSymbol.hide();
                }
            }
        }).fail(function(jqXHR) {
            grn.component.error_handler.show(jqXHR);
        });
    };

    G.deletePortlet = function(layout_id) {
        var portletTable = jQuery('#portlet_row_table_' + layout_id);
        var portletName = portletTable.find('span.portlet_title').html();
        var message = G.msgResource.delete_portlet_explain.replace('%%PORTLET_NAME%%', portletName);
        var portletObj = portletTable.parent().parent();
        portletTable.find('div.portlet_setting_tab_grn').hide();
        G.msgBox.show(message, G.msgResource.delete_portlet_title, GRN_MsgBoxButtons.yesno, {
            caption : {
                yes: G.msgResource.yes,
                no: G.msgResource.no
            },
            callback : function(result) {
                if (result == GRN_MsgBoxResult.yes) {
                    G.msgBox.close();
                    ajaxPortletDelete(getPortalId(), layout_id, portletObj);
                }
            }
        });
    };

    var ajaxPortletDelete = function(portal_id, layout_id, portletObj) {
        disableDragAndDrop();
        var jsonData = {
            'command': G.commandPrefix + 'portlet_delete',
            'portal_id': portal_id,
            'layout_id': layout_id
        };
        jQuery.ajax({
            type: 'POST',
            url: G.ajaxUrl,
            data: {
                'csrf_ticket': grn.csrfTicket,
                'use_ajax': 1,
                'json': YAHOO.lang.JSON.stringify(jsonData)
            }
        }).done(function(data, textStatus, jqXHR) {
            if (checkAjaxError(jqXHR)) {return;}
            var addLink = portletObj.next('div');
            var addLinkDeleteFrag = false;
            if (addLink.length > 0 && addLink.find('a.portlet_add_link').length > 0) {
                addLinkDeleteFrag = true;
                addLink.fadeOut('normal');
            }
            portletObj.fadeOut('normal');
            setTimeout(function(){
                portletObj.remove();
                if (addLinkDeleteFrag) {
                    addLink.remove();
                }
                enableDragAndDrop();
                ensureDroppableAreaMinHeight();
                setPortletAreaHeight();
                checkPortletExisting();
            }, 1000);
        }).fail(function(jqXHR) {
            grn.component.error_handler.show(jqXHR);
        });
    };

    G.openPortletOpenAll = function(portal_id) {
        var portalName = jQuery('#portal_setting_portal_name').html();
        var message = G.msgResource.portlet_open_all_explain.replace('%%PORTAL_NAME%%', portalName);
        G.msgBox.show(message, G.msgResource.portlet_open_all_title, GRN_MsgBoxButtons.yesno, {
            caption : {
                yes: G.msgResource.yes,
                no: G.msgResource.no
            },
            callback : function(result) {
                if (result == GRN_MsgBoxResult.yes) {
                    G.msgBox.close();
                    ajaxPortletOpenAll(portal_id);
                }
            }
        });
    };

    var ajaxPortletOpenAll = function(portal_id) {
        var jsonData = {
            'command': G.commandPrefix + 'portlet_open_all',
            'portal_id': portal_id
        };
        jQuery.ajax({
            type: 'POST',
            url: G.ajaxUrl,
            data: {
                'csrf_ticket': grn.csrfTicket,
                'use_ajax': 1,
                'json': YAHOO.lang.JSON.stringify(jsonData)
            }
        }).done(function(data, textStatus, jqXHR) {
            if (checkAjaxError(jqXHR)) {return;}
            allPortletStatusOpen();
        }).fail(function(jqXHR) {
            grn.component.error_handler.show(jqXHR);
        });
    };

    var allPortletStatusOpen = function() {
        jQuery("#portal_layout_table").find("div.private").each(function(index, element){
            var portletFrame = jQuery(element);
            portletFrame.removeClass("private").addClass("public");
            portletFrame.find("span[id^='open_button_']").find("div").removeClass("button_state_off_grn").addClass("button_state_on_grn").find("a").html(G.msgResource.open);
        });
    };

    var ajaxPortletAdd = function(droppableObj, ui) {
        G.spinnerFilter.create();
        var portletType = ui.sender.children().attr("id").match(/p[0-9]+$/)[0];
        var position = droppableObj.parent().attr("id");
        var jsonData = {
            'command': G.commandPrefix + 'portlet_add',
            'portal_id': getPortalId(),
            'portlet_type': portletType,
            'position': position,
            'index': G.targetPortletIndex
        };
        jQuery.ajax({
            type: 'POST',
            url: G.ajaxUrl,
            data: {
                'csrf_ticket': grn.csrfTicket,
                'use_ajax': 1,
                'json': YAHOO.lang.JSON.stringify(jsonData)
            },
            dataType: 'html'
        }).done(function(data, textStatus, jqXHR) {
            if (checkAjaxError(jqXHR)) {
                G.spinnerFilter.remove();
                return;
            }
            var divObj = jQuery(data);
            var policy = new ReloadPolicy(divObj);
            if (policy.shouldReload()) {
                location.reload();
                return;
            }
            G.spinnerFilter.remove();
            divObj.hide();
            var existPortletList = droppableObj.find("li.portlet_row");
            if (existPortletList.length == 0 || existPortletList.length == G.targetPortletIndex) {
                droppableObj.append(divObj);
            } else {
                existPortletList.eq(G.targetPortletIndex).before(divObj);
            }
            divObj.fadeIn("normal");
            var openButton = divObj.find("span[id^='open_button_']");
            if (openButton.length > 0) {
                var callbackFunctionsForPortlet = {
                    'turn_on': grn.page.portal.setting.changePortletOpenStatus,
                    'turn_off': grn.page.portal.setting.changePortletOpenStatus
                };
                new grn.component.toggle_button.ToggleButton(divObj.find("span[id^='open_button_']").attr('id'), G.msgResource.toggleButtonMsg, callbackFunctionsForPortlet);
            }
            ensureDroppableAreaMinHeight();
            setPortletAreaHeight();
            wrapPortletFrame(divObj.find("div.setting_portlet_frame_grn").get(0));
            checkPortletExisting();
        }).fail(function(jqXHR) {
            if (checkAjaxError(jqXHR)) {
                G.spinnerFilter.remove();
            }
        });
    };

    var ajaxPortletOrder = function(ui) {
        disableDragAndDrop();
        var layout_ids = [];
        ui.item.parent().find("table[id^='portlet_row_table_']").each(function(index, element){
            layout_ids[index] = element.id.match(/[0-9]+$/)[0];
        });
        var jsonData = {
            'command': G.commandPrefix + 'portlet_order',
            'portal_id': getPortalId(),
            'layout_ids': layout_ids,
            'position': ui.item.parents("[class^='portal_canvas_block_']").attr("id")
        };
        jQuery.ajax({
            type: 'POST',
            url: G.ajaxUrl,
            data: {
                'csrf_ticket': grn.csrfTicket,
                'use_ajax': 1,
                'json': YAHOO.lang.JSON.stringify(jsonData)
            }
        }).done(function(data, textStatus, jqXHR) {
            if (checkAjaxError(jqXHR)) {return;}
            enableDragAndDrop();
        }).fail(function(jqXHR) {
            grn.component.error_handler.show(jqXHR);
        });
    };

    var ajaxPortletMove = function(ui) {
        disableDragAndDrop();
        wrapPortletsFrame();
        checkPortletExisting();
        var layout_id = ui.item.find("table[id^='portlet_row_table_']").attr("id").match(/[0-9]+$/)[0];
        var target_position = ui.item.parents("[class^='portal_canvas_block_']").attr("id");
        var original_position = jQuery(G.startElement).parent().attr("id");
        var jsonData = {
            'command': G.commandPrefix + 'portlet_move',
            'portal_id': getPortalId(),
            'layout_id': layout_id,
            'target_position': target_position,
            'original_position': original_position,
            'index': G.targetPortletIndex
        };
        jQuery.ajax({
            type: 'POST',
            url: G.ajaxUrl,
            data: {
                'csrf_ticket': grn.csrfTicket,
                'use_ajax': 1,
                'json': YAHOO.lang.JSON.stringify(jsonData)
            }
        }).done(function(data, textStatus, jqXHR) {
            if (checkAjaxError(jqXHR)) {return;}
            enableDragAndDrop();
        }).fail(function(jqXHR) {
            grn.component.error_handler.show(jqXHR);
        });
    };

    /**
     * @returns {*|number}
     */
    var getPortalId = function() {
        var parameter = new RegExp('[\\?&amp;]pid=([^&amp;#]*)').exec(window.location.href);
        return (parameter != null && parameter.length > 0) ? parameter[1] : 0;
    };

    var disableDragAndDrop = function() {
        if (G.isMobile) {return;}
        jQuery("#portal_setting_left_area").find('li.portlet_parts_list_grn').draggable('disable');
        jQuery("#portal_layout_table").find(".portlet_setting_droppable_area").sortable('disable');
    };

    var enableDragAndDrop = function() {
        if (G.isMobile) {return;}
        jQuery("#portal_setting_left_area").find('li.portlet_parts_list_grn').draggable('enable');
        jQuery("#portal_layout_table").find(".portlet_setting_droppable_area").sortable('enable');
    };

    var destroyDragAndDrop = function() {
        if (G.isMobile) {return;}
        jQuery("#portal_setting_left_area").find('li.portlet_parts_list_grn').draggable('destroy');
        jQuery("#portal_layout_table").find(".portlet_setting_droppable_area").sortable('destroy');
    };

    var checkPortletExisting = function() {
        var centerPortlet = jQuery('#center').find('li');
        var rightPortlet = jQuery('#right').find('li');
        var singleColumn = jQuery("#1_column_layout_setting");
        var dobbleColumn = jQuery("#2_column_layout_setting");
        if (centerPortlet.length > 0 || rightPortlet.length > 0) {
            singleColumn.find("span.portal_layout_thumbnail2_grn").removeClass("portal_layout_thumbnail2_grn").addClass("portal_layout_thumbnail2_disable_grn");
            singleColumn.find("span.portal_layout_item_grn").hide();
            singleColumn.find("div.portal_layout_pulldown_info_grn").show();
        } else {
            singleColumn.find("span.portal_layout_thumbnail2_disable_grn").removeClass("portal_layout_thumbnail2_disable_grn").addClass("portal_layout_thumbnail2_grn");
            singleColumn.find("span.portal_layout_item_grn").show();
            singleColumn.find("div.portal_layout_pulldown_info_grn").hide();
        }
        if (rightPortlet.length > 0) {
            dobbleColumn.find("span.portal_layout_thumbnail3_grn").removeClass("portal_layout_thumbnail3_grn").addClass("portal_layout_thumbnail3_disable_grn");
            dobbleColumn.find("span.portal_layout_item_grn").hide();
            dobbleColumn.find("div.portal_layout_pulldown_info_grn").show();
        } else {
            dobbleColumn.find("span.portal_layout_thumbnail3_disable_grn").removeClass("portal_layout_thumbnail3_disable_grn").addClass("portal_layout_thumbnail3_grn");
            dobbleColumn.find("span.portal_layout_item_grn").show();
            dobbleColumn.find("div.portal_layout_pulldown_info_grn").hide();
        }
        setSelectboxEnableValue();
    };

    var setSelectboxEnableValue = function() {
        var selectBox = jQuery('#portal_layout');
        if (selectBox.find('option:selected').parents('optgroup:disabled').length > 0) {
            selectBox.val('0');
        }
    };

    var ensureDroppableAreaMinHeight = function() {
        if (G.isMobile) { return; }
        jQuery('#portal_layout_table').find('.portlet_setting_droppable_area').each(function(index, element){
            var childElementHeight = 0;
            var droppableArea = jQuery(element);
            for (var i = 0; i < droppableArea.find('li.portlet_row').length; i++) {
                childElementHeight += droppableArea.find('li.portlet_row').eq(i).outerHeight();
            }
            if (childElementHeight <= 200) {
                droppableArea.height("200");
            } else {
                droppableArea.height("");
            }
        });
    };

    var initToggleButton = function() {
        var callbackFunctionsForPortal = {
            'turn_on': grn.page.portal.setting.changePortalOpenStatus,
            'turn_off': grn.page.portal.setting.changePortalOpenStatus
        };
        var callbackFunctionsForPortlet = {
            'turn_on': grn.page.portal.setting.changePortletOpenStatus,
            'turn_off': grn.page.portal.setting.changePortletOpenStatus
        };
        jQuery("[id^=open_button_]").each(function(index, element){
            if (element.id == "open_button_portal") {
                new grn.component.toggle_button.ToggleButton(element.id, G.msgResource.toggleButtonMsg, callbackFunctionsForPortal);
            } else {
                new grn.component.toggle_button.ToggleButton(element.id, G.msgResource.toggleButtonMsg, callbackFunctionsForPortlet);
            }
        });
    };

    var validatePortletLayout = function() {
        var topPortletList = jQuery("#top").find("table[id^='portlet_row_table_']");
        var leftPortletList = jQuery("#left").find("table[id^='portlet_row_table_']");
        var centerPortletList = jQuery("#center").find("table[id^='portlet_row_table_']");
        var rightPortletList = jQuery("#right").find("table[id^='portlet_row_table_']");
        var portletLayout = {'0':{}, '1':{}, '2':{}, '3':{}};
        topPortletList.each(function(index, element){
            portletLayout['0'][index] = element.id.match(/[0-9]+/g)[0];
        });
        leftPortletList.each(function(index, element){
            portletLayout['1'][index] = element.id.match(/[0-9]+/g)[0];
        });
        centerPortletList.each(function(index, element){
            portletLayout['2'][index] = element.id.match(/[0-9]+/g)[0];
        });
        rightPortletList.each(function(index, element){
            portletLayout['3'][index] = element.id.match(/[0-9]+/g)[0];
        });
        var postData = {
            'command': 'grn.portal.ajax.validate',
            'page': location.href.split('?')[0],
            'portal_id': getPortalId(),
            'portlet_layout': portletLayout,
            'portal_layout': jQuery("input[name='current_layout']").prop("value")
        };
        G.checkValid = false;
        disableDragAndDrop();
        jQuery.ajax({
            type: 'POST',
            url: G.ajaxUrl,
            data: {
                'csrf_ticket': grn.csrfTicket,
                'use_ajax': 1,
                'json': YAHOO.lang.JSON.stringify(postData)
            },
            dataType: 'json'
        }).done(function(data, textStatus, jqXHR){
            if (checkAjaxError(jqXHR)) {return;}
            if (data.validate == false) {
                destroyDragAndDrop();
                G.msgBox.show(
                    G.msgResource.validate_error,
                    null,
                    GRN_MsgBoxButtons.ok,
                    {
                        caption: {'ok': G.msgResource.ok},
                        callback: function(result){if(result == GRN_MsgBoxResult.ok){window.location.reload();}}
                    }
                );
                return;
            }
            G.checkValid = true;
            enableDragAndDrop();
        }).fail(function (jqXHR) {
            grn.component.error_handler.show(jqXHR);
        });
    };

    /**
     *
     * @constructor
     */
    function WindowResizeObserver(listener) {
        this.setWindowProperties = function() {
            var oldWindow = jQuery(window);
            this.window = {
                "width" : oldWindow.width(),
                "height" : oldWindow.height(),
                "isSizeChanged" : function(window) {
                    var newWindow = jQuery(window);
                    return newWindow.height() != this.height || newWindow.width() != this.width;
                }
            };
        };
        this.setWindowProperties();
        /** register funciton */
        this.listener = listener;
    }

    WindowResizeObserver.prototype.create = function() {
        return new WindowResizeObserver(function(){
            setPortletAreaHeight();
            wrapPortletsFrame();
        });
    };

    WindowResizeObserver.prototype.handle = function () {
        if(!this.window.isSizeChanged(window)) {
            return false;
        }
        this.listener();
        this.setWindowProperties();
        return true;
    };

    if (! G.isMobile) {
        jQuery(window).scroll(function() {
            fixPortletArea();
            setPortletAreaHeight();
        });
        var resizeHandler = WindowResizeObserver.prototype.create();
        jQuery(window).resize(resizeHandler.handle.bind(resizeHandler));
    }
})();
