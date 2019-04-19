{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
 {cb_msg module='grn.report.system' key='GRN_RPRT_SY-420' replace='true'}<span class="bold">{if $category_id == GRN_REPORT_CATEGORY_NONPARTY_ID}{grn_image image='category_trush20.gif'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-421' replace='true'}{else}{grn_sentence image='category20.gif' caption=$category.name}{/if}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-422' replace='true'}</p>
 <p>
  {capture name='grn_report_system_GRN_RPRT_SY_423'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-423' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_423}
  {capture name='grn_report_system_GRN_RPRT_SY_424'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-424' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_424 page='report/system/form_list' cid=$category_id sf=1}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
</form>
{include file="grn/system_footer.tpl"}
