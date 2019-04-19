{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='phonemessage/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{if $available_system_email}

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.phonemessage.personal' key='GRN_PHM_PE-11' replace='true'}{$application_name}{cb_msg module='grn.phonemessage.personal' key='GRN_PHM_PE-12' replace='true'}</th>
  <td>{capture name='grn_phonemessage_personal_GRN_PHM_PE_13'}{cb_msg module='grn.phonemessage.personal' key='GRN_PHM_PE-13' replace='true'}{$application_name}{cb_msg module='grn.phonemessage.personal' key='GRN_PHM_PE-14' replace='true'}{/capture}{grn_checkbox name='forward_email' id='forward_email' value='1' caption=$smarty.capture.grn_phonemessage_personal_GRN_PHM_PE_13 checked=$forward_email}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.phonemessage.personal' key='GRN_PHM_PE-2' replace='true'}{$application_name}{cb_msg module='grn.phonemessage.personal' key='GRN_PHM_PE-3' replace='true'}<br>{cb_msg module='grn.phonemessage.personal' key='GRN_PHM_PE-4' replace='true'}</th>
  <td>
{if $user_email_address}
 {if ! $forward_user_email}{assign var='forward_system_email' value=true}{/if}
  {capture name='grn_phonemessage_personal_GRN_PHM_PE_5'}{cb_msg module='grn.phonemessage.personal' key='GRN_PHM_PE-5' replace='true'}{/capture}{grn_radio name='forward_user_email' id='forward_user_email_address' value='1' caption=$smarty.capture.grn_phonemessage_personal_GRN_PHM_PE_5 checked=$forward_user_email}&nbsp;{cb_msg module='grn.phonemessage.personal' key='GRN_PHM_PE-6' replace='true'}{$user_email_address|escape}{cb_msg module='grn.phonemessage.personal' key='GRN_PHM_PE-7' replace='true'}<br>
  {capture name='grn_phonemessage_personal_GRN_PHM_PE_8'}{cb_msg module='grn.phonemessage.personal' key='GRN_PHM_PE-8' replace='true'}{/capture}{grn_radio name='forward_user_email' id='forward_other_email_address' value='0' caption=$smarty.capture.grn_phonemessage_personal_GRN_PHM_PE_8 checked=$forward_system_email}
{/if}
  {grn_text name='other_email_address' size='50' value=$other_email_address}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_phonemessage_personal_GRN_PHM_PE_9'}{cb_msg module='grn.phonemessage.personal' key='GRN_PHM_PE-9' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_phonemessage_personal_GRN_PHM_PE_9}
  {grn_button_cancel}
  </td>
 </tr>
</table>

{else}
  <p>
   <div class="explanation">{cb_msg module='grn.phonemessage.personal' key='GRN_PHM_PE-10' replace='true'}</div>
   
  </p>
{/if}

</form>

{include file="grn/personal_footer.tpl"}
