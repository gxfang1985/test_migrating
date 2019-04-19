{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{include file='grn/org_tree.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<p>
 <div class="explanation">
  {cb_msg module='grn.portal.system' key='GRN_POT_SY-479' replace='true'}<br>
  {cb_msg module='grn.portal.system' key='GRN_POT_SY-480' replace='true'}
 </div>
</p>

<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">
  <span class="tree-view-label">{cb_msg module='grn.portal.system' key='GRN_POT_SY-481' replace='true'}</span>
  <div id="tree_view" class="tree-view"> 
{if $organization_id}
{capture name='grn_portal_system_GRN_POT_SY_482'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-482' replace='true'}{/capture}{grn_link page='portal/system/first_portal_list' top=1 caption=$smarty.capture.grn_portal_system_GRN_POT_SY_482}
{else}
{capture name='grn_portal_system_GRN_POT_SY_483'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-483' replace='true'}{/capture}{grn_link page='portal/system/first_portal_list' top=1 caption=$smarty.capture.grn_portal_system_GRN_POT_SY_483 class='tree-select-current'}
{/if}
    <div id="org_tree"></div>
  </div>
  </td>
  <td width="90%" id="tree_view_right" class="wrap-tree-view-right">

  <div id="main_menu_part">
{if $organization.oid}
  <span class="menu_item">{capture name='grn_portal_system_GRN_POT_SY_484'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-484' replace='true'}{/capture}{grn_link image='write20.gif' page='portal/system/first_portal_set' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_484 oid=$organization.oid}</span>
{else}
  <span class="menu_item">{capture name='grn_portal_system_GRN_POT_SY_485'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-485' replace='true'}{/capture}{grn_link image='write20.gif' page='portal/system/first_portal_set' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_485}</span>
{/if}
</div>
<p>

{if $organization.oid}
  <div class="bold">{$organization.title|escape}</div>
  <table class="list_column">
   <tr>
    <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-486' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-487' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-488' replace='true'}</th>
   </tr>
   <tr>
    <td>{grn_organize_name gid=$organization.oid}</td>
    <td>{$organization.code|escape}</td>
 {if $first_portal.portal_title}
    <td>{$first_portal.portal_title|escape}</td>
 {else}
    <td>{cb_msg module='grn.portal.system' key='GRN_POT_SY-489' replace='true'}</td>
 {/if}
   </tr>
  </table>
{else}
  <div class="bold">{cb_msg module='grn.portal.system' key='GRN_POT_SY-490' replace='true'}</div>
  <table class="list_column">
   <tr>
    <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-491' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-492' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-493' replace='true'}</th>
   </tr>
   <tr>
    <td>{cb_msg module='grn.portal.system' key='GRN_POT_SY-494' replace='true'}</td>
    <td>--</td>
 {if $first_portal.portal_title}
    <td>{$first_portal.portal_title|escape}</td>
 {else}
    <td>{cb_msg module='grn.portal.system' key='GRN_POT_SY-495' replace='true'}</td>
 {/if}
   </tr>
  </table>
{/if}

  </td>
  </tr>
  </table>
  </td>
  </tr>
 </tbody>
</table>

<script language="JavaScript">
<!--

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page='portal/system/org_json'}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page='portal/system/first_portal_list'}';

{if $organization_id}
var selectedOID = '{$organization_id|escape:javascript}';
{else}
var selectedOID = 0;
{/if}

var orgTree = new YAHOO.grn.orgTree(treeName, asyncURL, pageName, linkURL, selectedOID);
    
var treeData = {include org=$org file='grn/org_json.tpl'};

setTreeHeight('tree_view', 'tree_view_right');

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));

//-->
</script>

{include file='grn/system_footer.tpl'}
