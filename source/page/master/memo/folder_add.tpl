{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=""}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='memo/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{capture name='grn_memo_GRN_MEM_4'}{cb_msg module='grn.memo' key='GRN_MEM-4' replace='true'}{/capture}{include file='memo/_folder_form.tpl' submit_caption=$smarty.capture.grn_memo_GRN_MEM_4 cancel_page='memo/index'}

</form>
{include file='grn/footer.tpl'}
