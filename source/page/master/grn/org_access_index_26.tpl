{**
 *  Only for user/group
 *
 *  @param  string  app_id          アプリケーションID
 *  @param  array   page_info       画面情報
 *  @param  string  page_prefix     一連の画面名のプレフィックス
 *  @param  array   info            アクセス権情報付きユーザー/ロール/施設一覧
 *}

{*** 組織の処理ここから ***}

{include file='grn/org_tree.tpl'}

<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">

  <span class="tree-view-label">{cb_msg module='grn.grn' key='GRN_GRN-129' replace='true'}</span>
  <div id="tree_view" class="tree-view">

{if $org_id}
{capture name='grn_grn_GRN_GRN_130'}{cb_msg module='grn.grn' key='GRN_GRN-130' replace='true'}{/capture}{grn_link page=$link_page top=1 caption=$smarty.capture.grn_grn_GRN_GRN_130}
{else}
{capture name='grn_grn_GRN_GRN_131'}{cb_msg module='grn.grn' key='GRN_GRN-131' replace='true'}{/capture}{grn_link page=$link_page top=1 caption=$smarty.capture.grn_grn_GRN_GRN_131 class='tree-select-current'}
{/if}

    <div id="org_tree"></div>
  </div>
  </td>

  <td width="90%" id="tree_view_right" class="wrap-tree-view-right">
  {if $org_id}
    {if ! $is_nogroups}
     <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-132' replace='true'}{grn_appname app_id=$app_id}</div>
     <table class="list_column">
      <colgroup>
        <col width="30%">
        <col width="30%">
        {if $tab_role}
          <col width="30%">
          <col width="10%">
        {else}
          <col width="40%">
        {/if}
      </colgroup>
      <tr>
       <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-133' replace='true'}</th>
       <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-134' replace='true'}</th>
       {if $tab_role}<th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-135' replace='true'}</th>{/if}
       <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-136' replace='true'}</th>
      </tr>
      <tr>
       <td>{grn_link image='organize20.gif' page="`$page_prefix`access_list" oid=$org_id reset=1 caption=$info.name}</td>
       <td>{$info.foreign_key|escape}</td>
       {if $tab_role}<td nowrap>{grn_image image='access20.gif'}{$info.security_model|upper}{cb_msg module='grn.grn' key='GRN_GRN-137' replace='true'}{if $info.security_model == 'revoke'}{cb_msg module='grn.grn' key='GRN_GRN-138' replace='true'}{else}{cb_msg module='grn.grn' key='GRN_GRN-139' replace='true'}{/if}{cb_msg module='grn.grn' key='GRN_GRN-140' replace='true'}</td>{/if}
       <td align="right">{$info.access_count}</td>
      </tr>
     </table>
     <br>
    {/if}

    {if $is_nogroups}
     <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-141' replace='true'}{grn_appname app_id=$app_id} {include file="grn/smart_data_count.tpl" start_num=$info.navi_info.start_count end_num=$info.navi_info.end_count all_num=$info.navi_info.count}</div>
    {else}
     <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-145' replace='true'}{grn_appname app_id=$app_id} {include file="grn/smart_data_count.tpl" start_num=$info.navi_info.start_count end_num=$info.navi_info.end_count all_num=$info.navi_info.count}</div>
    {/if}
     <div class="contents_navi">
     {include file="grn/word_navi.tpl" navi=$info.navi_info.navi}
     </div>
     <table class="list_column">
      <colgroup>
       <col width="30%">
       <col width="30%">
       {if $tab_role}
         <col width="30%">
         <col width="10%">
       {else}
         <col width="40%">
       {/if}
      </colgroup>
      <tr>
       <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-149' replace='true'}</th>
       <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-150' replace='true'}</th>
       {if $tab_role}<th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-151' replace='true'}</th>{/if}
       <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-152' replace='true'}</th>
      </tr>
    {foreach from=$info.user_list key=key item=item}
      <tr>
       <td>{grn_user_name page="`$page_prefix`access_list" oid=$org_id uid=$key reset=1}</td>
       <td>{$item.foreign_key|escape}</td>
       {if $tab_role}<td nowrap>{grn_image image='access20.gif'}{$item.security_model|upper}{cb_msg module='grn.grn' key='GRN_GRN-153' replace='true'}{if $item.security_model == 'revoke'}{cb_msg module='grn.grn' key='GRN_GRN-154' replace='true'}{else}{cb_msg module='grn.grn' key='GRN_GRN-155' replace='true'}{/if}{cb_msg module='grn.grn' key='GRN_GRN-156' replace='true'}</td>{/if}
       <td align="right">{$item.access_count}</td>
      </tr>
    {/foreach}
    </table>
    <div class="contents_navi">
    {include file="grn/word_navi.tpl" navi=$info.navi_info.navi}
    </div>
   {else}
    {* (トップ）のView *}
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
{/literal}

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
YAHOO.util.Event.addListener(window, "load", createExternalNodes());


//-->
</script>

{*** 組織の処理ここまで ***}
