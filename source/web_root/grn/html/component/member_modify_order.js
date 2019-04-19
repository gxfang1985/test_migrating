(function ($) {
    "use strict";
    grn.base.namespace("grn.component.member_modify_order");
    var member_modify_order = grn.component.member_modify_order;
    var instances = {};

    /**
     *
     * @param name
     * @param form_name
     * @param member_list_name
     * @constructor
     */
    member_modify_order.MemberModifyOrder = function (name, form_name, member_list_name) {

        this.name = name;
        this.memberListName = member_list_name;
        this.memberList = new grn.component.member_select_list.MemberSelectList(this.memberListName, {isCalendar: false});
        this.formName = form_name;

        var self = this;
        $(function () {
            self.init();
        });
        instances[name] = this;
    };

    /**
     *
     * @param {string} name
     * @return MemberModifyOrder
     */
    member_modify_order.get_instance = function (name) {
        return instances[name];
    };

    member_modify_order.MemberModifyOrder.prototype = {
        init: function () {
            var self = this;

            $("#" + self.memberListName + "_order_top").on("click", function () {
                self.memberList.orderTop();
            });
            $("#" + self.memberListName + "_order_up").on("click", function () {
                self.memberList.orderUp();
            });
            $("#" + self.memberListName + "_order_down").on("click", function () {
                self.memberList.orderDown();
            });
            $("#" + self.memberListName + "_order_bottom").on("click", function () {
                self.memberList.orderBottom();
            });
        },
        prepareSubmit: function () {
            var form = document.forms[this.formName];
            var order = form.elements[this.memberListName];

            var order_list = [];
            var src = this.memberList.getList().toArray();
            src.forEach(function (option) {
                var value = $(option).attr("data-value");
                if (!value) {
                    return;
                }
                order_list.push(value);
            });
            order.value = order_list.join(":");
        }
    };

})(jQuery);