{**
 *  組織/ユーザー/ロール/施設におけるアクセス権の設定画面のテンプレート
 *
 *  @param  string  app_id          アプリケーションID
 *  @param  boolean tab_facility    施設を含むか
 *  @param  array   page_info       画面情報
 *  @param  string  page_prefix     一連の画面名のプレフィックス
 *  @param  array   info            アクセス権情報付きユーザー/ロール/施設一覧
 *}

<div class="tab_menu">
 <div class="tab">
{if ! $target}
  <span class="tab_left_on"></span>
  <span class="tab_on">
   {grn_image image='user20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-87' replace='true'}
  </span>
  <span class="tab_right_on"></span>
{else}
  <span class="tab_left_off"></span>
  <span class="tab_off">
   {capture name='grn_grn_GRN_GRN_88'}{cb_msg module='grn.grn' key='GRN_GRN-88' replace='true'}{/capture}{grn_link image='user20.gif' page=$page_info.all oid=$org_id fagid=$fgroup_id caption=$smarty.capture.grn_grn_GRN_GRN_88}
  </span>
  <span class="tab_right_off"></span>
{/if}
 </div>
 <div class="tab">
{if $target == 'role'}
  <span class="tab_left_on"></span>
  <span class="tab_on">
   {grn_image image='role20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-89' replace='true'}
  </span>
  <span class="tab_right_on"></span>
{else}
  <span class="tab_left_off"></span>
  <span class="tab_off">
   {capture name='grn_grn_GRN_GRN_90'}{cb_msg module='grn.grn' key='GRN_GRN-90' replace='true'}{/capture}{grn_link image='role20.gif' page=$page_info.all tid='role' oid=$org_id fagid=$fgroup_id caption=$smarty.capture.grn_grn_GRN_GRN_90}
  </span>
  <span class="tab_right_off"></span>
{/if}
 </div>
{if $tab_facility}
 <div class="tab">
 {if $target == 'facility'}
  <span class="tab_left_on"></span>
  <span class="tab_on">
   {grn_image image='facility20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-91' replace='true'}
  </span>
  <span class="tab_right_on"></span>
 {else}
  <span class="tab_left_off"></span>
  <span class="tab_off">
   {capture name='grn_grn_GRN_GRN_92'}{cb_msg module='grn.grn' key='GRN_GRN-92' replace='true'}{/capture}{grn_link image='facility20.gif' page=$page_info.all tid='facility' oid=$org_id fagid=$fgroup_id caption=$smarty.capture.grn_grn_GRN_GRN_92}
  </span>
  <span class="tab_right_off"></span>
 {/if}
 </div>
{/if}
</div>
<div class="tab_menu_end"><div class="tab_menu_end_bg">&nbsp;</div></div>


{*** ロールの処理ここから ***}
{if $target == 'role' }

<div id="path_part">
 {grn_image image='role20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-93' replace='true'}
</div>
<table width="100%">
 <tr valign="top">
  <td id="tree_part" width="30%">
  </td>
  <td id="view_part" width="70%">

  <table class="list_column">
   <colgroup>
    <col width="60%">
    <col width="30%">
    <col width="10%">
   </colgroup>
   <tr>
    <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-94' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-95' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-96' replace='true'}</th>
   </tr>
 {foreach from=$info.role_list key=key item=item}
   <tr>
    <td>{grn_link image='role20.gif' page="`$page_prefix`access_list" tid=$target oid=$org_id fagid=$fgroup_id rid=$key reset=1 caption=$item.foreign_key}</td>
    <td nowrap>{grn_image image='access20.gif'}{$item.security_model|upper}{cb_msg module='grn.grn' key='GRN_GRN-97' replace='true'}{if $item.security_model == 'revoke'}{cb_msg module='grn.grn' key='GRN_GRN-98' replace='true'}{else}{cb_msg module='grn.grn' key='GRN_GRN-99' replace='true'}{/if}{cb_msg module='grn.grn' key='GRN_GRN-100' replace='true'}</td>
    <td align="right">{$item.access_count}</td>
   </tr>
 {/foreach}
  </table>

  </td>
 </tr>
</table>

{*** ロールの処理ここまで ***}
{elseif $target == 'facility' && $tab_facility}
{*** 施設の処理ここから ***}
{include file='grn/org_tree.tpl'}

<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tr valign="top">
  <td class="wrap-tree-view">

  <span class="tree-view-label">{cb_msg module='grn.grn' key='GRN_GRN-101' replace='true'}</span>
  <div id="tree_view" class="tree-view">

{if $fgroup_id}
{capture name='grn_grn_GRN_GRN_102'}{cb_msg module='grn.grn' key='GRN_GRN-102' replace='true'}{/capture}{grn_link page=$link_page top=1 tid='facility' caption=$smarty.capture.grn_grn_GRN_GRN_102}
{else}
{capture name='grn_grn_GRN_GRN_103'}{cb_msg module='grn.grn' key='GRN_GRN-103' replace='true'}{/capture}{grn_link page=$link_page top=1 tid='facility' caption=$smarty.capture.grn_grn_GRN_GRN_103 class='tree-select-current'}
{/if}

    <div id="org_tree"></div>
  </div>
  </td>
<td width="70%" id="tree_view_right" class="wrap-tree-view-right">

{if ! $top}
 {if $fgroup_id && $fgroup_id > 0}
  {if $app_id == 'schedule'}
  <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-1086' replace='true'}</div>
	{else}
  <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-104' replace='true'}{grn_appname app_id=$app_id}</div>
  {/if}
  <table class="list_column">
   <colgroup>
    <col width="30%">
    <col width="30%">
    <col width="30%">
    <col width="10%">
   </colgroup>
   <tr>
    <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-105' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-106' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-107' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-108' replace='true'}</th>
   </tr>
   <tr>
     <td>{grn_link image='facilitygroup20.gif' page="`$page_prefix`access_list" tid='facilitygroup' oid=$org_id fagid=$fgroup_id reset=1 caption=$info.facility_group.name}</td>
     <td>{$info.facility_group.code}</td>
    <td nowrap>{grn_image image='access20.gif'}{$info.facility_group.security_model|upper}{cb_msg module='grn.grn' key='GRN_GRN-109' replace='true'}{if $info.facility_group.security_model == 'revoke'}{cb_msg module='grn.grn' key='GRN_GRN-110' replace='true'}{else}{cb_msg module='grn.grn' key='GRN_GRN-111' replace='true'}{/if}{cb_msg module='grn.grn' key='GRN_GRN-112' replace='true'}</td>
    <td align="right" width="20%">{$info.facility_group.access_count}</td>
   </tr>
  </table>
  <br>
 {/if}

 {if $fgroup_id}
  <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-113' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$info.navi_info.start_count end_num=$info.navi_info.end_count all_num=$info.navi_info.count}</div>
  {include file="grn/word_navi.tpl" navi=$info.navi_info.navi}
 {else}
  <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-116' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$info.navi_info.start_count end_num=$info.navi_info.end_count all_num=$info.navi_info.count}</div>
  <div class="contents_navi">
  {include file="grn/word_navi.tpl" navi=$info.navi_info.navi}
  </div>
 {/if}
  <table class="list_column">
   <colgroup>
    <col width="30%">
    <col width="30%">
    <col width="30%">
    <col width="10%">
   </colgroup>
   <tr>
    <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-119' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-120' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-121' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-122' replace='true'}</th>
   </tr>
 {foreach from=$info.facility_list key=key item=item}
   <tr>
    <td>{grn_link image='facility20.gif' page="`$page_prefix`access_list" tid=$target oid=$org_id fagid=$fgroup_id faid=$key reset=1 caption=$item.name}</td>
    <td>{$item.foreign_key|escape}</td>
    <td nowrap>{grn_image image='access20.gif'}{$item.security_model|upper}{cb_msg module='grn.grn' key='GRN_GRN-123' replace='true'}{if $item.security_model == 'revoke'}{cb_msg module='grn.grn' key='GRN_GRN-124' replace='true'}{else}{cb_msg module='grn.grn' key='GRN_GRN-125' replace='true'}{/if}{cb_msg module='grn.grn' key='GRN_GRN-126' replace='true'}</td>
    <td align="right">{$item.access_count}</td>
   </tr>
 {/foreach}
  </table>
  <div class="contents_navi">
  {include file="grn/word_navi.tpl" navi=$info.navi_info.navi}
  </div>
{/if}
  </td>
 </tr>
</table>

<script language="JavaScript">
<!--

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page=$ftree_async_page}';
var pageName = '{$page_name|escape:"url"}';
var linkURL  = '{grn_pageurl page=$link_page tid='facility'}';

{if $fgroup_id}
var selectedOID = '{$fgroup_id|escape:javascript}';
{else}
var selectedOID = 0;
{/if}

var orgTree = new YAHOO.grn.orgTree(treeName, asyncURL, pageName, linkURL, selectedOID);
orgTree.setOidKey( 'fagid');
var treeData = {include org=$tree_org file='grn/org_json.tpl'};
setTreeHeight('tree_view', 'tree_view_right');

{literal}
function createExternalNodes() {
    var tree = orgTree.getTree();
    var root = tree.getRoot();

    orgTree.createNode(root, -1, '{/literal}{cb_msg module='grn.grn' key='GRN_GRN-127' replace='true'}{literal}', 0);

{/literal}
{if $allow_all_facilities}
    orgTree.createNode(root, -2, '{cb_msg module='grn.grn' key='GRN_GRN-128' replace='true'}', 0);
{/if}
{literal}

    tree.draw();
}
{/literal}

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
YAHOO.util.Event.addListener(window, "load", createExternalNodes());


//-->
</script>

{*** 施設の処理ここまで ***}

{else}
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
        <col width="30%">
        <col width="10%">
      </colgroup>
      <tr>
       <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-133' replace='true'}</th>
       <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-134' replace='true'}</th>
       <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-135' replace='true'}</th>
       <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-136' replace='true'}</th>
      </tr>
      <tr>
       <td>{grn_link image='organize20.gif' page="`$page_prefix`access_list" oid=$org_id fagid=$fgroup_id reset=1 caption=$info.name}</td>
       <td>{$info.foreign_key|escape}</td>
       <td nowrap>{grn_image image='access20.gif'}{$info.security_model|upper}{cb_msg module='grn.grn' key='GRN_GRN-137' replace='true'}{if $info.security_model == 'revoke'}{cb_msg module='grn.grn' key='GRN_GRN-138' replace='true'}{else}{cb_msg module='grn.grn' key='GRN_GRN-139' replace='true'}{/if}{cb_msg module='grn.grn' key='GRN_GRN-140' replace='true'}</td>
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
       <col width="30%">
       <col width="10%">
      </colgroup>
      <tr>
       <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-149' replace='true'}</th>
       <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-150' replace='true'}</th>
       <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-151' replace='true'}</th>
       <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-152' replace='true'}</th>
      </tr>
    {foreach from=$info.user_list key=key item=item}
      <tr>
       <td>{grn_user_name page="`$page_prefix`access_list" oid=$org_id fagid=$fgroup_id uid=$key reset=1}</td>
       <td>{$item.foreign_key|escape}</td>
       <td nowrap>{grn_image image='access20.gif'}{$item.security_model|upper}{cb_msg module='grn.grn' key='GRN_GRN-153' replace='true'}{if $item.security_model == 'revoke'}{cb_msg module='grn.grn' key='GRN_GRN-154' replace='true'}{else}{cb_msg module='grn.grn' key='GRN_GRN-155' replace='true'}{/if}{cb_msg module='grn.grn' key='GRN_GRN-156' replace='true'}</td>
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
{/if}
{*** 組織の処理ここまで ***}
