{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-208' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-209' replace='true'}
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-210' replace='true'}
<br>
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-567' replace='true'}
</div>

{include file='grn/access_list.tpl' page_dir='report/system' page_prefix='report/system/' base_prefix=''}

{include file="grn/system_footer.tpl"}
