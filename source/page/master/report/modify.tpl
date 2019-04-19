{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename|cat:$tmp_key}

{grn_load_javascript file="grn/html/report.js"}

<form name="{$form_name}" method="post" action="{grn_pageurl page='report/command_'|cat:$page_info.last}" enctype="multipart/form-data" onsubmit="{literal}if (this.cmd.value == ''){return false};{/literal}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p class="explanation">{cb_msg module='grn.report' key='GRN_RPRT-112' replace='true'}</p>
{assign var='half_width_number' value='1'}
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}

<p></p>
{cb_msg module='grn.report' key='GRN_RPRT-113' replace='true'}<span class="bold">{grn_image image='report20.gif'}{$report.form_name|escape}</span>{cb_msg module='grn.report' key='GRN_RPRT-114' replace='true'}
<p></p>

<table class="std_form">
  {include file='report/_item_section.tpl' item_list=$item_list event=$event event_id=$event_id event_date=$event_date event_item=$event_item category_id=$category_id form_id=$form_id form=$report form_name=$form_name members=$members notification=$notification plugin=$plugin private=$private modify=true}
 <tr>
  <td></td>
  <td>
      {strip}
          <div class="mTop10">
              {capture name='grn_report_GRN_RPRT_124'}{cb_msg module='grn.report' key='GRN_RPRT-124' replace='true'}{/capture}
              {capture name="onreportmodify"}jQuery(this).closest("form")[0].cmd.value="next"; grn_onsubmit_common(document.forms['{$form_name}']); grn.component.button.util.submit(this);{/capture}
              {grn_button id="report_button_next" ui="main" spacing="normal" auto_disable=true caption=$smarty.capture.grn_report_GRN_RPRT_124 onclick=$smarty.capture.onreportmodify}
              {grn_button id="report_button_cancel" action="cancel" page='report/view' page_param_rid=$report_id}
          </div>
      {/strip}
  </td>
 </tr>
</table>
<input type="hidden" name="cmd" value="">
<input type="hidden" name="sf"  value="1" />
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
<input type="hidden" name="rid" value="{$report_id|escape}">
<input type="hidden" name="sf" value="1">
<input type="hidden" name="tmp_key" value="{$tmp_key|escape}">
</form>

{include file="grn/footer.tpl"}
