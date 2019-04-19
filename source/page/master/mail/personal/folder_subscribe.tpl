{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{if $no_setting neq '0'}
 {include file='mail/_no_setting.tpl'}
{else}
 {assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/wm.js"}

<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

  <table class="std_form">
   <tr valign="top">
    <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-53' replace='true'}</th>
    <td nowrap>{grn_image image='mailaccount20.gif'}&nbsp;{grn_select name='naccount' options=$user_account onchange="cmd.value='change_account';this.form.submit()"}
     {if $set.stop}
    <br><span class="attention">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-20' replace='true'}</span>     {/if}
    </td>
   </tr>
   <tr>
    <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-52' replace='true'}</th>
    <td nowrap>
 {foreach name=folder_data from=$folder_list.data item=folder}
  {if $folder_list.selected == $folder.aid}
      <span id="change_folder_{$smarty.foreach.folder_data.iteration}">{grn_mail_select_folders select_name="ncid"|cat:$smarty.foreach.folder_data.iteration account_id=$folder.aid hide_root_folder='1' hide_garbage_folder='1' need_checkbox='1'}</span>
  {else}
      <span id="change_folder_{$smarty.foreach.folder_data.iteration}" style="display:none">{grn_mail_select_folders select_name="ncid"|cat:$smarty.foreach.folder_data.iteration account_id=$folder.aid hide_root_folder='1' hide_garbage_folder='1' need_checkbox='1'}</span>
  {/if}
 {/foreach}
    </td>
  </table>
  
      {capture name='grn_mail_personal_GRN_MAIL_PE_55'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-55' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_55}
      {grn_button_cancel page="personal/application_list" app_id="mail"}
      <input type='hidden' name='cmd'>
</form>
{/if}

{include file='grn/personal_footer.tpl'}
