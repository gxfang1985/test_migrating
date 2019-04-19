grn.base.namespace("grn.component.com_header_start_menu");
(function($) {
    'use strict';

    var com_header_start_menu = $("#header_pulldown_appmenu_base_grn");

    var setLongApplicationName = function() {
        var menu_item = $(this);
        menu_item.find('nobr:first').text(menu_item.prop('title'));
    };

    var setShortApplicationName = function() {
        var menu_item = $(this);
        menu_item.find('nobr:first').text(menu_item.data('short_title'));
    };

    com_header_start_menu.on("mouseover", "span.appmenu-item", setLongApplicationName);
    com_header_start_menu.on("mouseout", "span.appmenu-item", setShortApplicationName);
    
})(jQuery);
