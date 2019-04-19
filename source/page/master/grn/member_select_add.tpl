{*
 *  User select screen（Multiple users）
 *
 *  @param  boolean can_select_role Can select Role
 *  @param  string  target          Group/User or Role
 *  @param  string  poid            Current organization ID
 *  @param  array   org             Current organization
 *  @param  boolean is_root         Current organization is whether top
 *  @param  array   ous_params      Page parameters
 *  @param  array   user_list       Candidate user list
 *  @param  array   role_list       Candidate role list
 *  @param  array   navi_info       Navigation infomation
 *  @param  array   selected_list   Selected item list
 *}
{grn_load_javascript_resource}
{grn_load_javascript file="grn/html/component/member_select_list.js"}
{grn_load_javascript file="grn/html/component/member_select_add.js"}
{capture name="candidate_list"}aid{/capture}
{capture name="selected_list"}rids{/capture}
<script type="text/javascript">
    <!--
    {literal}
    new grn.component.member_select_list.MemberSelectList("aid", {
        isScrollToAdd: true,
        isNeedScroll: "{/literal}{$is_need_scroll}{literal}",
        ajaxGetMemberListUrl: "grn/ajax/get_more_member_select_list",
        parameterForGetMoreMember: {{/literal}
            poid: "{$poid}",
            prid: "{$prid}",
            menu: "{$target}",
            is_search: "{$is_search}",
            selected_tab: "{$selected_tab}",
            is_system: "{$is_system}",
            show_group_role: "{$show_group_role}",
            s_oid: "{$s_oid}",
            s_rid: "{$s_rid}",
            org_id: "{$org_id}",
            searchword: "{$searchword}",
            is_search_result: "{$is_search_result}",
            more_user_offset: "{$more_user_offset}",
            more_user_limit: "{$more_user_limit}",
            app_id: "{$app_id}"{literal}
        }
    });
    new grn.component.member_select_list.MemberSelectList("rids", {
        isScrollToAdd: true,
        isNeedScroll: "{/literal}{$is_need_scroll}{literal}",
        ajaxGetMemberListUrl: "grn/ajax/get_more_member_select_list",
        parameterForGetMoreMember: {{/literal}
            poid: "{$poid}",
            prid: "{$prid}",
            menu: "{$target}",
            is_search: "{$is_search}",
            selected_tab: "{$selected_tab}",
            is_system: "{$is_system}",
            show_group_role: "{$show_group_role}",
            s_oid: "{$s_oid}",
            s_rid: "{$s_rid}",
            org_id: "{$org_id}",
            searchword: "{$searchword}",
            is_search_result: "{$is_search_result}",
            more_user_offset: "{$more_user_offset}",
            more_user_limit: "{$more_user_limit}",
            app_id: "{$app_id}"{literal}
        }
    });
    {/literal}
    //-->
</script>

<form method="post" action="{grn_pageurl page=$page_info.all}" name="list">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="search_text" value="{$search_text|escape}">
    <input type="hidden" name="menu" value="{$target|escape}">
    <input type="hidden" name="poid" value="{$poid|escape}">
    <input type="hidden" name="prid" value="{$prid|escape}">
    <input type="hidden" name="is_search" value="{$is_search|escape}">
    <input type="hidden" name="is_search_result" value="{$is_search_result|escape}">
    {foreach from=$ous_params key=key item=item}
        <input type="hidden" name="{$key|escape}" value="{$item|escape}">
    {/foreach}
    <div style="display: none;">
        <select id="aid" name="aid[]" multiple style="width:100%"></select>
        <select id="rids" name="rids[]" multiple style="width:100%"></select>
    </div>

    {include file="grn/member_select.tpl" is_popup=false permission_to_select_role=$permission_to_select_role require_role_tab=true is_system=$is_system}

</form>

{if $target != 'role'}
    <script language="JavaScript">
        <!--

        var treeName = 'org_tree';
        var asyncURL = '{grn_pageurl page=$json_page}';
        var pageName = '{$page_name|escape:"url"}';
        var linkURL  = '{grn_pageurl page=$page_info.all params=$ous_params}';

        {if $poid}
        var selectedOID = '{$poid|escape:javascript}';
        {else}
        var selectedOID = 0;
        {/if}

        var orgTree = new YAHOO.grn.orgTree(treeName, asyncURL, pageName, linkURL, selectedOID);
        orgTree.setOidKey( 'poid');
        var treeData = {include org=$tree_org file='grn/org_json.tpl'};
        setTreeHeight('tree_view', 'tree_view_right');

        {literal}

        function createExternalNodes() {
            var tree = orgTree.getTree();
            var root = tree.getRoot();

            orgTree.createNode(root, -2, '{/literal}{cb_msg module='grn.grn' key='GRN_GRN-1004' replace='true'}{literal}', 0);

            tree.draw();
        }
        jQuery(window).on('load', function () {
            orgTree.init(treeData);
            createExternalNodes();
        });
        {/literal}


        //-->
    </script>
{/if}