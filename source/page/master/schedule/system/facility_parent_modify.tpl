{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

{if ! $is_search}
{include file='schedule/system/facility_group_move_tree.tpl'}
{/if}
<div class="explanation">
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-162' replace='true'}<span class="bold">{grn_image image='facility20.gif'}{$facility_name}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-163' replace='true'} 
</div>

{literal}
<style TYPE="text/css">
.tree_input_box {
    padding: 0.3em;
    border: 1px solid #008899;
    background: #ffffff;
}

.tree_input_box .tree_input_inner_box {
    width: 100%;
}

.tree_input_box .tree-view {
    overflow-y: auto;
    width: 480px;
}

.tree_input_box .tree_navi {
    width: 100%;
}
  
.tree_input_box .tree_navi td {
    padding: 0;
}

.tree_view_result {
   width:480px;
   margin:3px 0;
   padding:2px 5px 5px 4px;
   border:1px solid #CCCCCC;
   background-color:white;
   overflow-x:scroll;
font-size: 90%;
}
</style>
{/literal}

<table class="std_form">

 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-164' replace='true'}
  </th>
  <td>
  {grn_image image="facilitygroup20.gif"}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-165' replace='true'}{foreach from=$fagidgroup.ancestors item="item"}&gt; {$item.col_name} {/foreach}
  </td>
</tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-166' replace='true'}
  </th>
  <td>
  <div class="tree_input_box">
    <div class="tree_input_inner_box">
      <div class="hilight">{grn_image image="facilitygroup20.gif"}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-167' replace='true'}{foreach from=$oidgroup.ancestors item="item"}&gt; {$item.col_name} {/foreach}</div>
      <hr>

{if $is_search}
<table class="tree_navi" border="0" cellpading="0" cellspacing="0">
<tr valign="bottom">
<td nowrap><nobr><span class="sub_title">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-168' replace='true'}</span></nobr></td>
<td nowrap>
<div class="search_navi">
          <form action="{grn_pageurl page="schedule/system/facility_parent_modify"}"><input type="hidden" name="fid" value="{$fid}" />
	  {if $org_id}<input type="hidden" name="oid" value="{$org_id}" />{else}<input type="hidden" name="top" value="1" />{/if}
          {grn_text necessary=true name='search_text' value=$search_text size='20'}{capture name='grn_schedule_system_GRN_SCH_SY_169'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-169' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_169}
	  </form>
</div>
</td>
</tr>
</table>

{else}
<table class="tree_navi" border="0" cellpading="0" cellspacing="0"><tbody>
<tr valign="bottom">
<td nowrap></td>
<td nowrap>
<div class="search_navi">
          <form action="{grn_pageurl page="schedule/system/facility_parent_modify"}"><input type="hidden" name="fid" value="{$fid}" />
	  {if $org_id}<input type="hidden" name="oid" value="{$org_id}" />{else}<input type="hidden" name="top" value="1" />{/if}
          {grn_text necessary=true name='search_text' value=$search_text size='20' class=""}{capture name='grn_schedule_system_GRN_SCH_SY_170'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-170' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_170}
	  </form>
</div>
</td>
</tr>
</tbody>
</table>
{/if}

{if $is_search}
      <div class="tree_view_result">
        {foreach from=$search_result item=s_item}
<nobr><a href="{grn_pageurl page="schedule/system/facility_parent_modify" oid=$s_item.fagid fid=$fid s=1}" class="">{grn_image image="facilitygroup20.gif"} {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-171' replace='true'}{foreach from=$s_item.ancestor item=item} &gt; {$item.col_name}{/foreach}</a></nobr><br>
	{/foreach}
<br />
{capture name='grn_schedule_system_GRN_SCH_SY_172'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-172' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_172 page="schedule/system/facility_parent_modify" oid=$org_id fid=$fid}
      </div>
     </div>
    </div>

{else}

      <div id="tree_view" class="tree-view">

{if $org_id}
{capture name='grn_schedule_system_GRN_SCH_SY_173'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-173' replace='true'}{/capture}{grn_link page='schedule/system/facility_parent_modify' top=1 fid=$fid caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_173}
{else}
{capture name='grn_schedule_system_GRN_SCH_SY_174'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-174' replace='true'}{/capture}{grn_link page='schedule/system/facility_parent_modify' top=1 fid=$fid caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_174 class='tree-select-current'}
{/if}        <div id="org_tree"></div>
      </div>
    </div>
  </div>
{/if}
   <tr>
  <td></td>
  <td>
<form method="POST" action="{grn_pageurl page="schedule/system/command_facility_parent_modify"}">
  <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <input type="hidden" name="fid" value="{$fid}" />
  <input type="hidden" name="oid" value="{$org_id}" />
       {capture name='grn_schedule_system_GRN_SCH_SY_175'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-175' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_175}
       {grn_button_cancel page='schedule/system/facility_view' faid=$fid}
</form>
  </td>
 </tr>


  </td>
 </tr>
</table>

{if ! $is_search}
<script language="JavaScript">
var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page=$ftree_async_page}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page='schedule/system/facility_parent_modify' fid=$fid}';

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
