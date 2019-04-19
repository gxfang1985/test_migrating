{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{cb_msg module='grn.portal.system' key='GRN_POT_SY-151' replace='true'}<span class="bold">{grn_image image='portlet20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-152' replace='true'}
{cb_msg module='grn.portal.system' key='GRN_POT_SY-153' replace='true'}
</div>

{include file='grn/privilege_list.tpl' page_dir='portal/system' page_prefix='portal/system/portlet_group_' base_prefix='portlet_group_'}

{include file="grn/system_footer.tpl"}
