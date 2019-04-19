{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-459' replace='true'}<span class="bold">{grn_sentence caption=$form.name image='report20.gif'}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-460' replace='true'}{if $form.active == 1}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-461' replace='true'}{else}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-462' replace='true'}{/if}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-463' replace='true'}</p>
 <p>
  {capture name='grn_report_system_GRN_RPRT_SY_464'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-464' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_464}
  {capture name='grn_report_system_GRN_RPRT_SY_465'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-465' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_465}
 </p>
 <input type="hidden" name="cid" value="{$category_id|escape}">
 <input type="hidden" name="fid" value="{$form_id|escape}">
 <input type="hidden" name="active" value="{$form.active|escape}">
</form>
{include file='grn/system_footer.tpl'}
