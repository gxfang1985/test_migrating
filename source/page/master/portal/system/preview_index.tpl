{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{include file='grn/org_tree.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div class="explanation">
{cb_msg module='grn.portal.system' key='GRN_POT_SY-224' replace='true'}
</div>

<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">
  <span class="tree-view-label">{cb_msg module='grn.portal.system' key='GRN_POT_SY-225' replace='true'}</span>
  <div id="tree_view" class="tree-view">
{if $org_id}
{capture name='grn_portal_system_GRN_POT_SY_226'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-226' replace='true'}{/capture}{grn_link page=$page_name pid=$portal_id top=1 caption=$smarty.capture.grn_portal_system_GRN_POT_SY_226}
{else}
{capture name='grn_portal_system_GRN_POT_SY_227'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-227' replace='true'}{/capture}{grn_link page=$page_name pid=$portal_id top=1 caption=$smarty.capture.grn_portal_system_GRN_POT_SY_227 class='tree-select-current'}
{/if}
    <div id="org_tree"></div>
  </div>
  
  </td>
  <td width="90%" id="tree_view_right" class="wrap-tree-view-right">
{if ! $is_root}

 {if $is_nogroups}
  <div class="sub_title">{cb_msg module='grn.portal.system' key='GRN_POT_SY-228' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {else}
  <div class="sub_title">{cb_msg module='grn.portal.system' key='GRN_POT_SY-231' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {/if}
  <div class="contents_navi">
  {include file="grn/word_navi.tpl" navi=$navi_info.navi}
  </div>
  <table class="list_column">
   <tr>
    <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-234' replace='true'}</th>
   </tr>
 {foreach from=$user_list key=key item=item}
   <tr>
    <td>{grn_link image='blank20.gif' page="portal/system/preview" pid=$portal_id oid=$org_id uid=$key caption=$item.display_name target='_blank'}</td>
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

<script language="JavaScript">
<!--

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page='portal/system/org_json'}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page=$page_name pid=$portal_id}';

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
    
    orgTree.createNode(root, -1, '{/literal}{cb_msg module='grn.portal.system' key='GRN_POT_SY-235' replace='true'}{literal}', 0);
    
    tree.draw();
    
}
{/literal}

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
YAHOO.util.Event.addListener(window, "load", createExternalNodes());
//-->
</script>

{include file='grn/system_footer.tpl'}
