{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-103' replace='true'}</div></p>

{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr valign="top">
  <th nowrap>
      {capture name='grn_schedule_operation_GRN_SCH_OP_104'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-104' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_104}
  </th>
  <td>
      {capture name='grn_schedule_operation_GRN_SCH_OP_105'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-105' replace='true'}{/capture}
      {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_105 values=$multiLanguageInfoArray.values}
  </td>
 </tr>

 <tr valign="top">
  <th nowrap>
      {capture name='grn_schedule_operation_GRN_SCH_OP_106'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-106' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_106}
  </th>
  <td>
      {grn_text necessary=true name="facility_group_code" value=$facility_group.code size="50" disable_return_key=true}<br>
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-107' replace='true'}<br />{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-108' replace='true'}_{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-109' replace='true'}<br />{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-110' replace='true'}_{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-111' replace='true'}</div>
  </td>
 </tr>

 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-112' replace='true'}
  </th>
  <td>
      {grn_textarea name="memo" value=$facility.memo rows="5"}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-113' replace='true'}
  </th>
  <td>
  {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-114' replace='true'}{foreach from=$ancestors item='group'} &gt; {$group.col_name} {/foreach}
  </td>
 </tr>

 <input type="hidden" name="fagid" value="{$fagid}" />
 
 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_operation_GRN_SCH_OP_115'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-115' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_115}
       {grn_button_cancel page='schedule/operation/facility_list' oid=$fagid}
  </td>
 </tr>
</table>

</form>
{include file='grn/footer.tpl'}
