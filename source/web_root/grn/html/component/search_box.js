(function ($) {
    "use strict";
    grn.base.namespace("grn.component.search_box");
    var search_box = grn.component.search_box;
    var instances = {};
    search_box.SearchBox = function (id) {
        this.firstFlag = true;
        this.$textField = $("#keyword_" + id);
        this.defaultText = ( this.$textField.length ) ? this.$textField.val() : null;
        this.init();
        instances[id] = this;
    };

    /**
     *
     * @param id
     * @returns {SearchBox}
     */
    search_box.get_instance = function (id) {
        return instances[id];
    };
    search_box.SearchBox.prototype = {
        clearSearchHint: function () {
            if (!this.firstFlag) {
                return true;
            }
            this.$textField.val('');
            this.$textField.removeClass('prefix-grn');
            this.firstFlag = false;
        },

        init: function () {
            var self = this;
            if (this.$textField.length) {
                this.$textField.on('focus', function () {
                    self.clearSearchHint();
                });

                this.$textField.blur(function () {
                    if (self.$textField.val() === '') {
                        self.$textField.val(self.defaultText);
                        self.$textField.addClass('prefix-grn');
                        self.firstFlag = true;
                    }
                });
            }
        }
    };

    $(function () {
        var $arrSearchBox = $('.searchbox-keyword-area');
        $.each($arrSearchBox, function (index, target) {
            var id = $(target).attr("id").split("searchbox-cybozu-")[1];
            new search_box.SearchBox(id);
        });
    });
})(jQuery);