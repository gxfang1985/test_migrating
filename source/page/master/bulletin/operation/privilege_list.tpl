{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{cb_msg module='grn.bulletin' key='GRN_BLLT-621' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.bulletin' key='GRN_BLLT-622' replace='true'}
{cb_msg module='grn.bulletin' key='GRN_BLLT-623' replace='true'}
</div>

{include file='grn/privilege_list.tpl' page_dir='bulletin/operation' page_prefix='bulletin/operation/' base_prefix=''}

{include file="grn/footer.tpl"}
