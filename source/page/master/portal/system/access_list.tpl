{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{if 'portal' == $node.type}
{cb_msg module='grn.portal.system' key='GRN_POT_SY-115' replace='true'}<span class="bold">{grn_image image='portal20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-116' replace='true'}
{else}
{cb_msg module='grn.portal.system' key='GRN_POT_SY-117' replace='true'}<span class="bold">{grn_image image='portlet20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-118' replace='true'}
{/if}
<br>
{cb_msg module='grn.portal.system' key='GRN_POT_SY-533' replace='true'}
</div>

{include file='grn/access_list.tpl' page_dir='portal/system' page_prefix='portal/system/' base_prefix=''}

{include file="grn/system_footer.tpl"}