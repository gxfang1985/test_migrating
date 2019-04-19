(function ($) {
    "use strict";
    grn.base.namespace("grn.component.popup_member_select");
    var popup_member_select = grn.component.popup_member_select;

    /**
     *
     * @param member_list_name
     * @param candidate_list_Name
     * @param is_need_scroll
     * @param params_to_get_more_members
     * @constructor
     */
    popup_member_select.PopupMemberSelect = function (member_list_name, candidate_list_Name, is_need_scroll, params_to_get_more_members) {
        this.memberListName = member_list_name;
        this.memberList = new grn.component.member_select_list.MemberSelectList(this.memberListName, {
            isScrollToAdd: true,
            isNeedScroll: is_need_scroll,
            ajaxGetMemberListUrl: "grn/ajax/get_more_member_select_list_in_popup",
            parameterForGetMoreMember: params_to_get_more_members
        });
        this.candidateListName = candidate_list_Name;
        this.candidateList = new grn.component.member_select_list.MemberSelectList(this.candidateListName, {
            isScrollToAdd: true,
            isNeedScroll: is_need_scroll,
            ajaxGetMemberListUrl: "grn/ajax/get_more_member_select_list_in_popup",
            parameterForGetMoreMember: params_to_get_more_members
        });
    };


    popup_member_select.search = function (form, tab) {
        form["select_func"].value = 'browse';
        if (tab === 'user') {
            form.s_oid.value = -1;
            form.s_rid.value = 0;
        } else if (tab === 'role') {
            form.s_oid.value = 0;
            form.s_rid.value = -1;
        } else {
            form.s_oid.value = -1;
            form.s_rid.value = 0;
        }

        form.submit();
    };

    popup_member_select.addMember = function (select_list_id) {

        var form = document.forms["list"];
        var selected_users = form.elements["selected_users_c_id"];
        selected_users.value = $('#' + select_list_id).find("li.selectlist_selected_grn").map(function () {
            return $(this).attr("data-value");
        }).get().join(',');

        form["select_func"].value = "add";
        form.submit();
    };

    popup_member_select.removeMember = function (selected_list_id) {

        var form = document.forms["list"];
        var remove_users = form.elements["selected_users_s_id"];
        remove_users.value = $('#' + selected_list_id).find("li.selectlist_selected_grn").map(function () {
            return $(this).attr("data-value");
        }).get().join(',');

        form["select_func"].value = "remove";
        form.submit();
    };

    popup_member_select.apply = function () {
        var form = document.forms["list"];

        form["select_func"].value = "apply";
        form.submit();

    };

    popup_member_select.reflectToParentWindow = function (params) {
        $(document).ready(function () {
            new grn.component.member_add.MemberAdd(params.name, params.form_name, [params.member_list_name], params.candidate_list_Name,
                {
                    isPopup: true,
                    appId: params.appId,
                    isCalendar: params.isCalendar,
                    includeOrg: params.includeOrg,
                    accessPlugin: params.accessPlugin,
                    pluginSessionName: params.pluginSessionName,
                    pluginDataName: params.pluginDataName,
                    ajax_url: params.ajax_url
                }
            );
            var member_add = grn.component.member_add.get_instance(params.name);
            member_add.candidateList.selectAllMembers();

            var opener_grn_component = window.opener.grn.component;
            var parent_member_add = opener_grn_component.member_add.get_instance(params.name);
            if (parent_member_add && parent_member_add.operatorAddName) {
                member_add.operatorAddName = parent_member_add.operatorAddName;
            }

            if (params.ajax_url == "") {
                var to_list = opener_grn_component.member_select_list.get_instance(params.member_list_name);
                member_add.addMembers(to_list, member_add.candidateList);
                window.close();
            } else {
                member_add.updateTargetList(member_add.candidateList);
            }
        });
    };

})(jQuery);