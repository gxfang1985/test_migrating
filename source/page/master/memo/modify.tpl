{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class="memo-title"}

{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" id="mod" method="post" enctype="multipart/form-data" action="{grn_pageurl page='memo/command_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{capture name='grn_memo_GRN_MEM_41'}{cb_msg module='grn.memo' key='GRN_MEM-41' replace='true'}{/capture}{include file="memo/_memo_form.tpl" submit_caption=$smarty.capture.grn_memo_GRN_MEM_41 cancel_page='memo/view'}

</form>
{include file="grn/footer.tpl"}
