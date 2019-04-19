{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<div class="explanation">
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-381' replace='true'}<span class="bold">{grn_sentence image='report20.gif' caption=$form.name}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-382' replace='true'}<br>
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-383' replace='true'}
</div>
<p>

{include file="report/system/_category_parent.tpl" move_form=1 parent=$current page_prefix="report/system"}

{include file="grn/system_footer.tpl"}
