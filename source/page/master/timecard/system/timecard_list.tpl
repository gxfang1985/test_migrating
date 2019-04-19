{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{include file='grn/org_tree.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

 {** メニューバー **}
 {**
 <div id="menubar_top">
  <ul id="menu">
   <li>{capture name='grn_timecard_system_GRN_TIM_SY_18'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-18' replace='true'}{/capture}{grn_link page='timecard/system/timecard_users_export' caption=$smarty.capture.grn_timecard_system_GRN_TIM_SY_18 image='export20.gif' oid=$org_id}
  </ul>
 </div>
  **}

 <table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">
  <span class="tree-view-label">{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-19' replace='true'}</span>
  <div id="tree_view" class="tree-view">
{if $org_id}
{capture name='grn_timecard_system_GRN_TIM_SY_20'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-20' replace='true'}{/capture}{grn_link page=$page_name top=1 caption=$smarty.capture.grn_timecard_system_GRN_TIM_SY_20}
{else}
{capture name='grn_timecard_system_GRN_TIM_SY_21'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-21' replace='true'}{/capture}{grn_link page=$page_name top=1 caption=$smarty.capture.grn_timecard_system_GRN_TIM_SY_21 class='tree-select-current'}
{/if}
    
    <div id="org_tree"></div>
  </div>
  
  </td>
  <td width="90%" id="tree_view_right" class="wrap-tree-view-right">

 {** 一覧 **}
{if $is_root}
  <div class="sub_title">{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-22' replace='true'}</div>
  <blockquote>
  <table>
   <tr><td nowrap>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-23' replace='true'}</td><td>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-24' replace='true'}</td><td align="right" nowrap><span class="bold">{$user_count}</span> {cb_msg module='grn.timecard.system' key='GRN_TIM_SY-25' replace='true'}</td></tr>
   <tr><td nowrap>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-26' replace='true'}</td><td>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-27' replace='true'}</td><td align="right" nowrap><span class="bold">{$group_count}</span> {cb_msg module='grn.timecard.system' key='GRN_TIM_SY-28' replace='true'}</td></tr>
  </table>
  </blockquote>
{**
  <div class="sub_explanation">
   <span class="bold">{grn_image image='organize20.gif'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-29' replace='true'}</span>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-30' replace='true'}
   {cb_msg module='grn.timecard.system' key='GRN_TIM_SY-31' replace='true'}<br>
   {cb_msg module='grn.timecard.system' key='GRN_TIM_SY-32' replace='true'}<br>
   {cb_msg module='grn.timecard.system' key='GRN_TIM_SY-33' replace='true'}
   </div>
**}
  
{else}
    <div class="margin_vert">
      <b>{$date.curr.year}&nbsp;{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-34' replace='true'}</b>&nbsp;&nbsp;
      <button onclick="location.href='{grn_pageurl page=$page_info.all date=$date.prev oid=$org_id sf=1}';return false;">&nbsp;&nbsp;<img src="{$app_path}/grn/image/cybozu/arrow_back_single.gif?{$build_date}" align='absmiddle'>&nbsp;&nbsp;</button>
      <button onclick="location.href='{grn_pageurl page=$page_info.all oid=$org_id sf=1}';return false;"> {cb_msg module='grn.timecard.system' key='GRN_TIM_SY-87' replace='true'} </button>
      <button onclick="location.href='{grn_pageurl page=$page_info.all date=$date.next oid=$org_id sf=1}';return false;">&nbsp;&nbsp;<img src="{$app_path}/grn/image/cybozu/arrow_next_single.gif?{$build_date}" align='absmiddle'>&nbsp;&nbsp;</button>
    </div>
    <div class="sub_title">{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-35' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
    <div class="contents_navi">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi}
    </div>
  <table class="list_column">
   <colgroup>
    <col width="20%">
    <col width="80%">
   </colgroup>
   <tr>
    <th nowrap>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-38' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-39' replace='true'}</th>
   </tr>
 {foreach from=$user_list key=key item=item}
   <tr>
    <td>{grn_user_name uid=$key name=$item.display_name}</td>
    <td>
  {foreach from=$date.months key=num item=month}
   {capture name='month'}{cb_msg module='fw.date' key='MonthShort'|cat:$num}{/capture}
   {if $month.this_month}<b>{/if}
   {grn_link page='timecard/system/timecard_view' uid=$key date=$month.value oid=$org_id caption=$smarty.capture.month}
   {if $month.this_month}</b>{/if}
  {/foreach}
    </td>
   </tr>
 {/foreach}
  </table>
    <div class="contents_navi">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi}
    </div>
{/if}

  </td>
 </tr>
 </tbody>
</table>

<input type="hidden" name="oid" value="{$org_id}">

<script language="JavaScript">
<!--

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page='timecard/system/org_json'}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page=$page_name}';

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
    
    orgTree.createNode(root, -1, '{/literal}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-41' replace='true'}{literal}', 0);
    
    tree.draw();
    
}
{/literal}

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
YAHOO.util.Event.addListener(window, "load", createExternalNodes());
//-->
</script>

{include file="grn/system_footer.tpl"}
