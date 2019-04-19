grn.base.namespace('grn.page.folder_form');

(function () {
    grn.page.folder_form.access_dropdown = new grn.component.Dropdown_copy('access');
    grn.page.folder_form.notification_dropdown = new grn.component.Dropdown_copy('notification');
    grn.page.folder_form.access_dropdown.run();
    grn.page.folder_form.notification_dropdown.run();
})();
