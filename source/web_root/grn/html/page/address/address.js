grn.base.namespace("grn.page.address.address");

(function () {
    if(jQuery('#address_family_sort_key').length > 0 && jQuery('#address_given_sort_key').length > 0 && jQuery('#address_family_name').length > 0 && jQuery('#address_given_name').length > 0)
    {
        grn.component.auto_phonetic('address_family_name', 'address_family_sort_key');
        grn.component.auto_phonetic('address_given_name', 'address_given_sort_key');
    }
})();
