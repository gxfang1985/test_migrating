(function ($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.component.tree_item")) {
        return;
    }
    grn.base.namespace("grn.component.tree_item");
    var tree_item = grn.component.tree_item;

    /**
     * @type {string}
     *
     * @const
     */
    var HAS_POPUP_TREE_LABEL = "has_popup_tree_label";

    /**
     *
     * @param {jQuery} $tree_item
     * @constructor
     */

    tree_item.TreeItem = function ($tree_item) {
        this.$tree_item = $tree_item;
        this.$has_popup_tree_item = this.$tree_item.find("." + HAS_POPUP_TREE_LABEL);
        this.$arrow_icon = this.$has_popup_tree_item.find(".arrow_icon");
    };

    tree_item.TreeItem.prototype = {
        toggleTree: function () {
            if (this.isExpanded()) {
                this.closeTree(this.$has_popup_tree_item);
            } else {
                this.openTree(this.$has_popup_tree_item);
            }
        },

        openTree: function () {
            this.openArrowIcon();
            this.$has_popup_tree_item.attr("aria-expanded", true);
            this.$has_popup_tree_item.parent().find("ul").show();
        },

        closeTree: function () {
            this.closeArrowIcon();
            this.$has_popup_tree_item.attr("aria-expanded", false);
            this.$has_popup_tree_item.parent().find("ul").hide();
        },

        openArrowIcon: function () {
            if (this.$arrow_icon.length === 0) {
                return;
            }
            this.$arrow_icon.addClass("icon_arrow_open_grn");
            this.$arrow_icon.removeClass("icon_arrow_close_grn");
        },

        closeArrowIcon: function () {
            if (this.$arrow_icon.length === 0) {
                return;
            }
            this.$arrow_icon.addClass("icon_arrow_close_grn");
            this.$arrow_icon.removeClass("icon_arrow_open_grn");
        },

        /**
         *
         * @return {boolean}
         */
        hasPopup: function (){
            return this.$has_popup_tree_item.length !== 0;
        },
        /**
         *
         * @return {boolean}
         */
        isExpanded: function () {
            if (!this.hasPopup()){
                return false;
            }
            return (this.$has_popup_tree_item.attr("aria-expanded") === "true");
        }
    };
})(jQuery);
