{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<div class="explanation">
{cb_msg module='grn.workflow.system' key='key_157_1' replace='true'}<span class="bold">{grn_workflow_form_icon_image icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url}{grn_sentence caption=$form.name}</span>{cb_msg module='grn.workflow.system' key='key_157_2' replace='true'}<br>
{cb_msg module='grn.workflow.system' key='w_select_category_moved' replace='true'}
</div>
<p>

{include file="workflow/system/_category_parent.tpl" move_form=1 parent=$current page_prefix="workflow/system"}

{include file="grn/system_footer.tpl"}
