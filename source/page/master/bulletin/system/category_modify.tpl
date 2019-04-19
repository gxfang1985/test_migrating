{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/system/command_category_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{capture name='grn_bulletin_system_GRN_BLLT_SYS_103'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-103' replace='true'}{/capture}{include file='bulletin/_category_form.tpl' submit_caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_103 cancel_page='bulletin/system/category_view'}

</form>

{include file="grn/system_footer.tpl"}
