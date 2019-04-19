(function ($) {
    "use strict";

    grn.base.namespace("grn.page.space.reuse");

    var G = grn.page.space.reuse;

    G.cssSelectors = {
        container: ".js_folder_disc_container",
        folder_discussion: ".js_folder_discussion",
        folder: ".js_folder",
        discussion: ".js_discussion"
    };

    G.KEY_WORDS = {
        CLICK: "click",
        INPUT: "input",
        CHECKED: "checked",
        DIV: "DIV"
    };

    G.init = function () {
        G.cacheElements();
        G._bindEvents();
    };

    G.cacheElements = function () {
        this.$container = $(this.cssSelectors.container);
    };

    G._bindEvents = function () {
        this.$container.on(this.KEY_WORDS.CLICK, this.cssSelectors.folder, $.proxy(this.selectFolder, this));
    };

    G.selectFolder = function (e) {
        var checkedList;
        if (e.target.nodeName === this.KEY_WORDS.DIV) {
            return;
        }

        checkedList = $(e.target)
            .closest(this.cssSelectors.folder_discussion)
            .find(this.cssSelectors.discussion)
            .find(this.KEY_WORDS.INPUT);

        if ($(e.target).prop(this.KEY_WORDS.CHECKED) === true) {

            checkedList.prop(this.KEY_WORDS.CHECKED, true);
        } else {
            checkedList.prop(this.KEY_WORDS.CHECKED, false);
        }
    };

    $(document).ready(function () {

        G.init();
    });
})(jQuery);

