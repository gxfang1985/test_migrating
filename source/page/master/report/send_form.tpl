{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename|cat:$tmp_key}
{grn_load_javascript file="grn/html/report.js"}
{grn_load_javascript file="grn/html/page/report/edit.js"}

<form name="{$form_name}" method="post" action="{grn_pageurl page='report/command_'|cat:$page_info.last}" enctype="multipart/form-data" onsubmit="{literal}if (this.cmd.value == ''){return false};{/literal}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{* Start Navigation *}
<center>
<table border=0>
 <tr align="center">
  <td class="step_grn" valign="middle">{cb_msg module='grn.report' key='GRN_RPRT-13' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_current_grn" valign="middle">{cb_msg module='grn.report' key='GRN_RPRT-15' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.report' key='GRN_RPRT-17' replace='true'}</td>
 </tr>
</table>
</center>
{* End Navigation *}

<p class="explanation">{cb_msg module='grn.report' key='GRN_RPRT-19' replace='true'}</p>
{assign var='half_width_number' value='1'}
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}

<p></p>
{cb_msg module='grn.report' key='GRN_RPRT-20' replace='true'}<span class="bold">{grn_image image='report20.gif'}{$form.name|escape}</span>{cb_msg module='grn.report' key='GRN_RPRT-21' replace='true'}
<p></p>

<table class="std_form">
 {include file='report/_item_section.tpl' item_list=$item_list event=$event event_id=$event_id event_date=$str_date event_item=$event_item category_id=$category_id form_id=$form_id form=$form form_name=$form_name members=$members notification=$notification operators=$operators plugin=$plugin private=$private send_form=true creator_is_login=true operator_open=$operator_open}
 <tr>
  <td></td>
  <td>
      {strip}
          <div class="mTop10">
              {capture name='grn_report_GRN_RPRT_30'}{cb_msg module='grn.report' key='GRN_RPRT-30' replace='true'}{/capture}
              {capture name='grn_report_GRN_RPRT_31'}{cb_msg module='grn.report' key='GRN_RPRT-31' replace='true'}{/capture}
              {grn_button id="report_button_next" ui="main" spacing="loose" caption=$smarty.capture.grn_report_GRN_RPRT_30}
              {grn_button id="report_button_save" class="button_submit_grn" spacing="tight" caption=$smarty.capture.grn_report_GRN_RPRT_31 }
              {if $event_id > 0}
                  {* From Schedule Cooperation *}
                  {grn_button id="report_button_cancel" action="cancel" page='schedule/view' page_param_event=$event_id page_param_bdate=$str_date}
              {else}
                  {grn_button id="report_button_cancel" action="cancel" page='report/send' page_param_cid=$category_id}
              {/if}
          </div>
      {/strip}
  </td>
 </tr>
</table>
<input type="hidden" name="sf" value="1">
<input type="hidden" name="cmd" value="">
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
<input type="hidden" name="tmp_key" value="{$tmp_key|escape}">
{if $event_id > 0}
    <input type="hidden" name="eid" value="{$event_id}">
    <input type="hidden" name="date" value="{$str_date}">
{/if}
</form>

{include file="grn/footer.tpl"}
