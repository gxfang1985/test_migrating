{*
 *  ユーザーの選択（複数）
 *
 *  @param  string  form_name            選択ユーザー確定フォームのNAME属性
 *  @param  string  post_page            選択ユーザー確定フォームのACTION属性のPOST先ページ名
 *  @param  string  cancel_page          キャンセル後に飛ぶページ
 *  @param  string  poid                 現在の組織ID
 *  @param  array   org                  現在の組織情報
 *  @param  boolean is_root              現在の組織が（トップ）かどうか
 *  @param  array   ous_params           同ページへのパラメーター配列
 *  @param  array   user_list            候補ユーザーの一覧
 *  @param  array   navi_info            候補ユーザーの一覧の次ナビ情報
 *  @param  array   selected_list        選択されたユーザーの一覧
 *  @param  string  sumbit_caption       submitボタンのキャプション
 *  @param  boolean without_foreign_key  ログイン名を表示しない
 *  @param  boolean is_sandbox_page      Snadbox mode or not
 *}
 <p>
 <table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">
  <span class="tree-view-label">{cb_msg module='grn.grn' key='GRN_GRN-977' replace='true'}</span>
  <div id="tree_view" class="tree-view">
{if $poid}
{capture name='grn_grn_GRN_GRN_978'}{cb_msg module='grn.grn' key='GRN_GRN-978' replace='true'}{/capture}{grn_link page=$page_info.all params=$ous_params top=1 caption=$smarty.capture.grn_grn_GRN_GRN_978}
{else}
{capture name='grn_grn_GRN_GRN_979'}{cb_msg module='grn.grn' key='GRN_GRN-979' replace='true'}{/capture}{grn_link page=$page_info.all params=$ous_params top=1 caption=$smarty.capture.grn_grn_GRN_GRN_979 class='tree-select-current'}
{/if}
    <div id="org_tree"></div>
  </div>
  </td>
  <td width="90%" id="tree_view_right" class="wrap-tree-view-right">
   <!-- search start -->
   <div style="padding:0.2em 0.5em;margin:0.2em;border:1px solid #dddddd;">
    <table>
    <tr>
    <td nowrap>
     <form name="search" method="post" action="{grn_pageurl page=$page_info.all}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    {foreach from=$ous_params key=key item=item}
     <input type="hidden" name="{$key|escape}" value="{$item|escape}">
    {/foreach}
     <input type="hidden" name="poid" value="{$poid|escape}">
     <input type="text" name="search_text" size="20" value="{$search_text|escape}">
     <input class="small" id="search_submit" type="submit" value="{cb_msg module='grn.grn' key='GRN_GRN-980' replace='true'}">
     </form>
    </td>
    </tr>
    </table>
   </div>
   <!-- search end -->
 {if ! $is_root}
 <small style="margin-top:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-981' replace='true'}</small>
 <div class="bold" style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">{grn_organize_name gid=$poid is_sandbox_page=$is_sandbox_page}</div>
 {elseif ! $is_search}
 <small style="margin-top:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-982' replace='true'}</small>
 <div class="bold" style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">{grn_image image='organize20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-983' replace='true'}</div>
 {/if}
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

<form method="post" action="{grn_pageurl page=$page_info.all}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{if $is_search}
<input type="hidden" name="search_text" value="{$search_text|escape}">
{/if}
<input type="hidden" name="poid" value="{$poid|escape}">
{foreach from=$ous_params key=key item=item}
<input type="hidden" name="{$key|escape}" value="{$item|escape}">
{/foreach}
<input type="hidden" name="sp" value="{$navi_info.offset|escape}">
 <div class="m_small">
 {include file="grn/word_navi.tpl" navi=$navi_info.navi}
 </div>
 <select name="aid[]" size="10" multiple style="width:100%">
 {if $without_foreign_key}
  {foreach from=$user_list key=key item=item}
 <option value="{$key}">{$item.display_name|escape}</option>
  {/foreach}
 {else}
  {foreach from=$user_list key=key item=item}
 <option value="{$key}">{$item.display_name|escape}({$item.foreign_key|escape})</option>
  {/foreach}
 {/if}
 </select>
 <div class="m_small">
 {include file="grn/word_navi.tpl" navi=$navi_info.navi}
 </div>

  <div class="margin_vert">
  <input class="margin" type="submit" name="add" value="{cb_msg module='grn.grn' key='GRN_GRN-1000' replace='true'}">
  <input class="margin" type="submit" name="remove" value="{cb_msg module='grn.grn' key='GRN_GRN-1001' replace='true'}">
  </div>

 <select name="rid[]" size="5" multiple style="width:100%">
 {if $without_foreign_key}
  {foreach from=$selected_list key=key item=item}
 <option value="{$key}">{$item.display_name|escape}</option>
  {/foreach}
 {else}
  {foreach from=$selected_list key=key item=item}
 <option value="{$key}">{$item.display_name|escape}({$item.foreign_key|escape})</option>
  {/foreach}
 {/if}
 </select>
</form>

<p>
<form name="{$form_name}" method="post" action="{grn_pageurl page=$post_page}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 {foreach from=$ous_params key=key item=item}
<input type="hidden" name="{$key|escape}" value="{$item|escape}">
 {/foreach}

 {if !$submit_caption}
{capture name='grn_grn_GRN_GRN_1002'}{cb_msg module='grn.grn' key='GRN_GRN-1002' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_grn_GRN_GRN_1002 id="user_select_submit"}
 {else}
{grn_button_submit class="margin" caption=$submit_caption id="user_select_submit"}
 {/if}

<input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-1003' replace='true'}" onclick="location.href='{grn_pageurl page=$cancel_page params=$ous_params}'">
</form>
  </p>




  </td>
  </tr>
  </tbody>
  </table>

{include file='grn/org_tree.tpl'}
 
<script language="JavaScript" type="text/javascript">

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page=$json_page}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page=$page_info.all params=$ous_params }';

{if $poid}
var selectedOID = '{$poid|escape:javascript}';
{else}
var selectedOID = 0;
{/if}

var orgTree = new YAHOO.grn.orgTree(treeName, asyncURL, pageName, linkURL, selectedOID);
orgTree.setOidKey( 'poid');
var treeData = {include org=$org file='grn/org_json.tpl'};

setTreeHeight('tree_view', 'tree_view_right');

{literal}


function createExternalNodes() {
    var tree = orgTree.getTree();
    var root = tree.getRoot();
    
    orgTree.createNode(root, -1, '{/literal}{cb_msg module='grn.grn' key='GRN_GRN-1004' replace='true'}{literal}', 0);
    
    tree.draw();
    
}

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
YAHOO.util.Event.addListener(window, "load", createExternalNodes());

{/literal}
</script>


