{*
 *  {cb_msg module='grn.timecard.system' key='GRN_TIM_SY-58' replace='true'}
 *
 *  @param  string  form_name       選択ユーザー確定フォームのNAME属性
 *  @param  string  post_page       選択ユーザー確定フォームのACTION属性のPOST先ページ名
 *  @param  string  cancel_page     キャンセル後に飛ぶページ
 *  @param  string  poid            現在の組織ID
 *  @param  array   org             現在の組織情報
 *  @param  boolean is_root         現在の組織が（ルート）かどうか
 *  @param  array   ous_params      同ページへのパラメーター配列
 *  @param  array   user_list       候補ユーザーの一覧
 *  @param  array   navi_info       候補ユーザーの一覧の次ナビ情報
 *  @param  array   selected_list   選択されたユーザーの一覧
 *}

<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">
  <span class="tree-view-label">{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-72' replace='true'}</span>
  <div id="tree_view" class="tree-view">
{if $poid}
{capture name='grn_timecard_system_GRN_TIM_SY_73'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-73' replace='true'}{/capture}{grn_link page=$page_info.all top=1 params=$ous_params ss=1 caption=$smarty.capture.grn_timecard_system_GRN_TIM_SY_73}
{else}
{capture name='grn_timecard_system_GRN_TIM_SY_74'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-74' replace='true'}{/capture}{grn_link page=$page_info.all top=1 params=$ous_params ss=1 caption=$smarty.capture.grn_timecard_system_GRN_TIM_SY_74 class='tree-select-current'}
{/if}
    
    <div id="org_tree"></div>
  </div>
  
  </td>
  <td width="90%" id="tree_view_right" class="wrap-tree-view-right">
{if !$is_root}
  <form method="post" action="{grn_pageurl page=$page_info.all}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <input type="hidden" name="poid" value="{$poid}">
  <input type="hidden" name="ss" value="1">
  <input type="hidden" name="sf" value="1">
{foreach from=$ous_params key=key item=item}
  <input type="hidden" name="{$key|escape}" value="{$item|escape}">
{/foreach}

   <div class="sub_title">{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-75' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
   <div class="m_small">
   {include file="grn/word_navi.tpl" navi=$navi_info.navi}
   </div>
   <select name="aid[]" size="10" multiple style="width:100%">
{foreach from=$user_list key=key item=item}
   <option value="{$key}">{$item.display_name|escape}({$item.foreign_key|escape})</option>
{/foreach}
   </select>
   <div class="m_small">
   {include file="grn/word_navi.tpl" navi=$navi_info.navi}
   </div>

   <input class="margin" type="submit" name="add" value="{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-78' replace='true'}">
   <input class="margin" type="submit" name="remove" value="{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-79' replace='true'}">

   <p>
   <select name="rid[]" size="5" multiple style="width:100%">
{foreach from=$selected_list key=key item=item}
   <option value="{$key}">{$item.display_name|escape}({$item.foreign_key|escape})</option>
{/foreach}
   </select>
  </form>

  <form name="{$form_name}" method="post" action="{grn_pageurl page=$post_page}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{foreach from=$ous_params key=key item=item}
  <input type="hidden" name="{$key|escape}" value="{$item|escape}">
{/foreach}

  {grn_button_submit class="margin" caption=$submit_caption}
  <input type="button" value="{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-80' replace='true'}" onclick="location.href='{grn_pageurl page=$cancel_page params=$cancel_params}'">
  </form>
{/if}
  </td>
  </tr>
 </tbody>
</table>

<script language="JavaScript">
<!--

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page='timecard/system/org_json'}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page=$page_info.all params=$ous_params ss=1}';

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
    
    orgTree.createNode(root, -1, '{/literal}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-81' replace='true'}{literal}', 0);
    
    tree.draw();
    
}
{/literal}

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
YAHOO.util.Event.addListener(window, "load", createExternalNodes());
//-->
</script>
