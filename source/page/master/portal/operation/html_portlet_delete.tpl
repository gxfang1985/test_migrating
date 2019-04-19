{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="plid" value="{$portlet.plid}">
 <p>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-199' replace='true'}<span class="bold">{grn_image image='portlet20.gif'}{$portlet.title|escape}</span>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-200' replace='true'}</p>
 <p>
  {capture name='grn_portal_operation_GRN_POT_OP_201'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-201' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_201}
  {capture name='grn_portal_operation_GRN_POT_OP_202'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-202' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_202}
 </p>
</form>
{include file='grn/footer.tpl'}
