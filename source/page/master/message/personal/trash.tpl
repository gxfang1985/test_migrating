{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-68' replace='true'}</th>
  <td>
{if $selected.use == '1'}
  {capture name='grn_message_personal_GRN_MSG_PE_69'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-69' replace='true'}{/capture}{grn_checkbox name='use' id='checkbox_id' value='1' caption=$smarty.capture.grn_message_personal_GRN_MSG_PE_69 checked=true}
{else}
  {capture name='grn_message_personal_GRN_MSG_PE_70'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-70' replace='true'}{/capture}{grn_checkbox name='use' id='checkbox_id' value='1' caption=$smarty.capture.grn_message_personal_GRN_MSG_PE_70}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-71' replace='true'}</th>
  <td>{grn_select_numbers select_name=$select1.name options=$select1.options selected=$selected.set_day padding=$select1.padding}&nbsp;{cb_msg module='grn.message.personal' key='GRN_MSG_PE-72' replace='true'}</td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_message_personal_GRN_MSG_PE_73'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-73' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_message_personal_GRN_MSG_PE_73}
  {grn_button_cancel page='personal/application_list' app_id='message'}
  </td>
 </tr>
</table>

</form>

{include file='grn/personal_footer.tpl'}
