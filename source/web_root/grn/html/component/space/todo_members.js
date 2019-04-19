(function ($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.component.space.todo_members")) {
        return;
    }
    grn.base.namespace("grn.component.space.todo_members");
    var todo_members = grn.component.space.todo_members;
    var instances = {};

    /**
     * @param name
     * @constructor
     */
    todo_members.TodoMembers = function (name) {

        this.name = name;

        var self = this;
        $(function () {
            self.init();
        });
        instances[name] = this;
    };

    /**
     * @param name
     * @return TodoMembers
     */
    todo_members.get_instance = function (name) {
        return instances[name];
    };

    todo_members.TodoMembers.prototype = {
        init: function () {
            var $users = $("#" + this.name + "_no_space_member_users");
            $users.hide();

            var self = this;
            $("#" + self.name + "_no_space_member_opener").on("click", function () {
                $("#" + self.name + "_no_space_member_icon_inline").toggleClass("icon_show_element_b_grn icon_hide_element_b_grn");
                $users.toggle();
            });
        }
    }

})(jQuery);