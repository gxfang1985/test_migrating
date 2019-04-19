{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-56' replace='true'}</th>
  <td>{grn_sentence caption=$set.account image='mailaccount20.gif'}
{if $set.stop}
       <br><span class="attention">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-20' replace='true'}</span>
{/if}
  </td>
 </tr>
 <tr>
  <td><br></td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_mail_personal_GRN_MAIL_PE_58'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-58' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_58 necessary=TRUE}</th>
  <td>{capture name='grn_mail_personal_GRN_MAIL_PE_59'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-59' replace='true'}{/capture}{validate form=$form_name field="sign_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_59 append="validation_errors"}{grn_text name='sign_name' size='50' value=$set.name}</td>
 </tr>
 <tr>
    <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-257' replace='true'}</th>
    <td>{capture name='grn_mail_personal_GRN_MAIL_PE_258'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-258' replace='true'}{/capture}{grn_radio name='position_signature' id='position_top' value='top' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_258 checked=$top}&nbsp;&nbsp;&nbsp;&nbsp;{capture name='grn_mail_personal_GRN_MAIL_PE_259'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-259' replace='true'}{/capture}{grn_radio name='position_signature' id='position_bottom' value='bottom' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_259 checked=$bottom}
</td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-60' replace='true'}</th>
  <td>{grn_textarea name='sign_value' cols='50' rows='10' value=$set.value}</td>
 </tr>
 <tr>
  <td></td>
  <td>
       {include file="$button_file"}
  </td>
 </tr>
</table>
