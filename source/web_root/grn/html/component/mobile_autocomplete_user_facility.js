(function ($) {
    if (grn.base.isNamespaceDefined("grn.Component.Autocomplete")) {
        return;
    }
    grn.base.namespace("grn.Component.Autocomplete");
    grn.Component.Autocomplete.AutocompleteUserFaci = function () {
    };

    var _keywords = {
        'click': 'click',
        'keydown': 'keydown',
        'keyup': 'keyup',
        'keypress': 'keypress',
        'input': 'input',
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
    var _elements = {
        icon_search: "#icon_search_grn",
        dropDownList: ".mobile_pulldown_user_incremental_search_grn",//list of user suggestion after enter keyword
        dropDownListSelected: "div.mobile_userlines_grn",
        suggestion_part: ".mobile_schedulelist_search_grn",//,when click icon-search, expand suggestion part
        search_input: "input.tbsearch",
        search_input_part:".mobile_user_search_grn",
        icon_triangle: "a#icon_search_grn div.mobile_triangle_grn",
        icon_delete_input: "a.mobile_delete_icon_grn",
        icon_delete_item: "a.mobile_delete_icon_normal_grn",
        title_bar: "div.mobile_breadcrumbtitle_right_grn",
        mobile_user_search_grn: ".mobile_user_search_grn",
        mobile_user_list_grn: "ul.mobile_user_list_grn",
        mobile_schedule_week_header_grn: "div.mobile_schedule_week_header_grn",
        mobile_user_list_scroll_grn: 'div.mobile_user_list_scroll_grn',
        hfPageLoad: "#hfPageLoad",
        hfClearTbSearch: "#hfClearTbSearch"
    };
    var _css_class = {
        mobile_triangle_grn: 'mobile_triangle_grn',
        mobile_user_search_focus_grn: 'mobile_user_search_focus_grn'
    };
    var _key = {
        'enter': 13,
        'tab': 9,
        'comma': 188,
        'backspace': 8,
        'leftarrow': 37,
        'uparrow': 38,
        'rightarrow': 39,
        'downarrow': 40,
        'exclamation': 33,
        'slash': 47,
        'colon': 58,
        'at': 64,
        'squarebricket_left': 91,
        'apostrof': 96,
        'del': 46,
        'esc': 27
    };
    var G = grn.Component.Autocomplete.AutocompleteUserFaci;
    G.Msg = {}; //Resource string
    G.Parameters = {};//Parameter for component
    G.prototype = {

        init: function () {
            if (Object.size(G.Parameters) < 1) {
                return;
            }
            if ($(_elements.hfPageLoad).length < 1) {
                console.log("Please register hidden field for auto-complete");
            }
            this.SearchCommand(G.Parameters);
        },
        _setOptions: function (options) {
            this._url = options.url || null;
        },
        SearchCommand: function (options) {
            var fn = this;
            //IOS focus and showed keyboard
            $(_elements.search_input).trigger('touchstart');
            $(_elements.search_input).on("touchstart", function () {
                $(this).focus();
            });
            $(_elements.icon_search).on(_keywords.click, function () {

                $(_elements.dropDownList).hide();//drop down list
                if ($(_elements.icon_triangle).length > 0) {
                    $(_elements.icon_triangle).remove();
                } else {
                    $(this).append($("<div/>", {'class': _css_class.mobile_triangle_grn}));
                }
                //$(_elements.search_input).val("").focus(); //remove this logic because at result screen toggle
                $(_elements.suggestion_part).toggle();
                if ($(_elements.suggestion_part).css('display') != "block") {
                    $(this).addClass("mobile_schedulelist_icon_search_grn").removeClass("mobile_schedulelist_icon_search_off_grn");
                    return;
                } else {
                    $(this).removeClass("mobile_schedulelist_icon_search_grn").addClass("mobile_schedulelist_icon_search_off_grn");
                }
                //if ($.GetURLParameter(_keywords.gid) !== _keywords.search) {
                // return;in the case screen result list, click also display, this is issue focus not effect
                //}
                //Current search events result screen

                var search_text = G.Msg.search_text;                                //transport from server side
                if ($(_elements.hfClearTbSearch).val() == "") {                    //search_text != "" &&  I receive the feedback from CTK, then focus and show keyboard
                    var search_text_decoded = $('<div/>').html(search_text).text();
                    $(_elements.search_input).val(search_text_decoded).focus();
                } else {
                    $(_elements.search_input).focus();
                }
                //Page load if the uids has user, reload info to list

                var str_uids = "";
                var str_fids = "";
                if ($(_elements.hfPageLoad).val() != "") {                          //is click deleted or add
                    var result = fn.PrepareUidsFidsForServerSearch();
                    str_uids = result[0];
                    str_fids = result[1];
                } else {// this is your first time go to page
                    str_uids = $.GetURLParameter(_keywords.uids);
                    str_fids = $.GetURLParameter(_keywords.fids);
                    if ($(_elements.search_input).val() == "") {
                        $(_elements.search_input).val("");
                        $(_elements.search_input).autocomplete(_keywords.search, "");
                    }
                }
                //execute for uids
                var uids_fids = fn._computedUidsFids(str_uids, str_fids);
                if (uids_fids[0].length > 0 || uids_fids[1].length > 0) {

                    $.ajax({
                        type: _keywords.post,
                        url: options.url,
                        data: {
                            uids: uids_fids[0],
                            fids: uids_fids[1],
                            flag: _keywords.selected,
                            referer_key: options.referer_key
                        },
                        beforeSend: function () {
                            grn.component.mobile_loading.show();
                        },
                        complete: function () {
                            grn.component.mobile_loading.remove();
                        }
                    }).done(function (data) {
                        if (typeof data != "undefined" && typeof data.user != "undefined" && typeof data.facility != "undefined") {
                            $(_elements.dropDownListSelected).empty();
                            if ((Object.size(data.user) < 1 && Object.size(data.facility) < 1)) {

                            } else {
                                $.each(data, function (key, value) {

                                    $.each(value, function (key1, value1) {
                                        if (typeof value1._id != "undefined") {
                                            fn._createdAppendListItemSelected(value1._id, value1.col_display_name, key, value1.primary_group);
                                        }
                                    });
                                });
                            }
                        } else if (typeof  data != "undefined") {
                            document.write(data);
                            document.close();
                            return;
                        }
                    }).fail(function (xhr) {
                        document.write(xhr.responseText);
                        document.close();
                        return;
                    });
                }
            });

            $(_elements.search_input).focus(function () {
                $(_elements.mobile_user_search_grn).addClass(_css_class.mobile_user_search_focus_grn);
                if ($(_elements.search_input).val() == "") {//in the case focus and empty value then clear and hidden
                    $(_elements.dropDownList).hide();
                    $(_elements.icon_delete_input).hide();// the first click to show search part and focus, do not show delete icon at input field
                } else {
                    $(_elements.icon_delete_input).show();
                }
            });
            $(_elements.search_input).blur(function () {
                setTimeout(function () {
                    if ($(_elements.search_input).val() == "") {
                        $(_elements.icon_delete_input).hide();
                    } else {
                        $(_elements.icon_delete_input).show();
                    }
                    $(_elements.mobile_user_search_grn).removeClass(_css_class.mobile_user_search_focus_grn);
                }, 300);

            });
            $(_elements.search_input).on(_keywords.input, function (event) {
                if ($(event.target).val() == '') {
                    $(_elements.icon_delete_input).hide();
                    $(_elements.search_input).autocomplete(_keywords.search, "");
                    $(_elements.dropDownList).hide();
                    // do something that normally would have required the backspace key
                }
            });
            $(_elements.search_input).on(_keywords.keyup, function (eu) {
                if ((eu.keyCode == _key.backspace || eu.keyCode == _key.del) &&
                    $(_elements.search_input).val().length == 0) {
                    $(_elements.icon_delete_input).hide();
                    $(_elements.search_input).autocomplete(_keywords.search, "");
                    $(_elements.dropDownList).hide();
                }

            });
            $(_elements.search_input).on(_keywords.keydown, function (ed) {
                $(_elements.mobile_user_search_grn).addClass(_css_class.mobile_user_search_focus_grn);
                if (ed.keyCode != _key.backspace &&
                    ed.keyCode != _key.del &&
                    ed.keyCode != _key.esc &&
                    ed.keyCode != _key.uparrow &&
                    ed.keyCode != _key.leftarrow &&
                    ed.keyCode != _key.rightarrow &&
                    ed.keyCode != _key.downarrow &&
                    ed.keyCode != _key.tab &&
                    ed.keyCode != _key.enter) {
                    $(_elements.icon_delete_input).show();
                }
                if (ed.keyCode == _key.backspace) {
                    if ($(_elements.search_input).val().length = 0) {
                        $(_elements.search_input).autocomplete(_keywords.search, "");
                        $(_elements.dropDownList).hide();
                    }
                }
            });
            $(_elements.search_input).on(_keywords.keypress, function (ep) {
                if ((ep.keyCode == _key.backspace || ep.keyCode == _key.del) &&
                    $(_elements.search_input).val().length == 0) {
                    $(_elements.icon_delete_input).hide();
                    $(_elements.search_input).autocomplete(_keywords.search, "");
                    $(_elements.dropDownList).hide();
                }
            });
            $(_elements.icon_delete_input).on(_keywords.click, function () {
                $(_elements.search_input).val("");
                $(_elements.hfClearTbSearch).val("1");
                $(_elements.icon_delete_input).hide();
                $(_elements.search_input).attr("placeholder", G.Msg.place_holder);//only use for android os
                $(_elements.search_input).trigger('touchstart');
                $(_elements.search_input).on("touchstart", function () {
                    $(this).focus();
                });

            });
            /* bind event delete at created and append
             $(_elements.icon_delete_item).on("click",function(e){
             $(this).parent().remove();
             $("#hfPageLoad").val("1");
             });
             */


            $(_elements.search_input).autocomplete({
                source: function (request) {
                    $.ajax({
                        type: _keywords.post,
                        url: options.url,
                        data: {
                            p: request.term,
                            flag: _keywords.search,
                            referer_key: options.referer_key
                        },
                        beforeSend: function () {
                            grn.component.mobile_loading.show();
                        },
                        complete: function () {
                            grn.component.mobile_loading.remove();
                        }
                    }).done(function (data) {

                        var $drop_down = $(_elements.dropDownList);

                        if (data == undefined || (data.user == undefined && data.facility == undefined) ||
                            (Object.size(data.user) < 1 && Object.size(data.facility) < 1)
                        ) {
                            $drop_down.hide();
                        } else {
                            $drop_down.show();
                        }
                        var itemTemplate = '<li data-icon="false" data-corners="false" data-shadow="false" data-iconshadow="true" data-wrapperels="div" data-iconpos="right" data-theme="c">\
                                                    <a href="#" class="ui-btn">\
                                                        <div class="mobile_user_photo_grn mobile_img_userPlofile_grn"></div>\
                                                        <div class="mobile_info_grn">\
                                                            <div class="mobile_position_center_grn">\
                                                                <div class="mobile_position_width_grn">\
                                                                    <div class="mobile_user_grn"> {{col_display_name}} {{col_nickname}}</div>\
                                                                    <div class="mobile_text_grn">{{primary_group}}</div>\
                                                                </div>\
                                                            </div>\
                                                        </div>\
                                                    </a>\
                                            </li>';

                        itemTemplate = $(itemTemplate);
                        $(_elements.mobile_user_list_grn).empty();
                        var limit = 0;
                        if (typeof data.facility != "undefined" && typeof data.user != "undefined") {
                            $.each(data, function (key, value) {

                                $.each(value, function (key1, value1) {

                                    if (limit > 19) {
                                        return;
                                    }
                                    limit++;
                                    var item_i = itemTemplate.clone();
                                    var primary_group = (typeof value1.primary_group !== "undefined" ? value1.primary_group : "");
                                    var nick_name = typeof value1.col_nickname !== "undefined" && value1.col_nickname !== "" ? "(" + value1.col_nickname + ")" : "";

                                    item_i.find("div.mobile_user_grn").text(value1.col_display_name + nick_name);
                                    item_i.find("div.mobile_text_grn").text(primary_group);
                                    item_i.find("div.mobile_user_photo_grn").addClass("mobile_img_" + key + "Plofile_grn");

                                    item_i.data("data-cb-id", value1._id);
                                    item_i.data("data-cb-display_name", value1.col_display_name);
                                    item_i.data("data-cb-primary_group", primary_group);
                                    item_i.data("data-cb-item_type", key);

                                    $(_elements.mobile_user_list_grn).append(item_i);
                                });
                            });
                        } else {
                            document.write(data);
                            document.close();
                            return;

                        }
                        $("div.mobile_pulldown_user_incremental_search_grn div.mobile_user_list_scroll_grn ul> li").on(_keywords.click, function () {
                            $(_elements.search_input).val('').focus();//when click selected a items from suggest list
                            fn._createdAppendListItemSelected($(this).data('data-cb-id'),
                                $(this).data('data-cb-display_name'), $(this).data("data-cb-item_type"), $(this).data('data-cb-primary_group'));

                            $drop_down.hide();
                            setTimeout(function () {
                                //in the case the same keyword the second
                                $(_elements.search_input).val("");
                                $(_elements.search_input).autocomplete(_keywords.search, "");
                            }, 50);
                        });

                        fn._computedL();
                    }).fail(function (data) {
                        document.write(data.responseText);

                    });
                },
                minLength: 1,
                delay: 500
            });
            $(_elements.icon_delete_input).on(_keywords.click, function (e) {
                e.preventDefault();
                $(_elements.dropDownList).hide();
                // if don't provide the flow logic, the sam keyword in the secode not execute.
                $(_elements.search_input).val("");
                $(_elements.search_input).autocomplete(_keywords.search, "");
            });
            $(window).bind(_keywords.resize,function () {
                fn._computedL();
            }).trigger(_keywords.resize);
        },
        PrepareUidsFidsForServerSearch: function () {
            var uids = "", fids = "";
            var result = [];
            $("div.mobile_userlines_grn div.mobile_line_grn").each(function () {
                var _id = $(this).data("id");
                var _type = $(this).data('type');
                if (_type === 'user') {
                    uids += "+" + _id;
                } else if (_type == 'facility') {
                    fids += "+" + _id;
                }
            });
            if (uids.length > 0) {
                uids = uids.substr(1);
            }
            if (fids.length > 0) {
                fids = fids.substr(1);
            }

            result.push(uids);
            result.push(fids);
            return result;
        },
        _computedUidsFids: function (str_uids, str_fids) {
            var result = [];                                               //Return the array User id, and Facility id from string user and facility
            if (str_uids == undefined || str_uids == "") {
                str_uids = "";
            }
            if (str_fids == undefined || str_fids == null) {
                str_fids = "";
            }
            var uids_tmp = str_uids.split('+');
            var fids_tmp = str_fids.split('+');
            var uids = [];
            var fids = [];
            for (var i = 0; i < uids_tmp.length; i++) {
                if ($.isNumeric(uids_tmp[i]) && uids_tmp[i] > 0) {
                    uids.push(uids_tmp[i]);
                }
            }
            for (var j = 0; j < fids_tmp.length; j++) {
                if ($.isNumeric(fids_tmp[j]) && fids_tmp[j] > 0) {
                    fids.push(fids_tmp[j]);
                }
            }

            result.push(uids);
            result.push(fids);
            return result;
        },
        //Builder a item selected when click or page load of search screen
        _createdAppendListItemSelected: function (id, display, type, group) {

            var itemSelected = $('<div class="mobile_line_grn"/>');

            itemSelected.text(display + (typeof group !== "undefined" && group !== "" ? ";" + group : ""));
            itemSelected.append($('<a href="javascript:void(0);" class="mobile_delete_icon_normal_grn"></a><a href="#" class="mobile_icon_grn"></a>'));
            $(_elements.dropDownListSelected).append($(itemSelected).data('id', id).data('type', type));
            $(_elements.icon_delete_item).on("click", function (e) {
                e.preventDefault();
                $(this).parent().remove();

            });
            $(_elements.hfPageLoad).val("0");
        },
        _computedL: function () {
            if ($(_elements.mobile_user_list_grn).children("li").length > 8) {
                var page_height = $(window).height();
                var exclusive_height = $(_elements.title_bar).height() +
                    $(_elements.mobile_schedule_week_header_grn).height() +
                    $(_elements.search_input_part).height();
                var user_list_height = (page_height - exclusive_height) * 0.7;
                if (user_list_height < 50) {
                    user_list_height = 50;
                }
                $(_elements.mobile_user_list_scroll_grn).height(user_list_height);
                $(_elements.mobile_user_list_grn).height(user_list_height);
            } else {
                $(_elements.mobile_user_list_scroll_grn).removeAttr("style");
                $(_elements.mobile_user_list_grn).removeAttr("style");
            }
        }
    };
})(jQuery);
