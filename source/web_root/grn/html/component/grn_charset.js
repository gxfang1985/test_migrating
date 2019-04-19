grn.base.namespace("grn.html.component.grn_charset");
(function ($) {
    "use strict";
    var G = grn.html.component.grn_charset;

    G.charsetSelectName = '';

    $(function (){
        var bom = $("#bom");
        var charsetSelect = $("select[name='" + G.charsetSelectName+ "']");

        if ($("option:selected", charsetSelect).val() === "UTF-8") {
            bom.parent().show();
            bom.prop("checked", false);
        }

        var adjustBomElement = function(e){
            var selectedElm = $("option:selected", this);
            if (selectedElm.val() === "UTF-8") {
                bom.parent().show();
            }
            else {
                bom.parent().hide();
            }
            bom.prop("checked", false);
        };

        charsetSelect.change( adjustBomElement );
    });
})(jQuery);
