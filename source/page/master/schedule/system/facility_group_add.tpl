{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-270' replace='true'}</div></p>

{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr valign="top">
  <th nowrap>
      {capture name='grn_schedule_system_GRN_SCH_SY_271'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-271' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_271}
  </th>
  <td>
      {capture name='grn_schedule_system_GRN_SCH_SY_272'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-272' replace='true'}{/capture}
      {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_schedule_system_GRN_SCH_SY_272 values=$multiLanguageInfoArray.values}
   <div class="br">&nbsp;</div>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {capture name='grn_schedule_system_GRN_SCH_SY_273'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-273' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_273}
  </th>
  <td>
      {grn_text necessary=true name="facility_group_code" value=$facility_group.code size="50" disable_return_key=true}<br>
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-274' replace='true'}<br />{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-275' replace='true'}_{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-276' replace='true'}<br />{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-277' replace='true'}_{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-278' replace='true'}</div>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-279' replace='true'}
  </th>
  <td>
      {grn_textarea name="memo" value=$facility_group.memo rows="5"}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-280' replace='true'}
  </th>
  <td>
  {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-281' replace='true'}{foreach from=$ancestors item='group'} &gt; {$group.col_name} {/foreach}
  </td>
 </tr>

 <input type="hidden" name="fagid" value="{$fagid}" />
 
 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_system_GRN_SCH_SY_282'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-282' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_282 id="`$page_info.last`_submit"}
       {grn_button_cancel page='schedule/system/facility_group'}
  </td>
 </tr>
</table>

</form>
{include file='grn/system_footer.tpl'}
