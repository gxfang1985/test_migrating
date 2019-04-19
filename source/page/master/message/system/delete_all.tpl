{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$page_info.all}
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

 <div class="explanation">
  {cb_msg module='grn.message.system' key='GRN_MSG_SY-98' replace='true'}{$app_name}{cb_msg module='grn.message.system' key='GRN_MSG_SY-99' replace='true'}
  <div class="attention">{cb_msg module='grn.message.system' key='GRN_MSG_SY-100' replace='true'}{$app_name}{cb_msg module='grn.message.system' key='GRN_MSG_SY-101' replace='true'}</div>
 </div>

<p>
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.message.system' key='GRN_MSG_SY-102' replace='true'}</th>
  <td>{grn_select_date prefix='term_' date=$date form_name=$form_name}&nbsp;{cb_msg module='grn.message.system' key='GRN_MSG_SY-103' replace='true'}{$app_name}</td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_message_system_GRN_MSG_SY_104'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-104' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_message_system_GRN_MSG_SY_104}
       {grn_button_cancel page='system/application_list' app_id='message'}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
