(function ($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.component.space.todo_out_of_members")) {
        return;
    }
    grn.base.namespace("grn.component.space.todo_out_of_members");
    var todo_out_of_members = grn.component.space.todo_out_of_members;
    var instances = {};

    /**
     * @param name
     * @constructor
     */
    todo_out_of_members.TodoOutOfMembers = function (name, space_id) {

        this.name = name;
        this.space_id = space_id;

        var self = this;
        $(function () {
            self.init();
        });
        instances[name] = this;
    };

    /**
     * @param name
     * @return TodoOutOfMembers
     */
    todo_out_of_members.get_instance = function (name) {
        return instances[name];
    };

    todo_out_of_members.TodoOutOfMembers.prototype = {
        init: function () {
            var $spinner = $("#" + this.name + "_spinner");
            $spinner.hide();

            var self = this;

            $("a#" + self.name + "_opener").on("click", function () {

                $spinner.show();

                var isOpen = $("#" + self.name + "_opener").hasClass("show_element_grn");
                if (isOpen) {
                    $("#" + self.name + "_opener").hide();
                    $("#" + self.name + "_opener").toggleClass("show_element_grn hide_element_grn");

                    var post_data = {
                        spid: self.space_id
                    };

                    var ajaxRequest = new grn.component.ajax.request(
                        {
                            url: grn.component.url.page('space/application/todo/ajax/get_space_out_of_members'),
                            method: "post",
                            dataType: "json",
                            data: post_data
                        });

                    ajaxRequest.send().done(function (json_obj) {
                        $("#" + self.name + "_left_member_list").append(json_obj.SpaceOutOfMembers);
                        $("#" + self.name + "_opener").show();
                        $spinner.hide();
                    }.bind(this));
                } else {
                    $("#" + self.name + "_left_member_list").empty()
                    $("#" + self.name + "_opener").toggleClass("show_element_grn hide_element_grn");
                    $spinner.hide();
                }

            });

        }
    }

})(jQuery);