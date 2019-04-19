grn.base.namespace("grn.page.dezielink.system.view");

(function ($) {
    "use strict";

    var G = grn.page.dezielink.system.view;

    $(function (){
        var body_html = $(".mainarea");
        var new_html_string = body_html.html().replace(/&amp;&amp;module&amp;&amp;/gi, G.moduleName);
        body_html.html(new_html_string);
    });
})(jQuery);
