{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/system/command_category_name_export' postfix='category_name.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-94' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-95' replace='true'}
  </th>
  <td>
      {capture name='grn_bulletin_system_GRN_BLLT_SYS_96'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-96' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_96   checked=0}&nbsp;{capture name='grn_bulletin_system_GRN_BLLT_SYS_97'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-97' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_97 checked=1}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-172' replace='true'}
  </th>
  <td>
        {capture name='grn_bulletin_system_GRN_BLLT_SYS_173'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-173' replace='true'}{/capture}
        {grn_checkbox name='all' id='all' value='1' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_173}
        {foreach from=$language_codes item="language_code"}
            {capture name='language_name'}{cb_language_name code=$language_code}{/capture}
            {grn_checkbox name=$language_code id=$language_code value='1' caption=$smarty.capture.language_name}
        {/foreach}
  </td>
 </tr>

 <tr>
  <td></td>
  <td>
       {capture name='grn_bulletin_system_GRN_BLLT_SYS_98'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-98' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_98}
       {grn_button_cancel page="bulletin/system/export_index"}
  </td>
 </tr>
</table>

<hr>
<p>
{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-45' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-174' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-46' replace='true'}</div> 
{/capture}
{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='export'}


</form>
{include file="grn/system_footer.tpl"}
