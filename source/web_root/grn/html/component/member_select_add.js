(function ($) {
    "use strict";
    grn.base.namespace("grn.component.member_select_add");
    var member_select_add = grn.component.member_select_add;

    member_select_add.addMember = function (select_list_id) {
        var form = document.forms['list'];

        var selected_data_values = jQuery('#' + select_list_id).find("li.selectlist_selected_grn").map(function () {
            return jQuery(this).attr("data-value");
        }).get();
        var aid_array = [];
        selected_data_values.forEach(function (val, index, ar) {
            var prefix = val.substr(0, 1);
            if (prefix === 'r') {
                aid_array[index] = 'static_role:' + val.substr(1);
            }
            else if (prefix === 'g') {
                aid_array[index] = 'group:' + val.substr(1);
            } else {
                aid_array[index] = 'user:' + val;
            }
        });

        var select = jQuery('#aid');
        jQuery.each(aid_array, function (value, name) {
            var option = jQuery('<option>').val(name).prop('selected', true);
            select.append(option);
        });

        jQuery('<input>').attr({
            name: 'add',
            value: '1',
            style: 'display:none'
        }).appendTo(form);
        var search_text = $("#searchbox-keyword-user").find(".input-text-cybozu");
        if (search_text.text().length !== 0)
        {
            jQuery('<input>').attr({
                name: 'is_search',
                value: '1',
                style: 'display:none'
            }).appendTo(form);
        }

        form.submit();
    };

    member_select_add.removeMember = function (select_list_id) {
        var form = document.forms['list'];

        var selected_data_values = jQuery('#' + select_list_id).find("li.selectlist_selected_grn").map(function () {
            return jQuery(this).attr("data-value");
        }).get();
        var rid_array = [];
        selected_data_values.forEach(function (val, index, ar) {
            var prefix = val.substr(0, 1);
            if (prefix === 'r') {
                rid_array[index] = 'static_role:' + val.substr(1);
            }
            else if (prefix === 'g') {
                rid_array[index] = 'group:' + val.substr(1);
            } else {
                rid_array[index] = 'user:' + val;
            }
        });

        var select = jQuery('#rids');
        jQuery.each(rid_array, function (value, name) {
            var option = jQuery('<option>').val(name).prop('selected', true);
            select.append(option);
        });

        jQuery('<input>').attr({
            name: 'remove',
            value: '1',
            style: 'display:none'
        }).appendTo(form);
        var search_text = $("#searchbox-keyword-user").find(".input-text-cybozu");
        if (search_text.text().length !== 0)
        {
            jQuery('<input>').attr({
                name: 'is_search',
                value: '1',
                style: 'display:none'
            }).appendTo(form);
        }

        form.submit();
    };

    member_select_add.search = function () {
        var form = document.forms['list'];
        jQuery('<input>').attr({
            name: 'is_search',
            value: '1',
            style: 'display:none'
        }).appendTo(form);

        form.submit();
    };

})(jQuery);