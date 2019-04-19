{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='timecard/system/command_'|cat:$page_info.last postfix='timecards.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="oid" value="{$org_id}">

<p>
<div class="explanation">{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-89' replace='true'}{grn_appname app_id='timecard'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-83' replace='true'}</div>
</p>
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_timecard_system_GRN_TIM_SY_84'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-84' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_timecard_system_GRN_TIM_SY_84}</th>
  <td>
{if $org_id == -1}
{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-85' replace='true'}
{else}
{foreach from=$user_list key=uid item=user}
{grn_user_name uid=$uid name=$user.name}
{/foreach}
{/if}
  </td>
 </tr>
</table>

<p>
{capture name='grn_timecard_system_GRN_TIM_SY_86'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-86' replace='true'}{/capture}{include file='timecard/_export.tpl' back_page='timecard/system/export_cards1' back_caption='<< '|cat:$smarty.capture.grn_timecard_system_GRN_TIM_SY_86 cancel_page='system/application_list' cancel_params=$cancel_params}

</form>

{include file='grn/system_footer.tpl'}
