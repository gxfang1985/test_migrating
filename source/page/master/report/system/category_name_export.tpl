{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name='{$form_name}' method='post' action='{grn_pageurl page="report/system/command_category_name_export" postfix="report_category_name.csv"}'><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.report.system' key='GRN_RPRT_SY-504' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.report.system' key='GRN_RPRT_SY-505' replace='true'}
  </th>
  <td>
      {capture name='grn_report_system_GRN_RPRT_SY_506'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-506' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_506   checked=0}&nbsp;{capture name='grn_report_system_GRN_RPRT_SY_507'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-507' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_507 checked=1}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.report.system' key='GRN_RPRT_SY-563' replace='true'}
  </th>
  <td>
        {capture name='grn_report_system_GRN_RPRT_SY_564'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-564' replace='true'}{/capture}
        {grn_checkbox name='all' id='all' value='1' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_564}
        {foreach from=$language_codes item="language_code"}
            {capture name='language_name'}{cb_language_name code=$language_code}{/capture}
            {grn_checkbox name=$language_code id=$language_code value='1' caption=$smarty.capture.language_name}
        {/foreach}
  </td>
 </tr>

 <tr>
  <td></td>
  <td>
       {capture name='grn_report_system_GRN_RPRT_SY_508'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-508' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_508}
       {grn_button_cancel page="report/system/export_index"}
  </td>
 </tr>
</table>

<hr>
<p>
{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.report' key='GRN_RPRT-354' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.report.system' key='GRN_RPRT_SY-565' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.report' key='GRN_RPRT-355' replace='true'}</div> 
{/capture}
{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='export'}

</form>
{include file='grn/system_footer.tpl'}
