{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{include file='grn/org_tree.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<p>
<div class="explanation">
{cb_msg module='grn.workflow.system' key='w_select_user_confirm_app_preview_y' replace='true'}
</div>

<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">
  <span class="tree-view-label">{cb_msg module='grn.workflow.system' key='w_do_select_team_y' replace='true'}</span>
  <div id="tree_view" class="tree-view"> 
  
{if $org_id}
{capture name='grn_workflow_system_w_top'}{cb_msg module='grn.workflow.system' key='w_top' replace='true'}{/capture}{grn_link page='workflow/operation/form_preview_select' top=1 caption=$smarty.capture.grn_workflow_system_w_top cid=$category_id fid=$form_id}
{else}
{capture name='grn_workflow_system_w_top'}{cb_msg module='grn.workflow.system' key='w_top' replace='true'}{/capture}{grn_link page='workflow/operation/form_preview_select' top=1 caption=$smarty.capture.grn_workflow_system_w_top class='tree-select-current' cid=$category_id fid=$form_id}
{/if}
  <div id="org_tree"></div>
  </div>
  
  </td>
  
  <td width="90%" id="tree_view_right" class="wrap-tree-view-right">

{if ! $is_root}

 {if $is_nogroups}
  <div class="sub_title">{cb_msg module='grn.workflow.system' key='key_112' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {else}
  <div class="sub_title">{cb_msg module='grn.workflow.system' key='key_113' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {/if}
  <div class="contents_navi">
  {include file="grn/word_navi.tpl" navi=$navi_info.navi}
  </div>
  <div class="wf_path_table">
  <table class="list_column">
   <tr>
    <th nowrap>{cb_msg module='grn.workflow.system' key='w_user_name' replace='true'}</th>
   </tr>
 {foreach from=$user_list key=key item=item}
   <tr>
    <td>{grn_link image='blank20.gif' page="workflow/operation/form_preview" cid=$category_id fid=$form_id oid=$org_id uid=$key caption=$item.display_name target='_blank'}</td>
   </tr>
 {/foreach}
  </table>
  </div>
  <div class="contents_navi">
  {include file="grn/word_navi.tpl" navi=$navi_info.navi}
  </div>
{/if}

  </td>
  </tr>
 </tbody>
</table>

<script language="JavaScript">
<!--

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page='workflow/org_json'}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page='workflow/operation/form_preview_select' cid=$category_id fid=$form_id}';

// 選択済み組織ID
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
    
    orgTree.createNode(root, -1, '{/literal}{cb_msg module='grn.workflow.system' key='w_non-member' replace='true'}{literal}', 0);
    
    tree.draw();
    
}

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
YAHOO.util.Event.addListener(window, "load", createExternalNodes());

{/literal}
//-->
</script>

{include file='grn/footer.tpl'}
