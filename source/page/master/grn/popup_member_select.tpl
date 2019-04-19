{if $url_params.system_display}
    {include file="grn/popup_system_head.tpl"}
{else}
    {include file="grn/popup_head.tpl"}
{/if}
{capture name="selected_list"}popup_{$url_params.select_name}{/capture}
{capture name="candidate_list"}popup_CID{/capture}
{grn_load_javascript file="grn/html/component/popup_member_select.js"}
{grn_load_javascript file="grn/html/component/member_select_list.js"}
{grn_load_javascript file="grn/html/component/member_add.js"}
{grn_load_javascript file="grn/html/component/button.js"}
{if $url_params.ajax_url != ''}
    {include file='grn/component/ajax.tpl'}
{/if}
<script language="JavaScript" type="text/javascript">
<!--
new grn.component.popup_member_select.PopupMemberSelect("{$smarty.capture.selected_list}",
        "{$smarty.capture.candidate_list}", "{$is_need_scroll}", {ldelim}
            selected_tab: "{$selected_tab}",
            no_multiple: "{$url_params.no_multiple}",
            select_name: "{$url_params.select_name}",
            system: "{$url_params.system}",
            system_display: "{$url_params.system_display}",
            item_data_name: "{$url_params.item_data_name}",
            item_session_name: "{$url_params.item_session_name}",
            multi_apply: "{$url_params.multi_apply}",
            plid: "{$url_params.plid}",
            show_group_role: "{$url_params.show_group_role}",
            require_role_tab: "{$require_role_tab}",
            item_group_id: "{$url_params.item_group_id}",
            return_page: "{$url_params.return_page}",
            send_cgi_parameter: "{$url_params.send_cgi_parameter}",
            form_name: "{$page_name}",
            member_list_name: "{$url_params.select_name}",
            selected_list: "{$smarty.capture.selected_list}",
            app_id: "{$url_params.app_id}",
            s_oid: "{$s_oid}",
            s_rid: "{$s_rid}",
            org_id: "{$org_id}",
            is_calendar: "{$url_params.is_calendar}",
            include_org: "{$url_params.include_org}",
            plugin_session_name: "{$url_params.plugin_session_name}",
            plugin_data_name: "{$url_params.plugin_data_name}",
            searchword: "{$url_params.searchword}",
            is_search_result: "{$is_search_result}",
            more_user_offset: "{$more_user_offset}",
            more_user_limit: "{$more_user_limit}",
            require_dynamic_roles: "{$url_params.require_dynamic_roles}",
            require_administrator_role: "{$url_params.require_administrator_role}",
            ajax_url: "{$url_params.ajax_url}",
            selected_tid : "{$url_params.selected_tid}"
            {rdelim});

{if $select_func == 'apply'}
grn.component.popup_member_select.reflectToParentWindow(
    {ldelim}
        name: "{$url_params.select_name}",
        form_name: "{$page_name}",
        member_list_name: "{$url_params.select_name}",
        candidate_list_Name: "{$smarty.capture.selected_list}",
        appId: "{$url_params.app_id}",
        isCalendar: "{$url_params.is_calendar}",
        includeOrg: "{$url_params.include_org}",
        accessPlugin: true,
        pluginSessionName: "{$url_params.plugin_session_name}",
        pluginDataName: "{$url_params.plugin_data_name}",
        reflect_to_additional_name: "{$url_params.reflect_to_additional_name}",
        ajax_url: "{$url_params.ajax_url}"
    {rdelim}
);
{/if}
//-->
</script>

<form name="list" method="POST" action="{grn_pageurl page='grn/popup_member_select'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    {foreach from=$url_params item=param key=key}
        <input type="hidden" name="{$key}" value="{$param|escape}">
    {/foreach}
    <input type="hidden" name="select_func" value="{$select_func|escape}">
    <input type="hidden" name="selected_tab" value="{$selected_tab|escape}">
    <input type="hidden" name="s_oid" value="{$s_oid|escape}">
    <input type="hidden" name="org_id" value="{$org_id|escape}">

    <input type="hidden" name="selected_users_c_id" value=""/>
    <input type="hidden" name="selected_users_s_id" value=""/>

    <input type="hidden" name="s_rid" value="{$s_rid|escape}">

    <div class="popup_body1_grn">
        <div class="popup_body1_sub_grn">
            <!-- Header Start -->
            {include file="grn/popup_header.tpl"}
            <!-- Header End -->

            <div class="popup_content_grn multi_select_base_grn" style="width:1000px;">
                {include file="grn/member_select.tpl" is_popup=true require_role_tab=$require_role_tab is_system=$url_params.system}
    </div>

    {if ! $selected_tab }{** User selected **}
    <script language="JavaScript">
    <!--

        var treeName = 'org_tree';
        var asyncURL = '{grn_pageurl page='grn/popup_user_select_json'}';
        var pageName = '{$page_name|escape:"url"}';
        var linkURL = '{grn_pageurl page='grn/popup_member_select' select_func='browse' selected_tab=0 params=$url_params}';

        {if $org_id}
            var selectedOID = '{$org_id|escape:javascript}';
        {else}
            var selectedOID = 0;
        {/if}

        var orgTree = new YAHOO.grn.orgTree(treeName, asyncURL, pageName, linkURL, selectedOID);
        orgTree.setOidKey('s_oid');
        var treeData = {include org=$org file='grn/org_json.tpl'};

        setTreeHeight('tree_view', 'tree_view_right');

        {literal}

        function createExternalNodes() {
            var tree = orgTree.getTree();
            var root = tree.getRoot();
                orgTree.createNode(root, -2, '{/literal}{cb_msg module='grn.grn' key='GRN_GRN-229' replace='true'}{literal}', 0);
                tree.draw();
            }

            jQuery(window).on('load', function () {
                orgTree.init(treeData)
                createExternalNodes()
            });

        {/literal}

    //-->
    </script>
    {/if}

    <div class="popup_button_area_grn">
        <span class="button_grn_js button1_main_grn  button1_r_margin2_grn">
            {** That it does not format Start (Byte space cut by the new line between inline elements) **}
            <a role="button" href="#" onclick="grn.component.popup_member_select.apply('selectlist_base_selectlist_sUID')">{cb_msg module='grn.grn' key='GRN_GRN-241' replace='true'}</a></span><span class="button_grn_js button1_normal_grn"><a role="button" href="#" onclick="window.close();">{cb_msg module='grn.grn' key='GRN_GRN-243' replace='true'}</a>
            {** That it does not format End **}
        </span>
    </div>
</form>
