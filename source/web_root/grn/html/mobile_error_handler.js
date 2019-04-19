(function () {
    grn.base.namespace("grn.component.mobile_error_handler");
    var G = grn.component.mobile_error_handler;
    G.Msg = {}; // Resource string
    G.getHeader = function (request) {
        if (typeof(request.getAllResponseHeaders) == 'function') {
            return request.getAllResponseHeaders();
        } else {
            return request.getAllResponseHeaders; // for YAHOO.util.Connect.asyncRequest
        }
    };
    G.hasCybozuError = function (request) {
        var headers = G.getHeader(request);
        return headers.match(new RegExp(/X-Cybozu-Error/i)) ? true : false;
    };
    G.hasCybozuLogin = function (request) {
        var headers = G.getHeader(request);
        return (headers.match(new RegExp(/X-CybozuLogin/i)) || !headers.match(new RegExp(/X-Cybozu-User/i)));
    };
    G.show = function (jqXHR, my_callback) {

        var json = typeof jqXHR.responseJSON != "undefined" ? jqXHR.responseJSON : jqXHR;
        if (json != undefined) {
            var title = json.code;
            var _template = '<div id="error-screen">\
                            <div id="error_content" data-role="listview" data-theme="{{theme}}" class="mobile_ul_grn ui-listview" >\
                                <div class="mobile_error_grn" >\
                                    <div data-role="listview" data-theme="{{theme}}" class="mobile_error_scroll_grn ui-listview">\
                                        <span class="mobile_icon_attention_grn"></span>\
                                        <span class="mobile_error_text_grn">\
                                            <span class="mobile_error_texttittle_grn"><!--{{Error}}({{code}})--></span><br id="diagnosis"/>\
                                           <!-- {{diagnosis}}-->\
                                        </span>\
                                        <span class="mobile_error_text_grn">\
                                            <span class="mobile_error_texttittle_grn" id="h-cause">{{Cause}}</span><br id="c-cause"/>\
                                            <!--{{cause}}-->\
                                        </span>\
                                        <span class="mobile_error_text_grn">\
                                            <span class="mobile_error_texttittle_grn" id="h-counter_measure">{{CounterMeasure}}</span><br id="c-counter_measure"/>\
                                           <!-- {{counter_measure}}-->\
                                        </span>\
                                        <!--{{#show_backtrace}}-->\
                                        <div class="mobile_error_border_partition_grn"></div>\
                                        <div class="mobile_error_main_grn">\
                                            <b id="GRN_GRN-33">{{GRN_GRN-33}}</b>\
                                            <h3 class="ui-li-heading" id="GRN_GRN-34">{{GRN_GRN-34}}</h3>\
                                            <p class="ui-li-desc" id="c-developer_info">\
                                            {{developer_info}}\
                                            </p>\
                                            <h3 class="ui-li-heading" id="h-GRN_GRN-35">{{GRN_GRN-35}}</h3>\
                                            <p class="ui-li-desc" id="GRN_GRN-36-37" >{{GRN_GRN-36}} / {{GRN_GRN-37}}</p>\
                                            <pre class="mobile_error_backtrace_grn" id="mobile_error_backtrace_grn">\
                                            {{#backtrace}}\
                                                {{&backtrace}}\
                                            {{/backtrace}}\
                                            </pre>\
                                            <p class="ui-li-desc" id="GRN_GRN-38">{{GRN_GRN-38}}</p>\
                                            <pre class="mobile_error_backtrace_grn" id="c-input">\
                                                {{#input}}\
                                                    {{&input}}\
                                                {{/input}}\
                                            </pre>\
                                        </div>\
                                       <!-- {{/show_backtrace}}-->\
                                    </div>\
                                </div>\
                                <div class="mobile_select_button_area_grn" data-theme="" >\
                                    <div class="mobile_cancel_grn">\
                                        <div  data-corners="true" data-shadow="true" data-iconshadow="true" data-wrapperels="span" data-theme="{{theme}}" data-inline="true" data-disabled="false" class="ui-submit ui-btn ui-shadow ui-btn-corner-all ui-btn-inline ui-btn-up-c" aria-disabled="false" >\
                                            <span class="ui-btn-inner">\
                                                <span class="ui-btn-text" id="h-msgbox_btn_ok">\
                                                {{OK}}\
                                                </span>\
                                            </span>\
                                            <input type="button" value="{{OK}}" id="msgbox_btn_ok" data-inline="true" data-theme="{{theme}}" class="ui-btn-hidden" data-disabled="false"/>\
                                        </div>\
                                    </div>\
                                </div>\
                            </div>\
                        </div>';
            _template = _template.replace(/\s{2,}/g, ' ');

            if (G.Msg['theme'] === "") {
                G.Msg['theme'] = 'c';
            }
            var _data = $.extend(G.Msg, json);
            $("body").append(_template);
            $("#error_content").attr("data-theme", "c");
            $("div.mobile_error_grn .mobile_error_scroll_grn").attr("data-theme", _data.theme);
            $("span.mobile_error_texttittle_grn").text(_data.Error + "(" + _data.code + ")");
            $("br#diagnosis").after(_data.diagnosis);
            $("#h-cause").html(_data.Cause);
            $("#c-cause").after(_data.cause);
            $("#h-counter_measure").html(_data.CounterMeasure);
            $("#c-counter_measure").after(_data.counter_measure);

            $("div.mobile_select_button_area_grn").attr("data-theme", _data.theme);
            $("div.mobile_ok_grn> div").attr("data-theme", _data.theme);
            $("#msgbox_btn_ok").attr("data-theme", _data.theme);
            $("#h-msgbox_btn_ok").html(_data.OK);
            $("#msgbox_btn_ok").val(_data.OK);
            if (_data.show_backtrace === "1") {
                $("#GRN_GRN-33").html(_data.GRN_GRN_33);
                $("#GRN_GRN-34").html(_data.GRN_GRN_34);
                $("#c-developer_info").html($.trim(_data.developer_info !== null ? _data.developer_info : ""));
                $("#h-GRN_GRN-35").html(_data.GRN_GRN_35);
                $("#GRN_GRN-36-37").html(_data.GRN_GRN_36 + _data.GRN_GRN_37);
                $("#mobile_error_backtrace_grn").html(_data.backtrace);
                $("#GRN_GRN-38").html(_data.GRN_GRN_38);
                $("#c-input").html(_data.input);
            } else {
                $(".mobile_error_main_grn, .mobile_error_border_partition_grn").remove();
            }
            msg = $("#error-screen");
            grn.component.msgbox_mobile.MsgBox.show_error(msg, title, grn.component.msgbox_mobile.MsgBoxButtons.ok, {
                ui: {},
                caption: {
                    ok: json.OK
                },
                callback: function (result, form) {
                    grn.component.msgbox_mobile.MsgBox._remove();
                    if (typeof my_callback != 'undefined') my_callback();
                }
            });
            //auto-fix
            var _calculation_window = function () {
                var w_page = $("body> div:first").width();
                $("#error-screen .mobile_ok_grn").css({'margin-right': '0'});
                $("#msgbox").css({'top': 0, 'left': 0, 'width': w_page - 22});
                $("#error_content").height(window.innerHeight-22);
                $(".mobile_error_grn").height($("#error_content").innerHeight() - $("#error_content> .mobile_select_button_area_grn").outerHeight());
            };
            _calculation_window();
            $(window).resize(function () {
                _calculation_window();
            });
            //mobile_error_grn
        } else {
            document.write(jqXHR.responseText);
            document.close();
            return false;
        }
    };
})(jQuery);