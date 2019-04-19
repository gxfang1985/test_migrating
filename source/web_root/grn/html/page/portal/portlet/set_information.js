grn.base.namespace("grn.page.portal.portlet.set_information");

(function () {
    var G = grn.page.portal.portlet.set_information;

    G.informationFrameCheckboxHandler = function(checkbox) {
        var radio = jQuery("#portlet_information_frame_grn").find("input");
        if (jQuery(checkbox).prop('checked')) {
            radio.each(function(index, element){element.disabled = false;});
        }
        else {
            radio.each(function(index, element){element.disabled = true;});
        }
    };
})();
