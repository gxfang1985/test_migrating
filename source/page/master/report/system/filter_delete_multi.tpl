{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="filter_name" value=$smarty.template|basename}
<form name="{$filter_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-529' replace='true'}<span class="bold">{if $category_id == GRN_REPORT_CATEGORY_NONPARTY_ID}{capture name='grn_report_system_GRN_RPRT_SY_530'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-530' replace='true'}{/capture}{grn_sentence image='category_trush20.gif' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_530}{else}{grn_sentence image='category20.gif' caption=$category.name}{/if}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-531' replace='true'}<span class="bold">{$delete_numbers|escape}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-532' replace='true'}</p>
 <p>
  {capture name='grn_report_system_GRN_RPRT_SY_533'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-533' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_533}
  {capture name='grn_report_system_GRN_RPRT_SY_534'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-534' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_534 page='report/system/filter_index' cid=$category_id sf=1}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
{foreach from=$filter_id_list item=id}
<input type="hidden" name="ids[]" value="{$id|escape}">
{/foreach}
</form>
{include file="grn/system_footer.tpl"}
