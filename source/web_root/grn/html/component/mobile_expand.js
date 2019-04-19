(function ($) {
    "use strict";
    if (grn.base.isNamespaceDefined("grn.component.mobile_expand")) {
        return;
    }
    grn.base.namespace("grn.component.mobile_expand");
    var mobile_expand = grn.component.mobile_expand;
    var instances = {};

    /**
     * @param name
     * @constructor
     */
    mobile_expand.MobileExpand = function (name) {

        this.name = name;

        var self = this;
        $(function () {
            self.init(name);
        });
        instances[name] = this;
    };

    /**
     * @param name
     * @return MobileExpand
     */
    mobile_expand.get_instance = function (name) {
        return instances[name];
    };

    mobile_expand.MobileExpand.prototype = {
        init: function () {
            var self = this;
            $("#" + this.name + "_mobile_expand_link").on("click", function () {
                self.expand();
            });
        },
        expand: function () {
            $("#" + this.name + "_mobile_expand_contents").toggle();
            $("#" + this.name + "_mobile_expand_icon").toggleClass('mobile_arrow_inline_up_grn mobile_arrow_inline_down_grn');
        }
    };
})(jQuery);