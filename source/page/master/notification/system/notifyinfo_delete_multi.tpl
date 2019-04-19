{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='notification/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-13' replace='true'}<span class="bold">{$selected_id_count}</span>{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-14' replace='true'}</p>
 <p>
  {capture name='grn_notification_system_GRN_NTFC_SY_15'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-15' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_15}
  {capture name='grn_notification_system_GRN_NTFC_SY_16'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-16' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_16}
 </p>
{foreach from=$selected_id_list item=selected_id}
<input type="hidden" name="eid[]" value="{$selected_id}">
{/foreach}
</form>
{include file='grn/system_footer.tpl'}
