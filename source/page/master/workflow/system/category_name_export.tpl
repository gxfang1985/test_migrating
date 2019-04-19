{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name='{$form_name}' method='post' action='{grn_pageurl page="workflow/system/command_category_name_export" postfix="workflow_category_name.csv"}'><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.system' key='w_char_code_y' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.system' key='w_export_top_line_y' replace='true'}
  </th>
  <td>
      {capture name='grn_workflow_system_w_yes'}{cb_msg module='grn.workflow.system' key='w_yes' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_workflow_system_w_yes   checked=0}&nbsp;{capture name='grn_workflow_system_w_no'}{cb_msg module='grn.workflow.system' key='w_no' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_workflow_system_w_no checked=1}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-88' replace='true'}
  </th>
  <td>
        {capture name='grn_workflow_system_GRN_WKF_SYS_89'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-89' replace='true'}{/capture}
        {grn_checkbox name='all' id='all' value='1' caption=$smarty.capture.grn_workflow_system_GRN_WKF_SYS_89}
        {foreach from=$language_codes item="language_code"}
            {capture name='language_name'}{cb_language_name code=$language_code}{/capture}
            {grn_checkbox name=$language_code id=$language_code value='1' caption=$smarty.capture.language_name}
        {/foreach}
  </td>
 </tr>

 <tr>
  <td></td>
  <td>
       {capture name='grn_workflow_system_w_export_y'}{cb_msg module='grn.workflow.system' key='w_export_y' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_workflow_system_w_export_y}
       {grn_button_cancel page="workflow/system/export_index"}
  </td>
 </tr>
</table>

<hr>
<p>
{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.workflow' key='category_code' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-90' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.workflow' key='category_name' replace='true'}</div> 
{/capture}
{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='export'}

</form>
{include file='grn/system_footer.tpl'}
