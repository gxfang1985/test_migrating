{include file='grn/org_tree.tpl'}

<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">

  <span class="tree-view-label">{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-81' replace='true'}</span>
  <div id="tree_view" class="tree-view">

    {if $set_organization_id}
    {capture name='grn_schedule_portlet_GRN_SCH_PO_82'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-82' replace='true'}{/capture}{grn_link script='javascript:on_change_organization(0);' caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_82}
    {else}
    {capture name='grn_schedule_portlet_GRN_SCH_PO_83'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-83' replace='true'}{/capture}{grn_link script='javascript:on_change_organization(0);' caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_83 class='tree-select-current'}
    {/if}

    <div id="org_tree"></div>
  </div>
  </td>

   <td width="90%" id="tree_view_right" class="wrap-tree-view-right">

    {if $set_organization_id}
    <small style="margin-top:0.5em;">{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-84' replace='true'}</small>
     <div class="bold" style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">{grn_image image='organize20.gif'}{$organization.title|escape}</div>
    <small style="margin-bottom:0.5em;">{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-85' replace='true'}</small>
    <div class="m_small">
    {foreach from=$user_list key=key item=item}
      {grn_image image='user20.gif'}{$item|escape}<br>
    {/foreach}
    {if $user_continue}{grn_image image='spacer20.gif'} {cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-86' replace='true'}{/if}
    </div>
   {/if}

   </td>
  </tr>
 </tbody>
</table>

<script language="JavaScript">
<!--

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page=$async_page}';
var pageName = '{$page_name|escape:"url"}';
var linkURL  = '';

{if $set_organization_id}
var selectedOID = '{$set_organization_id|escape:javascript}';
{else}
var selectedOID = 0;
{/if}

var orgTree = new YAHOO.grn.orgTree(treeName, asyncURL, pageName, linkURL, selectedOID);
var treeData = {include org=$org file='grn/org_json.tpl'};
setTreeHeight('tree_view', 'tree_view_right');

{literal}
orgTree.createNode = function(parent, oid, name, count) {
    var html = '';

    html += "<a href='javascript:on_change_organization(" + oid + ");' >" + name;
    if (count > 0 ) html += "&nbsp;(" + count + ")";
    html += "</a>";

    html = this.setNodeStyle(oid, html);
    var node = new YAHOO.widget.HTMLNode(html, parent, false, true);
    node.href = "javascript:on_change_organization(" + oid + ");";
    return node;
}
{/literal}

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));

{*** 組織の処理ここまで ***}

//-->
</script>