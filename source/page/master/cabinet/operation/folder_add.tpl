{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/operation/command_folder_add'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{capture name='grn_cabinet_operation_GRN_CAB_OP_1'}{cb_msg module='grn.cabinet.operation' key='GRN_CAB_OP-1' replace='true'}{/capture}{include file='cabinet/_folder_form.tpl' submit_caption=$smarty.capture.grn_cabinet_operation_GRN_CAB_OP_1 cancel_page='cabinet/index' copy_checked=1}

</form>
{include file="grn/footer.tpl"}
