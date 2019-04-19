grn.base.namespace("grn.page.space.system.common_set");
(function ($) {
    var G = grn.page.space.system.common_set;
    var url;
    var onForest;
    G.selectors = {
        "unlimited_setting": "#allow_unlimited",
        "unlimited": "#unlimited",
        "for_unlimited": "label[for = 'unlimited']",
        "limited": "#limited",
        "for_limited": "label[for = 'limited']",
        "default_public_limited": "#default_public_limited"
    };

    G.init = function () {
        this.cache();
        this.bindEvent();
    };

    G.cache = function () {
        this.$container = $("table.std_form");
    };

    G.bindEvent = function () {
        this.$container.find(this.selectors.unlimited_setting).off("change").on("change", $.proxy(this.allowUnlimitedSetting, this));
        this.$container.find(this.selectors.unlimited).off("click").on("click", $.proxy(this.changeUnlimited, this));
        this.$container.find(this.selectors.limited).off("click").on("click", $.proxy(this.changeLimited, this));
    };

    G.changeUnlimited = function (e) {
        var self = this;
        var is_checked = $(e.currentTarget).prop("checked");
        self.$container.find(self.selectors.limited).prop("checked", !is_checked);
        self.$container.find(self.selectors.default_public_limited).attr("disabled", true);
    };

    G.changeLimited = function (e) {
        var self = this;
        var isChecked = $(e.currentTarget).prop("checked");
        self.$container.find(self.selectors.unlimited).prop("checked", !isChecked);
        self.$container.find(self.selectors.default_public_limited).prop("disabled", false);
    };

    G.allowUnlimitedSetting = function () {
        var unlimited_setting_value = this.$container.find(this.selectors.unlimited_setting).prop("checked");
        if (unlimited_setting_value) {
            this.$container.find(this.selectors.for_unlimited).removeClass("form_disable")
                .attr("onmouseover", "this.style.color='#ff0000'")
                .attr("onmouseout", "this.style.color = ''");
            this.$container.find(this.selectors.for_limited).removeClass("form_disable")
                .attr("onmouseover", "this.style.color='#ff0000'")
                .attr("onmouseout", "this.style.color = ''");
        } else {
            this.$container.find(this.selectors.for_unlimited)
                .addClass("form_disable")
                .removeAttr("onmouseover onmouseout");
            this.$container.find(this.selectors.for_limited)
                .addClass("form_disable")
                .removeAttr("onmouseover onmouseout");
            this.$container.find(this.selectors.limited).prop("checked", true);
            this.$container.find(this.selectors.unlimited).prop("checked", false);
            this.$container.find(this.selectors.default_public_limited).prop("disabled", false);
        }
        this.$container.find(this.selectors.unlimited).attr("disabled", !unlimited_setting_value);
    };

    G.onClickRadio = function () {
        if( jQuery("#use_kintone_use").prop("checked") )
        {
            jQuery("#url").val(G.url);
            if( G.onForest != 1 )
                jQuery("#url").prop("disabled", false);
        }
        else
        {
            jQuery("#url").val("");
            if( G.onForest != 1 )
                jQuery("#url").prop("disabled", true);
        }
    };
})(jQuery);

jQuery(document).ready(function () {
    var space_common_set = grn.page.space.system.common_set;
    space_common_set.init();
    space_common_set.allowUnlimitedSetting();
});
