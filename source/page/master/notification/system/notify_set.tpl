{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='notification/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-9' replace='true'}</th>
  <td>{capture name='grn_notification_system_GRN_NTFC_SY_10'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-10' replace='true'}{/capture}{grn_checkbox name="is_not_receive" id="0" value="1" checked=$setting caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_10}</td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_notification_system_GRN_NTFC_SY_11'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-11' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_11}
       {grn_button_cancel}
  </td>
 </tr>
</table>

</form>

{include file="grn/system_footer.tpl"}
