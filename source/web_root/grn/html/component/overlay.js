grn.base.namespace("grn.component.Overlay");
/**
 * Overlay Window
 * 
 * @param overlayId ID of the half opacity element covering whole the screen.
 * @param popupId ID of the element appearing when show() is called.
 */
grn.component.Overlay = function(overlayId, popupId){
    this.overlayId = overlayId;
    this.popupId = popupId;
};

grn.component.Overlay.prototype.show = function(){
    var b = document.body;
    var pageHeight = document.documentElement.scrollHeight != null ?
        document.documentElement.scrollHeight : window.innerHeight != null ?
        window.innerHeight : document.documentElement && document.documentElement.clientHeight ?
        document.documentElement.clientHeight : document.body != null ?
        document.body.clientHeight : null;

    jQuery("#" + this.overlayId).css("width", Math.max(b.clientWidth, b.scrollWidth))
        .css("height", Math.max(b.clientHeight, b.scrollHeight, pageHeight))
        .attr("class", "overlay-grn")
        .show();

    jQuery("#" + this.popupId).show();
};

grn.component.Overlay.prototype.hide = function(){
    jQuery("#" + this.overlayId).removeClass()
        .css({"width": 0, "height": 0})
        .hide();

    jQuery("#" + this.popupId).hide();
};

grn.component.Overlay.prototype.setOnClickOK = function(f){
    jQuery("#" + this.popupId + "-OK").on("click", f);
};

grn.component.Overlay.prototype.setOnClickCancel = function(f){
    jQuery("#" + this.popupId + "-Cancel").on("click", f);
    jQuery("#" + this.popupId + "-closeButton").on("click", f);
};