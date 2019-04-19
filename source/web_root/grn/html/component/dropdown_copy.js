grn.base.namespace("grn.component.dropdown_copy");

/**
 * _dropdown_copy.tplとセットで利用して下さい。
 * @param {String} key
 */
grn.component.Dropdown_copy = function(key) {
    this.key = key;
    this.checkbox_ = document.getElementById("enable_copy_" + key);
    this.dropdown_ = document.getElementById(key + "_dropdown");
    this.selectbox_area_ = document.getElementById(key + "_copy_selectbox");
    this.popupArea_ = document.getElementById(key + "_copy_popup");
    this.tree_name = "tree_for_" + key;
};

/**
 *
 * @param {Object} checkbox
 * @param {Object} element
 */
grn.component.Dropdown_copy.prototype.handleSelectBoxArea = function(checkbox, element) {
    if ( jQuery(checkbox).is(":checked") ) {
        element.style.display = "";
    } else {
        element.style.display = "none";
    }
};

/**
 *
 * @param {Object} popup
 * @param {Object} dropdown
 */
grn.component.Dropdown_copy.prototype.handleDropDown = function(popup, dropdown) {
    "use strict";
    if (popup.style.display == "none") {
        popup.style.display = "";
        document.getElementById(this.key + "_dropdown_tree_div1").style.width = dropdown.offsetWidth + "px";
    } else {
        popup.style.display = "none";
    }
};

/**
 *
 * @param {Event} e
 */
grn.component.Dropdown_copy.prototype.handlerClick = function(e) {
    var target = e.target || e.srcElement;
    if ( this.dropdown_ === null || this.popupArea_ === null ) {
        return;
    }
    if (target == this.dropdown_ || YAHOO.util.Dom.isAncestor(this.dropdown_, target)) {
        this.handleDropDown(this.popupArea_, this.dropdown_);
    } else if ( ! YAHOO.util.Dom.isAncestor(this.popupArea_, target) ) {
        this.popupArea_.style.display = "none";
    }
};

/**
 *
 * @param {String} id
 */
grn.component.Dropdown_copy.prototype.selectCategory = function(id) {
    var node_ = document.getElementById(this.tree_name + "-node-" + id);
    this.popupArea_.style.display = "none";
    if (node_) {
        if (node_.textContent) {
            document.getElementById(this.key + "_dropdown_title").textContent = node_.textContent;
        } else {
            document.getElementById(this.key + "_dropdown_title").innerText = node_.innerText;
        }
        document.getElementById(this.key + "_dropdown_selected").value = id;
    }
};

/**
 *
 */
grn.component.Dropdown_copy.prototype.run = function(){
    "use strict";
    var self = this;
    jQuery(this.checkbox_).click(function(){
        self.handleSelectBoxArea(self.checkbox_, self.selectbox_area_);
    });
    jQuery(document).click( function(e){
        self.handlerClick(e);
    });
};