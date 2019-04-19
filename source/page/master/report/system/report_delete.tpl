{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-242' replace='true'}<span class="bold">{grn_image image='report20.gif'}{grn_sentence caption=$report.name}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-243' replace='true'}</p>
 <p>
   {capture name='grn_report_system_GRN_RPRT_SY_244'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-244' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_244}
   {capture name='grn_report_system_GRN_RPRT_SY_245'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-245' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_245}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
<input type="hidden" name="rid" value="{$report_id|escape}">
</form>

{include file='grn/system_footer.tpl'}
