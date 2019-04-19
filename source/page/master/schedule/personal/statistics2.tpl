{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/personal/command_'|cat:$page_info.last postfix='schedules.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-4' replace='true'}
  </th>
  <td>
{foreach from=$selected_list key=key item=item}
 {if $item.type == 'user'}
  {grn_user_name uid=$item.uid nolink=1}
 {elseif $item.type == 'group'}
  {grn_organize_name gid=$item.gid cal_group=true}
 {/if}
{/foreach}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-5' replace='true'}
  </th>
  <td>
      {grn_select_date prefix='start_' date=$stime form_name=$form_name}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-6' replace='true'}{grn_select_date prefix='end_' date=$etime form_name=$form_name}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-7' replace='true'}
  </th>
  <td>
      {grn_select_time prefix='shour_' time=$set.shour minute_interval=$set.unit use_24_hours=true necessary=true}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-8' replace='true'}{grn_select_time prefix='ehour_' time=$set.ehour minute_interval=$set.unit use_24_hours=true necessary=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-9' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-10' replace='true'}
  </th>
  <td>
      {if $set.showholiday}
      {capture name='grn_schedule_personal_GRN_SCH_PE_11'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-11' replace='true'}{/capture}{grn_checkbox name='holiday' id='checkbox_id1' value='1' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_11}<br>
      {/if}
      {capture name='grn_schedule_personal_GRN_SCH_PE_12'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-12' replace='true'}{/capture}{grn_checkbox name='saturday' id='checkbox_id2' value='2' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_12}<br>
      {capture name='grn_schedule_personal_GRN_SCH_PE_13'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-13' replace='true'}{/capture}{grn_checkbox name='sunday' id='checkbox_id3' value='3' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_13}<br>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_personal_GRN_SCH_PE_14'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-14' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_14 page='schedule/personal/statistics1' keep='1'}
       {capture name='grn_schedule_personal_GRN_SCH_PE_15'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-15' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_15}
       {grn_button_cancel page="personal/application_list" app_id="schedule"}
  </td>
 </tr>
</table>

</form>

{include file='grn/personal_footer.tpl'}
