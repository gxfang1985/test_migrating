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
   {capture name='grn_grn_GRN_GRN_88'}{cb_msg module='grn.grn' key='GRN_GRN-88' replace='true'}{/capture}{grn_link image='user20.gif' page=$page_info.all poid=$poid params=$ous_params reset=1 caption=$smarty.capture.grn_grn_GRN_GRN_88 element_id="activate-left-tab"}
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
   {capture name='grn_grn_GRN_GRN_90'}{cb_msg module='grn.grn' key='GRN_GRN-90' replace='true'}{/capture}{grn_link image='role20.gif' page=$page_info.all menu='role' poid=$poid params=$ous_params reset=1 caption=$smarty.capture.grn_grn_GRN_GRN_90 element_id="activate-right-tab"}
  </span>
  <span class="tab_right_off"></span>
 {/if}
 </div>
</div>
<div class="tab_menu_end"><div class="tab_menu_end_bg">&nbsp;</div></div>
{/if}
{***** ロールの処理ここから *****}
{if $target == 'role'}
<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;">
<tbody>
<td width="70%" id="tree_view_right" style="border-left:6px solid #DDDDDD" class="wrap-tree-view-right">
{***** GTM-2226 start *****}
    <div class="search_navi">
        <form name="search" method="get" action="{grn_pageurl page=$page_info.all}">
            {foreach from=$ous_params key=key item=item}
                <input type="hidden" name="{$key|escape}" value="{$item|escape}">
            {/foreach}
            <input type="hidden" name="menu" value="{$target|escape}">
            <input type="hidden" name="poid" value="{$poid|escape}">
            <input type="text" name="role_search_text" size="40" maxlength="100" value="{$role_search_text|escape}">
            <input class="small" id="role_search_submit" type="submit" value="{cb_msg module='grn.grn' key='GRN_GRN-1554' replace='true'}">
        </form>
    </div>
    <div class="small">&nbsp;</div>
{***** GTM-2226 end *****}
<form method="post" action="{grn_pageurl page=$page_info.all}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{***** GTM-2226 start *****}
{if $is_role_search}
    <input type="hidden" name="role_search_text" value="{$role_search_text|escape}">
{/if}
{***** GTM-2226 end *****}
<input type="hidden" name="menu" value="{$target|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
{foreach from=$ous_params key=key item=item}
<input type="hidden" name="{$key|escape}" value="{$item|escape}">
{/foreach}
<input type="hidden" name="sp" value="{$navi_info.offset|escape}">

<select name="aid[]" size="10" multiple style="width:100%">
 {if $self}
 <option value="applicant:0">{cb_msg module='grn.workflow.system' key='w_applicant_self' replace='true'}</option>
 {else}
 {foreach from=$role_list.dynamic_role_list key=key item=item}
 <option value="dynamic_role:{$key}">{$item.foreign_key|escape}</option>
 {/foreach}
 {/if}
 {foreach from=$role_list.static_role_list key=key item=item}
 <option value="static_role:{$key}">{$item.foreign_key|escape}</option>
 {/foreach}
</select>

<input class="margin" type="submit" name="add" value="{cb_msg module='grn.grn' key='GRN_GRN-1000' replace='true'}">
<input class="margin" type="submit" name="remove" value="{cb_msg module='grn.grn' key='GRN_GRN-1001' replace='true'}">
<p></p>
 <select name="rid[]" size="5" multiple style="width:100%">
{foreach from=$selected_list key=key item=item}
 {if $item.type == 'dynamic_role'}
 <option value="{$key}">{$item.foreign_key|escape}</option>
 {elseif $item.type == 'applicant'}
 <option value="applicant:0">{cb_msg module='grn.workflow.system' key='w_applicant_self' replace='true'}</option>
 {else}
 <option value="{$key}">{$item.foreign_key|escape}</option>
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
 {if $authority_count > 0 }
 <p>
 <table style="width:50%">
 <tr>
 <td>
 <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-639' replace='true'}</div>
 </td>
 </tr>
 <tr>
 <td>
 <table class="admin_list_table" style="width:30%">
 <tr>
 {foreach from=$authority_types key=key item=item}
 <th style="text-align:center" nowrap>{$item|escape}</th>
 {/foreach}
 </tr>
 <tr>
 {if $authority_count == 1}
 {foreach from=$authority_types key=key item=item}
 {if $is_grant}
 <td align="center"><input type="hidden" name="authority_{$key|escape}" value="1">{grn_image image='check20.gif'}</td>
 {else}
 <td align="center">{cb_msg module='grn.grn' key='GRN_GRN-640' replace='true'}</td>
 {/if}
 {/foreach}
 {else}
 {foreach name='auth' from=$authority_types key=key item=item}
 {if $smarty.foreach.auth.first && $auth_disable_change_on_off != true}
 <td align="center">{grn_checkbox name="authority_`$key`" id="authority_`$key`" value='1' checked=$authorities.$key onclick="change_on_off(this);"}</td>
 {else}
 <td align="center">{grn_checkbox name="authority_`$key`" id="authority_`$key`" value='1' checked=$authorities.$key}</td>
 {/if}
 {/foreach}
 {/if}
 </tr>
 </table>
 </td>
 </tr>
 </table>
 {/if}
{if $display_app_list eq 1}
    <div class="sub_title mTop10">{cb_msg module='grn.system.application' key='GRN_SY_AP-66' replace='true'}</div>
    <table id="application_list" class="admin_list_table add_use_app_grn" style="width: 80%">
        <tr valign="top">
            <th class="nowrap-grn vAlignMiddle-grn">{cb_msg module='grn.system.application' key='GRN_SY_AP-53' replace='true'}</th>
            {foreach from=$menu_list key=key item=item}
                <th>
                    <div class="{$item.app_id}1 add_use_app_icon_grn"></div>
                    <div>{grn_appname app_id=$item.app_id}</div>
                </th>
            {/foreach}
        </tr>
        <tr>
            <td class="nowrap-grn">{cb_msg module='grn.system.application' key='GRN_SY_AP-103' replace='true'}</td>
            {foreach from=$menu_list key=key item=item}
                <td><input type="checkbox" name="appIds[]" value="{$item.app_id}" id="{$item.app_id}"></td>
            {/foreach}
        </tr>
        {if $allow_external_setting && $allow_external_setting > 0}
        <tr>
            <td class="nowrap-grn">{cb_msg module='grn.system.application' key='GRN_SY_AP-104' replace='true'}</td>
            {foreach from=$menu_list key=key item=item}
                <td>
                    {if $item.app_id neq 'cellular'}
                        <input type="checkbox" name="ext_appIds[]" value="{$item.app_id}" id="ext_{$item.app_id}">
                    {/if}
                </td>
            {/foreach}
        </tr>
        {/if}
    </table>
{/if}
 {capture name='grn_grn_GRN_GRN_1518'}{cb_msg module='grn.grn' key='GRN_GRN-1518' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_grn_GRN_GRN_1518}
 <input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-1003' replace='true'}" onclick="location.href='{grn_pageurl page=$cancel_page params=$ous_params}'">

</form>
</td>
</tr>
</tbody>
</table>

{***** ロールの処理ここまで *****}
{***** 組織の処理ここから *****}
{else}

{include file='grn/org_tree.tpl'}

<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" >
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
    <input class="small" id="search_submit" type="submit" value="{cb_msg module='grn.grn' key='GRN_GRN-980' replace='true'}">
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
     {if ! $no_needusers}
     {foreach from=$user_list key=key item=item}
      <option value="user:{$key}">{$item.display_name|escape}</option>
     {/foreach}
     {/if}
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
    {if $authority_count > 0 }
    <p>
    <table style="width:50%">
    <tr>
    <td>
    <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-639' replace='true'}</div>
    </td>
    </tr>
    <tr>
    <td>
    <table class="admin_list_table" style="width:30%">
    <tr>
    {foreach from=$authority_types key=key item=item}
    <th style="text-align:center" nowrap>{$item|escape}</th>
    {/foreach}
    </tr>
    <tr>
    {if $authority_count == 1}
    {foreach from=$authority_types key=key item=item}
    {if $is_grant}
    <td align="center"><input type="hidden" name="authority_{$key|escape}" value="1">{grn_image image='check20.gif'}</td>
    {else}
    <td align="center">{cb_msg module='grn.grn' key='GRN_GRN-640' replace='true'}</td>
    {/if}
    {/foreach}
    {else}
    {foreach name='auth' from=$authority_types key=key item=item}
    {if $smarty.foreach.auth.first && $auth_disable_change_on_off != true}
    <td align="center">{grn_checkbox name="authority_`$key`" id="authority_`$key`" value='1' checked=$authorities.$key onclick="change_on_off(this);"}</td>
    {else}
    <td align="center">{grn_checkbox name="authority_`$key`" id="authority_`$key`" value='1' checked=$authorities.$key}</td>
    {/if}
    {/foreach}
    {/if}
    </tr>
    </table>
    </td>
    </tr>
    </table>
    {/if}
    {if $display_app_list eq 1}
        <div class="sub_title mTop10">{cb_msg module='grn.system.application' key='GRN_SY_AP-66' replace='true'}</div>
        <table id="application_list" class="admin_list_table add_use_app_grn" style="width: 80%">
            <tr valign="top">
                <th class="nowrap-grn vAlignMiddle-grn">{cb_msg module='grn.system.application' key='GRN_SY_AP-53' replace='true'}</th>
                {foreach from=$menu_list key=key item=item}
                    <th class="nowrap-grn">
                        <div class="{$item.app_id}1 add_use_app_icon_grn"></div>
                        <div>{grn_appname app_id=$item.app_id}</div>
                    </th>
                {/foreach}
            </tr>
            <tr>
                <td class="nowrap-grn">{cb_msg module='grn.system.application' key='GRN_SY_AP-103' replace='true'}</td>
                {foreach from=$menu_list key=key item=item}
                    <td><input type="checkbox" name="appIds[]" value="{$item.app_id}" id="{$item.app_id}"></td>
                {/foreach}
            </tr>
            {if $allow_external_setting && $allow_external_setting > 0}
            <tr>
                <td class="nowrap-grn">{cb_msg module='grn.system.application' key='GRN_SY_AP-104' replace='true'}</td>
                {foreach from=$menu_list key=key item=item}
                    <td>
                        {if $item.app_id neq 'cellular'}
                            <input type="checkbox" name="ext_appIds[]" value="{$item.app_id}" id="ext_{$item.app_id}">
                        {/if}
                    </td>
                {/foreach}
            </tr>
            {/if}
        </table>
    {/if}
    {capture name='grn_grn_GRN_GRN_1518'}{cb_msg module='grn.grn' key='GRN_GRN-1518' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_grn_GRN_GRN_1518 id="btn_`$form_name`"}
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

{/if}
{if $authority_count != 1 && $auth_disable_change_on_off != true}
{literal}
<script language="JavaScript" type="text/javascript">
<!--
function change_on_off(e)
{
    if(e.checked)
    {
 {/literal}
 {foreach name='auth' from=$authority_types key=key item=item}
      if( e.id != "authority_{$key}" ) e.form.elements["authority_{$key}"].disabled = false;
 {/foreach}
 {literal}
    }
    else
    {
 {/literal}
 {foreach name='auth' from=$authority_types key=key item=item}
      if( e.id != "authority_{$key}" ) e.form.elements["authority_{$key}"].disabled = true;
 {/foreach}
 {literal}
    }
}
__change_on_off_temp_onload = window.onload;
function change_on_off_init()
{
 {/literal}
 {foreach name='auth' from=$authority_types key=key item=item}
  {if $smarty.foreach.auth.first}
    change_on_off(document.forms["{$form_name}"].elements["authority_{$key}"]);
  {/if}
 {/foreach}
 {literal}
    if( __change_on_off_temp_onload ) __change_on_off_temp_onload();
}
window.onload = function(){change_on_off_init();};
//-->
</script>
{/literal}
{/if}
