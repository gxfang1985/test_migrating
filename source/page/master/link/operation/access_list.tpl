{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{cb_msg module='grn.link.operation' key='GRN_LNK_OP-41' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-42' replace='true'}
{cb_msg module='grn.link.operation' key='GRN_LNK_OP-43' replace='true'}
<br>
{cb_msg module='grn.link.operation' key='GRN_LNK_OP-132' replace='true'}
</div>

{include file='grn/access_list.tpl' page_dir='link/operation' page_prefix='link/operation/' base_prefix=''}

{include file="grn/footer.tpl"}
