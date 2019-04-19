{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=""}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='memo/command_add'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

    {capture name='grn_memo_GRN_MEM_5'}{cb_msg module='grn.memo' key='GRN_MEM-5' replace='true'}{/capture}{include file="memo/_memo_form.tpl" submit_caption=$smarty.capture.grn_memo_GRN_MEM_5 cancel_page='memo/index'}

</form>
{include file="grn/footer.tpl"}
