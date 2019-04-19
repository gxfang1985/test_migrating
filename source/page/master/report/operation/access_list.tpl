{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-194' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-195' replace='true'}
{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-196' replace='true'}
<br>
{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-459' replace='true'}
</div>

{include file='grn/access_list.tpl' page_dir='report/operation' page_prefix='report/operation/' base_prefix=''}

{include file="grn/footer.tpl"}
