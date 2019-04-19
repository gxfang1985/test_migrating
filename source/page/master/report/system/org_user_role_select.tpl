{*
 *  ユーザーの選択（複数）
 *
 *  @param  string  form_name       選択ユーザー確定フォームのNAME属性
 *  @param  string  post_page       選択ユーザー確定フォームのACTION属性のPOST先ページ名
 *  @param  string  cancel_page     キャンセル後に飛ぶページ
 *  @param  string  cancel_app_id   アプリケーションID
 *  @param  boolean can_select_role ロールが選択可能かどうか
 *  @param  strign  target          組織/ユーザー or ロール
 *  @param  string  poid            現在の組織ID
 *  @param  array   org             現在の組織情報
 *  @param  boolean is_root         現在の組織が（トップ）かどうか
 *  @param  array   ous_params      同ページへのパラメーター配列
 *  @param  array   user_list       候補ユーザーの一覧
 *  @param  array   role_list       候補ロールの一覧
 *  @param  array   navi_info       候補一覧の次ナビ情報
 *  @param  array   selected_list   選択された項目の一覧
 *}
{if $can_select_role}
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
   {capture name='grn_grn_GRN_GRN_88'}{cb_msg module='grn.grn' key='GRN_GRN-88' replace='true'}{/capture}{grn_link image='user20.gif' page=$page_info.all poid=$poid params=$ous_params reset=1 caption=$smarty.capture.grn_grn_GRN_GRN_88}
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
   {capture name='grn_grn_GRN_GRN_90'}{cb_msg module='grn.grn' key='GRN_GRN-90' replace='true'}{/capture}{grn_link image='role20.gif' page=$page_info.all menu='role' poid=$poid params=$ous_params reset=1 caption=$smarty.capture.grn_grn_GRN_GRN_90}
  </span>
  <span class="tab_right_off"></span>
 {/if}
 </div>
</div>
<div class="tab_menu_end"><div class="tab_menu_end_bg">&nbsp;</div></div>
{/if}

{***** ロールの処理ここから *****}
{***** ロールの処理ここまで *****}
{***** 組織の処理ここから *****}

{include file='grn/org_tree.tpl'}

<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">

  <div id="tree_view" class="tree-view">

    {if $poid}
    {capture name='grn_grn_GRN_GRN_978'}{cb_msg module='grn.grn' key='GRN_GRN-978' replace='true'}{/capture}{grn_link page=$link_page top=1 params=$ous_params caption=$smarty.capture.grn_grn_GRN_GRN_978}
    {else}
    {capture name='grn_grn_GRN_GRN_979'}{cb_msg module='grn.grn' key='GRN_GRN-979' replace='true'}{/capture}{grn_link page=$link_page top=1 params=$ous_params caption=$smarty.capture.grn_grn_GRN_GRN_979 class='tree-select-current'}
    {/if}

    <div id="org_tree"></div>
  </div>
  </td>

   <td width="90%" id="tree_view_right" class="wrap-tree-view-right">

    <div class="search_navi">
    <form name="search" method="get" action="{grn_pageurl page=$page_info.all}">
    {foreach from=$ous_params key=key item=item}
    <input type="hidden" name="{$key|escape}" value="{$item|escape}">
    {/foreach}
    <input type="hidden" name="poid" value="{$poid|escape}">
    <input type="text" name="search_text" size="40" value="{$search_text|escape}">
    <input class="small" type="submit" value="{cb_msg module='grn.grn' key='GRN_GRN-980' replace='true'}">
    </form>
    </div>
    <div class="small">&nbsp;</div>

    <form method="post" action="{grn_pageurl page=$page_info.all}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    {if $is_search}
     <input type="hidden" name="search_text" value="{$search_text|escape}">
    {/if}
    <input type="hidden" name="menu" value="{$target|escape}">
    <input type="hidden" name="poid" value="{$poid|escape}">
    {foreach from=$ous_params key=key item=item}
     <input type="hidden" name="{$key|escape}" value="{$item|escape}">
    {/foreach}
    <input type="hidden" name="sp" value="{$navi_info.offset|escape}">
    {if $is_root && $is_search}
 <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-984' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {elseif $is_root}
 <div class="sub_title"><span class="grayout">{cb_msg module='grn.grn' key='GRN_GRN-987' replace='true'}</span></div>
 {elseif $is_nogroups && $is_search}
 <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-988' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {elseif $is_nogroups}
 <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-991' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {elseif $is_search}
 <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-994' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {else}
 <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-997' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
    {/if}
    <div class="m_small">
    {include file="grn/word_navi.tpl" navi=$navi_info.navi}
    </div>
     <select name="aid[]" size="10" multiple style="width:100%">
     {if ! $is_root && ! $is_nogroups && ! $is_search && ! $no_needgroups}
      <option value="group:{$poid|escape}">[{$org.name|escape}]</option>
     {/if}
     {foreach from=$user_list key=key item=item}
      <option value="user:{$key}">{$item.display_name|escape}</option>
     {/foreach}
     </select>
     <div class="m_small">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi}
     </div>
     <input class="margin" type="submit" name="add" value="{cb_msg module='grn.grn' key='GRN_GRN-1000' replace='true'}">
     <input class="margin" type="submit" name="remove" value="{cb_msg module='grn.grn' key='GRN_GRN-1001' replace='true'}">

     <p></p>
     <select name="rid[]" size="5" multiple style="width:100%">
     {foreach from=$selected_list key=key item=item}
     {if $item.type == 'group'}
      <option value="{$key}">[{$item.display_name|escape}]</option>
     {else}
      <option value="{$key}">{$item.display_name|escape}</option>
     {/if}
     {/foreach}
     </select>
    </form>

    <form name="{$form_name}" method="post" action="{grn_pageurl page=$post_page}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="func" value="add">
    {foreach from=$ous_params key=key item=item}
     <input type="hidden" name="{$key|escape}" value="{$item|escape}">
    {/foreach}
    {* 追加する状態 *}
    <p>
    <table style="width:50%">
     <tr>
     <td></td>
      <td>
      <div class="sub_title">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-358' replace='true'}</div>

      <table class="admin_list_table" style="width:50%">
      <tr>
      <th style="text-align:center" nowrap>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-359' replace='true'}</th>
      <th style="text-align:center" nowrap>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-360' replace='true'}</th>
      </tr>
      <tr>
      <td align="center">{grn_checkbox name="col_authority_report" id="report" value='1' checked=$col_authority_report onclick="change_status(this, 'cellular');" disabled=$is_over_user}</td>
      <td align="center">{grn_checkbox name="col_authority_cellular" id="cellular" value='1' checked=$col_authority_cellular disabled=$is_over_user}</td>
      </tr>
     </table>

 </td>
 </tr>

    </table>
    {capture name='grn_grn_GRN_GRN_1518'}{cb_msg module='grn.grn' key='GRN_GRN-1518' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_grn_GRN_GRN_1518}
    <input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-1003' replace='true'}" onclick="location.href='{grn_pageurl page=$cancel_page params=$ous_params}'">
    </form>

   </td>
  </tr>
 </tbody>
</table>

<script language="JavaScript">
<!--

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page=$json_page}';
var pageName = '{$page_name|escape:"url"}';
var linkURL  = '{grn_pageurl page=$page_info.all params=$ous_params}';

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

    orgTree.createNode(root, -1, '{/literal}{cb_msg module='grn.grn' key='GRN_GRN-1004' replace='true'}{literal}', 0);

    tree.draw();
}
{/literal}

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
YAHOO.util.Event.addListener(window, "load", createExternalNodes());

{*** 組織の処理ここまで ***}

//-->
</script>
{literal}
<script language="JavaScript" type="text/javascript">
<!--
function change_status(element, id)
{
    var disabled = true;
    var checked = false;

    if(element.checked)
    {
        disabled = false;
    }

    element.form.elements[id].disabled = disabled;
    element.form.elements[id].checked = checked;
}
var element = $('report');
if(! element.checked)
{
    element.form.elements['cellular'].disabled = true;
    element.form.elements['cellular'].checked = false;
}
//-->
</script>
{/literal}
