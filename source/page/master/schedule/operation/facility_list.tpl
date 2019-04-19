{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{include file='grn/org_tree.tpl'}
<p></p>

{if $is_search_facilitygroup }

{else}

<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">
  <span class="tree-view-label">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-25' replace='true'}</span>
  <div id="tree_view" class="tree-view">
    {capture name='grn_schedule_operation_GRN_SCH_OP_26'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-26' replace='true'}{/capture}{grn_link page='' top=1 caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_26 disabled=1}
    
    <div id="org_tree"></div>
  </div>
  
  </td>
  <td width="90%" id="tree_view_right" class="wrap-tree-view-right">

  {if ! $top}

     <!-- search start -->
   <div style="padding:0.2em 0.5em;margin:0.2em;border:1px solid #dddddd;">
    <table>
    <tr>
    <td nowrap>

 <form name="search" method="get" action="{grn_pageurl page='schedule/operation/facility_list'}">
 {if $top}
 <input type="hidden" name="top" value="1" />
 {else}
 <input type="hidden" name="oid" value="{$org_id|escape}" />
 {/if}

 <input type="hidden" name="cmd" />
 <input type="text" name="search_text" size="20" value="{$search_text|escape}" maxlength="100" />
 <input class="small" type="button" value="{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-27' replace='true'}" OnClick="cmd.value='facility'; submit(this.form);" />
 <input class="small" type="button" value="{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-28' replace='true'}" OnClick="document.forms.search.action='{grn_pageurl page='schedule/operation/facility_group_search'}'; submit( this );" />
 </form>
    </td>
    </tr>
    </table>
   </div>
   <!-- search end -->
  {if $enable_facility_group_detail}
  <small style="margin-top:0.5em;">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-29' replace='true'}</small>
  <div style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">
    <b>{$org_name}</b>&nbsp;
    {if $enable_facility_group_detail}    
      {capture name='grn_schedule_operation_GRN_SCH_OP_30'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-30' replace='true'}{/capture}{grn_link image='detail20.gif' page='schedule/operation/facility_group_view' fagid=$org_id caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_30}
    {else}
      {capture name='grn_schedule_operation_GRN_SCH_OP_31'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-31' replace='true'}{/capture}{grn_link image='detail20.gif' page='schedule/operation/facility_group_view' fagid=$org_id caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_31 disabled=1}
    {/if}
  </div>
  {/if}
{include file='schedule/operation/_list_menu.tpl'}

{if (! $top || $is_search ) }
  <div class="sub_title">{if $org_id == -2}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-32' replace='true'}{else}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-33' replace='true'}{/if}{if $is_search_facility}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-34' replace='true'}{/if}{include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/operation/facility_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="fagid" value="{$org_id|escape}">
  <div class="list">
   <p class="item">
    <div class="contents_navi">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi}
    </div>
   </p>
   {if $org_id > 0}
   <p class="item">
    <span>{include file='grn/checkall.tpl' elem_name='faid[]'}</span>
    <span>
     <input type="submit" name="remove" value="{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-47' replace='true'}" onclick="if( ! grn_is_checked( this.form, 'faid[]' ) ) return false;">&nbsp;&nbsp; 
    </span>
   </p>
   {/if}
  </div>
  <table class="admin_list_table">
   <colgroup>
 {if $org_id > 0}
    <col width="1%">
 {/if}
    <col width="40%">
    <col width="30%">
    <col width="30%">
   </colgroup>
   <tr>
 {if $org_id > 0}
    <th nowrap></th>
 {/if}
    <th nowrap>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-38' replace='true'}</th>
    {if $org_id == -2 || ($top && $is_search )}
    <th nowrap>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-39' replace='true'}</th>
    {else}
    <th nowrap>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-40' replace='true'}</th>
    {/if}
    <th nowrap>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-41' replace='true'}</th>
   </tr>
 {foreach from=$facility_list key=key item=item}
   <tr>
 {if $org_id > 0}
    <td nowrap>{grn_checkbox name='faid[]' id="faid_`$item._id`" value=$item._id}</td>
 {/if}
    <td>{grn_link image='facility20.gif' page='schedule/operation/facility_view' fagid=$org_id faid=$item._id search_text=$search_text caption=$item.col_name}</td>
    {if $org_id > 0}
    <td>{$item.col_foreign_key|escape}</td>
    {else}
    <td>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-42' replace='true'}{foreach from=$item.ancestors item=ancestors} &gt; {$ancestors.col_name|escape}{/foreach}</td>
    {/if}
    <td nowrap>
    {capture name='grn_schedule_operation_GRN_SCH_OP_43'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-43' replace='true'}{/capture}{grn_link page='schedule/operation/facility_modify' caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_43 faid=$item._id fagid=$org_id}
    {capture name='grn_schedule_operation_GRN_SCH_OP_44'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-44' replace='true'}{/capture}{grn_link page='schedule/operation/facility_delete' caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_44 faid=$item._id fagid=$org_id}
    </td>
   </tr>
 {/foreach}
   <tr>
	{if $org_id > 0}
    <td colspan="4" style="padding:0.5em; ">
        <div>{capture name='grn_schedule_operation_GRN_SCH_OP_45'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-45' replace='true'}{/capture}{grn_link image='facility20.gif' page='schedule/operation/facility_add' caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_45 oid=$org._id fagid=$org_id}
        </div>
    </td>
	{else}
    <td colspan="3" style="padding:0.5em;">
        <div>{capture name='grn_schedule_operation_GRN_SCH_OP_45'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-45' replace='true'}{/capture}{grn_link image='facility20.gif' page='schedule/operation/facility_add' caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_45 oid=$org._id fagid=$org_id}
        </div>
    </td>
	{/if}
   </tr>
  </table>
  <div class="list">
   {if $org_id > 0}
   <p class="item">
    <span>{include file='grn/checkall.tpl' elem_name='faid[]'}</span>
    <span>
     <input type="submit" name="remove" value="{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-47' replace='true'}" onclick="if( ! grn_is_checked( this.form, 'faid[]' ) ) return false;">&nbsp;&nbsp; 
    </span>
   </p>
   {/if}
   <p class="item">
    <div class="contents_navi">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi}
    </div>
   </p>
  </div>
  {/if}
  {/if}
  </td>
 </tr>
</table>

<script language="JavaScript">
<!--

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page='schedule/operation/json/facility_privilege_tree'}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page='schedule/operation/facility_list'}';

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
    
{/literal}
{if $allow_all_facilities}
    orgTree.createNode(root, -2, '{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-48' replace='true'}', 0);
{/if}
{literal}
    tree.draw();
}
{/literal}


YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
YAHOO.util.Event.addListener(window, "load", createExternalNodes());


//-->
</script>

{/if}

{include file='grn/footer.tpl'}
