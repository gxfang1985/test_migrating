(function () {
    if (grn.base.isNamespaceDefined("grn.component.mobile_select_menu")) {
        return;
    }
    grn.base.namespace("grn.component.mobile_select_menu");
    grn.component.mobile_select_menu = (function () {

        var instances = [];

        function SelectMenu(settings) {
            this._construct(settings);

            instances[settings.name] = this;
        }

        SelectMenu.getInstance = function (name) {
            return instances[name];
        };

        SelectMenu.prototype = {
            _construct: function (settings) {
                this.needResize = false;
                this.selectMenu = $(settings.selectMenu);
                this.selectMenuValue = $(settings.selectMenuValue);
                this.container = $(settings.container);
                this.selectMenuTitle = settings.selectMenuTitle;
                this.expandMenuSelect = $(settings.expandMenuSelect);
                this.useMenuColor = settings.useMenuColor;
                this.defaultTitle = settings.defaultTitle;
                this.eventMenu = $("<span class='mobile_event_menu_grn'></span>");
                this.arrowIcon = $("<span class='mobile_select_icon_grn'></span>");
                this.liTemplate = $("<li data-icon='false' class='mobile_list_grn' data-corners='false' data-shadow='false' data-iconshadow='true' data-wrapperels='div' data-iconpos='right' data-theme='c'><span class='mobile_select_item'></span><a href='#' class='selection_item ui-btn' data-value=''></a></li>");
                this.bindEventHandler();
                this.initSelectMenu(settings);
            },
            bindEventHandler: function () {
                this.container.find('.mobile_titlebar_grn').on("touchstart", $.proxy(this.handleTouchOnTitle, this));

                this.container.find('.cancel_button').on("touchstart", $.proxy(this.handleClose, this));
                this.container.on("tap", '.selection_item', $.proxy(this.handleSelectItem, this));
                this.expandMenuSelect.change($.proxy(this.handleExpandItem, this));
            },
            initSelectMenu: function (settings) {
                if (settings.selectedValue.length > 0) {
                    var text = settings.selectedValue;
                    var decoded = $('<div/>').html(text).text();
                    this.selectMenuValue.val(decoded);

                    var element = this.container.find('span.mobile_check_grn').siblings('.selection_item');
                    if (element.length > 0) {
                        this.applySelect(element.html(), element);
                        if (this.selectMenuTitle.length == 0) {
                            this.container.find('.mobile_titlebar_grn > .mobile_text_grn').html(element.html());
                        }
                    }
                    else {
                        var title = '',
                            color = '';
                        if (this.useMenuColor.length > 0) {
                            title = settings.selectedValue.substr(0, settings.selectedValue.length - 3);
                            color = settings.selectedValue.substr(settings.selectedValue.length - 1, 1);
                        }
                        else {
                            title = settings.selectedValue;
                        }
                        this.selectMenu.empty();
                        var content = $('<span class="mobile_event_menu_content_grn">' + title + '</span>');
                        this.selectMenu.append(content);
                        this.selectMenu.append(this.arrowIcon.clone());

                        if (this.useMenuColor.length > 0) {
                            if ($.isNumeric(color)) {
                                if (color == '0') {
                                    color = '_none';
                                }
                                this.eventMenu.empty();
                                this.eventMenu.append("<span class='mobile_event_menu_color" + color + "_grn'></span>");
                                this.selectMenu.prepend(this.eventMenu.clone());
                            }

                        }
                    }
                }
                else {
                    this.applySelect(this.defaultTitle ? this.defaultTitle : '--------------------');
                    this.selectMenuValue.val('');
                }
            },
            handleSelectItem: function (event) {
                var lastestValue;
                this.container.find('.mobile_check_grn').each(function () {
                    var thisObj = $(this);
                    thisObj.removeClass('mobile_check_grn');
                    lastestValue = thisObj.siblings('.selection_item').attr('data-value');
                });
                var element = $(event.target);
                element.siblings('.mobile_select_item').toggleClass("mobile_check_grn");

                this.applySelect(element.html(), element);

                var value = element.attr('data-value');
                if (lastestValue != value) {
                    this.selectMenuValue.val(value).triggerHandler('change');
                }

                if (this.selectMenuTitle.length == 0) {
                    this.container.find('.mobile_titlebar_grn > .mobile_text_grn').html(element.html());
                }
                event.preventDefault();
                event.stopPropagation();
                this.container.popup('close');
            },
            applySelect: function (title, item) {
                this.selectMenu.empty();

                var content = $('<span class="mobile_event_menu_content_grn">' + title + '</span>');
                this.selectMenu.append(content);
                this.selectMenu.append(this.arrowIcon.clone());

                if (typeof item !== 'undefined' && item.length > 0) {
                    var menuColor = item.siblings('.mobile_event_menu_grn');
                    if (menuColor.length > 0) {
                        this.eventMenu.empty();
                        this.eventMenu.append(menuColor.clone().removeClass('mobile_event_menu_grn'));
                        this.selectMenu.prepend(this.eventMenu.clone());
                    }
                }
            },
            handleTouchOnTitle: function (event) {
                var target = $(event.target);
                if (target.hasClass('mobile_titlebar_grn') || target.hasClass('mobile_colse_icon_grn')) {
                    this.handleClose(event);
                }
            },
            handleClose: function (event) {
                event.preventDefault();
                event.stopPropagation();
                this.container.popup('close');
            },
            setSizeSelectMenu: function (event) {
                var title_bar_height = this.container.find(".mobile_titlebar_grn").height();
                var button_area_height = this.container.find(".mobile_select_button_area_grn").height();

                var list_menu = this.container.find(".mobile_ul_grn");
                var list_menu_height = 0;

                this.container.find('.mobile_ul_grn > li').each(function () {
                    list_menu_height += $(this).height() + 1; // 1px is border bottom
                });

                var height_list_temp = parseInt(window.innerHeight - title_bar_height - button_area_height - 24); // 24px is margin top and bottom

                if (height_list_temp > list_menu_height) {
                    height_list_temp = list_menu_height;
                }
                list_menu.height(height_list_temp);
                this.needResize = false;
                event.preventDefault();
                event.stopPropagation();
            },
            handleExpandItem: function () {
                var valueItem = this.selectMenuValue.val();
                var title = this.expandMenuSelect.val();
                var flag = true;
                var me = this;
                this.container.find('.selection_item').each(function () {
                    var dataValue = $(this).attr('data-value');
                    if (valueItem == dataValue) {
                        flag = false;

                        me.container.find('.mobile_check_grn').each(function () {
                            $(this).removeClass('mobile_check_grn');
                        });

                        $(this).siblings('.mobile_select_item').addClass('mobile_check_grn');
                        me.applySelect(title, $(this));

                        return false;
                    }
                });

                if (flag) // need to add more item for select menu
                {
                    var liTag = this.liTemplate.clone();
                    var aLink = liTag.find('.selection_item');
                    aLink.attr('data-value', valueItem).html(title);

                    this.container.find('.select_menu_list .mobile_select_menu_last_item_grn').before(liTag);
                    this.container.find('.mobile_check_grn').each(function () {
                        $(this).removeClass('mobile_check_grn');
                    });

                    liTag.find('.mobile_select_item').addClass('mobile_check_grn');
                    this.applySelect(title, aLink);

                    this.needResize = true;
                }

                if (this.selectMenuTitle.length == 0) {
                    this.container.find('.mobile_titlebar_grn > .mobile_text_grn').html(title);
                }
            },
            setSelectedItemByValue: function (value) {
                this.selectMenuValue.val(value);

                var me = this;
                this.container.find('.selection_item').each(function () {
                    var dataValue = $(this).attr('data-value');
                    if (value == dataValue) {
                        me.container.find('.mobile_check_grn').each(function () {
                            $(this).removeClass('mobile_check_grn');
                        });

                        $(this).siblings('.mobile_select_item').addClass('mobile_check_grn');
                        me.applySelect($(this).text(), $(this));

                        return false;
                    }
                });
            },
            getSelectedMenuValue: function () {
                return this.selectMenuValue.val();
            }
        };

        return SelectMenu;
    })();
})();
