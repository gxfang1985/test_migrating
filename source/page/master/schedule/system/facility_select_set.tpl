{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">
    <div id="rare_menu_part">
        {capture name='grn_schedule_system_GRN_SCH_SY_537'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-537' replace='true'}{/capture}
        {grn_link class='menu_item' image='reserve32.gif' page='schedule/system/facility_common_set' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_537}
    </div>
</div>
{include file='grn/org_tree.tpl'}

<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
    <tr valign="top">
        <td class="wrap-tree-view">
            <span class="tree-view-label">{cb_msg module='grn.grn' key='GRN_GRN-101' replace='true'}</span>
            <div id="tree_view" class="tree-view">
                {if $fgroup_id}
                    {capture name='grn_grn_GRN_GRN_102'}{cb_msg module='grn.grn' key='GRN_GRN-102' replace='true'}{/capture}{grn_link page=$link_page top=1 caption=$smarty.capture.grn_grn_GRN_GRN_102}
                {else}
                    {capture name='grn_grn_GRN_GRN_103'}{cb_msg module='grn.grn' key='GRN_GRN-103' replace='true'}{/capture}{grn_link page=$link_page top=1 caption=$smarty.capture.grn_grn_GRN_GRN_103 class='tree-select-current'}
                {/if}
                <div id="org_tree"></div>
            </div>
        </td>

        <td width="70%" id="tree_view_right" class="wrap-tree-view-right">
            {if ! $top}
                {if $fgroup_id && $fgroup_id > 0}
                    {if $app_id == 'schedule'}
                        <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-1086' replace='true'}</div>
                    {else}
                        <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-104' replace='true'}{grn_appname app_id=$app_id}</div>
                    {/if}
                    <table class="list_column">
                        <colgroup>
                            <col width="30%">
                            <col width="10%">
                            <col width="10%">
                            <col width="25%">
                            <col width="10%">
                            <col width="5%">
                            <col width="10%">
                        </colgroup>
                        <tr>
                            <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-105' replace='true'}</th>
                            <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-538' replace='true'}</th>
                            <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-539' replace='true'}</th>
                            <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-540' replace='true'}</th>
                            <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-541' replace='true'}</th>
                            <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-542' replace='true'}</th>
                            <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-606' replace='true'}</th>
                        </tr>
                        <tr>
                            <td>{grn_link image='facilitygroup20.gif' page="schedule/system/facility_facility_set" fagid=$fgroup_id caption=$info.facility_group.name}</td>
                            {if $info.facility_group.advance == '0'}
                                <td>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-501' replace='true'}</td>
                            {else}
                                <td>{$info.facility_group.advance}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-38' replace='true'}</td>
                            {/if}
                            {if $info.facility_group.max_time == '0'}
                                <td>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-501' replace='true'}</td>
                            {else}
                                <td>{$info.facility_group.max_time}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-504' replace='true'}</td>
                            {/if}
                            {if $info.facility_group.modify_user == 'creator'}
                                <td>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-517' replace='true'}</td>
                            {elseif $info.facility_group.modify_user == 'member'}
                                <td>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-519' replace='true'}</td>
                            {elseif $info.facility_group.modify_user == 'grantuser'}
                                <td>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-521' replace='true'}</td>
                            {else}
                                <td>&nbsp;</td>
                            {/if}
                            {if $info.facility_group.show_memo}
                                <td>{grn_image image='check16.gif'}</td>
                            {else}
                                <td>&nbsp;</td>
                            {/if}
                            {if $info.facility_group.regularly}
                                <td>{grn_image image='check16.gif'}</td>
                            {else}
                                <td>&nbsp;</td>
                            {/if}
                            {if $info.facility_group.approval}
                                <td>{grn_image image='check16.gif'}</td>
                            {else}
                                <td>&nbsp;</td>
                            {/if}
                        </tr>
                    </table>
                    <br>
                {/if}

                {if $fgroup_id}
                    <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-113' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$info.navi_info.start_count end_num=$info.navi_info.end_count all_num=$info.navi_info.count}</div>
                    {include file="grn/word_navi.tpl" navi=$info.navi_info.navi}
                {else}
                    <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-116' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$info.navi_info.start_count end_num=$info.navi_info.end_count all_num=$info.navi_info.count}</div>
                    <div class="contents_navi">
                        {include file="grn/word_navi.tpl" navi=$info.navi_info.navi}
                    </div>
                {/if}
                <table class="list_column">
                    <colgroup>
                        <col width="30%">
                        <col width="10%">
                        <col width="10%">
                        <col width="25%">
                        <col width="10%">
                        <col width="5%">
                        <col width="10%">
                    </colgroup>
                    <tr>
                        <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-119' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-538' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-539' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-540' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-541' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-542' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-606' replace='true'}</th>
                    </tr>
                    {foreach from=$info.facility_list key=key item=item}
                        <tr>
                            <td>{grn_link image='facility20.gif' page="schedule/system/facility_facility_set" fagid=$fgroup_id faid=$key caption=$item.name}</td>
                            {if $item.advance == '0'}
                                <td>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-501' replace='true'}</td>
                            {else}
                                <td>{$item.advance}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-38' replace='true'}</td>
                            {/if}
                            {if $item.max_time == '0'}
                                <td>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-501' replace='true'}</td>
                            {else}
                                <td>{$item.max_time}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-504' replace='true'}</td>
                            {/if}
                            {if $item.modify_user == 'creator'}
                                <td>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-517' replace='true'}</td>
                            {elseif $item.modify_user == 'member'}
                                <td>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-519' replace='true'}</td>
                            {elseif $item.modify_user == 'grantuser'}
                                <td>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-521' replace='true'}</td>
                            {else}
                                <td>&nbsp;</td>
                            {/if}
                            {if $item.show_memo}
                                <td>{grn_image image='check16.gif'}</td>
                            {else}
                                <td>&nbsp;</td>
                            {/if}
                            {if $item.regularly}
                                <td>{grn_image image='check16.gif'}</td>
                            {else}
                                <td>&nbsp;</td>
                            {/if}
                            {if $item.approval}
                                <td>{grn_image image='check16.gif'}</td>
                            {else}
                                <td>&nbsp;</td>
                            {/if}
                        </tr>
                    {/foreach}
                </table>
                <div class="contents_navi">
                    {include file="grn/word_navi.tpl" navi=$info.navi_info.navi}
                </div>
            {/if}
        </td>
    </tr>
</table>

<script language="JavaScript">
    <!--
    var treeName = 'org_tree';
    var asyncURL = '{grn_pageurl page=$async_page}';
    var pageName = '{$page_name|escape:"url"}';
    var linkURL = '{grn_pageurl page=$link_page}';

    {if $fgroup_id}
    var selectedOID = '{$fgroup_id|escape:javascript}';
    {else}
    var selectedOID = 0;
    {/if}

    var orgTree = new YAHOO.grn.orgTree(treeName, asyncURL, pageName, linkURL, selectedOID);
    orgTree.setOidKey('fagid');
    var treeData = {include org=$tree_org file='grn/org_json.tpl'};
    setTreeHeight('tree_view', 'tree_view_right');

    {literal}
    function createExternalNodes()
    {
        var tree = orgTree.getTree();
        var root = tree.getRoot();

        orgTree.createNode(root, -1, '{/literal}{cb_msg module='grn.grn' key='GRN_GRN-127' replace='true'}{literal}', 0);

        {/literal}
        {if $allow_all_facilities}
        orgTree.createNode(root, -2, '{cb_msg module='grn.grn' key='GRN_GRN-128' replace='true'}', 0);
        {/if}
        {literal}

        tree.draw();
    }
    {/literal}

    YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
    YAHOO.util.Event.addListener(window, "load", createExternalNodes());
    //-->
</script>

{include file='grn/system_footer.tpl'}
