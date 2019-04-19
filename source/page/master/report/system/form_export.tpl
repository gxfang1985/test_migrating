{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last postfix=$filename postfix='form.xml'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-237' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$category.name}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-238' replace='true'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-239' replace='true'}</p>
<p>
 {capture name='grn_report_system_GRN_RPRT_SY_240'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-240' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_240}
 {capture name='grn_report_system_GRN_RPRT_SY_241'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-241' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_241 page='report/system/form_list' cid=$category.cid}
</p>
<input type="hidden" name="cid" value="{$category.cid|escape}">
</form>

{include file='grn/system_footer.tpl'}
