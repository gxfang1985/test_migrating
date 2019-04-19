{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=""}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='memo/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{capture name='grn_memo_GRN_MEM_58'}{cb_msg module='grn.memo' key='GRN_MEM-58' replace='true'}{/capture}{include file='memo/_folder_form.tpl' submit_caption=$smarty.capture.grn_memo_GRN_MEM_58 cancel_page='memo/folder_view'}

</form>
{include file='grn/footer.tpl'}
