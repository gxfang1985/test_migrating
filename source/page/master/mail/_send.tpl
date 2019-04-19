{grn_load_javascript file="fw/jquery/jquery-3.2.1.min.js"}
{grn_load_javascript file="fw/jquery/jquery-ui-1.12.1.custom.min.js"}

<script language="JavaScript" type="text/javascript">
jQuery.noConflict();
</script>

{grn_load_javascript file="grn/html/ui.mail.address.js"}
{grn_load_javascript file="grn/html/jquery.fcbkcomplete.js"}
{grn_load_javascript file="grn/html/component/mail/AddressArea.js"}
{grn_load_javascript file="grn/html/page/mail/_send.js"}
<script language="JavaScript" type="text/javascript">
<!--
var _send = grn.page.mail._send;
_send.form_name = '{$form_name|escape}';
_send.command_page = '{grn_pageurl page=mail/command_`$page_info.last`}';
_send.auto_complete_url = {if $incremental_search}'{grn_pageurl page="grn/get_data_auto_complete"}'{else}''{/if};
_send.popup_address_url = '{grn_pageurl page="mail/popup_address"}';
_send.error_message_1 = '{cb_msg module="grn.mail" key="GRN_MAIL-352" replace="true"}';
_send.error_message_2 = '{cb_msg module="grn.mail" key="GRN_MAIL-353" replace="true"}';
_send.mail_bcc = '{$mail.bcc}';
//-->
</script>

{if $no_setting neq '0'}
 {include file='mail/_no_setting.tpl' for_send=1}
{else}
 {*{include file='grn/indispensable.tpl'}*}
 {capture name='grn_mail_GRN_MAIL_354'}{cb_msg module='grn.mail' key='GRN_MAIL-354' replace='true'}{/capture}{validate form=$form_name field="recipient" criteria="notEmpty" message=$smarty.capture.grn_mail_GRN_MAIL_354 append="validation_errors"}
 <div class="mail-postButtonAreaTop-grn">{include file="$button_file" suffix="_top"}</div>
 <table class="std_form"> 
  <tr valign="middle">
   <td><span class="mail-sendLabel-grn">{cb_msg module='grn.mail' key='GRN_MAIL-44' replace='true'}</span></td>
   <td>{include file='mail/_change_send_account.tpl'}</td>
  </tr>
  
<tr style="display: none;">
   <td>
{if $account_id}
 {assign var='selected_aid' value=$account_id}
{else}
 {assign var='selected_aid' value=$aid}
{/if}
{foreach name=from_data from=$from_data item=from}
 {if $selected_aid == $from.aid}
    <span id="change_from_{$from.aid}"></span>
 {else}
    <span id="change_from_{$from.aid}" style="display:none"></span>
 {/if}
{/foreach}
   </td>
</tr>
  
  <tr valign="middle">
  <td>{if $disable_address}{cb_msg module='grn.mail' key='GRN_MAIL-357' replace='true'}{else}<input class="buttonStandard-grn mail-toButton-grn" type="button" value="{cb_msg module='grn.mail' key='GRN_MAIL-357' replace='true'}" onclick="_send.popupSelectAddress( this.form,'to' );"></input>{/if}</td>
   <td>
        <select id="selectTo" name="selectTo" class="hidden" ></select>
        <textarea  name="to" id="to" class="mail-textareaTo-grn hidden" maxlength="65535">{$mail.to}</textarea>
   </td>
   </tr>
   
   <tr valign="middle">
   <td>{if $disable_address}{cb_msg module='grn.mail' key='GRN_MAIL-423' replace='true'}{else}<input class="buttonStandard-grn mail-toButton-grn" type="button" value="{cb_msg module='grn.mail' key='GRN_MAIL-423' replace='true'}" onclick="_send.popupSelectAddress( this.form,'cc' );"></input>{/if}</td>
   <td>
        <select id="selectCC" name="selectCC" class="hidden" ></select>
        <textarea  name="cc" id="cc" class="mail-textareaTo-grn hidden" maxlength="65535">{$mail.cc}</textarea>
   </td>
   </tr>

   <tr id="add_bcc_mail" valign="middle">
   <td></td>
   <td>
        <a href="javascript:" onclick="_send.click_show_hide_bcc();">{cb_msg module='grn.mail' key='GRN_MAIL-416' replace='true'}</a>
   </td>
   </tr>
   
   <tr valign="middle" id="show_hide_bcc" style="display:none" >
        <td>{if $disable_address}{cb_msg module='grn.mail' key='GRN_MAIL-424' replace='true'}{else}<input class="buttonStandard-grn mail-toButton-grn" type="button" value="{cb_msg module='grn.mail' key='GRN_MAIL-424' replace='true'}" onclick="_send.popupSelectAddress( this.form,'bcc' );"></input>{/if}</td>
        <td valign="middle">
            <select id="selectBCC" name="selectBCC" class="hidden" ></select>
            <textarea  name="bcc" id="bcc" class="mail-textareaTo-grn hidden" maxlength="65535">{$mail.bcc}</textarea>
        </td>
    </tr>
    
  <tr>
   <td><span class="mail-sendLabel-grn">{cb_msg module='grn.mail' key='GRN_MAIL-361' replace='true'}&nbsp;&nbsp;&nbsp; </span></td>
   <td>{grn_text id="subject_mail" name="subject" value=$mail.subject size="104" maxlength="255" disable_return_key=true class="mail-textareaTitle-grn"}</td>
  </tr>

  <tr valign="top">
   <td></td>
   <td>{include file="grn/attach_file.tpl" attached_files=$mail.attached_files disable_return_key=true}</td>
  </tr>
  
  <tr valign="top">
   <td colspan="2">
{include file="grn/richeditor.tpl" html=$mail.html_data text=$mail.data cols=110 rows=$rows enable=$use_editor settings=2 class="form_textarea_grn mail-textareaBodytext-grn noautoexpand"}
   </td>
  </tr>
  
{if $user_sign[$aid].menu}
  <tr valign="top" id="display_sign">
{else}
  <tr valign="top" id="display_sign" style="display:none">
{/if}
   <td colspan="2"><span class="mail-sendLabel-grn">{cb_msg module='grn.mail' key='GRN_MAIL-364' replace='true'}</span> {include file='mail/_change_sign.tpl'}</td>
   <td></td>
  </tr>
  
{if $user_sign[$aid].menu}
  <tr valign="top" id="display_sign_1">
{else}
  <tr valign="top" id="display_sign_1" style="display:none">
{/if}
  <td colspan="2">{grn_textarea name="sign_value" value=$mail.sign rows="5" cols=92 flag_mail=1}</td>
  </tr>
{if $send_set}
  <tr>
   <td colspan="2"><span class="mail-sendLabel-grn">{cb_msg module='grn.mail' key='GRN_MAIL-365' replace='true'}</span> :{capture name='grn_mail_GRN_MAIL_366'}{cb_msg module='grn.mail' key='GRN_MAIL-366' replace='true'}{/capture} {grn_checkbox name='give_open_check' id='give_open_check1' value='1' caption=$smarty.capture.grn_mail_GRN_MAIL_366 checked="`$mail.give_open_check`"}</td>
   <td></td>
  </tr>
{/if}

  <tr>
   <td class="postButtonArea-grn" colspan="2">{include file="$button_file" suffix="_bottom"}</td>
   <td>
   </td>
  </tr>
 </table>
 <input type="hidden" name="cmd">
 <input type="hidden" name="aid" value="{$aid}">
 <input type="hidden" name="cid" value="{$cid}">
 <input type="hidden" name="uid" value="{$user.uid}">
 <input type="hidden" name="tmp_key" value="{$tmp_key}">
 <input type="hidden" name="hiDragging" id="hiDragging" >
 <input type="hidden" name="hiAcceptDrop" id="hiAcceptDrop" >
 <input type="hidden" name="position" id="position" value="{$position}">

{/if}
