{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{if 'portal' == $node.type}
{$app_name|escape}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-44' replace='true'}<span class="bold">{grn_image image='portal20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-45' replace='true'}
{else}
{cb_msg module='grn.portal.operation' key='GRN_POT_OP-46' replace='true'}<span class="bold">{grn_image image='portlet20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-47' replace='true'}
{/if}
<br>
{cb_msg module='grn.portal.operation' key='GRN_POT_OP-225' replace='true'}
</div>

{include file='grn/access_list.tpl' page_dir='portal/operation' page_prefix='portal/operation/' base_prefix=''}

{include file="grn/footer.tpl"}
