{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="faid" value="{$facility.faid}">

<p><div class="explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-313' replace='true'}</div></p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_schedule_system_GRN_SCH_SY_314'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-314' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_314}
  </th>
  <td>
      {capture name='grn_schedule_system_GRN_SCH_SY_315'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-315' replace='true'}{/capture}
      {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_schedule_system_GRN_SCH_SY_315 values=$multiLanguageInfoArray.values}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {capture name='grn_schedule_system_GRN_SCH_SY_316'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-316' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_316 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_schedule_system_GRN_SCH_SY_317'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-317' replace='true'}{/capture}{validate form=$form_name field="facility_code" criteria="notEmpty" message=$smarty.capture.grn_schedule_system_GRN_SCH_SY_317 transform="cb_trim" append="validation_errors"}{grn_text necessary=true name="facility_code" value=$facility.code size="50" disable_return_key=true}<br>
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-318' replace='true'}</div>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-319' replace='true'}
  </th>
  <td>
      {grn_textarea name="memo" value=$facility.memo rows="5"}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-320' replace='true'}
  </th>
  <td>
      {if $facility.ancestors}
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-321' replace='true'}
      {foreach from=$facility.ancestors item=group} &gt; {$group.title} {/foreach}
      {else}
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-322' replace='true'}
      {/if} <br />
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-323' replace='true'}
  </td>
 </tr>
{*--- add VCBSCH0010 ---s*}
{include file='schedule/system/_netmeeting_facility.tpl'}
{*--- add VCBSCH0010 ---e*}
 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_system_GRN_SCH_SY_324'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-324' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_324}
       {grn_button_cancel page='schedule/system/facility_view' faid=$facility.faid}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
