grn.base.namespace("grn.page.schedule.mobile.group_day");
(function ($) {
    $(document).ready(function () {
        var _keywords = {
            'click': 'click',
            'tap': 'tap',
            'keydown': 'keydown',
            'search': 'search',
            'resize': 'resize',
            'post': 'POST',
            'uids': 'uids',
            'fids': 'fids',
            'selected': 'selected',
            'change': 'change',
            'bdate': 'bdate',
            'sp': 'sp',
            'gid': 'gid',
            'search_text': 'search_text'
        };
        var searchPart = new grn.Component.Autocomplete.AutocompleteUserFaci();
        searchPart.init();
        //switch between personal week <-> group day command
        //group day and personal week, the same logic
        var $personal_week_command = $("div.mobile_schedule_week_header_grn div.mobile_left_grn, div.mobile_schedule_week_header_grn div.mobile_right_grn");
        $personal_week_command.on(_keywords.click, function (e) {
            e.preventDefault();
            if ($(this).children("a").length > 0) {
                window.location.href = $(this).children("a").attr("href");
            }
        });
        //enf of personal week
        //executed command search event
        var search_action = function (ed) {
            ed.preventDefault();
            var gid, search_text;
            search_text = encodeURIComponent($("input.tbsearch").val().trim());
            var uids_fids = searchPart.PrepareUidsFidsForServerSearch();
            var uids = uids_fids[0];
            var fids = uids_fids[1];
            gid = 'search';
            var _domain = window.location.href.replace(/personal_week/gi, "group_day");
            _domain = _domain.substr(0, _domain.indexOf("?"));
            var url_redirect = _domain + "?search_text=" + search_text + "&gid=" +
                gid + "&uids=" + uids + "&fids=" + fids;
            if ($.GetURLParameter(_keywords.sp).length > 0) {
                url_redirect += '&sp=0';                                                                                // + $.GetURLParameter(_keywords.sp); in the case view at sp 20, and click search command, force reset to 0
            }
            if (url_redirect.length > 0 && url_redirect.indexOf("?") < 0 && url_redirect[0] == "&") {
                url_redirect = url_redirect.replace("&", "?");
            }
            window.location.href = url_redirect;
            return 0;
        };
        $(window).on(_keywords.keydown, function (ed) {
            if (ed.keyCode == 13) {
                search_action(ed);
            }
        });
        $("a#mobile_event_search").on(_keywords.tap, function (e) {
            e.preventDefault();
            search_action(e);

        });
        //Only use group day logic
        //switch user/facility of schedule on group day view on mobile
        var url_parameter = $.GetURLParameter();
        //if (ep.target.className.search(/ui-page-footer/gi) > -1 || ep.target.className.search(/ui-page-panel/gi) > -1) {//fixed bug: broke ui user/facility part when click popup
        var $_div = $("div.mobile_switch_button_grn> div");

        if ($.GetURLParameter(_keywords.gid) != "" && $.GetURLParameter(_keywords.gid).indexOf('f') > -1) {

            $("div.mobile_switch_button_grn> a").replaceWith($("<div/>", {'class': 'mobile_right_grn mobile_selected_grn mobile_img_facility_on_grn'}));
            $_div.replaceWith($("<a/>", {'class': 'mobile_left_grn mobile_unselected_grn mobile_img_user_off_grn ui-link'}));
        } else {
            $_div.addClass("mobile_img_user_on_grn");
        }
        /// }
        $("div.mobile_switch_button_grn> a").on(_keywords.tap, function (e) {
            e.preventDefault();
            var facility_action = $(this).hasClass("mobile_img_facility_off_grn");
            var gid = $.GetURLParameter(_keywords.gid);
            var p_ = $.GetURLParameter('p');
            if (gid != null && gid != "f" && gid != "fr" && gid.substr(0, 1) != "f" || (facility_action && gid == "")) {
                //current view gid=1 convert to gid=f
                if (url_parameter.indexOf("gid=") > -1 && gid != "f" && gid != "fr") {
                    url_parameter = url_parameter
                        .replace("&gid=" + gid, "&gid=f")
                        .replace("?gid=" + gid, "?gid=f");
                } else if (url_parameter.indexOf("?") > -1 && gid != "f" && gid != "fr") { //schedule/mobile/group_day?
                    url_parameter = "&gid=f";
                } else {                                                                    //schedule/mobile/group_day
                    url_parameter = "?gid=f";
                }
                if (p_ != null && p_ != "") {
                    url_parameter = url_parameter.replace("&p=" + p_, "&p=").replace("?p=" + p_, "?p=");
                }
            } else {
                //current view gid=f convert to gid=mm(m is number)
                //bdate=2014-02-12&gid=7
                url_parameter = "?bdate=" + $.GetURLParameter(_keywords.bdate) + "&gid=";//+ $("select#facilities_groups option:selected").val();
            }
            if (url_parameter.indexOf("sp=") > -1)
            {
                var sp_number = $.GetURLParameter("sp");
                url_parameter = url_parameter
                    .replace("&sp=" + sp_number, "&sp=0")
                    .replace("?sp=" + sp_number, "?sp=0");
            }
            if (url_parameter.indexOf("uids=") > -1)
            {
                var uids = $.GetURLParameter("uids");
                url_parameter = url_parameter
                    .replace("&uids=" + uids, "&uids=")
                    .replace("?uids=" + uids, "?sp=");
            }
            if (url_parameter.indexOf("fids=") > -1)
            {
                var fids = $.GetURLParameter("fids");
                url_parameter = url_parameter
                    .replace("&fids=" + fids, "&fids=")
                    .replace("?fids=" + fids, "?fids=");
            }
            if (url_parameter.indexOf("search_text=") > -1)
            {
                var search_text = $.GetURLParameter("search_text");
                url_parameter = url_parameter
                    .replace("&search_text=" + search_text, "&search_text=")
                    .replace("?search_text=" + search_text, "?search_text=");
            }
            window.location.href = url_parameter;
        });
        //Switch command for group_day to personal week
        $("a.mobile_icon_week_grn").on(_keywords.click, function (e) {
            //The logic no execute by a has href in tpl
            e.preventDefault();
            var url = window.location.href;
            url = url.replace(window.location.search, "").replace(/group_day/gi, "personal_week");
            url += "?bdate=" + $.GetURLParameter(_keywords.bdate) + "&uid=" + $(this).attr('data-answer');

            window.location.href = url;
        });

        // click selected a user/group or facility recent, popup group tree
        $("#hf_user_facility_selected_").on(_keywords.change, function () {

            var url_params = $.GetURLParameter().
                replace("&uids=" + $.GetURLParameter('uids'), "").replace("?uids=" + $.GetURLParameter('uids'), "").
                replace("&fids=" + $.GetURLParameter('fids'), "").replace("?fids=" + $.GetURLParameter('fids'), "").
                replace("?search_text=" + $.GetURLParameter(_keywords.search_text), "").replace("&search_text=" + $.GetURLParameter(_keywords.search_text), "").
                replace("?type_search=" + $.GetURLParameter('type_search'), "").replace("&type_search=" + $.GetURLParameter('type_search'), "");
            var user_group_on = $("div.mobile_switch_button_grn> div").hasClass("mobile_img_user_on_grn");
            var id_selected = $(this).val();

            var gid = $.GetURLParameter(_keywords.gid);
            if (id_selected != "" && id_selected == _keywords.search) {
                return;//in the case view at search result screen, click selected "(search result)" item on drop-down menu
            }
            if (user_group_on) {
                //is group/user selected
                if (gid != "" || id_selected != "") {
                    if (url_params.length > 0 && url_params.indexOf(_keywords.gid) > -1) {                          //has gid param
                        url_params = url_params.
                            replace("&gid=" + gid, "&gid=" + id_selected).
                            replace("?gid=" + gid, "?gid=" + id_selected);
                    } else if (url_params.length > 0 && url_params.indexOf("?") > -1) {                      //"gid" not first param
                        url_params += "&gid=" + id_selected;
                    } else {                                                    //"gid" is first param url
                        url_params += "?gid=" + id_selected;
                    }
                }
            } else {                                                            //is facility selected
                var isNumber_ = /^[0-9]+$/.test(gid);                           //xr, x1, x2,x
                if (isNumber_) {
                    url_params = url_params.
                        replace("&gid=" + gid, "&gid=f" + id_selected).
                        replace("?gid=" + gid, "?gid=f" + id_selected).
                        replace("&p=1", "&p=").
                        replace("?p=1", "?p=");
                } else {

                    var id_result = new RegExp(/\d+/g).exec(id_selected);
                    if (id_result != null && id_selected != "-2") {
                        id_result = id_result[0];
                    } else if (id_selected == "xr") {
                        id_result = "r";
                    } else if(id_selected == "-2") {                            // in the case selected unassigned facility
                        id_result = "u";
                    }else{                                                      //popup selected f ->id_selected is null
                        id_result = "";
                    }
                    url_params = url_params.
                        replace("&gid=" + gid, "&gid=f" + id_result).
                        replace("?gid=" + gid, "?gid=f" + id_result).
                        replace("?p=1", "?p=").
                        replace("&p=1", "&p=");
                }
            }
            var sp = $.GetURLParameter(_keywords.sp);
            if (sp != "") {
                url_params = url_params.replace("&sp=" + sp, "").replace("?sp=" + sp, "");
            }
            //in the case after click popup selected a group-->error url missie "?" character
            if (url_params.length > 0 && url_params.indexOf("?") < 0 && url_params[0] == "&") {
                url_params = url_params.replace("&", "?");
            }
            window.location.href = url_params;
        });


        //Calendar picker selected
        $('input[type="hidden"]#start_set, input[type="hidden"]#date_select_footer_set').on(_keywords.change, function () {
            var new_bdate = "bdate=" + $(this).val();
            var url = $.GetURLParameter();
            if ($.GetURLParameter(_keywords.bdate) != "") {
                url = url.replace("bdate=" + $.GetURLParameter(_keywords.bdate), new_bdate);
            } else if (url.indexOf("?") > -1) {
                url += "&" + new_bdate;
            } else {
                url += "?" + new_bdate;
            }
            window.location.href = url;
        });
        //Add new event for a large user (at footer)

        var G = grn.page.schedule.mobile.group_day;
        $("div#operate_menu> .mobile_scroll_area_grn:first").on("touchstart", function (e) {
            e.preventDefault();
            var _thisForm = $("form").empty();

            _thisForm.attr({'id': 'tmpaddRediectForm', 'action': G.Parameters.href, 'method': "POST"});
            _thisForm.append($("<input type='hidden' id='selected_users_sUID[]' name='selected_users_sUID[]' />").val(G.Parameters.selected_users_sUID));
            _thisForm.append($("<input type='hidden' id='sITEM[]' name='sITEM[]' />").val(G.Parameters.sITEM));
            _thisForm.append($("<input type='hidden' id='bdate' name='bdate' />").val(G.Parameters.bdate));
            _thisForm.append($("<input type='hidden' id='referer_key' name='referer_key' />").val(G.Parameters.referer_key));
            _thisForm.append($("<input type='hidden' id='tab' name='tab' />").val("normal"));

            _thisForm.submit();

        });

        //Add new event (at footer)
        $("#footer_bar_b").on("click", function (e) {
            e.preventDefault();
            if (typeof G.Parameters != "undefined") {
                var url_parameters = "uid=" + G.Parameters.uid + "&bdate=" + G.Parameters.bdate;
                window.location.href = G.Parameters.href + "&" + url_parameters + "&referer_key=" + G.Parameters.referer_key;
            }
        });
        //auto fixed
        $("div.mobile_schedule_day_header_grn, div.mobile_select_grn, a.mobile_select_view_grn").css('margin-top', "0");

    });//end ready
    //auto fixed
    $(document).on("pageinit", "body div[data-role=page]:first", function() {
        $("#_popup_user_categories_tree").appendTo("body");
        $("#_popup_facility_categories_tree").appendTo("body");
        $("#_popup_user_categories_tree").css('margin-bottom', 63);
        $("#_popup_facility_categories_tree").css('margin-bottom', 63);
    });
})(jQuery);

