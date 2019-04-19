(function ($) {
    "use strict";

    grn.base.namespace("grn.component.space.thread_move.thread_list");

    var ThreadList = grn.component.space.thread_move.thread_list;

    ThreadList.init = function (settings) {
        this.threadListContainer = $(settings.threadListContainer);
        this.defaultList = this.threadListContainer.clone();

        this.emptyThreadListContainer = $(settings.emptyThreadListContainer);
    };

    ThreadList.setContent = function (content) {
        this.threadListContainer.html(content);
        this.threadListContainer.show();

        this.emptyThreadListContainer.hide();
    };

    ThreadList.setEmptyList = function(){
        this.emptyThreadListContainer.show();

        this.threadListContainer.empty();
        this.threadListContainer.html($(this.defaultList.html()));
    };

    ThreadList.getSelectedItems = function(){
        var selectedItems = [];

        this.threadListContainer.find("input[name='ids[]']:checked").each(function () {
            selectedItems.push($(this).prop('value'));
        });

        return selectedItems;
    };

    ThreadList.removeSelectedItems = function(){
        this.threadListContainer.find("input[name='ids[]']:checked").each(function () {
            $(this).closest("tr").fadeOut(function(){
                $(this).remove();
            });
        });
    };

    ThreadList.enableMoveFunction = function () {
        $(".selectmenu_base_grn").removeClass("selectmenu_disable_filter_grn");
        $(".js_button_change_to_other_space").removeClass("button_disable_filter_grn");
    };

    ThreadList.disableMoveFunction = function () {
        $(".selectmenu_base_grn").addClass("selectmenu_disable_filter_grn");
        $(".js_button_change_to_other_space").addClass("button_disable_filter_grn");
    };
})(jQuery);