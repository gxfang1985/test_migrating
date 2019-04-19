{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_mail_system_GRN_MAIL_SY_204'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-204' replace='true'}{/capture}{grn_link image='modify20.gif' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_204 page='mail/system/user_account_modify' oid=$org_id uid=$user.uid aid=$set.aid}</span>
<span class="menu_item">{capture name='grn_mail_system_GRN_MAIL_SY_205'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-205' replace='true'}{/capture}{grn_link image='delete20.gif' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_205 page='mail/system/user_account_delete' oid=$org_id uid=$user.uid aid=$set.aid}</span>
</div>

<p>
<table class="view_table" width="90%">
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-206' replace='true'}
  </th>
  <td>
      {grn_user_name uid=$user.uid truncated=20}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-207' replace='true'}
  </th>
  <td>
      {$set.foreign_key|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-208' replace='true'}
  </th>
  <td>
      {$set.name|escape}
  </td>
 </tr>
</table>

<p>
<div class="sub_title">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-209' replace='true'}</div>
<table class="view_table" width="90%">
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-210' replace='true'}
  </th>
  <td>
      {$set.mail_server|escape}&nbsp;{include file='mail/_mailserver_viewlist.tpl' system_page=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      E-mail
  </th>
  <td>
      {$set.email|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-211' replace='true'}
  </th>
  <td>
      {$set.account|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-212' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-213' replace='true'}
  </th>
  <td>
      {if $set.leave_server_mail eq 'LEAVE'}{capture name='grn_mail_system_GRN_MAIL_SY_214'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-214' replace='true'}{/capture}{grn_sentence class='check20' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_214}{else}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-215' replace='true'}{/if}
  </td>
 </tr>
{if $set.set_send}
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-216' replace='true'}
  </th>
  <td>
      {$set.send_account|escape}
  </td>
 </tr>
{/if}
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-217' replace='true'}
  </th>
  <td>
      {if !$set.stop}<font color="green">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-218' replace='true'}</font>{else}<font color="red">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-219' replace='true'}</font>{/if}
  </td>
 </tr>
{if 0}
 <tr>
  <th nowrap><br>
     <div class="sub_title">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-220' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-221' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-222' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-223' replace='true'}
  </th>
  <td>
      {if $set.mail_check}{capture name='grn_mail_system_GRN_MAIL_SY_224'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-224' replace='true'}{/capture}{grn_sentence class='check20' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_224}{else}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-225' replace='true'}{/if}
  </td>
 </tr>
 {if $set.mail_check}
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-226' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-227' replace='true'}
  </th>
  <td>
      {$set.mail_check_time|escape}&nbsp;{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-228' replace='true'}
  </td>
 </tr>
 {/if}
{/if}
</table>

<input type="hidden" name="cmd">
<input type="hidden" name="oid" value="{$org_id}">
<input type="hidden" name="uid" value="{$user.uid}">
</form>

{include file='grn/system_footer.tpl'}
