{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-39' replace='true'}<span class="bold">{$delete_item.delete_numbers}</span>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-40' replace='true'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-41' replace='true'}</p>
 <p>
  {capture name='grn_portal_operation_GRN_POT_OP_42'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-42' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_42}
  {capture name='grn_portal_operation_GRN_POT_OP_43'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-43' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_43}
 </p>
{foreach from=$delete_item.portlet item=eid}
<input type="hidden" name="eid[]" value="{$eid}">
{/foreach}
</form>
{include file='grn/footer.tpl'}
