{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

{if ! $is_search}
{include file='schedule/system/facility_group_move_tree.tpl'}
{/if}
<div class="explanation">
{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-79' replace='true'}<span class="bold">{grn_image image='facilitygroup20.gif'}{$fagidgroup.name}</span>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-80' replace='true'} 
</div>

<table class="std_form">
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-81' replace='true'}
  </th>
  <td>
  {grn_image image="facilitygroup20.gif"}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-82' replace='true'}{foreach from=$fagidgroup.ancestors item="item"}&gt; {$item.col_name} {/foreach}
  </td>
</tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-83' replace='true'}
  </th>
  <td>
  <div class="tree_input_box">
    <div class="tree_input_inner_box">
      <div class="hilight">{grn_image image="facilitygroup20.gif"}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-84' replace='true'}<nobr>{foreach from=$oidgroup.ancestors item="item"}&gt; {$item.col_name} {/foreach}</nobr></div>
      <hr>
{if $is_search}
<table class="tree_navi" border="0" cellpadding="0" cellspacing="0">
<tr valign="bottom">
<td nowrap class="m_small"><nobr></nobr></td>
<td nowrap>
<div class="search_navi">
          <form action="{grn_pageurl page="schedule/operation/facility_group_parent_modify"}"><input type="hidden" name="fagid" value="{$fagid}" />
	  {if $org_id}<input type="hidden" name="oid" value="{$org_id}" />{else}<input type="hidden" name="top" value="1" />{/if}
          {grn_text necessary=true name='search_text' value=$search_text size='20'}{capture name='grn_schedule_operation_GRN_SCH_OP_85'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-85' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_85}
	  </form>
</div>
</td>
</tr>
</table>

{else}
<div class="tree_navi">
<div class="search_navi">
          <form action="{grn_pageurl page="schedule/operation/facility_group_parent_modify"}"><input type="hidden" name="fagid" value="{$fagid}" />
	  {if $org_id}<input type="hidden" name="oid" value="{$org_id}" />{else}<input type="hidden" name="top" value="1" />{/if}
          {grn_text necessary=true name='search_text' value=$search_text size='20'}{capture name='grn_schedule_operation_GRN_SCH_OP_86'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-86' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_86}
	  </form>
</div>
{/if}

<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
</div>    		  

{if $is_search}
      <div class="tree_view_result">
        {foreach from=$search_result item=s_item}
<nobr><a href="{grn_pageurl page="schedule/operation/facility_group_parent_modify" oid=$s_item.fagid fagid=$fagid s=1}" class="">{grn_image image="facilitygroup20.gif"} {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-87' replace='true'}{foreach from=$s_item.ancestor item=item} &gt; {$item.col_name}{/foreach}</a></nobr><br>
	{/foreach}
<br />
{capture name='grn_schedule_operation_GRN_SCH_OP_88'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-88' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_88 page="schedule/operation/facility_group_parent_modify" oid=$org_id fagid=$fagid}
      </div>
     </div>
    </div>

{else}

      <div id="tree_view" class="tree-view">

{capture name='grn_schedule_operation_GRN_SCH_OP_89'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-89' replace='true'}{/capture}{grn_link page='schedule/operation/facility_group_parent_modify' top=1 fagid=$fagid caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_89 disabled=1}

        <div id="org_tree"></div>
      </div>
    </div>
  </div>
	{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-90' replace='true'} {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-91' replace='true'}
{/if}

   <tr>
  <td>
  </td>


  <td>

  <input type="hidden" name="fagid" value="{$fagid}" />
  <input type="hidden" name="oid" value="{$org_id}" />
       {capture name='grn_schedule_operation_GRN_SCH_OP_92'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-92' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_92}
       {grn_button_cancel page='schedule/operation/facility_group_view' fagid=$fagid}
</form>
  </td>
 </tr>


  </td>
 </tr>
</table>

{if ! $is_search }

<script language="JavaScript">
var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page=$ftree_async_page}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page='schedule/operation/facility_group_parent_modify' fagid=$fagid}';

{if $org_id}
var selectedOID = '{$org_id|escape:javascript}';
{else}
var selectedOID = 0;
{/if}

var orgTree = new YAHOO.grn.orgTree(treeName, asyncURL, pageName, linkURL, selectedOID);

var treeData = {include org=$org file='schedule/facility_json.tpl'};

/* setTreeHeight('tree_view', 'tree_view_right'); */

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));

</script>
{/if}

{include file='grn/footer.tpl'}
