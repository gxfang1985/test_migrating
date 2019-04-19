{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{cb_msg module='grn.workflow.system' key='key_92_1' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.workflow.system' key='key_92_2' replace='true'}
</div>

{include file='grn/privilege_list.tpl' page_dir='workflow/system' page_prefix='workflow/system/' base_prefix=''}

{include file="grn/system_footer.tpl"}
