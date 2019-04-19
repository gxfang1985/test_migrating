{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<div class="explanation">
{cb_msg module='grn.workflow.system' key='key_157_1' replace='true'}{grn_workflow_form_icon_image icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url}<span class="bold">{grn_sentence caption=$form.name}</span>{cb_msg module='grn.workflow.system' key='key_157_2' replace='true'}<br>
{cb_msg module='grn.workflow.system' key='w_select_category_moved' replace='true'}
</div>
<p>

{include file="workflow/operation/_category_parent.tpl" move_form=1 parent=$current page_prefix="workflow/operation"}

{include file="grn/footer.tpl"}
