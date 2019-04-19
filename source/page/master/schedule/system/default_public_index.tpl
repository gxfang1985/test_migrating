{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{include file='grn/org_tree.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div class="explanation">
    {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-632' replace='true'}
</div>

<p>
<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;">
    <tbody>
    <tr valign="top">
        <td class="wrap-tree-view">
            <span class="tree-view-label">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-633' replace='true'}</span>
            <div id="tree_view" class="tree-view">
                {if $org_id}
                    {capture name='grn_grn_GRN_GRN_978'}{cb_msg module='grn.grn' key='GRN_GRN-978' replace='true'}{/capture}{grn_link page='schedule/system/default_public_index' top=1 caption=$smarty.capture.grn_grn_GRN_GRN_978}
                {else}
                    {capture name='grn_grn_GRN_GRN_979'}{cb_msg module='grn.grn' key='GRN_GRN-979' replace='true'}{/capture}{grn_link page='schedule/system/default_public_index' top=1 caption=$smarty.capture.grn_grn_GRN_GRN_979 class='tree-select-current'}
                {/if}
                <div id="org_tree"></div>
            </div>
        </td>
        <td width="90%" id="tree_view_right" class="wrap-tree-view-right">{*Start view part*}
            <div>
                <div class="search_navi">
                    <form name="search" method="get" action="{grn_pageurl page=$page_info.all}">
                        <input type="hidden" name="oid" value="{$org_id|escape}">
                        <input type="text" name="search_text" size="20" value="{$search_text|escape}" maxlength="100">
                        <input class="small" type="submit" value="{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-634' replace='true'}">
                    </form>
                </div>
            </div>
            {if $is_root && ! $is_search}
                <div class="explanation">
                    {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-638' replace='true'}
                </div>

            {else}
                {if $is_root && $is_search}
                    <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-984' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
                {elseif $is_root}
                    <div class="sub_title"><span class="grayout">{cb_msg module='grn.grn' key='GRN_GRN-987' replace='true'}</span></div>
                {elseif $is_nogroups && $is_search}
                    <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-988' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
                {elseif $is_nogroups}
                    <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-991' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
                {elseif $is_search}
                    <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-994' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
                {else}
                    <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-997' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
                {/if}
                <div class="contents_navi">
                    {include file="grn/word_navi.tpl" navi=$navi_info.navi}
                </div>
                <table class="list_column">
                    <colgroup>
                        <col width="30%">
                        <col width="30%">
                        <col width="10%">
                    </colgroup>
                    <tr>
                        <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-635' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-636' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-637' replace='true'}</th>
                    </tr>
                    {foreach from=$user_list key=key item=item}
                        <tr>
                            <td>{grn_user_name page="schedule/system/default_public_list" oid=$org_id uid=$key}</td>
                            <td>{$item.foreign_key|escape}</td>
                            <td align="right">{$item.default_public_count}</td>
                        </tr>
                    {/foreach}
                </table>
                <div class="contents_navi">
                    {include file="grn/word_navi.tpl" navi=$navi_info.navi}
                </div>
            {/if}
        </td>
    </tr>
</table>
</td>{*End View Part*}
</tr>
</tbody>
</table>

<script language="JavaScript">
    <!--

    var treeName = 'org_tree';
    var asyncURL = '{grn_pageurl page=$async_page}';
    var pageName = '{$page_name|escape:"url"}';
    var linkURL  = '{grn_pageurl page=$link_page}';

    {if $org_id}
    var selectedOID = '{$org_id|escape:javascript}';
    {else}
    var selectedOID = 0;
    {/if}

    var orgTree = new YAHOO.grn.orgTree(treeName, asyncURL, pageName, linkURL, selectedOID);
    var treeData = {include org=$org file='grn/org_json.tpl'};

    setTreeHeight('tree_view', 'tree_view_right');

    {literal}

    function createExternalNodes() {
        var tree = orgTree.getTree();
        var root = tree.getRoot();

        orgTree.createNode(root, -1, '{/literal}{cb_msg module='grn.grn' key='GRN_GRN-157' replace='true'}{literal}', 0);

        tree.draw();

    }

    YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
    YAHOO.util.Event.addListener(window, "load", createExternalNodes());

    {/literal}
    //-->
</script>
{include file="grn/system_footer.tpl"}
