{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-91' replace='true'}</th>
  <td>
{if $set.name_format == 'full'}
       {capture name='grn_mail_personal_GRN_MAIL_PE_92'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-92' replace='true'}{/capture}{grn_radio name='name_format' id='name_format0' value='name' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_92}<br>
       {capture name='grn_mail_personal_GRN_MAIL_PE_93'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-93' replace='true'}{/capture}{grn_radio name='name_format' id='name_format1' value='email' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_93}<br>
       {capture name='grn_mail_personal_GRN_MAIL_PE_94'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-94' replace='true'}{/capture}{grn_radio name='name_format' id='name_format2' value='full' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_94 checked=TRUE}<br>
{elseif $set.name_format == 'email'}
       {capture name='grn_mail_personal_GRN_MAIL_PE_96'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-96' replace='true'}{/capture}{grn_radio name='name_format' id='name_format0' value='name' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_96}<br>
       {capture name='grn_mail_personal_GRN_MAIL_PE_97'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-97' replace='true'}{/capture}{grn_radio name='name_format' id='name_format1' value='email' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_97 checked=TRUE}<br>
       {capture name='grn_mail_personal_GRN_MAIL_PE_98'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-98' replace='true'}{/capture}{grn_radio name='name_format' id='name_format2' value='full' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_98}<br>
{else}
       {capture name='grn_mail_personal_GRN_MAIL_PE_100'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-100' replace='true'}{/capture}{grn_radio name='name_format' id='name_format0' value='name' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_100 checked=TRUE}<br>
       {capture name='grn_mail_personal_GRN_MAIL_PE_101'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-101' replace='true'}{/capture}{grn_radio name='name_format' id='name_format1' value='email' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_101}<br>
       {capture name='grn_mail_personal_GRN_MAIL_PE_102'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-102' replace='true'}{/capture}{grn_radio name='name_format' id='name_format2' value='full' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_102}<br>
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-104' replace='true'}</th>
  <td>
{if $set.file_save}
       {capture name='grn_mail_personal_GRN_MAIL_PE_105'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-105' replace='true'}{/capture}{capture name='grn_mail_personal_GRN_MAIL_PE_106'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-106' replace='true'}{/capture}{grn_checkbox name='file_save' id='file_save1' value='1' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_105|cat:$app_name|cat:$smarty.capture.grn_mail_personal_GRN_MAIL_PE_106 checked=TRUE}
{else}
       {capture name='grn_mail_personal_GRN_MAIL_PE_107'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-107' replace='true'}{/capture}{capture name='grn_mail_personal_GRN_MAIL_PE_108'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-108' replace='true'}{/capture}{grn_checkbox name='file_save' id='file_save1' value='1' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_107|cat:$app_name|cat:$smarty.capture.grn_mail_personal_GRN_MAIL_PE_108}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-109' replace='true'}</th>
  <td>
{if $set.view}
       {capture name='grn_mail_personal_GRN_MAIL_PE_110'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-110' replace='true'}{/capture}{grn_checkbox name='view' id='view1' value='1' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_110 checked=TRUE}
{else}
       {capture name='grn_mail_personal_GRN_MAIL_PE_111'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-111' replace='true'}{/capture}{grn_checkbox name='view' id='view1' value='1' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_111}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-112' replace='true'}</th>
  <td>
   {grn_mail_charset name='charset' default=$set.charset hide_select_encoding_msg=1 disable_onchange=1}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_mail_personal_GRN_MAIL_PE_113'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-113' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_113}
       {grn_button_cancel page='personal/application_list' app_id='mail'}
  </td>
 </tr>
</table>

</form>

{include file='grn/personal_footer.tpl'}
