{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-285' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-286' replace='true'}
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-287' replace='true'}
</div>

{include file='grn/privilege_list.tpl' page_dir='report/system' page_prefix='report/system/' base_prefix=''}

{include file="grn/system_footer.tpl"}
