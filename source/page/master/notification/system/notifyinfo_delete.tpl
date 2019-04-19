{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='notification/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-19' replace='true'}<span class="bold">{grn_image image='notify20.gif'}{$app.name|escape}</span>{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-20' replace='true'}</p>
 <p>
  {capture name='grn_notification_system_GRN_NTFC_SY_21'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-21' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_21}
  {capture name='grn_notification_system_GRN_NTFC_SY_22'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-22' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_22}
 </p>
<input type="hidden" name="app_id" value="{$app.app_id}">
</form>
{include file='grn/system_footer.tpl'}
