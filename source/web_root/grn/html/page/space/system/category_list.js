grn.base.namespace("grn.page.space.system.category_list");
(function ($) {
    var G = grn.page.space.system.category_list;
    G.selectors = {
        "filter_container": ".js_filter_container",
        "filter_command": ".js_filter_command",
        "filter_value": ".js_filter_value"
    };

    G.init = function () {
        this.cache();
        this.bindEvent();
    };

    G.cache = function () {
        this.$filter_container = $(this.selectors.filter_container);
        this.$filter_command = $(this.selectors.filter_command);
        this.$filter_value = $(this.selectors.filter_value);
    };

    G.bindEvent = function () {
        this.$filter_command.off("click").on("click", $.proxy(this.executeFilterSpace, this));
        this.$filter_value.off("change").on("change", $.proxy(this.executeFilterSpace, this));
    };

    G.executeFilterSpace = function (e) {
        e.preventDefault();

        var full_path = grn.component.url.parse(window.location.href);
        var query_params = grn.component.url.parseQueryString(full_path.search);

        query_params["filter_id"] = this.$filter_container.find(this.selectors.filter_value).val();
        query_params["sp"] = 0;

        window.location.href = full_path.pathname + "?" + grn.component.url.toQueryString(query_params);
    };

})(jQuery);

jQuery(document).ready(function () {
    var category_list = grn.page.space.system.category_list;
    category_list.init();
});
