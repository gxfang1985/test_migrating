{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='bulletin/command_draft_send'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{if ! $category_name}{capture name='grn_bulletin_GRN_BLLT_97'}{cb_msg module='grn.bulletin' key='GRN_BLLT-97' replace='true'}{/capture}{assign var="category_name" value=$smarty.capture.grn_bulletin_GRN_BLLT_97}{/if}
{include file="bulletin/_send.tpl" form_name=$form_name cancel_page="bulletin/draft_view" submit_page='bulletin/command_draft_send'}
</form>
{include file="grn/footer.tpl"}
