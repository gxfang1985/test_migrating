{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$set.name class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_mail_personal_GRN_MAIL_PE_225'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-225' replace='true'}{/capture}{grn_link image='modify20.gif' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_225 page='mail/personal/signature_modify' aid=$set.aid sid=$set.sid}</span>
{grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
<span class="menu_item">{capture name='grn_mail_personal_GRN_MAIL_PE_226'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-226' replace='true'}{/capture}{grn_link image='delete20.gif' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_226 page='mail/personal/signature_delete' script='javascript:void(0);' id="lnk_delete"}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-227' replace='true'}</th>
  <td>
       {grn_sentence caption=$set.account image='mailaccount20.gif'}
{if $set.stop}
       <br><span class="attention">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-20' replace='true'}</span>
{/if}
  </td>
 </tr>
 <tr>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-229' replace='true'}</th>
  <td>{$set.name|escape}</td>
 </tr>
 <tr>
    <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-257' replace='true'}</th>
    {if $set.position|escape == "top"}
        <td>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-258' replace='true'}</td>
    {else}
        <td>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-259' replace='true'}</td>
    {/if}
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-230' replace='true'}</th>
  <td>{grn_format body=$set.value}</td>
 </tr>
</table>

{include file='grn/personal_footer.tpl'}
