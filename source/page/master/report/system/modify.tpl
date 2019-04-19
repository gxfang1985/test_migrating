{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename|cat:$tmp_key}
{if ! $page_prefix}{assign var='page_prefix' value='report/system'}{/if}
{grn_load_javascript file="grn/html/report.js"}

<form name="{$form_name}" method="post" action="{grn_pageurl page=$page_prefix|cat:'/command_'|cat:$page_info.last}" enctype="multipart/form-data" onsubmit="{literal}if (this.cmd.value == ''){return false};{/literal}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p class="explanation">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-218' replace='true'}</p>
{assign var='half_width_number' value='1'}
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}

<p></p>
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-219' replace='true'}<span class="bold">{grn_image image='report20.gif'}{$report_form_name|escape}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-220' replace='true'}
<p></p>

<table class="std_form">
  {include file='report/_item_section.tpl' item_list=$item_list event=$event event_id=$event_id event_date=$event_date event_item=$event_item category_id=$category_id form_id=$form_id form=$report form_name=$form_name members=$members plugin=$plugin private=$private notification=$notification modify=true}
 <tr>
  <td></td>
  <td>
   {capture name='grn_report_system_GRN_RPRT_SY_230'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-230' replace='true'}{/capture}{grn_button_submit class='button_bold margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_230 onclick='this.form.cmd.value="next";if(confirmIfExistFailedFile() && report_file_validate(false)) grn_onsubmit_common(this.form); else return false;'}
   {grn_button_cancel class="margin" page=$page_prefix|cat:'/report_view' cid=$category_id fid=$form_id rid=$report_id}
  </td>
 </tr>
</table>
<input type="hidden" name="sf" value="1">
<input type="hidden" name="cmd" value="">
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
<input type="hidden" name="rid" value="{$report_id|escape}">
<input type="hidden" name="tmp_key" value="{$tmp_key|escape}">
</form>

{include file="grn/system_footer.tpl"}
