{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cellular/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">
{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-18' replace='true'}<br>
{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-20' replace='true'}
</div>

<p>
<table class="std_form">
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-22' replace='true'}</th>
  <td>
  {capture name='grn_cellular_system_GRN_CLLL_SY_23'}{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-23' replace='true'}{/capture}{validate form=$form_name field="login_url" criteria="grn_isURL" message=$smarty.capture.grn_cellular_system_GRN_CLLL_SY_23 transform="trim" append="validation_errors"}{grn_text name="login_url" value=$login_url size=80  maxlength="255" disable_return_key=true}<br>
  {cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-25' replace='true'}&nbsp;<b>{$sample_url|escape}</b>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_cellular_system_GRN_CLLL_SY_26'}{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-26' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_cellular_system_GRN_CLLL_SY_26}
  {grn_button_cancel page='system/application_list' app_id='cellular'}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
