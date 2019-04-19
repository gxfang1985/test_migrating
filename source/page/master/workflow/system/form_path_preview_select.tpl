{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{include file='grn/org_tree.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
<p class="explanation">{cb_msg module='grn.workflow.system' key='w_select_user_preview_app_route_y' replace='true'}<br />{cb_msg module='grn.workflow.system' key='w_show_route_user_apply_y' replace='true'}</p>
<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">
  <span class="tree-view-label">{cb_msg module='grn.workflow.system' key='w_do_select_team_y' replace='true'}</span>
  <div id="tree_view" class="tree-view">
{if $oid}
{capture name='grn_workflow_system_w_top'}{cb_msg module='grn.workflow.system' key='w_top' replace='true'}{/capture}{grn_link page=$page_info.all cid=$cid fid=$fid top=1 caption=$smarty.capture.grn_workflow_system_w_top}
{else}
{capture name='grn_workflow_system_w_top'}{cb_msg module='grn.workflow.system' key='w_top' replace='true'}{/capture}{grn_link page=$page_info.all cid=$cid fid=$fid top=1 caption=$smarty.capture.grn_workflow_system_w_top class='tree-select-current'}
{/if}
    
    <div id="org_tree"></div>
  </div>
  
  </td>
  <td width="90%" id="tree_view_right" class="wrap-tree-view-right">
{if $oid}
  <div class="sub_title">{if 0 > $oid}{cb_msg module='grn.workflow.system' key='key_112' replace='true'}{else}{cb_msg module='grn.workflow.system' key='key_113' replace='true'}{/if} {include file="grn/smart_data_count.tpl" start_num=$group_info.navi_info.start_count end_num=$group_info.navi_info.end_count all_num=$group_info.navi_info.count}</div>
  <div class="contents_navi">
{include file="grn/word_navi.tpl" navi=$group_info.navi_info.navi}
  </div>
  <table class="list_column">
   <tr>
    <th nowrap>{cb_msg module='grn.workflow.system' key='w_user_name' replace='true'}</th>
   </tr>
{foreach from=$group_info.user_list key=uid item=user}
   <tr>
    <td>{grn_link image='blank20.gif' page="workflow/system/form_path_preview" cid=$cid fid=$fid oid=$oid uid=$uid caption=$user.display_name target='_blank'}</td>
   </tr>
{/foreach}
  </table>
  <div class="contents_navi">
  {include file="grn/word_navi.tpl" navi=$group_info.navi_info.navi}
  </div>
{/if}
  </td>
 </tr>
 </tbody>
</table>

<script language="JavaScript">
<!--

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page='workflow/system/org_json'}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page=$page_info.all cid=$cid fid=$fid }';

{if $oid}
var selectedOID = '{$oid|escape:javascript}';
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
    
    orgTree.createNode(root, -1, '{/literal}{cb_msg module='grn.workflow.system' key='w_non-member' replace='true'}{literal}', 0);
    
    tree.draw();
    
}
{/literal}

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
YAHOO.util.Event.addListener(window, "load", createExternalNodes());
//-->
</script>

{include file='grn/system_footer.tpl'}
