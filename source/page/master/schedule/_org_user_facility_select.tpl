{*
 *  ユーザーの選択（複数）
 *
 *  @param  string  form_name       選択ユーザー確定フォームのNAME属性
 *  @param  string  post_page       選択ユーザー確定フォームのACTION属性のPOST先ページ名
 *  @param  string  cancel_page     キャンセル後に飛ぶページ
 *  @param  string  cancel_app_id   アプリケーションID
 *  @param  boolean can_select_facility 施設が選択可能かどうか
 *  @param  strign  target          組織/ユーザー or 施設
 *  @param  string  poid            現在の組織ID
 *  @param  string  fagid           現在の施設グループID
 *  @param  array   org             現在の組織情報
 *  @param  boolean is_root         現在の組織が（トップ）かどうか
 *  @param  array   ous_params      同ページへのパラメーター配列
 *  @param  array   user_list       候補ユーザーの一覧
 *  @param  array   faciltiy_group_list 施設グループの一覧
 *  @param  array   facility_list   候補施設の一覧
 *  @param  array   navi_info       候補一覧の次ナビ情報
 *  @param  array   selected_list   選択された項目の一覧
 *}
{if $can_select_facility}
<div class="tab_menu">
 <div class="tab">
 {if ! $target}
  <span class="tab_left_on"></span>
  <span class="tab_on">
   {grn_image image='user20.gif'}{cb_msg module='grn.schedule' key='GRN_SCH-340' replace='true'}
  </span>
  <span class="tab_right_on"></span>
 {else}
  <span class="tab_left_off"></span>
  <span class="tab_off">
   {capture name='grn_schedule_GRN_SCH_341'}{cb_msg module='grn.schedule' key='GRN_SCH-341' replace='true'}{/capture}{grn_link image='user20.gif' page=$page_info.all poid=$poid fagid=$fagid caption=$smarty.capture.grn_schedule_GRN_SCH_341}
  </span>
  <span class="tab_right_off"></span>
 {/if}
 </div>
 <div class="tab">
 {if $target == 'facility'}
  <span class="tab_left_on"></span>
  <span class="tab_on">
   {grn_image image='facility20.gif'}{cb_msg module='grn.schedule' key='GRN_SCH-342' replace='true'}
  </span>
  <span class="tab_right_on"></span>
 {else}
  <span class="tab_left_off"></span>
  <span class="tab_off">
   {capture name='grn_schedule_GRN_SCH_343'}{cb_msg module='grn.schedule' key='GRN_SCH-343' replace='true'}{/capture}{grn_link image='facility20.gif' page=$page_info.all tid='facility' poid=$poid fagid=$fagid caption=$smarty.capture.grn_schedule_GRN_SCH_343}
  </span>
  <span class="tab_right_off"></span>
 {/if}
 </div>
</div>
<div class="tab_menu_end"><div class="tab_menu_end_bg">&nbsp;</div></div>
{/if}

<div class="input_box">
{if $target == 'facility'}
 <div class="m_small">
 {grn_image image='facilitygroup20.gif'}{cb_msg module='grn.schedule' key='GRN_SCH-344' replace='true'}
 </div>
{else}
 <div class="search_navi">
 <form name="search" method="get" action="{grn_pageurl page=$page_info.all}">
 {foreach from=$ous_params key=key item=item}
 <input type="hidden" name="{$key|escape}" value="{$item|escape}">
 {/foreach}
 <input type="hidden" name="poid" value="{$poid|escape}">
 <input type="hidden" name="fagid" value="{$fagid|escape}">
 <input type="text" name="search_text" size="20" value="{$search_text|escape}">
 <input class="small" name="search_submit" type="submit" value="{cb_msg module='grn.schedule' key='GRN_SCH-345' replace='true'}">
 </form>
 </div>
 <div class="small">&nbsp;</div>
{/if}
</div>

{***** 施設の処理ここから *****}
{if $target == 'facility'}

{include file='grn/org_tree.tpl'}

<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
<tr valign="top">

  <td class="wrap-tree-view">

  <span class="tree-view-label">{cb_msg module='grn.schedule' key='GRN_SCH-346' replace='true'}</span>
  <div id="tree_view" class="tree-view">

    {if $fagid}
    {capture name='grn_schedule_GRN_SCH_347'}{cb_msg module='grn.schedule' key='GRN_SCH-347' replace='true'}{/capture}{grn_link page=$link_page top=1 keep=1 tid='facility' caption=$smarty.capture.grn_schedule_GRN_SCH_347}
    {else}
    {capture name='grn_schedule_GRN_SCH_348'}{cb_msg module='grn.schedule' key='GRN_SCH-348' replace='true'}{/capture}{grn_link page=$link_page top=1 keep=1 tid='facility' caption=$smarty.capture.grn_schedule_GRN_SCH_348 class='tree-select-current'}
    {/if}

    <div id="org_tree"></div>
  </div>
  </td>


<td width="70%" id="tree_view_right" class="wrap-tree-view-right">
<form method="post" action="{grn_pageurl page=$page_info.all}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{if $is_search}
<input type="hidden" name="search_text" value="{$search_text|escape}">
{/if}
<input type="hidden" name="tid" value="{$target|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="fagid" value="{$fagid|escape}">
{foreach from=$ous_params key=key item=item}
<input type="hidden" name="{$key|escape}" value="{$item|escape}">
{/foreach}
<input type="hidden" name="sp" value="{$navi_info.offset|escape}">

{if $is_root}
<div class="sub_title"><span class="grayout">{cb_msg module='grn.schedule' key='GRN_SCH-349' replace='true'}</span></div>
{else}
<div class="sub_title">{cb_msg module='grn.schedule' key='GRN_SCH-350' replace='true'}{if $fagid}{include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}{/if}</div>
{/if}
<div class="m_small">
{include file="grn/word_navi.tpl" navi=$navi_info.navi}
</div>
<select name="aid[]" size="10" multiple style="width:100%">
{foreach from=$facility_list key=key item=item}
 <option value="facility:{$key}">{$item.name|escape}{if ! $without_foreign_key}({$item.foreign_key|escape}){/if}</option>
{/foreach}
</select>
<div class="m_small">
{include file="grn/word_navi.tpl" navi=$navi_info.navi}
</div>

<input class="margin" type="submit" name="add" value="{cb_msg module='grn.schedule' key='GRN_SCH-354' replace='true'}">
<input class="margin" type="submit" name="remove" value="{cb_msg module='grn.schedule' key='GRN_SCH-355' replace='true'}">
<p></p>
 <select name="rid[]" size="5" multiple style="width:100%">
{foreach from=$selected_list key=key item=item}
 {if $item.type == 'group'}
 <option value="{$key}">[{$item.display_name|escape}{if ! $without_foreign_key}({$item.foreign_key|escape}){/if}]</option>
 {else}
 <option value="{$key}">{$item.display_name|escape}{if ! $without_foreign_key}({$item.foreign_key|escape}){/if}</option>
 {/if}
{/foreach}
 </select>
</form>

<form name="{$form_name}" method="get" action="{grn_pageurl page=$post_page}">
{foreach from=$ous_params key=key item=item}
<input type="hidden" name="{$key|escape}" value="{$item|escape}">
{/foreach}

{capture name='grn_schedule_GRN_SCH_356'}{cb_msg module='grn.schedule' key='GRN_SCH-356' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_GRN_SCH_356}
{if $cancel_app_id}
<input type="button" value="{cb_msg module='grn.schedule' key='GRN_SCH-357' replace='true'}" onclick="location.href='{grn_pageurl page=$cancel_page params=$ous_params app_id=$cancel_app_id}'">
{else}
<input type="button" value="{cb_msg module='grn.schedule' key='GRN_SCH-358' replace='true'}" onclick="location.href='{grn_pageurl page=$cancel_page params=$ous_params}'">
{/if}
</form>
</td>
</tr>
</table>

<script language="JavaScript">
<!--

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page="schedule/system/json/facility_tree"}';
var pageName = '{$page_name|escape:"url"}';
var linkURL  = '{grn_pageurl page=$link_page keep='1' tid='facility'}';

{if $fagid}
var selectedOID = '{$fagid|escape:javascript}';
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

    orgTree.createNode(root, -1, '{/literal}{cb_msg module='grn.schedule' key='GRN_SCH-359' replace='true'}{literal}', 0);

{/literal}
{if $allow_all_facilities}
    orgTree.createNode(root, -2, '{cb_msg module='grn.schedule' key='GRN_SCH-360' replace='true'}', 0);
{/if}
{literal}

    tree.draw();
}
YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
YAHOO.util.Event.addListener(window, "load", createExternalNodes());

{/literal}
-->
</script>

{***** 施設の処理ここまで *****}
{***** 組織の処理ここから *****}
{else}

{include file='grn/org_tree.tpl'}

<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">

  <span class="tree-view-label">{cb_msg module='grn.schedule' key='GRN_SCH-361' replace='true'}</span>
  <div id="tree_view" class="tree-view">

    {if $poid}
    {capture name='grn_schedule_GRN_SCH_362'}{cb_msg module='grn.schedule' key='GRN_SCH-362' replace='true'}{/capture}{grn_link page=$link_page top=1 keep=1 caption=$smarty.capture.grn_schedule_GRN_SCH_362}
    {else}
    {capture name='grn_schedule_GRN_SCH_363'}{cb_msg module='grn.schedule' key='GRN_SCH-363' replace='true'}{/capture}{grn_link page=$link_page top=1 keep=1 caption=$smarty.capture.grn_schedule_GRN_SCH_363 class='tree-select-current'}
    {/if}

    <div id="org_tree"></div>
  </div>
  </td>

   <td width="90%" id="tree_view_right" class="wrap-tree-view-right">

    <form method="post" action="{grn_pageurl page=$page_info.all}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    {if $is_search}
     <input type="hidden" name="search_text" value="{$search_text|escape}">
    {/if}
    <input type="hidden" name="tid" value="{$target|escape}">
    <input type="hidden" name="poid" value="{$poid|escape}">
    <input type="hidden" name="fagid" value="{$fagid|escape}">
    {foreach from=$ous_params key=key item=item}
     <input type="hidden" name="{$key|escape}" value="{$item|escape}">
    {/foreach}
    <input type="hidden" name="sp" value="{$navi_info.offset|escape}">

    {if $is_root && $is_search}
     <div class="sub_title">{cb_msg module='grn.schedule' key='GRN_SCH-364' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
    {elseif $is_root}
     <div class="sub_title"><span class="grayout">{cb_msg module='grn.schedule' key='GRN_SCH-367' replace='true'}</span></div>
    {elseif $is_nogroups && $is_search}
     <div class="sub_title">{cb_msg module='grn.schedule' key='GRN_SCH-368' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
    {elseif $is_nogroups}
     <div class="sub_title">{cb_msg module='grn.schedule' key='GRN_SCH-371' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
    {elseif $is_search}
     <div class="sub_title">{cb_msg module='grn.schedule' key='GRN_SCH-374' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
    {else}
     <div class="sub_title">{cb_msg module='grn.schedule' key='GRN_SCH-377' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
    {/if}
     <div class="m_small">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi}
     </div>
     <select name="aid[]" size="10" multiple style="width:100%">
     {if ! $is_root && ! $is_nogroups && ! $is_search }
      <option value="group:{$poid|escape}">[{$org.name|escape}{if ! $without_foreign_key}({$org.foreign_key}){/if}]</option>
     {/if}
     {foreach from=$user_list key=key item=item}
      <option value="user:{$key}">{$item.display_name|escape}{if ! $without_foreign_key}({$item.foreign_key|escape}){/if}</option>
     {/foreach}
     </select>
     <div class="m_small">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi}
     </div>

     <input class="margin" type="submit" name="add" value="{cb_msg module='grn.schedule' key='GRN_SCH-380' replace='true'}">
     <input class="margin" type="submit" name="remove" value="{cb_msg module='grn.schedule' key='GRN_SCH-381' replace='true'}">

     <p></p>
     <select name="rid[]" size="5" multiple style="width:100%">
     {foreach from=$selected_list key=key item=item}
     {if $item.type == 'group'}
      <option value="{$key}">[{$item.display_name|escape}{if ! $without_foreign_key}({$item.foreign_key|escape}){/if}]</option>
     {else}
      <option value="{$key}">{$item.display_name|escape}{if ! $without_foreign_key}({$item.foreign_key|escape}){/if}</option>
     {/if}
     {/foreach}
     </select>
    </form>

    <form name="{$form_name}" method="get" action="{grn_pageurl page=$post_page}">
    {foreach from=$ous_params key=key item=item}
     <input type="hidden" name="{$key|escape}" value="{$item|escape}">
    {/foreach}

    {capture name='grn_schedule_GRN_SCH_382'}{cb_msg module='grn.schedule' key='GRN_SCH-382' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_GRN_SCH_382}
    {if $cancel_app_id}
     <input type="button" value="{cb_msg module='grn.schedule' key='GRN_SCH-383' replace='true'}" onclick="location.href='{grn_pageurl page=$cancel_page params=$ous_params app_id=$cancel_app_id}'">
    {else}
     <input type="button" value="{cb_msg module='grn.schedule' key='GRN_SCH-384' replace='true'}" onclick="location.href='{grn_pageurl page=$cancel_page params=$ous_params}'">
    {/if}
    </form>

   </td>
  </tr>
 </tbody>
</table>

<script language="JavaScript">
<!--

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page='schedule/org_json'}';
var pageName = '{$page_name|escape:"url"}';
var linkURL  = '{grn_pageurl page=$link_page keep='1'}';

{if $poid}
var selectedOID = '{$poid|escape:javascript}';
{else}
var selectedOID = 0;
{/if}

var orgTree = new YAHOO.grn.orgTree(treeName, asyncURL, pageName, linkURL, selectedOID);
orgTree.setOidKey( 'poid');
var treeData = {include org=$tree_org file='grn/org_json.tpl'};
setTreeHeight('tree_view', 'tree_view_right');

{literal}

function createExternalNodes() {
    var tree = orgTree.getTree();
    var root = tree.getRoot();

    orgTree.createNode(root, -1, '{/literal}{cb_msg module='grn.schedule' key='GRN_SCH-385' replace='true'}{literal}', 0);

    tree.draw();
}
{/literal}

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
YAHOO.util.Event.addListener(window, "load", createExternalNodes());

{*** 組織の処理ここまで ***}

//-->
</script>

{/if}
