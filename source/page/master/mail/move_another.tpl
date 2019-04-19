{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/wm.js"}
<div class="mainarea-mail">
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{cb_msg module='grn.mail' key='GRN_MAIL-290' replace='true'}<br>
{cb_msg module='grn.mail' key='GRN_MAIL-291' replace='true'}<span class="bold">{$move_numbers|escape}</span>
 <p>
 <table class="std_form">
  <tr>
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-292' replace='true'}</th>
   <td><div>{grn_image image='mailaccount20.gif'}{$set.account|escape}</div><div>{grn_mail_get_folder_name folder_id=$category_id}</div></td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-293' replace='true'}</th>
   <td>{include file='mail/_change_folder.tpl' selected_folder_id=$folder.cid hide_root_folder=1 hide_garbage_folder=1 a_name='daccount' c_name='dcid'}</td>
  </tr>
  <tr>
   <td></td>
   <td>
       {strip}
           {capture name='grn_mail_GRN_MAIL_294'}{cb_msg module='grn.mail' key='GRN_MAIL-294' replace='true'}{/capture}
           {grn_button id="mail_button_move" ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_mail_GRN_MAIL_294}
           {grn_button id="mail_button_cancel" action="cancel"}
       {/strip}
   </td>
  </tr>
 </table>
 <input type="hidden" name="cmd" value="move">
 <input type="hidden" name="aid" value="{$aid}">
 <input type="hidden" name="cid" value="{$category_id}">
{foreach from=$mails item=id}
 <input type="hidden" name="mail_ids[]" value="{$id}">
{/foreach}
</form>
</div>
{include file='grn/footer.tpl'}
