{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/operation/command_category_add'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{capture name='grn_bulletin_operation_GRN_BLLT_OP_34'}{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-34' replace='true'}{/capture}{include file='bulletin/_category_form.tpl' submit_caption=$smarty.capture.grn_bulletin_operation_GRN_BLLT_OP_34 cancel_page='bulletin/index' copy_checked=1}

</form>
{include file="grn/footer.tpl"}
