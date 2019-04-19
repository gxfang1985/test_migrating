{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-271' replace='true'}<span class="bold">{grn_image image='person20.gif'}{$node.name|escape}</span>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-272' replace='true'}
{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-273' replace='true'}
<br>
{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-302' replace='true'}
</div>

{include file='grn/access_list.tpl' page_dir='address/system' page_prefix='address/system/' base_prefix=''}

{include file="grn/system_footer.tpl"}
