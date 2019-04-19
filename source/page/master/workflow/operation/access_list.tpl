{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{cb_msg module='grn.workflow.system' key='key_154_1' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.workflow.system' key='key_154_2' replace='true'}
<br />
{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-95' replace='true'}
</div>

{include file='grn/access_list.tpl' page_dir='workflow/operation' page_prefix='workflow/operation/' base_prefix=''}

{include file="grn/footer.tpl"}
