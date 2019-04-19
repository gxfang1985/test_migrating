(function ($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.component.operator_add")) {
        return;
    }
    grn.base.namespace("grn.component.operator_add");
    var operator_add = grn.component.operator_add;
    var instances = {};

    /**
     *
     * @param name
     * @param form_name
     * @param selected_list_name
     * @param candidate_list_Name
     * @param member_add_names
     * @constructor
     */
    operator_add.OperatorAdd = function (name, form_name, selected_list_name, candidate_list_Name, member_add_names) {
        var self = this;

        self.name = name;
        self.member_adds = {};
        member_add_names.forEach(function(member_add_name) {
            self.member_adds[member_add_name] = (grn.component.member_add.get_instance(member_add_name));
        });
        self.operator_add = grn.component.member_add.get_instance(name);

        instances[name] = self;
    };

    /**
     *
     * @param {string} name
     * @return MemberAdd
     */
    operator_add.get_instance = function (name) {
        return instances[name];
    };

    operator_add.OperatorAdd.prototype = {

        /**
         *
         * @param {string} member_add_name
         */
        addOperators: function (member_add_name) {
            var to = this.operator_add.candidateList;
            var member_lists = this.member_adds[member_add_name].memberLists;
            var from = member_lists[Object.keys(member_lists)[0]];
            this.operator_add.addMembers(to, from);
        },

        /**
         *
         * @param {jQuery} $member
         * @param {string} member_remove_name
         * @returns {boolean}
         */
        canDelete: function ($member, member_remove_name) {
            var selected_member_id = $member.prop("id");
            var can_delete = true;

            for (var idx in this.member_adds) {
                var member_add = this.member_adds[idx];
                if (!member_add) {
                    continue;
                }

                var member_list_name = member_add.getFirstMemberSelectList().shortListName;
                var member_id = selected_member_id.replace(member_remove_name, member_list_name);

                if (document.getElementById(member_id)) {
                    can_delete = false;
                    break;
                }
            }
            return can_delete;
        },

        /**
         *
         * @param {jQuery|HTMLElement|Array} remove_member_list
         * @param {string} member_list_name
         */
        removeOperators: function (remove_member_list, member_list_name) {
            var self = this;
            var o_member_list_name = this.operator_add.getFirstMemberSelectList().shortListName;
            var o_candidate_list_name = this.operator_add.candidateList.shortListName;

            remove_member_list.forEach(function (member) {
                var $member = $(member);
                if (self.canDelete($member, member_list_name)) {
                    var selected_member_id = $member.attr("id");
                    var o_member_id = selected_member_id.replace(member_list_name, o_member_list_name);
                    var o_candidate_id = selected_member_id.replace(member_list_name, o_candidate_list_name);

                    $("#" + o_member_id).remove();
                    $("#" + o_candidate_id).remove();
                }
            });
        }

    };
})(jQuery);