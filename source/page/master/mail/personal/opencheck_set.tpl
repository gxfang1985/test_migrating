{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{literal}
<script language="JavaScript" type="text/javascript">
<!--
function disable_no_response_bcc(e)
{
   var d = document.getElementById('form1');
   switch(e.value)
   {
   case 'ignore':
   case 'manual':
      d.no_response_bcc1.checked  = false;

      var l = document.getElementsByTagName('label');
      for(i=0;i<l.length;i++)
      {
         var forName = l[i].getAttributeNode('for');
         if(forName.nodeValue == 'no_response_bcc1')
         {
            l[i].className = 'form_disable';
         }
     }

      d.no_response_bcc1.disabled = true;
      break;
   case 'auto':
      d.no_response_bcc1.disabled = false;
      var l = document.getElementsByTagName('label');
      for(i=0;i<l.length;i++)
      {
         var forName = l[i].getAttributeNode('for');
         if(forName.nodeValue == 'no_response_bcc1')
         {
            l[i].className = '';
         }
     }
   }
}
//-->
</script>
{/literal}
<form name="{$form_name}" id='form1' method="post" action="{grn_pageurl page='mail/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-193' replace='true'}</th>
  <td>{capture name='grn_mail_personal_GRN_MAIL_PE_194'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-194' replace='true'}{/capture}{capture name='grn_mail_personal_GRN_MAIL_PE_195'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-195' replace='true'}{/capture}{grn_checkbox name='send_set' id='send_set1' value='1' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_194|cat:$app_name|cat:$smarty.capture.grn_mail_personal_GRN_MAIL_PE_195 checked=$set.send_set}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-196' replace='true'}</th>
  <td>
{if $set.receive_set == 'auto'}
   {capture name='grn_mail_personal_GRN_MAIL_PE_197'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-197' replace='true'}{/capture}{grn_radio name='receive_set' id='receive_set0' value='ignore' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_197 onclick='disable_no_response_bcc(this)'}<br>
   {capture name='grn_mail_personal_GRN_MAIL_PE_198'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-198' replace='true'}{/capture}{grn_radio name='receive_set' id='receive_set2' value='manual' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_198 onclick='disable_no_response_bcc(this)'}<br>
   {capture name='grn_mail_personal_GRN_MAIL_PE_199'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-199' replace='true'}{/capture}{grn_radio name='receive_set' id='receive_set1' value='auto' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_199 checked=TRUE onclick='disable_no_response_bcc(this)'}<br>
{elseif $set.receive_set == 'ignore'}
   {capture name='grn_mail_personal_GRN_MAIL_PE_200'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-200' replace='true'}{/capture}{grn_radio name='receive_set' id='receive_set0' value='ignore' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_200 checked=TRUE onclick='disable_no_response_bcc(this)'}<br>
   {capture name='grn_mail_personal_GRN_MAIL_PE_201'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-201' replace='true'}{/capture}{grn_radio name='receive_set' id='receive_set2' value='manual' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_201 onclick='disable_no_response_bcc(this)'}<br>
   {capture name='grn_mail_personal_GRN_MAIL_PE_202'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-202' replace='true'}{/capture}{grn_radio name='receive_set' id='receive_set1' value='auto' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_202 onclick='disable_no_response_bcc(this)'}<br>
{else}
   {capture name='grn_mail_personal_GRN_MAIL_PE_203'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-203' replace='true'}{/capture}{grn_radio name='receive_set' id='receive_set0' value='ignore' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_203 onclick='disable_no_response_bcc(this)'}<br>
   {capture name='grn_mail_personal_GRN_MAIL_PE_204'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-204' replace='true'}{/capture}{grn_radio name='receive_set' id='receive_set2' value='manual' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_204 checked=TRUE onclick='disable_no_response_bcc(this)'}<br>
   {capture name='grn_mail_personal_GRN_MAIL_PE_205'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-205' replace='true'}{/capture}{grn_radio name='receive_set' id='receive_set1' value='auto' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_205 onclick='disable_no_response_bcc(this)'}<br>
{/if}
{if $set.receive_set == 'auto'}
 {capture name='grn_mail_personal_GRN_MAIL_PE_206'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-206' replace='true'}{/capture}{grn_checkbox name='no_response_bcc' id='no_response_bcc1' value='1' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_206 checked=$set.no_response_bcc}
{else}
 {capture name='grn_mail_personal_GRN_MAIL_PE_208'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-208' replace='true'}{/capture}{grn_checkbox name='no_response_bcc' id='no_response_bcc1' value='1' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_208 checked=$set.no_response_bcc disabled=TRUE}
{/if}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
   {capture name='grn_mail_personal_GRN_MAIL_PE_210'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-210' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_210}
   {grn_button_cancel page='personal/application_list' app_id='mail'}
  </td>
 </tr>
</table>
</form>
{include file='grn/personal_footer.tpl'}
