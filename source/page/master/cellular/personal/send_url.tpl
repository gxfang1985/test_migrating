{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
{if $system_config.login_url && $system_config.system_mail && $account.address}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cellular/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">
{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-1' replace='true'}{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-2' replace='true'}<br>
</div>

<p>
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-4' replace='true'}</th>
  <td>{$account.foreign_key|escape}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-5' replace='true'}</td>
  <td>{$account.address|escape}</td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_cellular_personal_GRN_CLLL_PE_9'}{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-9' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_cellular_personal_GRN_CLLL_PE_9}
  {grn_button_cancel page='personal/application_list' app_id='cellular'}
  </td>
 </tr>
</table>

</form>

{else}
<div id="view">
 <p>{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-10' replace='true'}</p>
 <ul>
{if ! $account.address}
  <li>{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-11' replace='true'}
{/if}
{if ! $system_config.login_url}
  <li>{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-13' replace='true'}
{/if}
{if ! $system_config.system_mail}
  <li>{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-14' replace='true'}
{/if}
 </ul>
 <p>{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-15' replace='true'}</p>
 <ul>
{if ! $account.address}
  <li>{capture name='grn_cellular_personal_GRN_CLLL_PE_18'}{cb_msg module='grn.cellular.personal' key='GRN_CLLL_PE-18' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_cellular_personal_GRN_CLLL_PE_18 page='cellular/personal/account'}<br>
{/if}
 </ul>
</div>
{/if}

{include file='grn/personal_footer.tpl'}
