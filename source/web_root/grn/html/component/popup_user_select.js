grn.base.namespace("grn.component.popup_user_select");
(function($) {
    "use strict";
    $(function() {
        grn.component.popup_user_select = (function() {
            var searchTargetIconObj = $("#searchtarget_info_icon");
            var searchTargetTooltip = $("#searchtarget_info_tooltip");
            var searchTargetIconPos = searchTargetIconObj.position();
            var searchBtn = $("#searchbutton");
            var searchBtnPosition = searchBtn.position();
            var distance = searchTargetIconPos.left - searchBtnPosition.left;
            /**
             * @returns {boolean}
             */
            var isExist = function() {
                return searchTargetIconObj.length != 0 && searchTargetTooltip.length != 0;
            };

            /**
             * @param {Event} e
             * @returns {boolean}
             */
            var isClickedIcon = function(e) {
                return searchTargetIconObj.has(e.target).length != 0;
            };

            /**
             * @returns {boolean}
             */
            var isOpenedToolTip = function() {
                return searchTargetTooltip.is(":visible");
            };

            var closeToolTip = function() {
                searchTargetTooltip.hide();
            };

            var toggleToolTip = function() {
                var bodyWidth = $("body").width();
                searchTargetTooltip.css({
                    'top': searchTargetIconPos.top + 17,
                    'left': searchTargetIconPos.left - distance,
                    'width': 'auto'
                }).toggle().find("div.top-prong").css('left', searchTargetIconPos.left - searchTargetTooltip.position().left);
                // adjust the right edge position of the popup
                var toolTipWidth = searchTargetTooltip.width();
                var toolTipLEdge = searchTargetTooltip.position().left;
                var toolTipREdge = toolTipLEdge + toolTipWidth + 10;
                if (toolTipREdge >= bodyWidth) {
                    var w = toolTipWidth > (bodyWidth - toolTipLEdge) ? (bodyWidth - toolTipLEdge) : toolTipWidth;
                    searchTargetTooltip.width(w - 10);
                }
            };

            /**
             * @param {Event} e
             */
            var handler = function(e) {
                if (isExist()) {
                    if (isOpenedToolTip()) {
                        closeToolTip();
                    } else if (isClickedIcon(e)) {
                        searchTargetIconPos = searchTargetIconObj.position();
                        toggleToolTip();
                    }
                }
            };
            return {
                toggle: handler,
                hide: closeToolTip
            };
        })();

        var thePopup = grn.component.popup_user_select;
        $(window).on("resize", thePopup.hide);
        $(document).on("click", function(e) {
            var target = $(e.target);
            if (target.hasClass("icon_information_sub16_grn")) {
                thePopup.toggle(e);
            }
            else if (target.hasClass("balloon_search_target_grn") || target.hasClass("sub_title")) {
                e.stopPropagation();
            }
            else {
                thePopup.hide();
            }
        });
    });
})(jQuery);
