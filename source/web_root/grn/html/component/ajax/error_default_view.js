(function ($) {
    "use strict";

    grn.base.namespace("grn.component.ajax.error_default_view");

    var G = grn.component.ajax.error_default_view;
    var i18n = grn.component.i18n;

    var icon = grn.component.url.image("cybozu/warn100x60.gif");
    var backtrace_style = "style='border:1px solid #6666ff; background:#eeeeff; padding:10px;'";

    G._template = function() {
        var resources = this._loadResources();

        return "" +
        "<div style='overflow: auto;'>" +
        "    <table>" +
        "        <tbody>" +
        "            <tr>" +
        "                <td>" +
        "                    <div><img border='0' src='" + icon + "'></div>" +
        "                    <div class='bold'>" + resources.error + " (<span class='error_code'>{{code}}</span>)</div>" +
        "                    <div class='error_diagnosis'>{{diagnosis}}</div>" +
        "                    <br>" +
        "                    <div class='bold'>" + resources.cause + "</div>" +
        "                    <div class='error_cause'>{{cause}}</div>" +
        "                    <br>" +
        "                    <div class='bold'>" + resources.counterMeasure + "</div>" +
        "                    <div class='error_countermeasure'>{{counter_measure}}</div>" +
        "                    <div class='trace_info_area' style='display: none'>" +
        "                        <br>" +
        "                        <hr>" +
        "                        <div class='bold'>" + resources.debugOnly + "</div>" +
        "                        <br>" +
        "                        <div class='bold'>" + resources.devInfo + "</div>" +
        "                        <div class='error_developer_info'>{{developer_info}}</div>" +
        "                        <br>" +
        "                        <div class='bold'>" + resources.backtrace + "</div>" +
        "                        <br>" + resources.howToReadBacktrace1 + " / " + resources.howToReadBacktrace2 +
        "                        <br>" +
        "                        <pre class='error_backtrace' " + backtrace_style + ">{{backtrace}}</pre>" +
        "                        <br>" +
        "                        " + resources.inputVar +
        "                        <br>" +
        "                        <pre class='error_input' " + backtrace_style + ">{{input}}</pre>" +
        "                    </div>" +
        "                </td>" +
        "            </tr>" +
        "        </tbody>" +
        "    </table>" +
        "</div>";
    };

    G._loadResources = function() {
        return {
            error: i18n.cbMsg('fw.error', 'Error'),
            cause: i18n.cbMsg('fw.error', 'Cause'),
            counterMeasure: i18n.cbMsg('fw.error', 'Counter Measure'),
            debugOnly: i18n.cbMsg('grn', 'GRN_GRN-33'),
            devInfo: i18n.cbMsg('grn', 'GRN_GRN-34'),
            backtrace: i18n.cbMsg('grn', 'GRN_GRN-35'),
            howToReadBacktrace1: i18n.cbMsg('grn', 'GRN_GRN-36'),
            howToReadBacktrace2: i18n.cbMsg('grn', 'GRN_GRN-37'),
            inputVar: i18n.cbMsg('grn', 'GRN_GRN-38')
        };
    };

    G.render = function(error) {
        var $element = $(this._template());

        $element.find(".error_code").html(error.code);
        $element.find(".error_diagnosis").html(error.diagnosis);
        $element.find(".error_cause").html(error.cause);
        $element.find(".error_countermeasure").html(error.counter_measure);

        if (error.backtrace) {
            $element.find(".error_developer_info").html(error.developer_info || '');
            $element.find(".error_backtrace").html(error.backtrace || '');
            $element.find(".error_input").html(error.input || '');
            $element.css({height: 200});
            $element.find(".trace_info_area").show();
        }

        return $element[0];
    };

})(jQuery);
