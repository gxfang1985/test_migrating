{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-232' replace='true'}<span class="bold">{grn_image image='report20.gif'}{grn_sentence caption=$form.name}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-233' replace='true'}<span class="bold">{$delete_numbers|escape}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-234' replace='true'}</p>
 <p>
  {capture name='grn_report_system_GRN_RPRT_SY_235'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-235' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_235}
  {capture name='grn_report_system_GRN_RPRT_SY_236'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-236' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_236}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
{foreach from=$item_id_list item=id}
<input type="hidden" name="ids[]" value="{$id|escape}">
{/foreach}
</form>
{include file="grn/system_footer.tpl"}
