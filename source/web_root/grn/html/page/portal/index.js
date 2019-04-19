(function(){
    var PulldownSettings = function() {
        var iconObj = jQuery("#portal_operation_option_icon");
        var menuObj = jQuery("#portal_operation_option_menu");
        /**
         * @param {Event} e
         * @returns {boolean}
         */
        var isClickedObj = function(e) {
            return iconObj.has(e.target).length != 0;
        };

        /**
         * @param {Event} e
         * @returns {boolean}
         */
        var isClickedIcon = function(e) {
            return iconObj.has(e.target).length != 0 && menuObj.has(e.target).length == 0;
        };

        var changeArrowToDown = function() {
            iconObj.find('span.icon-hideMenu-grn').removeClass('icon-hideMenu-grn').addClass('icon-showMenu-grn');
        };

        var changeArrowToUp = function() {
            iconObj.find('span.icon-showMenu-grn').removeClass('icon-showMenu-grn').addClass('icon-hideMenu-grn');
        };

        var setMenuPosition = function() {
            var switchOffset = cumulativeOffset(iconObj.get(0));
            menuObj.css({
                'top': (switchOffset[1] + iconObj.outerHeight()),
                'left': (switchOffset[0]  - menuObj.outerWidth() + iconObj.outerWidth())
            });
        };

        var hideSettingMenu = function() {
            if (menuObj.is(":visible")) {
                menuObj.hide();
                changeArrowToDown();
            }
        };

        var toggleSettingMenu = function() {
            menuObj.toggle();
            if (menuObj.is(":visible")) {
                changeArrowToUp();
                setMenuPosition();
            } else {
                changeArrowToDown();
            }
        };

        /**
         *
         * @param {Event} e
         */
        this.eventObserver = function (e) {
            if (! isClickedObj(e)) {
                hideSettingMenu();
            } else if (isClickedIcon(e)) {
                toggleSettingMenu();
            }
        };
    };

    jQuery("#portal_operation_option_icon").ready(function() {
        var pulldownSettings = new PulldownSettings();
        jQuery(document).click(pulldownSettings.eventObserver.bind(pulldownSettings));
        jQuery(window).resize(pulldownSettings.eventObserver.bind(pulldownSettings));
    });

})();
