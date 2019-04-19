{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-61' replace='true'}<span class="bold">{grn_sentence caption=$item.display_name class='person20'}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-62' replace='true'}
 <div class="attention"></div>
 </p>
 <p>
   {capture name='grn_report_system_GRN_RPRT_SY_63'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-63' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_63}
   {capture name='grn_report_system_GRN_RPRT_SY_64'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-64' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_64}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
<input type="hidden" name="iid" value="{$item_id|escape}">
</form>

{include file='grn/system_footer.tpl'}
