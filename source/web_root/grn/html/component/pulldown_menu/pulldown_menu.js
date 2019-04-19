grn.base.namespace("grn.component.pulldown_menu.pulldown_menu");

(function () {
    var G = grn.component.pulldown_menu.pulldown_menu;

    /**
     *
     * @param {jQuery}pulldownObj
     * @param {object} options
     *
     * @param {function} options.onSelect This is call back function.
     * @param {boolean} options.autoClose Close pull down automatically when click other element.
     */
    G.initWithOptions = function (pulldownObj, options) {
        var _callback = function (element) {
            if (options.onSelect) {
                var value = jQuery(element).data('id');
                var name = jQuery(element).find('.js_name');
                var data = {name: name, value: value};

                options.onSelect(element, data);
            }
        };

        var pulldownHead = pulldownObj.find('dt');
        pulldownHead.click(function (event) {
            if (pulldownObj.hasClass('selectmenu_disable_filter_grn')) {
                event.stopImmediatePropagation();
            }
        });

        this.init(pulldownObj, _callback);

        if (options.autoClose) {
            jQuery(document).mousedown(function (event) {
                if (!pulldownObj.is(event.target) && pulldownObj.has(event.target).length === 0) {
                    var pulldownMenu = pulldownObj.find('div.pulldown_menu_grn');

                    G.closePullDownMenu(pulldownHead, pulldownMenu);
                }
            });
        }
    };

    /**
     *
     * @param pulldownObj
     * @param callback
     */
    G.init = function (pulldownObj, callback) {
        if (pulldownObj.length == 0) {
            return;
        }

        var pulldownHead = pulldownObj.find('dt');
        var pulldownMenu = pulldownObj.find('div.pulldown_menu_grn');
        pulldownHead.click(function () {
            pulldownMenu.toggle();
            if (pulldownMenu.is(':visible')) {
                setPulldownPosition(pulldownHead, pulldownMenu);
                setPulldownHeight(pulldownMenu);
                pulldownHead.find('span.pulldownbutton_arrow_down_grn').removeClass('pulldownbutton_arrow_down_grn').addClass('pulldownbutton_arrow_up_grn');
            } else {
                resetPulldownHeight(pulldownMenu);
                pulldownHead.find('span.pulldownbutton_arrow_up_grn').removeClass('pulldownbutton_arrow_up_grn').addClass('pulldownbutton_arrow_down_grn');
            }
        });

        pulldownMenu.find('li').each(function (index, element) {
            jQuery(element).click(function () {
                if (jQuery(element).hasClass('disable')) {
                    return;
                }
                G.setSelectItemToHead(pulldownHead, element);
                if (callback != null) {
                    callback(element);
                }
                G.closePullDownMenu(pulldownHead, pulldownMenu);
            });
        });
    };

    G.closePullDownMenu = function (pullDownHead, pullDownMenu) {
        pullDownMenu.hide();
        pullDownHead.find('span.pulldownbutton_arrow_up_grn').removeClass('pulldownbutton_arrow_up_grn').addClass('pulldownbutton_arrow_down_grn');
        resetPulldownHeight(pullDownMenu);
    };

    /**
     *
     * @param pulldownHead
     * @param clickElement
     */
    G.setSelectItemToHead = function (pulldownHead, clickElement) {
        pulldownHead.find('span.pulldown_head').html(jQuery(clickElement).find('span.vAlignMiddle-grn').html());
        pulldownHead.find('input').prop('value', jQuery(clickElement).find('input').prop('value'));
    };

    /**
     *
     * @param pulldownObj
     * @param name
     * @param value
     * @param options
     * @option callback
     * @option select
     */
    G.addItem = function (pulldownObj, name, value, options) {
        "use strict";
        var $ = jQuery;
        var default_options = {
            callback: null,
            select: false
        };
        options = $.extend({}, default_options, options);
        var pulldownHead = pulldownObj.find('dt');
        var pulldownMenu = pulldownObj.find('div.pulldown_menu_grn');
        var pulldownItemList = pulldownObj.find(".pulldown_menu_grn > ul");
        var newItem = $("<li></li>", {"data-value": value})
            .append($("<a></a>", {"href": "javascript:void(0);"})
                .append($("<span></span>", {"class": "vAlignMiddle-grn", "text": name})));

        newItem.on("click", function () {
            G.setSelectItemToHead(pulldownHead, this);
            if (options.callback != null) {
                options.callback(this);
            }
            G.closePullDownMenu(pulldownHead, pulldownMenu);
        });
        pulldownItemList.prepend(newItem);

        if (options.select === true) {
            G.setSelectItemToHead(pulldownHead, newItem);
        }
    };

    /**
     * Check pull down menu item has value or not
     * @param pull_down_obj
     * @param value
     * @returns {boolean}
     */
    G.isItemHasValue = function (pull_down_obj, value) {
        var item = pull_down_obj.find("li[data-value='" + value + "']");
        return item.length > 0;
    };

    /**
     * Remove pull down menu item by value
     * @param pull_down_obj
     * @param value
     */
    G.removeItemByValue = function (pull_down_obj, value) {
        pull_down_obj.find("li[data-value='" + value + "']").remove();
    };

    /**
     *
     * @param pulldownHead
     * @param pulldownMenu
     */
    var setPulldownPosition = function (pulldownHead, pulldownMenu) {
        var switchOffset = cumulativeOffsetByOffsetParent(pulldownHead.get(0), pulldownMenu.get(0).offsetParent);
        pulldownMenu.css('left', switchOffset.left);
    };

    /**
     *
     * @param pulldownMenu
     */
    var setPulldownHeight = function (pulldownMenu) {
        var minPullDownHeight = 50;
        var switchOffset = cumulativeOffset(pulldownMenu.get(0));
        var scrollTop = (document.documentElement && document.documentElement.scrollTop) || document.body.scrollTop;
        var realPullDownHeight = jQuery(window).height() - switchOffset.top - 10 + scrollTop;

        if (pulldownMenu.height() > realPullDownHeight) {
            if (realPullDownHeight < minPullDownHeight) {
                pulldownMenu.height(minPullDownHeight);
            } else {
                pulldownMenu.height(realPullDownHeight);
            }
            pulldownMenu.width(pulldownMenu.width() + 20);
        }
    };

    /**
     *
     * @param pulldownMenu
     */
    var resetPulldownHeight = function (pulldownMenu) {
        pulldownMenu.css({'height': '', 'width': ''});
    };
})();
