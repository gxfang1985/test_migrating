{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<div class="explanation">
{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-320' replace='true'}<span class="bold">{grn_sentence image='report20.gif' caption=$form.name}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-321' replace='true'}<br>
{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-322' replace='true'}
</div>
<p>

{include file="report/operation/_category_parent.tpl" move_form=1 parent=$current page_prefix="report/operation"}

{include file="grn/footer.tpl"}
