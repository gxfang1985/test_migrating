{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last postfix='schedules.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-150' replace='true'}
  </th>
  <td>
{foreach from=$selected_list key=key item=item}
 {if $item.type == 'user'}
  {grn_user_name uid=$item.uid nolink=1}
 {elseif $item.type == 'group'}
  {grn_organize_name gid=$item.gid cal_group=true}
 {elseif $item.type == 'facility'}
  {grn_image image='facility20.gif'}{$item.display_name|escape}
 {/if}
{/foreach}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-151' replace='true'}
  </th>
  <td>
      {grn_select_date prefix='start_' date=$stime form_name=$form_name}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-152' replace='true'}{grn_select_date prefix='end_' date=$etime form_name=$form_name}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-153' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-154' replace='true'}
  </th>
  <td>
      {capture name='grn_schedule_system_GRN_SCH_SY_155'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-155' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_155 checked=false}&nbsp;{capture name='grn_schedule_system_GRN_SCH_SY_156'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-156' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_156 checked=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-157' replace='true'}
  </th>
  <td>
      {capture name='grn_schedule_system_GRN_SCH_SY_158'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-158' replace='true'}{/capture}{grn_radio name="creator" id="creator_yes" value="1" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_158 checked=false}&nbsp;{capture name='grn_schedule_system_GRN_SCH_SY_159'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-159' replace='true'}{/capture}{grn_radio name="creator" id="creator_no" value="0" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_159 checked=true}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_system_GRN_SCH_SY_160'}<< {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-160' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_160 page='schedule/system/export1'}
       {capture name='grn_schedule_system_GRN_SCH_SY_161'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-161' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_161}
       {grn_button_cancel page="schedule/system/export_index"}
  </td>
 </tr>
</table>
<p>
<hr>
<p>
{include file='schedule/system/_event_csv_columns.tpl'}
{include file='grn/csv_columns.tpl' columns=$columns column_explanation=$smarty.capture.explanation type='export'}

</form>

{include file='grn/system_footer.tpl'}
