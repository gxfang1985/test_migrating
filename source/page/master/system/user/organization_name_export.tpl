{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_'|cat:$page_info.last postfix='ounit_name.csv'}">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.user' key='GRN_SY_US-496' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.user' key='GRN_SY_US-497' replace='true'}
  </th>
  <td>
      {capture name='grn_system_user_GRN_SY_US_498'}{cb_msg module='grn.system.user' key='GRN_SY_US-498' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_system_user_GRN_SY_US_498   checked=0}&nbsp;{capture name='grn_system_user_GRN_SY_US_499'}{cb_msg module='grn.system.user' key='GRN_SY_US-499' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_system_user_GRN_SY_US_499 checked=1}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.system.user' key='GRN_SY_US-693' replace='true'}
  </th>
  <td>
        {capture name='grn_system_user_GRN_SY_US_694'}{cb_msg module='grn.system.user' key='GRN_SY_US-694' replace='true'}{/capture}
        {grn_checkbox name='all' id='all' value='1' caption=$smarty.capture.grn_system_user_GRN_SY_US_694}
        {foreach from=$language_codes item="language_code"}
            {capture name='language_name'}{cb_language_name code=$language_code}{/capture}
            {grn_checkbox name=$language_code id=$language_code value='1' caption=$smarty.capture.language_name}
        {/foreach}
  </td>
 </tr>

 <tr>
  <td></td>
  <td>
       {capture name='grn_system_user_GRN_SY_US_500'}{cb_msg module='grn.system.user' key='GRN_SY_US-500' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_500}
       {grn_button_cancel page="system/user/org_export_index"}
  </td>
 </tr>
</table>
</form>

<hr>
<p>
{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-155' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-695' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-148' replace='true'}</div> 
{/capture}
{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='export'}

{include file="grn/system_footer.tpl"}
