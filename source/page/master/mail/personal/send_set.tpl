{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{if $no_setting neq '0'}
 {include file='mail/_no_setting.tpl'}
{else}
 {assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/wm.js"}

  <table class="std_form">
   <tr valign="top">
    <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-21' replace='true'}</th>
    <td>
        <form name="account" method="post" action="{grn_pageurl page='mail/personal/command_send_account'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        {grn_image image='mailaccount20.gif'}&nbsp;{grn_select name=user_account options=$user_account onchange="this.form.submit()"}
        </form>
        {if $set.stop}
         <span class="attention">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-20' replace='true'}</span>
        {/if}
    </td>
   </tr>
   
  <form name="{$form_name}" method="post" action="{grn_pageurl page='mail/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <input type="hidden" name="aid" value="{$account_id}">
   <tr>
    <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-22' replace='true'}</th>
    <td>
       {grn_text name='from_name' size='50' value=$set.from_name}<br>
       {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-23' replace='true'}<br>
       {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-25' replace='true'}
    </td>
   </tr>
   <tr>
    <td></td>
    <td>
       {capture name='grn_mail_personal_GRN_MAIL_PE_26'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-26' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_26}
       {grn_button_cancel page='personal/application_list' app_id='mail'}
    </td>
   </tr>
  </form>

  </table>

{/if}

{include file='grn/personal_footer.tpl'}
