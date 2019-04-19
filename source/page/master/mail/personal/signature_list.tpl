{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{if $no_setting neq '0'}
 {include file='mail/_no_setting.tpl'}
{else}
 {assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/wm.js"}

  <div>
   <form name="account" method="post" action="{grn_pageurl page='mail/personal/command_signature_account'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-182' replace='true'}{grn_image image='mailaccount20.gif'}&nbsp;{grn_select name='user_account' options=$user_account onchange="this.form.submit()"}
   </form>
    {if $set.stop}
     <span class="attention">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-20' replace='true'}</span>
    {/if}
  </div>
   
<div id="main_menu_part">
 {if $set.aid == '0'}{* 選択してください状態の時 *}
<span class="menu_item">{capture name='grn_mail_personal_GRN_MAIL_PE_177'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-177' replace='true'}{/capture}{grn_link image='write20.gif' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_177 page='mail/personal/signature_add' disabled=TRUE}</span>
<span class="menu_item">{capture name='grn_mail_personal_GRN_MAIL_PE_178'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-178' replace='true'}{/capture}{grn_link image='order20.gif' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_178 page='mail/personal/signature_order' disabled=TRUE}</span>
 {else}
<span class="menu_item">{capture name='grn_mail_personal_GRN_MAIL_PE_179'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-179' replace='true'}{/capture}{grn_link image='write20.gif' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_179 page='mail/personal/signature_add' aid=$set.aid}</span>
<span class="menu_item">{capture name='grn_mail_personal_GRN_MAIL_PE_180'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-180' replace='true'}{/capture}{grn_link image='order20.gif' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_180 page='mail/personal/signature_order' aid=$set.aid disabled=$disabled_change_order}</span>
 {/if}
</div>

  <form name="{$form_name}" method="post" action="{grn_pageurl page='mail/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
   <table class="admin_list_table" width="100%">
    <colgroup>
     <col width="1%">
     <col width="100%">
    </colgroup>
    <tr>
     <th nowrap>{include file="grn/checkall.tpl" elem_name="ids[]"}</th>
     <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-183' replace='true'}</th>
    </tr>
 {foreach from=$sign_list item=sign}
    <tr valign="top">
     <td><input type="checkbox" name="ids[]" value="{$sign.sid}"></td>
     <td>
      {grn_link image='signature20.gif' caption=$sign.name page='mail/personal/signature_view' aid=$set.aid sid=$sign.sid}
     </td>
    </tr>
 {/foreach}
   </table>
{grn_delete title=$delete_info_multi.title page=$delete_info_multi.page no_confirm=$delete_info_multi.no_confirm data=$delete_info_multi.data handler=$delete_info_multi.handler multi_target=$delete_info_multi.multi_target form_target=$delete_info_multi.form_target}
<div class="margin_top">
       {capture name='grn_mail_personal_GRN_MAIL_PE_184'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-184' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_184 id="btn_delete_multi" onclick="return false;"}
</div>

  <input type="hidden" name="cmd">
  <input type="hidden" name="aid" value="{$set.aid}">
  </form>
{/if}

{include file='grn/personal_footer.tpl'}
