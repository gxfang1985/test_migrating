{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='space/system/command_category_name_export' postfix='category_name.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.space.system' key='category_name_export-1' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.space.system' key='category_name_export-2' replace='true'}
  </th>
  <td>
      {capture name='tmp'}{cb_msg module='grn.space.system' key='category_name_export-3' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.tmp checked=0}&nbsp;{capture name='tmp'}{cb_msg module='grn.space.system' key='category_name_export-4' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.tmp checked=1}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.space.system' key='category_name_export-6' replace='true'}
  </th>
  <td>
        {capture name='tmp'}{cb_msg module='grn.space.system' key='category_name_export-7' replace='true'}{/capture}
        {grn_checkbox name='all' id='all' value='1' caption=$smarty.capture.tmp}
        {foreach from=$language_codes item="language_code"}
            {capture name='language_name'}{cb_language_name code=$language_code}{/capture}
            {grn_checkbox name=$language_code id=$language_code value='1' caption=$smarty.capture.language_name}
        {/foreach}
  </td>
 </tr>

 <tr>
  <td></td>
  <td>
       {capture name='tmp'}{cb_msg module='grn.space.system' key='category_name_export-9' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.tmp}
       {grn_button_cancel page="space/system/export_index"}
  </td>
 </tr>
</table>

<hr>
<p>
{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.space.system' key='category_name_export-10' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.space.system' key='category_name_export-11' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.space.system' key='category_name_export-12' replace='true'}</div> 
{/capture}
{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='export'}


</form>
{include file="grn/system_footer.tpl"}
