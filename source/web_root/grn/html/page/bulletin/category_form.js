grn.base.namespace("grn.page.category_form");

(function () {
    grn.page.category_form.access_dropdown = new grn.component.Dropdown_copy('access');
    grn.page.category_form.notification_dropdown = new grn.component.Dropdown_copy('notification');
    grn.page.category_form.access_dropdown.run();
    grn.page.category_form.notification_dropdown.run();
})();
