{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-82' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-83' replace='true'}
{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-84' replace='true'}
</div>

{include file='grn/privilege_list.tpl' page_dir='bulletin/system' page_prefix='bulletin/system/' base_prefix=''}

{include file="grn/system_footer.tpl"}
