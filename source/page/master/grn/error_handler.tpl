{literal}
<script text="text/javascript">
    // namespace
    grn.base.namespace("grn.component.error_handler");

    (function () {
        var G = grn.component.error_handler;

        G.show = function (request, my_callback) {
            var s = request.responseText;
            if (s != undefined) {
                var title = '';
                var msg = '';
                var json = null;

                try {
                    json = JSON.parse(s);
                } catch(e){}

                if (json) {
                    var show_backtrace = "{/literal}{$show_backtrace}{literal}";
                    title = '';//json.code;

                    if (show_backtrace) {
                        msg = msg + "<div style='height:145px; overflow: auto;'><table><tr><td>";
                    }
                    msg = msg + "<div><img border='0' src='{/literal}{$app_path}/grn/image/cybozu/warn100x60.gif?{$build_date}{literal}'></div>";
                    msg = msg + "<div class='bold'>" + '{/literal}{cb_msg module="fw.error" key="Error"|escape:javascript}{literal} (' + json.code + ")</div><div>" + json.diagnosis + "</div><br>";
                    msg = msg + "<div class='bold'>" + '{/literal}{cb_msg module="fw.error" key="Cause"|escape:javascript}{literal}' + "</div><div>" + json.cause + "</div><br>";
                    msg = msg + "<div class='bold'>" + '{/literal}{cb_msg module="fw.error" key="Counter Measure"|escape:javascript}{literal}' + "</div><div>" + json.counter_measure + "</div>";

                    if (show_backtrace) {
                        msg = msg + "<br><hr>";
                        msg = msg + "<div class='bold'>{/literal}{cb_msg module='grn' key='GRN_GRN-33' replace='true'}{literal}</div><br>";
                        msg = msg + "<div class='bold'>{/literal}{cb_msg module='grn' key='GRN_GRN-34' replace='true'}{literal}</div><br>";
                        if (json.developer_info) {
                            msg = msg + json.developer_info;
                        }
                        msg = msg + "<div class='bold'>{/literal}{cb_msg module='grn' key='GRN_GRN-35' replace='true'}{literal}</div><br>";
                        msg = msg + "{/literal}{cb_msg module='grn' key='GRN_GRN-36' replace='true'}{literal} / {/literal}{cb_msg module='grn' key='GRN_GRN-37' replace='true'}{literal}<br>";
                        msg = msg + "<pre style='border:1px solid #6666ff; background:#eeeeff; padding:10px;'>";
                        if (json.backtrace) {
                            msg = msg + json.backtrace;
                        }
                        msg = msg + "</pre>";
                        msg = msg + "<br>{/literal}{cb_msg module='grn' key='GRN_GRN-38' replace='true'}{literal}<br>";
                        msg = msg + "<pre style='border:1px solid #6666ff; background:#eeeeff; padding:10px;'>";
                        if (json.input) {
                            msg = msg + json.input;
                        }
                        msg = msg + "</pre>";
                        msg = msg + "</td></tr></table></div>";
                    }
                }
                else {
                    title = '{/literal}{cb_msg module='fw.error' key="Error"|escape:javascript}{literal}';
                    msg = grn_split_tags(s, 1000);
                }
            }
            else {
                title = "{/literal}{cb_msg module='fw.error' key='Error'|escape:javascript}{literal}";
                msg = "{/literal}{cb_msg module='grn' key='ajax_undefined_error' replace='true'}{literal}";
            }

            GRN_MsgBox.show(msg, title, GRN_MsgBoxButtons.ok, {
                ui: [],
                caption: {
                    ok: '{/literal}{cb_msg module="grn.common" key="ok" replace="true"}{literal}'
                },

                callback: function (result, form) {
                    GRN_MsgBox._remove();
                    if (typeof my_callback != 'undefined') my_callback();
                }
            });
        };
        G.getHeader = function (request) {
            if (typeof(request.getAllResponseHeaders) == 'function') {
                return request.getAllResponseHeaders();
            }
            else {
                return request.getAllResponseHeaders; // for YAHOO.util.Connect.asyncRequest
            }
        };
        G.hasCybozuError = function (request) {
            var headers = G.getHeader(request);
            return (headers && headers.match(new RegExp(/X-Cybozu-Error/i))) ? true : false;
        };
        G.hasCybozuLogin = function (request) {
            var headers = G.getHeader(request);
            return (headers.match(new RegExp(/X-CybozuLogin/i)) || !headers.match(new RegExp(/X-Cybozu-User/i)));
        };
})();

</script>
{/literal}
