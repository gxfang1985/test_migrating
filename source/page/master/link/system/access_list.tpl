{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{cb_msg module='grn.link.system' key='GRN_LNK_SY-70' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.link.system' key='GRN_LNK_SY-71' replace='true'}
{cb_msg module='grn.link.system' key='GRN_LNK_SY-72' replace='true'}
<br>
{cb_msg module='grn.link.system' key='GRN_LNK_SY-220' replace='true'}
</div>

{include file='grn/access_list.tpl' page_dir='link/system' page_prefix='link/system/' base_prefix=''}

{include file="grn/system_footer.tpl"}
