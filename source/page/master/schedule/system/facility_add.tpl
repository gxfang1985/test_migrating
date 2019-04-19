{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-258' replace='true'}</div></p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_schedule_system_GRN_SCH_SY_259'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-259' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_259}
  </th>
  <td>
      {capture name='grn_schedule_system_GRN_SCH_SY_260'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-260' replace='true'}{/capture}
      {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_schedule_system_GRN_SCH_SY_260 values=$multiLanguageInfoArray.values}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {capture name='grn_schedule_system_GRN_SCH_SY_261'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-261' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_261 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_schedule_system_GRN_SCH_SY_262'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-262' replace='true'}{/capture}{validate form=$form_name field="facility_code" criteria="notEmpty" message=$smarty.capture.grn_schedule_system_GRN_SCH_SY_262 transform="cb_trim" append="validation_errors"}{grn_text necessary=true name="facility_code" value=$facility.code size="50" disable_return_key=true}<br>
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-263' replace='true'}</div>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-264' replace='true'}
  </th>
  <td>
      {grn_textarea name="memo" value=$facility.memo rows="5"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-265' replace='true'}
  </th>
  <td>
  <input type="hidden" name="fagid" value="{$fagid}" />
  {if $facility_group}
  {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-266' replace='true'}{foreach from=$facility_group item='group'} &gt; {$group.col_name} {/foreach}
  {else}
  {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-267' replace='true'}
  {/if}
  </td>
 </tr>
{*--- add VCBSCH0010 ---s*}
{include file='schedule/system/_netmeeting_facility.tpl'}
{*--- add VCBSCH0010 ---e*}
 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_system_GRN_SCH_SY_268'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-268' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_268 id="facility_add_submit"}
       {grn_button_cancel page='schedule/system/facility_group'}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
