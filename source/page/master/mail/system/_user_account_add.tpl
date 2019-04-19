{include file='grn/indispensable.tpl'}
<table class="std_form">
 <colgroup>
  <col style="width:16em">
 </colgroup>
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-335' replace='true'}
  </th>
  <td>
      {grn_user_name uid=$user.uid truncated=20}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {capture name='grn_mail_system_GRN_MAIL_SY_336'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-336' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_mail_system_GRN_MAIL_SY_336 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_mail_system_GRN_MAIL_SY_337'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-337' replace='true'}{/capture}{validate form=$page_info.all field="foreign_key" criteria="notEmpty" message=$smarty.capture.grn_mail_system_GRN_MAIL_SY_337 transform="cb_trim" append="validation_errors"}{grn_text name="foreign_key" size="30" value=$set.foreign_key}<br>
      <div class="br">&nbsp;</div>
      <div class="sub_explanation">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-338' replace='true'}</div>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-339' replace='true'}
  </th>
  <td>
      {grn_text name='name' size='50' value=$set.name}<br>
      <div class="br">&nbsp;</div>
      <div class="sub_explanation">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-340' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <td colspan="2" nowrap><br>
   <div class="sub_title">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-342' replace='true'}</div>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {capture name='grn_mail_system_GRN_MAIL_SY_343'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-343' replace='true'}{/capture}{validate form=$page_info.all field="mail_server" criteria="notEmpty" message=$smarty.capture.grn_mail_system_GRN_MAIL_SY_343 append="validation_errors"}{capture name='grn_mail_system_GRN_MAIL_SY_344'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-344' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_mail_system_GRN_MAIL_SY_344 necessary=TRUE}
  </th>
  <td>
       {grn_select name='mail_server' options=$mail_server onchange="changeDisplay(this,'display_set_send_account',$server_set_send,'sm');changeDisplay(this,'display_set_send_password',$server_set_send,'sm')"}
{if $set.msid eq ''}
       &nbsp;{include file='mail/_mailserver_viewlist.tpl' system_page=$system_page}
{else}
       <span class="attention">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-345' replace='true'}</span>
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_mail_system_GRN_MAIL_SY_346'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-346' replace='true'}{/capture}{validate form=$page_info.all criteria="notEmpty" field="email" message=$smarty.capture.grn_mail_system_GRN_MAIL_SY_346 transform="cb_trim" append="validation_errors"}{grn_show_input_title title='E-mail' necessary=TRUE}
  </th>
  <td>
       {grn_text name='email' size='50' value=$set.email}
  </td>
 </tr>
 <tr>
  <th nowrap>
   {capture name='grn_mail_system_GRN_MAIL_SY_347'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-347' replace='true'}{/capture}{validate form=$page_info.all criteria="notEmpty" field="account" message=$smarty.capture.grn_mail_system_GRN_MAIL_SY_347 transform="cb_trim" append="validation_errors"}{capture name='grn_mail_system_GRN_MAIL_SY_348'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-348' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_mail_system_GRN_MAIL_SY_348 necessary=TRUE}
  </th>
  <td>
       {grn_text name='account' size='50' value=$set.account}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-349' replace='true'}
  </th>
  <td>
      {capture name='grn_mail_system_GRN_MAIL_SY_350'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-350' replace='true'}{/capture}{grn_password name="password" purpose='modify' size=50 maxlength=64 title=$smarty.capture.grn_mail_system_GRN_MAIL_SY_350 disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-351' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-352' replace='true'}
  </th>
  <td>
{if $set.leave_server_mail eq 'LEAVE'}
       {capture name='grn_mail_system_GRN_MAIL_SY_353'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-353' replace='true'}{/capture}{grn_radio name='leave_server_mail' id='leave_server_mail1' value='LEAVE' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_353 checked=TRUE}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_354'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-354' replace='true'}{/capture}{grn_radio name='leave_server_mail' id='leave_server_mail2' value='DELETE' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_354}<br>
{else}
       {capture name='grn_mail_system_GRN_MAIL_SY_355'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-355' replace='true'}{/capture}{grn_radio name='leave_server_mail' id='leave_server_mail1' value='LEAVE' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_355}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_356'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-356' replace='true'}{/capture}{grn_radio name='leave_server_mail' id='leave_server_mail2' value='DELETE' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_356 checked=TRUE}<br>
{/if}
  </td>
 </tr>
{if $set.set_send}
 <tr id="display_set_send_account">
{else}
 <tr id="display_set_send_account" style="display:none">
{/if}
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-357' replace='true'}
  </th>
  <td>
       {grn_text name='send_account' size='50' value=$set.send_account}
  </td>
 </tr>
{if $set.set_send}
 <tr id="display_set_send_password">
{else}
 <tr id="display_set_send_password" style="display:none">
{/if}
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-358' replace='true'}
  </th>
  <td>
      {capture name='grn_mail_system_GRN_MAIL_SY_359'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-359' replace='true'}{/capture}{grn_password name="send_password" purpose='modify' size=50 maxlength=64 title=$smarty.capture.grn_mail_system_GRN_MAIL_SY_359 disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-360' replace='true'}
  </th>
  <td>
{if $set.stop}
       {capture name='grn_mail_system_GRN_MAIL_SY_361'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-361' replace='true'}{/capture}{grn_checkbox name="stop" id='stop1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_361 checked=TRUE}
{else}
       {capture name='grn_mail_system_GRN_MAIL_SY_362'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-362' replace='true'}{/capture}{grn_checkbox name="stop" id='stop1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_362}
{/if}
  </td>
 </tr>
{if 0}
 <tr>
  <th colspan="2" nowrap><br>
   <div class="sub_title">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-363' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-364' replace='true'}</div>
  </th>
 </tr>
{/if}

{if 0}
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-365' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-366' replace='true'}
  </th>
  <td>
 {if $set.mail_check}
       {capture name='grn_mail_system_GRN_MAIL_SY_367'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-367' replace='true'}{/capture}{grn_radio name='mail_check' id='mail_check1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_367 checked=TRUE}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_368'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-368' replace='true'}{/capture}{grn_radio name='mail_check' id='mail_check2' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_368}<br>
 {else}
       {capture name='grn_mail_system_GRN_MAIL_SY_369'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-369' replace='true'}{/capture}{grn_radio name='mail_check' id='mail_check1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_369}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_370'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-370' replace='true'}{/capture}{grn_radio name='mail_check' id='mail_check2' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_370 checked=TRUE}<br>
 {/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-371' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-372' replace='true'}
  </th>
  <td>
       {grn_select_numbers select_name=$select1.name options=$select1.options padding=$select1.padding selected=$select1.selected}&nbsp;{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-373' replace='true'}<br>
  </td>
 </tr>
{/if}
 <tr>
  <td></td>
  <td nowrap>
       {include file="$button_file"}
  </td>
 </tr>
</table>

<input type="hidden" name="oid" value="{$org_id}">
<input type="hidden" name="uid" value="{$user.uid}">
