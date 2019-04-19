{include file='grn/org_tree.tpl'}
 
 <table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">
  <span class="tree-view-label">{cb_msg module='grn.grn' key='GRN_GRN-421' replace='true'}</span>
  <div id="tree_view" class="tree-view">
{if $org_id}
{capture name='grn_grn_GRN_GRN_422'}{cb_msg module='grn.grn' key='GRN_GRN-422' replace='true'}{/capture}{grn_link_raw page='javascript:on_change_organization(0)' caption=$smarty.capture.grn_grn_GRN_GRN_422}
{else}
{capture name='grn_grn_GRN_GRN_423'}{cb_msg module='grn.grn' key='GRN_GRN-423' replace='true'}{/capture}{grn_link_raw page='javascript:on_change_organization(0)' caption=$smarty.capture.grn_grn_GRN_GRN_423 class='tree-select-current'}
{/if}
    <div id="org_tree"></div>
  </div>
  
  </td>
  <td width="90%" id="tree_view_right" class="wrap-tree-view-right">
    {if $set_organization_id}        
        <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-424' replace='true'}{cb_msg module='grn.grn' key='GRN_GRN-425' replace='true'}</div>
        <div class="m_small">
         {foreach from=$user_list key=key item=item}
          {grn_user_name uid=$key nolink=true app_id=$app_id}<br>
         {/foreach}
         {if $user_continue}{grn_image image='spacer20.gif'} {cb_msg module='grn.grn' key='GRN_GRN-426' replace='true'}{/if}
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
var linkURL = 'javascript:on_change_organization';

{if $org_id}
var selectedOID = '{$org_id|escape:javascript}';
{else}
var selectedOID = 0;
{/if}

var orgTree = new YAHOO.grn.orgTree(treeName, asyncURL, pageName, linkURL, selectedOID);
    
var treeData = {include org=$org file='grn/org_json.tpl'};

setTreeHeight('tree_view', 'tree_view_right');

{literal}
orgTree.createNode = function(parent, oid, name, count) {
    var html = '';
    
    html += "<a href='" + this._linkURL + "(" + oid + ")'>" + name;
    if (count > 0 ) html += "&nbsp;(" + count + ")";
        html += "</a>";
    
    html = this.setNodeStyle(oid, html);
    var node = new YAHOO.widget.HTMLNode(html, parent, false, true);
    node.href = this._linkURL + "(" + oid + ")";
    return node;
}
YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));

{/literal}
//-->
</script>
