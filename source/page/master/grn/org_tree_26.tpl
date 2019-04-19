{**
 * Folder Tree View
 * Author: Huy Nguyen @ 2009/12
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
 *
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
//-->
</script>

<div id="{$tree_view_ele_id}" class="tree-view">
{if !$folder_tree.no_root}
<span id="{$folder_tree_id|cat:'_top'}">
    {capture  assign='root_folder_caption'}{if (! is_null($folder_tree.root_caption)) && (strlen($folder_tree.root_caption) > 0) }{$folder_tree.root_caption|grn_noescape}{else}{cb_msg module='grn.grn' key='GRN_GRN-173' replace='true'}{/if}{/capture}
    {if $folder_tree.on_select}
        {if $folder_tree.no_top}
            {capture assign='root_on_select'}javascript:{$folder_tree.on_select}({$folder_tree.selected_oid});{/capture}
            {capture assign='root_id'}{$folder_tree_id|cat:'-node-'}{$folder_tree.selected_oid}{/capture}
            {grn_link script=$root_on_select caption=$root_folder_caption id=$root_id}
        {else}
            {capture assign='root_on_select'}javascript:{$folder_tree.on_select}('top');{/capture}
            {if $folder_tree.selected_oid}
            {grn_link script=$root_on_select
                      caption=$root_folder_caption}
            {else}
            {grn_link script=$root_on_select
                      caption=$root_folder_caption
                      class='tree-select-current'}
            {/if}
        {/if}
    {else}
        {if $folder_tree.selected_oid}
        {grn_link page=$folder_tree.link_url
                  top=1
                  params=$folder_tree.link_url_params
                  caption=$root_folder_caption}
        {else}
        {grn_link page=$folder_tree.link_url
                  top=1
                  params=$folder_tree.link_url_params
                  caption=$root_folder_caption
                  class='tree-select-current'}
        {/if}
    {/if}
    {if $folder_tree.root_subcribled}<span class="icon_mark_subscribe_grn" title="{cb_msg module='grn.grn' key='GRN_GRN-1553' replace='true'}"></span>{/if}
{/if}
</span>
<div id="{$folder_tree_id}"></div>
</div>

<script language="javascript">
<!--
    var tree_id   = '{$folder_tree_id}';
    var async_url = '{grn_pageurl page=$folder_tree.async_url}';
    var page_name = '{$folder_tree.page_name|escape:"url"}';
    var link_url  = '{grn_pageurl page=$folder_tree.link_url params=$folder_tree.link_url_params}';
    var trash_id  = {if $folder_tree.trash_enable}{$folder_tree.trash_id}{else}null{/if};
    var deleted_folder_caption = "{cb_msg module='grn.cabinet.system' key='deleted_folder'}";
    var update_group_caption = "{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-4' replace='true'}";
    var new_group_caption = "{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-7' replace='true'}";
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
    var tree_params = '';
{foreach from=$tree_params key=param item=value}
    tree_params += "&{$param|escape:javascript}={$value|escape:javascript}";
{/foreach}
    var {$obj_folder_tree} = new YAHOO.grn.orgTree(tree_id, async_url, page_name, link_url, selected_oid, tree_params);
{if $folder_tree.on_select}
    {$obj_folder_tree}.setOnSelect('{$folder_tree.on_select|escape:javascript}');
{/if}
    {if $folder_tree.oid_key}{$obj_folder_tree}.setOidKey('{$folder_tree.oid_key|escape:javascript}');{/if}
    {$obj_folder_tree}.setSubscribeTitle('{cb_msg module="grn.grn" key="GRN_GRN-1553" replace="true"}');
    YAHOO.util.Event.onDOMReady(function()
    {ldelim}
        {$obj_folder_tree}.initWithNumber(tree_data);
    {rdelim});
//-->
</script>
