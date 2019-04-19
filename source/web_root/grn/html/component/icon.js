grn.base.namespace("grn.component.icon");
grn.component.icon.Icon = function (iconId, iconPath) {
    this.element = null;
    this.iconId = iconId;
    this.iconPath = iconPath;
    this.onClickCallback = null;
};

grn.component.icon.Icon.prototype.render = function (wrapperId) {
    this.element = jQuery("<img>").attr({"src": this.iconPath});
    jQuery("#" + wrapperId).append(this.element);

    this.element.on("click", jQuery.proxy(this.onClick, this));
};

grn.component.icon.Icon.prototype.onClick = function (event) {
    this.onClickCallback(this);
};

grn.component.icon.Icon.prototype.setOnClick = function (func) {
    this.onClickCallback = func;
};

grn.component.icon.Icon.prototype.getId = function () {
    return this.iconId;
};

grn.component.icon.IconSelector = function (iconData, targetInputId) {
    this.iconData = iconData;
    this.icons = new Array();
    this.targetInputId = targetInputId;
};

grn.component.icon.IconSelector.prototype.render = function (wrapperId) {
    for (var i = 0; i < this.iconData.length; i++) {
        var icon = new grn.component.icon.Icon(this.iconData[i]["iconId"], this.iconData[i]["iconPath"]);
        icon.render(wrapperId);
        icon.setOnClick(jQuery.proxy(this.onClick, this));
        this.icons.push(icon);
    }
};

grn.component.icon.IconSelector.prototype.onClick = function (icon) {
    jQuery(".space-createForm-iconSelected-grn").each(function (idx, elm) {
        jQuery(elm).removeClass("space-createForm-iconSelected-grn");
    });
    jQuery("#" + this.targetInputId).val(icon.iconId);
    icon.element.addClass("space-createForm-iconSelected-grn");
};

grn.component.icon.IconSelector.prototype.selectIcon = function (iconId) {
    for (var i = 0; i < this.icons.length; i++) {
        if (this.icons[i].getId() == iconId) {
            return this.onClick(this.icons[i]);
        }
    }
};
