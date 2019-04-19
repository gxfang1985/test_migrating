(function ($) {
    "use strict";

    grn.base.namespace("grn.component.space.thread_move.folder_tree");

    var FolderTree = grn.component.space.thread_move.folder_tree;

    FolderTree.init = function (settings) {
        this.tree = settings.treeObj;
        this.container = $(settings.treeContainer);

        this._event = $({});

        // change html
        this.container.removeClass("tree-view");
        this.container.find("#folder_tree")
            .addClass("tree_style1_grn")
            .wrap("<div class='tree_folder_only_grn'></div>");

        this.container.find(".ygtvitem").each(function () {
            if ($(this).children().get(0).nodeName === "TABLE") {
                var table_obj = $(this).children("table");
                table_obj.addClass("menu_unselect_grn");
            }
        });

        this.container.find("div.tree-select-current").closest("table").addClass("menu_selected_grn").removeClass("menu_unselect_grn");

        this.bindEvents();
    };

    FolderTree.on = function (eventName, callback) {
        this._event.on(eventName, callback);
    };

    FolderTree.bindEvents = function () {
        this.container.on("click", "tr", function (event) {
            var target = jQuery(event.currentTarget);
            target.find("a")[1].click();
        });
    };

    FolderTree.handleSelectFolder = function (oid) {
        this.highlightFolder(oid);

        this._event.trigger("folder_change", oid);
    };

    FolderTree.highlightFolder = function (oid) {
        this.container.find(".menu_selected_grn").removeClass("menu_selected_grn").addClass("menu_unselect_grn");
        this.tree.selectNode(oid);

        this.container.find("div.tree-select-current").closest("tr").find("a")[0].blur();
        this.container.find("div.tree-select-current").closest("table").addClass("menu_selected_grn").removeClass("menu_unselect_grn");
        this.container.find("a.ygtvspacer").attr("href", 'javascript:void(0);');
    };
})(jQuery);