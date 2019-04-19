{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{include file='grn/org_tree.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<!-- ツリー表示用テーブル -->
<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <!-- ツリーを含めた外側の枠 -->
  <td class="wrap-tree-view">
  
  <!-- ツリーのラベル -->
  <span class="tree-view-label">{cb_msg module='grn.workflow.system' key='w_do_select_team_y' replace='true'}</span>
  
  <!-- ツリーを表示する枠 -->
  <div id="tree_view" class="tree-view"> 
  
  <!-- ツリーのトップへのリンク -->
{if $org_id}
{capture name='grn_workflow_system_w_top'}{cb_msg module='grn.workflow.system' key='w_top' replace='true'}{/capture}{grn_link page='workflow/system/agent_index' top=1 caption=$smarty.capture.grn_workflow_system_w_top }
{else}
{capture name='grn_workflow_system_w_top'}{cb_msg module='grn.workflow.system' key='w_top' replace='true'}{/capture}{grn_link page='workflow/system/agent_index' top=1 caption=$smarty.capture.grn_workflow_system_w_top class='tree-select-current'}
{/if}
    <!-- ツリー本体 -->
  <div id="org_tree"></div>
  </div>
  
  </td>
  
  <!-- ツリーの右側（画面のメイン部分） -->
  <td width="90%" id="tree_view_right" class="wrap-tree-view-right">

   <div style="padding:0.2em 0.5em;margin:0.2em;border:1px solid #dddddd;">
    <table>
    <tr>
    <td nowrap>
      <div class="search_navi">
       <form name="search" method="get" action="{grn_pageurl page=$page_info.all}">
        <input type="hidden" name="oid" value="{$org_id|escape}">
        <input type="text" name="search_text" size="20" value="{$search_text|escape}" maxlength="100">
        <input class="small" type="submit" value="{cb_msg module='grn.workflow.system' key='w_user_search' replace='true'}">
      </form>
     </div>
    </td>
    </tr>
    </table>
   </div>
  <br>

{if $is_root && ! $is_search}
  <div class="sub_title">{cb_msg module='grn.workflow.system' key='w_setting_status_of_substitute_y' replace='true'}</div>
  <blockquote>
  <table>
   <tr><td nowrap>{cb_msg module='grn.workflow.system' key='w_number_of_setting_substitute_applicant_y_1' replace='true'}</td><td>{cb_msg module='grn.workflow.system' key='w_number_of_setting_substitute_applicant_y_2' replace='true'}</td><td align="right" nowrap><span class="bold">{$petition_count}</span> {cb_msg module='grn.workflow.system' key='w_number_of_setting_substitute_applicant_y_3' replace='true'}</td></tr>
   <tr><td nowrap>{cb_msg module='grn.workflow.system' key='w_number_of_setting_substitute_approver_y_1' replace='true'}</td><td>{cb_msg module='grn.workflow.system' key='w_number_of_setting_substitute_approver_y_2' replace='true'}</td><td align="right" nowrap><span class="bold">{$approval_count}</span> {cb_msg module='grn.workflow.system' key='w_number_of_setting_substitute_approver_y_3' replace='true'}</td></tr>
  </table>
  </blockquote>
{else}
 {if $is_root && $is_search}
  <div class="sub_title">{cb_msg module='grn.workflow.system' key='w_all_user_search_result_n_out_of_nn_y' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {elseif $is_nogroups && $is_search}
  <div class="sub_title">{cb_msg module='grn.workflow.system' key='w_search_resulet_non_member_y' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {elseif $is_search}
  <div class="sub_title">{cb_msg module='grn.workflow.system' key='w_search_result_members_n_out_of_n_y' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {elseif $is_nogroups}
  <div class="sub_title">{cb_msg module='grn.workflow.system' key='w_non-members_y' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {else}
  <div class="sub_title">{cb_msg module='grn.workflow.system' key='w_member_n_out_of_nnn_y' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {/if}
    <div class="contents_navi">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi}
    </div>
  <table class="list_column">
   <colgroup>
    <col width="30%">
    <col width="30%">
    <col width="30%">
    <col width="10%">
   </colgroup>
   <tr>
    <th nowrap>{cb_msg module='grn.workflow.system' key='w_user_name' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.workflow.system' key='w_substitute_applicant_y' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.workflow.system' key='w_substitute_approver_y' replace='true'}</th>
    <th nowrap></th>
   </tr>
 {foreach from=$user_list key=key item=item}
   <tr valign="top">
    <td valign="middle">
        {grn_user_name uid=$item.uid name=$item.display_name users_info=$users_info}
    </td>
    <td valign="middle">
        {if $item.agents.0}
            {foreach from=$item.agents.0 key=agent_uid item=agent}
                <div>{if $agent}{grn_user_name uid=$agent.uid name=$agent.display_name}{else}{cb_msg module='grn.workflow.system' key='w_default' replace='true'}{/if}</div>
            {/foreach}
        {else}
            {cb_msg module='grn.workflow.system' key='w_default' replace='true'}
        {/if}
    </td>
    <td valign="middle">
         {if $item.agents.1}
             {foreach from=$item.agents.1 key=agent_uid item=agent}
                 <div>{if $agent}{grn_user_name uid=$agent.uid name=$agent.display_name}{else}{cb_msg module='grn.workflow.system' key='w_default' replace='true'}{/if}</div>
             {/foreach}
         {else}
             {cb_msg module='grn.workflow.system' key='w_default' replace='true'}
         {/if}
    </td>
    <td valign="middle">
        {capture name='grn_workflow_system_w_change_y'}{cb_msg module='grn.workflow.system' key='w_change_y' replace='true'}{/capture}{grn_link page='workflow/system/agent_modify' caption=$smarty.capture.grn_workflow_system_w_change_y oid=$org_id uid=$key}
    </td>
   </tr>
 {/foreach}
  </table>
    <div class="contents_navi">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi sort='size'}
    </div>
{/if}

  </td>
  </tr>
 </tbody>
</table>

<script language="JavaScript">
<!--

// ツリー名（上のツリー本体で指定したdivのid）
var treeName = 'org_tree';

// Ajaxのリクエスト先
var asyncURL = '{grn_pageurl page='workflow/system/org_json'}';

// ページ名（セッションから取得するツリーのID）
var pageName = '{$page_name|escape:"url"}';

// 組織をクリックしたときのリンク先（GETパラメータ付きも可）
// ※createNodeメソッドを上書きする場合は指定する必要ありません。
var linkURL = '{grn_pageurl page='workflow/system/agent_index'}';

// 選択済み組織ID
{if $org_id}
var selectedOID = '{$org_id|escape:javascript}';
{else}
var selectedOID = 0;
{/if}

// ツリーの生成
var orgTree = new YAHOO.grn.orgTree(treeName, asyncURL, pageName, linkURL, selectedOID);

// ツリーデータの生成
var treeData = {include org=$org file='grn/org_json.tpl'};

// ツリー表示部分の高さを制御
setTreeHeight('tree_view', 'tree_view_right');

{literal}

// 組織のリンクを自前で生成する場合、createNodeメソッドを上書きしてください。
/*
orgTree.createNode = function(parent, oid, name, count) {    
    var html = 'hogehoge';

    return new YAHOO.widget.HTMLNode(html, parent, false, true);
}
*/

// ツリーデータにないノードをツリーに含める場合、以下のような関数を作成します。
function createExternalNodes() {
    var tree = orgTree.getTree();
    var root = tree.getRoot();
    
    orgTree.createNode(root, -1, '{/literal}{cb_msg module='grn.workflow.system' key='w_non-member' replace='true'}{literal}', 0);
    //orgTree.createNode(root, -2, '（使用停止中のユーザー）', 0);
    
    tree.draw();
    
}

// ツリーの初期化処理を初期化イベントに登録
YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));

// createExternalNodes関数を初期化イベントに登録
YAHOO.util.Event.addListener(window, "load", createExternalNodes());

{/literal}
//-->
</script>


{include file="grn/system_footer.tpl"}
