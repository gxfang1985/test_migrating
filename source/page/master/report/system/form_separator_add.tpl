{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-96' replace='true'}<span class="bold">{if $category_id == GRN_REPORT_CATEGORY_NONPARTY_ID}{grn_image image='category_trush20.gif'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-97' replace='true'}{else}{grn_image image='category20.gif'}{$category.name|escape}{/if}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-98' replace='true'}</p>
 <p>
  {capture name='grn_report_system_GRN_RPRT_SY_99'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-99' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_99}
  {capture name='grn_report_system_GRN_RPRT_SY_100'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-100' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_100 page='report/system/form_list' cid=$category_id sf=1}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
</form>
{include file="grn/system_footer.tpl"}
