{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename|cat:$tmp_key}
{grn_load_javascript file="grn/html/report.js"}
{grn_load_javascript file="grn/html/page/report/edit.js"}

<form name="{$form_name}" method="post" action="{grn_pageurl page='report/command_'|cat:$page_info.last}" enctype="multipart/form-data" onsubmit="{literal}if (this.cmd.value == ''){return false};{/literal}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{* Navigation *}
<center>
<table border=0>
 <tr align="center">
  <td class="step_current_grn" valign="middle">{cb_msg module='grn.report' key='GRN_RPRT-185' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.report' key='GRN_RPRT-187' replace='true'}</td>
 </tr>
</table>
</center>
{* End Navigation *}

<p class="explanation">{cb_msg module='grn.report' key='GRN_RPRT-189' replace='true'}</p>
{assign var='half_width_number' value='1'}
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}

<p></p>
{cb_msg module='grn.report' key='GRN_RPRT-190' replace='true'}<span class="bold">{grn_image image='report20.gif'}{$form.name|escape}</span>{cb_msg module='grn.report' key='GRN_RPRT-191' replace='true'}
<p></p>

<table class="std_form">
  {include file='report/_item_section.tpl' item_list=$item_list category_id=$category_id form_id=$form_id form=$properties form_name=$form_name members=$members plugin=$plugin private=$private notification=$notification send_form=false creator_is_login=true}
 <tr>
  <td></td>
  <td>
      {strip}
          <div class="mTop10">
              {capture name='grn_report_GRN_RPRT_199'}{cb_msg module='grn.report' key='GRN_RPRT-199' replace='true'}{/capture}
              {capture name='grn_report_GRN_RPRT_200'}{cb_msg module='grn.report' key='GRN_RPRT-200' replace='true'}{/capture}
              {grn_button id="report_button_next" ui="main" spacing="loose" caption=$smarty.capture.grn_report_GRN_RPRT_199}
              {grn_button id="report_button_save" spacing="tight" class="button_submit_grn" caption=$smarty.capture.grn_report_GRN_RPRT_200}
              {if $properties.draft}
                  {grn_button id="report_button_cancel" action="cancel" page='report/view_draft' page_param_rid=$report_id}
              {else}
                  {grn_button id="report_button_cancel" action="cancel" page='report/view' page_param_rid=$report_id}
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
<input type="hidden" name="rid" value="{$report_id|escape}">
<input type="hidden" name="tmp_key" value="{$tmp_key|escape}">
<input type="hidden" name="upload_ticket" value="{$upload_ticket|escape}">
</form>

{include file="grn/footer.tpl"}