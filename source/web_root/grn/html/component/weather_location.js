(function ($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.component.location_tree")) {
        return;
    }
    grn.base.namespace("grn.component.location_tree");
    var location_tree = grn.component.location_tree;

    var TreeItem = grn.component.tree_item.TreeItem;

    var KEY_CODE = {
        TAB: 9,
        ENTER: 13,
        SPACE: 32,
        LEFT: 37,
        UP: 38,
        RIGHT: 39,
        DOWN: 40
    };

    /**
     * @type {string}
     *
     * @const
     */
    var HAS_POPUP_TREE_LABEL = "has_popup_tree_label";

    /**
     * @type {string}
     *
     * @const
     */
    var TREE_ITEM = "treeitem";

    /**
     * @type {string}
     *
     * @const
     */
    var PREFECTURE_ITEM = "prefecture_item";

    /**
     * @type {string}
     *
     * @const
     */
    var POINT_ITEM = "point_item";

    /**
     * @type {string}
     *
     * @const
     */
    var CHECKBOX = "checkbox_base_grn";


    /**
     * @type {string}
     *
     * @const
     */
    var LI_POINT = "li_point";

    /**
     *
     * @param {string} id
     * @constructor
     */
    location_tree.LocationTree = function (id) {
        var self = this;
        this.id = id;
        this.focused_id = null;
        $(function () {
            self.init();
        });
    };

    location_tree.LocationTree.prototype = {
        init: function () {
            this.onCheckbox();
            this.onRegionTreeNode();
        },

        onRegionTreeNode: function () {
            var $tree_items = $("." + TREE_ITEM);
            $tree_items.on("blur", function () {
                self.focused_id = null;
            });

            $("." + HAS_POPUP_TREE_LABEL).on("click", function () {
                var tree_item = new TreeItem($(this).parent("." + TREE_ITEM));
                tree_item.toggleTree();
                return false;
            });

            $(".region_item").on("click", function () {
                if ($(this).attr("id") !== self.focused_id) {
                    return;
                }
                var tree_item = new TreeItem($(this));
                tree_item.toggleTree();
            });

            $tree_items.on("click", function () {
                self.focused_id = $(this).attr("id");
            });

            var self = this;
            $("#" + this.id).on("keydown", function (event) {
                var key_code = event.keyCode;
                var $elem = $(":focus");
                var is_checkbox = $elem.attr("type") === "checkbox";
                if (is_checkbox) {
                    $elem = $elem.parents("." + POINT_ITEM);
                } else {
                    var is_tree_item = $elem.hasClass(TREE_ITEM);
                    if (!is_tree_item) {
                        return true;
                    }
                }

                switch (key_code) {
                    case KEY_CODE.ENTER:
                    case KEY_CODE.SPACE:
                        return self.spaceAndEnterHandle($elem);
                    case KEY_CODE.RIGHT:
                        self.rightHandle($elem);
                        event.preventDefault();
                        return false;
                    case KEY_CODE.LEFT:
                        self.leftHandle($elem);
                        event.preventDefault();
                        return false;
                    case KEY_CODE.UP:
                        self.selectPreviousTreeItem($elem);
                        event.preventDefault();
                        return false;
                    case KEY_CODE.DOWN:
                        self.selectNextTreeItem($elem, false);
                        event.preventDefault();
                        return false;
                    case KEY_CODE.TAB:
                        if (event.shiftKey) {
                            return !self.selectPreviousTreeItem($elem);
                        } else {
                            return !self.selectNextTreeItem($elem, true);
                        }
                }
                return true;
            });
        },

        onCheckbox: function () {
            var self = this;
            $("." + CHECKBOX).on("click", function () {
                self.toggleAriaChecked($(this));
            });
        },

        /**
         * @return {jQuery}
         */
        findAllTreeItems: function () {
            return $("#" + this.id).find("." + TREE_ITEM + ":visible");
        },

        /**
         *
         * @param {jQuery} $tree
         * @return {boolean}
         */
        selectPreviousTreeItem: function ($tree) {
            var $tree_items = this.findAllTreeItems();
            var index = $tree_items.index($tree);
            if (index === -1 || index === 0) { //Not found || the tree item is the first one.
                return false;
            }
            this.focusTreeItem($($tree_items.get(index - 1)));
            return true;
        },

        /**
         *
         * @param {jQuery} $tree
         * @param {boolean} is_tab
         *
         * @return {boolean}
         */
        selectNextTreeItem: function ($tree, is_tab) {
            var $tree_items = this.findAllTreeItems();
            var index = $tree_items.index($tree);
            if (index === -1) { //Not found
                return false;
            }
            var is_last_item = (index === $tree_items.length - 1);
            if (is_last_item) {
                if (is_tab && this.isPointItem($tree)) {
                    this.focusTreeItem($tree_items.find("input"));
                }
                return false;
            }
            this.focusTreeItem($($tree_items.get(index + 1)));
            return true;
        },

        /**
         *
         * @param {jQuery} $check_box_item
         */
        toggleCheck: function ($check_box_item) {
            var $check_box = $check_box_item.find("input");
            var new_state = !$check_box.prop("checked");
            $check_box.prop("checked", new_state);
            $check_box_item.attr("aria-checked", new_state);
        },

        /**
         *
         * @param {jQuery} $check_box_base
         */
        toggleAriaChecked: function ($check_box_base) {
            var $check_box = $check_box_base.find("input");
            var $check_box_item = $check_box_base.parents("." + POINT_ITEM);
            var checked = $check_box.prop("checked");
            $check_box_item.attr("aria-checked", checked);
        },

        focusTreeItem: function ($tree_item) {
            $tree_item.focus();
            this.focused_id = $tree_item.attr("id");
        },
        /**
         *
         * @param {jQuery} $tree_item
         */
        selectParentRegion: function ($tree_item) {
            this.focusTreeItem($tree_item.parent().parent());
        },

        /**
         *
         * @param {jQuery} $tree_item
         */
        selectChildPoint: function ($tree_item) {
            this.focusTreeItem($tree_item.find("." + LI_POINT + ":first-child").find("." + POINT_ITEM));
        },

        /**
         *
         * @param {jQuery} $tree_item
         */
        selectChildPrefecture: function ($tree_item) {
            this.focusTreeItem($tree_item.find("." + PREFECTURE_ITEM + ":first-child"));
        },

        /**
         *
         * @param {jQuery} $tree_item
         * @return {boolean}
         */
        selectSiblingPoint: function ($tree_item) {
            var $next = $tree_item.parents("." + LI_POINT).next("." + LI_POINT).find("." + POINT_ITEM);
            if ($next.length !== 0) {
                this.focusTreeItem($next);
                return true;
            }
            return false;
        },

        /**
         *
         * @param {jQuery} $tree_item
         * @return {boolean}
         */
        isPrefectureItem: function ($tree_item) {
            return $tree_item.hasClass(PREFECTURE_ITEM);
        },

        /**
         *
         * @param {jQuery} $tree_item
         * @return {boolean}
         */
        isPointItem: function ($tree_item) {
            return $tree_item.hasClass(POINT_ITEM);
        },

        /**
         *
         * @param {jQuery} $tree_item
         * @return {boolean}
         */
        spaceAndEnterHandle: function ($tree_item) {
            var tree_item = new TreeItem($tree_item);
            if (tree_item.hasPopup()) {
                tree_item.toggleTree();
                return false;
            }
            if (this.isPointItem($tree_item)) {
                this.toggleCheck($tree_item);
                return false;
            }
            return true;
        },

        /**
         *
         * @param {jQuery} $tree_item
         */
        rightHandle: function ($tree_item) {
            var tree_item = new TreeItem($tree_item);
            if (tree_item.hasPopup()) {
                if (tree_item.isExpanded()) {
                    this.selectChildPrefecture($tree_item);
                    return;
                }
                tree_item.openTree();
                return;
            }
            if (this.isPrefectureItem($tree_item)) {
                this.selectChildPoint($tree_item);
                return;
            }
            if (this.isPointItem($tree_item)) {
                this.selectSiblingPoint($tree_item);
            }
        },

        /**
         *
         * @param {jQuery} $tree_item
         */
        leftHandle: function ($tree_item) {
            var tree_item = new TreeItem($tree_item);
            if (tree_item.hasPopup()) {
                tree_item.closeTree();
                return;
            }
            if (this.isPrefectureItem($tree_item)) {
                this.selectParentRegion($tree_item);
                return;
            }
            if (this.isPointItem($tree_item)) {
                this.selectPreviousTreeItem($tree_item);
            }
        }
    };
})(jQuery);
