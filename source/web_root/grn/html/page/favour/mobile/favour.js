// namespace
grn.base.namespace("grn.page.favour.mobile.favour");

(function () {
    "use strict";
    var G = grn.page.favour.mobile.favour;

    var isFavourLoading = false;
    G.favour = function (module, sub_module, type, value, org_data) {
        if (isFavourLoading) {
            return;
        }
        isFavourLoading = true;

        var unique_id = type + '_' + value;
        var favour_link = jQuery("#favour_link_" + unique_id);
        var favour_count = jQuery("#favourer_count_link_" + unique_id);
        var favour_count_span = jQuery("#favourer_count_span_" + unique_id);

        var loading = jQuery("#favour_loading_" + unique_id);
        loading.html('<img src="' + G.spinner_image + '" />');

        var request = new grn.component.ajax.request({
                url: G.favour_url,
                grnErrorHandler: grn.component.mobile_error_handler,
                method: 'post',
                dataType: 'json',
                grnRedirectOnLoginError: true,
                data: 'module=' + module + '&sub_module=' + sub_module + '&type=' + type + '&value=' + value + org_data
                + '&csrf_ticket=' + G.csrf_ticket
            }
        );

        request.send().done(
            function (json_obj) {
                favour_link.html(json_obj.f_word);
                favour_count.html(json_obj.f_count);
                if (json_obj.count > 0) {
                    favour_count_span.show();
                    if (favour_count.hasClass("icon_reaction_sub_grn")) {
                        favour_link.removeClass("icon_reaction_sub_grn");
                    }
                }
                else {
                    if (favour_count.hasClass("icon_reaction_sub_grn")) {
                        favour_link.addClass("icon_reaction_sub_grn");
                    }
                    favour_count_span.hide();
                }
            }
        ).always(
            function () {
                loading.html('');
                isFavourLoading = false;
            }
        );
    };

    var isFavourListLoading = false;
    G.getFavourList = function (module, sub_module, type, value, params) {
        if (isFavourListLoading) {
            return;
        }
        isFavourListLoading = true;
        var favour_list = jQuery("#favour_list_popup");
        var spinner = '<div class="mobile_spinner_block_grn"><span class="mobile_icon_spinner_grn"></span></div>';
        favour_list.html(spinner);
        var request = new grn.component.ajax.request({
                url: G.get_favour_list_url,
                grnErrorHandler: grn.component.mobile_error_handler,
                method: 'post',
                dataType: 'json',
                grnRedirectOnLoginError: true,
                data: "module=" + module + "&sub_module=" + sub_module + "&type=" + type + "&value=" + value + params
            }
        );
        request.on('beforeShowError', function () {
            jQuery('#favour_user_list').popup('close');
        });

        request.send().done(
            function (json_obj) {
                favour_list.html(json_obj.list);
                G.setSizeSelectMenu();
            }
        ).always(
            function () {
                isFavourListLoading = false;
            }
        );
    };

    G.setSizeSelectMenu = function () {
        var container = jQuery('#favour_user_list');
        var title_bar_height = container.find(".mobile_titlebar_grn").height();
        var button_area_height = container.find(".mobile_select_button_area_grn").height();

        var list_menu = container.find(".mobile_ul_grn");
        var list_menu_height = 0.5;
        container.find('.mobile_ul_grn > li').each(function () {
            list_menu_height += jQuery(this).height() + 1; // 1px is border bottom
        });


        var height_list_temp = parseInt(window.innerHeight - title_bar_height - button_area_height - 24, 0);
        if (height_list_temp > list_menu_height) {
            height_list_temp = list_menu_height;
        }
        list_menu.height(height_list_temp);
        this.needResize = false;
    };

    G.initPopup = function () {
        var popupDup = jQuery('#favour_user_list');
        popupDup.popup("option", "tolerance", "10");

        popupDup.popup({
            afterclose: function () {
                var list_menu = popupDup.find(".mobile_ul_grn");
                var list_menu_height = 40;
                list_menu.height(list_menu_height);
            }
        });

        popupDup.find('.cancel_button').on('touchstart', function (event) {
            event.preventDefault();
            event.stopPropagation();
            popupDup.popup('close');
        });
    };

    jQuery(function () {
        G.initPopup();
    });
})();
