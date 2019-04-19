{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_mail_system_GRN_MAIL_SY_97'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-97' replace='true'}{/capture}{grn_link image='write20.gif' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_97 page='mail/system/user_account_add' oid=$org_id uid=$user.uid disabled=$disabled_add_account element_id='system_mail_user_account_add'}</span>
<span class="menu_item">{capture name='grn_mail_system_GRN_MAIL_SY_98'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-98' replace='true'}{/capture}{grn_link image='order20.gif' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_98 page='mail/system/user_account_order' oid=$org_id uid=$user.uid disabled=$disabled_change_order element_id='system_mail_account_order'}</span>
</div>

<p>
<div class="sub_title">
{grn_user_name uid=$user.uid} {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-99' replace='true'}
</div>
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="5%">
     <col width="23%">
     <col width="20%">
     <col width="23%">
     <col width="18%">
     <col width="11%">
    </colgroup>
    <tr>
     <th nowrap>{include file="grn/checkall.tpl" elem_name="ids[]"}</th>
     <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-100' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-101' replace='true'}</th>
     <th nowrap>E-mail</th>
     <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-102' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-103' replace='true'}</th>
    </tr>
{foreach from=$account_list item=account}
    <tr valign="top">
 {assign var='account_class' value=''}
 {if $account.stop}
  {assign var='account_class' value='gray'}
 {/if}
 {if $account.deleted}
  {assign var='account_class' value='column_red'}
 {/if}
     <td class="{$account_class}">{if ! $account.deleted}<input type="checkbox" name="ids[]" value="{$account.aid}">{else}&nbsp;{/if}</td>
     <td class="{$account_class}">{grn_link image='mailaccount20.gif' caption=$account.title page='mail/system/user_account_view' oid=$org_id uid=$user.uid aid=$account.aid}</td>
     <td class="{$account_class}">{$account.mailserver.name|escape}</td>
     <td class="{$account_class}">{$account.email|escape}</td>
  {if $account.leave_server_mail eq 'LEAVE'}
     <td class="{$account_class}">{grn_image image='check16.gif'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-104' replace='true'}</td>
  {else}
     <td class="{$account_class}">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-105' replace='true'}</td>
  {/if}
     <td align="right" class="{$account_class}">
     {if $account.size >= 1048576}
        {grn_format_filesize size=$account.size unit="MB"}
     {else}
        {grn_format_filesize size=$account.size unit="KB"}
     {/if}
     </td>
    </tr>
{/foreach}
   </table>
   <div class="margin_top">
       {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-106' replace='true'}{capture name='grn_mail_system_GRN_MAIL_SY_107'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-107' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_107 onclick="if( ! grn_is_checked( this.form, 'ids[]' ) ) return false;cmd.value='restart';"}&nbsp;/&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_108'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-108' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_108 onclick="if( ! grn_is_checked( this.form, 'ids[]' ) ) return false;cmd.value='stop';"}
   </div>
   <div class="margin_top">
       {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-109' replace='true'}{capture name='grn_mail_system_GRN_MAIL_SY_110'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-110' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_110 onclick="if( ! grn_is_checked( this.form, 'ids[]' ) ) return false;cmd.value='delete';"}
   </div>
   <p>
    <div class="small_notes">
     {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-111' replace='true'}<br>
     {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-112' replace='true'}<br>
     <div class="attention">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-113' replace='true'}</div>
    </div>
   </p>

<input type="hidden" name="cmd">
<input type="hidden" name="oid" value="{$org_id}">
<input type="hidden" name="uid" value="{$user.uid}">
</form>

{include file='grn/system_footer.tpl'}
