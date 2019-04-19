{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cellular/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">
{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-19' replace='true'}
</div>

<p>
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-21' replace='true'}</th>
  <td>{$account.foreign_key|escape}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-22' replace='true'}</th>
  <td>{capture name='grn_cellular_personal_GRN_CLLL_PE_23'}{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-23' replace='true'}{/capture}{validate form=$form_name field="cellular_address" criteria="grn_isEmail" message=$smarty.capture.grn_cellular_personal_GRN_CLLL_PE_23 empty="yes" append="validation_errors"}{grn_text name="cellular_address" value=$account.address size=50 disable_return_key=true}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-24' replace='true'}</th>
  <td>{capture name='grn_cellular_personal_GRN_CLLL_PE_25'}{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-25' replace='true'}{/capture}{grn_checkbox name="suspension" id="suspension" value="1" checked=$account.suspension caption=$smarty.capture.grn_cellular_personal_GRN_CLLL_PE_25}</td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_cellular_personal_GRN_CLLL_PE_26'}{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-26' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_cellular_personal_GRN_CLLL_PE_26}
  {grn_button_cancel page='personal/application_list' app_id='cellular'}
  </td>
 </tr>
</table>

</form>

{include file='grn/personal_footer.tpl'}
