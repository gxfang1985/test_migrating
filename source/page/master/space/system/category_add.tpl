{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value="space/system/category_add"}

<form name="{$form_name}" method="post" action="{grn_pageurl page='space/system/command_category_add'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  {capture name='grn_space_system_GRN_SPACE_SY_1'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-1' replace='true'}{/capture}
  {include file='space/_category_form.tpl' submit_caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_1 cancel_page='space/system/category_list'}
</form>

{include file="grn/system_footer.tpl"}