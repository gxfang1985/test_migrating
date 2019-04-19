{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

{if ! $is_search}
{include file='schedule/system/facility_group_move_tree.tpl'}
{/if}
<div class="explanation">
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-180' replace='true'}<span class="bold">{grn_image image='facilitygroup20.gif'}{$fagidgroup.name}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-181' replace='true'} 
</div>

<table class="std_form">
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-182' replace='true'}
  </th>
  <td>
  {grn_image image="facilitygroup20.gif"}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-183' replace='true'}{foreach from=$fagidgroup.ancestors item="item"}&gt; {$item.col_name} {/foreach}
  </td>
</tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-184' replace='true'}
  </th>
  <td>
  <div class="tree_input_box">
    <div class="tree_input_inner_box">
      <div class="hilight">{grn_image image="facilitygroup20.gif"}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-185' replace='true'}<nobr>{foreach from=$oidgroup.ancestors item="item"}&gt; {$item.col_name} {/foreach}</nobr></div>
      <hr>
{if $is_search}
<table class="tree_navi" border="0" cellpadding="0" cellspacing="0">
<tr valign="bottom">
<td nowrap><nobr><span class="sub_title">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-186' replace='true'}</span></nobr></td>
<td nowrap>
<div class="search_navi">
          <form action="{grn_pageurl page="schedule/system/facility_group_parent_modify"}"><input type="hidden" name="fagid" value="{$fagid}" />
	  {if $org_id}<input type="hidden" name="oid" value="{$org_id}" />{else}<input type="hidden" name="top" value="1" />{/if}
          {grn_text necessary=true name='search_text' value=$search_text size='20'}{capture name='grn_schedule_system_GRN_SCH_SY_187'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-187' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_187}
	  </form>
</div>
</td>
</tr>
</table>
{else}
<table class="tree_navi" border="0" cellpadding="0" cellspacing="0">
<tbody><tr valign="bottom">
         <td nowrap=""> </td>
         <td nowrap="">
<div class="search_navi">
          <form action="{grn_pageurl page="schedule/system/facility_group_parent_modify"}"><input type="hidden" name="fagid" value="{$fagid}" />
	  {if $org_id}<input type="hidden" name="oid" value="{$org_id}" />{else}<input type="hidden" name="top" value="1" />{/if}
          {grn_text necessary=true name='search_text' value=$search_text size='20'}{capture name='grn_schedule_system_GRN_SCH_SY_188'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-188' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_188}
	  </form>
</div>
</td>
</tr>
</tbody>
</table>
{/if}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
</div>    		  

{if $is_search}
      <div class="tree_view_result">
        {foreach from=$search_result item=s_item}
<nobr><a href="{grn_pageurl page="schedule/system/facility_group_parent_modify" oid=$s_item.fagid fagid=$fagid s=1}" class="">{grn_image image="facilitygroup20.gif"} {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-189' replace='true'}{foreach from=$s_item.ancestor item=item} &gt; {$item.col_name}{/foreach}</a></nobr><br>
	{/foreach}
        <br />
{capture name='grn_schedule_system_GRN_SCH_SY_190'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-190' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_190 page="schedule/system/facility_group_parent_modify" oid=$org_id fagid=$fagid}	
      </div>
     </div>
    </div>
{else}
      <div id="tree_view" class="tree-view">

{if $org_id}
{capture name='grn_schedule_system_GRN_SCH_SY_191'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-191' replace='true'}{/capture}{grn_link page='schedule/system/facility_group_parent_modify' top=1 fagid=$fagid caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_191}
{else}
{capture name='grn_schedule_system_GRN_SCH_SY_192'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-192' replace='true'}{/capture}{grn_link page='schedule/system/facility_group_parent_modify' top=1 fagid=$fagid caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_192 class='tree-select-current'}
{/if}
        <div id="org_tree"></div>
      </div>
    </div>
  </div>
	<div class="sub_explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-193' replace='true'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-194' replace='true'}</div>
{/if}	
   <tr>
  <td>
  </td>


  <td>
  <input type="hidden" name="fagid" value="{$fagid}" />
  <input type="hidden" name="oid" value="{$org_id}" />
       {capture name='grn_schedule_system_GRN_SCH_SY_195'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-195' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_195}
       {grn_button_cancel page='schedule/system/facility_group_view' fagid=$fagid}
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
var linkURL = '{grn_pageurl page='schedule/system/facility_group_parent_modify' fagid=$fagid}';

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

{include file='grn/system_footer.tpl'}
