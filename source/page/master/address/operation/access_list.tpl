{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<div class="explanation">
{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-130' replace='true'}<span class="bold">{grn_image image='person20.gif'}{$node.name|escape}</span>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-131' replace='true'}
{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-132' replace='true'}
<br>
{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-133' replace='true'}
</div>

{include file='grn/access_list.tpl' page_dir='address/operation' page_prefix='address/operation/' base_prefix=''}

{include file="grn/footer.tpl"}
