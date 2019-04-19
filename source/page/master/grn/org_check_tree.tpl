{**
 * Folder Check Tree View
 * Author: K.Kajita @ 2012/12
 *
 * Parameters:
 * [folder_tree] => [tree_name],        REQUIRE     ID of tree
 *                  [async_url],        REQUIRE     URL to retrieve children nodes
 *                  [link_url],         REQUIRE     URL of node
 *                  [link_url_params],              URL parameter of node
 *                  [page_name],        REQUIRE     page name
 *                  [selected_oid],     REQUIRE     ID of selected node
 *                  [oid_key],                      Name of URL parameter used for node. Default: 'oid'
 *                  [json_template],                Template file used for JSON data of tree
 *                  [root_caption],                 Caption of root node. Default: '（ルート）'
 *                  [root_subscribed],              Specify TRUE to display notify icon (mark_subscribe10.png) beside root node. Default: 'FALSE'
 *                  [no_root],                      Specify TRUE to hide root node. Default: 'FALSE'
 *                  [on_select],                    Name of javascript function will be call when a node is selected
 *                  [tree_view_ele_id],             ID of HTML element, the container of tree. Default: 'tree-view'
 *                  [view_part_ele_id],             ID of HTML element, the container of view part. Default: 'view-part'
 *                  [set_tree_height],              Specify FALSE, if don't want to set size of tree on page load.
 *                  [reflection_info]   =>  [source_key]    Name of URL parameter used for copy source.
 *                                          [source_oid]    ID of copy source
 *                  [check_info]        =>  [id_prefix]     Prefix ID for check box
 *                                          [name]          Name of URL parameter used for check box.
 *                                          [on_click]      onClick Event for check box
 *                  [incremental_search],             Use in incremental search text. Default: 'NULL'
 *                  [incremental_search_url],         Url to incremental search.
 *                  [incremental_search_session_url], Store the checked categories in the session.
  *                 [incremental_search_params],      Parameters for incremental search.
 *                  [incremental_search_picker_css],  Set the css name of incremental search.
 *}

{assign var="folder_tree_id"    value=$folder_tree.tree_name|default:"folder_tree"}
{assign var="tree_view_ele_id"  value=$folder_tree.tree_view_ele_id|default:"tree_view"}
{assign var="view_part_ele_id"  value=$folder_tree.view_part_ele_id|default:"view_part"}
{assign var="obj_folder_tree"   value='obj_'|cat:$folder_tree_id}

<script type="text/javascript" src="{$app_path}/fw/yui/build/yahoo/yahoo-min.js?{$build_date}" ></script>
<script type="text/javascript" src="{$app_path}/fw/yui/build/event/event-min.js?{$build_date}" ></script>
<script type="text/javascript" src="{$app_path}/fw/yui/build/dom/dom-min.js?{$build_date}" ></script>
<script type="text/javascript" src="{$app_path}/fw/yui/build/treeview/treeview-min.js?{$build_date}" ></script>
<script type="text/javascript" src="{$app_path}/fw/yui/build/connection/connection-min.js?{$build_date}" ></script>
<script type="text/javascript" src="{$app_path}/grn/html/org_tree_26.js?{$build_date}" ></script>
<script language="javascript">
<!--
YAHOO.grn.orgTree.csrf_ticket= "{$csrf_ticket}";
YAHOO.grn.orgTree.app_path= "{$app_path}";
YAHOO.grn.orgTree.useIncrementalSearch = "{$folder_tree.incremental_search}";
//-->
</script>

<div id="{$tree_view_ele_id}" class="tree-view">
{if !$folder_tree.no_root}
    <table class="ygtvtable ygtvdepth0 ygtv-collapsed ygtv-highlight0" cellspacing="0" cellpadding="0" border="0">
        <tr class="ygtvrow">
            <td class="ygtvcell ygtvhtml ygtvcontent">
                {if $folder_tree.incremental_search}
                    {strip}
                        <div id="{$folder_tree_id|cat:'_top'}" class="{if $folder_tree.selected_oid eq '1'}tree-select-current{else}tree-node{/if}">
                            <input type="checkbox" id="{$folder_tree.check_info.id_prefix}1" name="{$folder_tree.check_info.name}" value="1" class="tree_checkbox_grn" onclick="{$folder_tree.check_info.on_click}(1, this)">
                            <span class="nowrap-grn ">
                                <a id="{$folder_tree_id|cat:'-node-1'}" href="javascript:{$folder_tree.on_select}(1)">{$folder_tree.root_caption}</a>
                            </span>
                        </div>
                    {/strip}
                {else}
                    {if ! $folder_tree.selected_oid}
                        <div id="{$folder_tree_id|cat:'_top'}" class="tree-select-current">
                    {else}
                        <div id="{$folder_tree_id|cat:'_top'}" class="tree-node">
                    {/if}
                    {capture  assign='root_folder_caption'}{if (! is_null($folder_tree.root_caption)) && (strlen($folder_tree.root_caption) > 0) }{$folder_tree.root_caption}{else}{cb_msg module='grn.grn' key='GRN_GRN-173' replace='true'}{/if}{/capture}
                        {if $folder_tree.selected_oid}
                            {grn_link page=$folder_tree.link_url
                                      top=1
                                      params=$folder_tree.link_url_params
                                      caption=$root_folder_caption}
                        {else}
                            {grn_link page=$folder_tree.link_url
                                      top=1
                                      params=$folder_tree.link_url_params
                                      caption=$root_folder_caption}

                        {/if}
                        {if $folder_tree.reflection_info.source_oid == 1}
                            <span class="category_important_grn">{cb_msg module='grn.grn' key='GRN_GRN-1545' replace='true'}</span>
                        {/if}
                        {if $folder_tree.root_subcribled}<span class="icon_mark_subscribe_grn" title="{cb_msg module='grn.grn' key='GRN_GRN-1553' replace='true'}"></span>{/if}
                    </div>
                {/if}
            </td>
        </tr>
    </table>
{/if}
<div id="{$folder_tree_id}"></div>
</div>

<script language="javascript">
<!--
    var tree_id   = '{$folder_tree_id}';
    var async_url = '{grn_pageurl page=$folder_tree.async_url}';
    var page_name = '{$folder_tree.page_name|escape:"url"}';
    var link_url  = '{grn_pageurl page=$folder_tree.link_url params=$folder_tree.link_url_params}';
    var trash_id  = {if $folder_tree.trash_enable}{$folder_tree.trash_id}{else}null{/if};
{if $folder_tree.selected_oid}
    var selected_oid = '{$folder_tree.selected_oid|escape:javascript}';
{else}
    var selected_oid = 0;
{/if}
{if $folder_tree.json_template}
    var tree_data = {include org=$folder_tree.root file=$folder_tree.json_template};
{else}
    var tree_data = {include org=$folder_tree.root file='grn/org_json_26.tpl'};
{/if}
    var {$obj_folder_tree} = new YAHOO.grn.orgTree(tree_id, async_url, page_name, link_url, selected_oid);
{if $folder_tree.on_select}
    {$obj_folder_tree}.setOnSelect('{$folder_tree.on_select|escape:javascript}');
{/if}
{if $folder_tree.oid_key}{$obj_folder_tree}.setOidKey('{$folder_tree.oid_key|escape:javascript}');{/if}
{if $folder_tree.reflection_info}{$obj_folder_tree}.setReflectionInfo('{$folder_tree.reflection_info.source_key}','{$folder_tree.reflection_info.source_oid|escape:javascript}','{cb_msg module="grn.grn" key="GRN_GRN-1545" replace="true"}');{/if}
{if $folder_tree.check_info}{$obj_folder_tree}.setCheckInfo('{$folder_tree.check_info.id_prefix}','{$folder_tree.check_info.name}','{$folder_tree.check_info.on_click}');{/if}

YAHOO.util.Event.onDOMReady(function()
{ldelim}
    {$obj_folder_tree}.initWithNumber(tree_data);

    var check_list = new Array();
    {foreach from=$folder_tree.checked_ids item=value}
        check_list.push('{$value}');
    {/foreach}
    var checked = {$obj_folder_tree}.setCheckList(check_list);

    {if $folder_tree.incremental_search}
        var force_notify_list = new Array();
        {foreach from=$folder_tree.force_notify_ids item=value}
            force_notify_list.push('{$value}');
        {/foreach}
        {$obj_folder_tree}.setForceNotifyList(force_notify_list);

        {$obj_folder_tree}.buildTreeCollapseAndExpand(selected_oid);
        {$obj_folder_tree}.highlightNode(selected_oid);

        var urlParams = new Object();
        {foreach from=$folder_tree.incremental_search_params key=param_key item=param_value}
            urlParams["{$param_key}"] = "{$param_value}";
        {/foreach}

        var category_picker = new grn.component.category_picker(
            "{$folder_tree.tree_name}",
            {$obj_folder_tree},
            {ldelim}
                searchBoxTextId: "keyword_{$id_searchbox}",
                searchBoxIconId: "searchbox-submit-{$id_searchbox}",
                tree_name: "{$folder_tree.tree_name}",
                url: "{$folder_tree.incremental_search_url}",
                sessionManagerUrl: "{$folder_tree.incremental_search_session_url}",
                urlParams: urlParams,
                container: "{$folder_tree.incremental_search_picker_css}"
            {rdelim}
        );

        category_picker.movePositionTop(selected_oid);
    {else}
        grn.component.check_tree.toggleSendButton(checked);
    {/if}

{rdelim});
//-->
</script>
