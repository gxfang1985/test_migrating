{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-448' replace='true'}<span class="bold">{grn_sentence caption=$form.name image='report20.gif'}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-449' replace='true'}</p>
 <p>
  {capture name='grn_report_system_GRN_RPRT_SY_450'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-450' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_450}
  {capture name='grn_report_system_GRN_RPRT_SY_451'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-451' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_451}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
</form>
{include file="grn/system_footer.tpl"}
