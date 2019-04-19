grn.base.namespace("grn.component.autofit");

grn.component.autofit.autofit = function(img, parent, maxHeight, maxWidth)
{
    var w = img.width ;
    var h = img.height;
    if (h > maxHeight || w > maxWidth) {
        if (w / h > maxWidth / maxHeight) {
            img.width = maxWidth;
            img.height = h * (maxWidth / w);
        } else {
            img.height = maxHeight;
            img.width = w * (maxHeight / h);
        }
    }

    if (parent.classList.contains("autofit-hidden")) {
        parent.classList.remove("autofit-hidden");
    }

};
