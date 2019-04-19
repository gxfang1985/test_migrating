{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{if $set.system}

<table class="std_form">
 <tr>
  <th nowrap>
     {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-16' replace='true'}
  </th>
  <td>
 {if $set.used}
      {capture name='grn_schedule_personal_GRN_SCH_PE_17'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-17' replace='true'}{/capture}{grn_checkbox name='forward_mail' id='checkbox_id' value='1' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_17 checked=true}
 {else}
      {capture name='grn_schedule_personal_GRN_SCH_PE_18'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-18' replace='true'}{/capture}{grn_checkbox name='forward_mail' id='checkbox_id' value='1' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_18}
 {/if}
  </td>
 </tr>
 {if $set.manage}
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-84' replace='true'}
  </th>
  <td>
      {if $set.facility_rely_mail}
          {capture name='grn_schedule_personal_GRN_SCH_PE_85'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-85' replace='true'}{/capture}{grn_checkbox name='forward_facility_rely_mail' id='facility_rely_mail' value='1' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_85 checked=true}
      {else}
          {capture name='grn_schedule_personal_GRN_SCH_PE_86'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-86' replace='true'}{/capture}{grn_checkbox name='forward_facility_rely_mail' id='facility_rely_mail' value='1' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_86}
      {/if}
  </td>
 </tr>
 {/if}
 <tr valign="top">
  <th nowrap>
     {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-19' replace='true'}
  </th>
  <td>
 {if $set.mail.address}
  {if $set.mail.value == 0}
      {capture name='grn_schedule_personal_GRN_SCH_PE_20'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-20' replace='true'}{/capture}{grn_radio name='mail' id='0' value='0' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_20 checked=true}({$set.mail.address})<br>
      {capture name='grn_schedule_personal_GRN_SCH_PE_21'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-21' replace='true'}{/capture}{grn_radio name='mail' id='1' value='1' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_21}
  {else}
      {capture name='grn_schedule_personal_GRN_SCH_PE_22'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-22' replace='true'}{/capture}{grn_radio name='mail' id='0' value='0' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_22}({$set.mail.address})<br>
      {capture name='grn_schedule_personal_GRN_SCH_PE_23'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-23' replace='true'}{/capture}{grn_radio name='mail' id='1' value='1' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_23 checked=true}
  {/if}
 {else}
      <input type="hidden" name="mail" value="1">
 {/if}
      {grn_text name="other_mail" size="50" value=$set.mail.other}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_schedule_personal_GRN_SCH_PE_24'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-24' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_24}
      {grn_button_cancel class='margin' page='personal/application_list' app_id='schedule'}
  </td>
 </tr>
</table>

{else}
 <p>{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-25' replace='true'}</p>
 <ul>
 <li>{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-26' replace='true'}
 </ul>
 <p>
  <div class="explanation">
   {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-27' replace='true'}<br>
   {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-28' replace='true'}<br>
  </div>
   
 </p>
{/if}

</form>

{include file='grn/personal_footer.tpl'}
