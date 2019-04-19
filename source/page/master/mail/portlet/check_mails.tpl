{if $settings.font_size == "large"}
 {assign var="font_size" value='font-size:140%;'}
{elseif $settings.font_size == "normal"}
 {assign var="font_size" value=''}
{elseif $settings.font_size == "small"}
 {assign var="font_size" value='font-size:70%;'}
{/if}
{if $settings.font_size == "large"}
 {assign var="font_size" value='font-size:140%;'}
{elseif $settings.font_size == "normal"}
 {assign var="font_size" value=''}
{elseif $settings.font_size == "small"}
 {assign var="font_size" value='font-size:70%;'}
{/if}

<form name="mail_receive_{$plid}" method="post" action="{grn_pageurl page='mail/command_receive'}">
 <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <input type="hidden" name="aid" value="">
 <input type="hidden" name="cmd" value="new_mail">
 <table class="list_column" style="{$font_size}" width="100%" style="border-spacing:0px;">
  <colgroup>
   <col width="100%">
  </colgroup><tbody>
 {if $has_account}
  {counter start=0 assign='counter' print=false}
  {foreach from=$user_account item=account key=aid}
   {*if $account.count > 0*}
    {counter print=false}
  <tr valign="top">
   <th>
     {$account.title|escape}</div>
   </th>
  </tr>
  <tr valign="top" id="user_mail_account_{$plid}">
   <td id="received_mail_count_{$plid}">
   {if $check_mails}
    &nbsp;<a href="javascript:document.mail_receive_{$plid}.submit()" target='_parent' onclick='changeValue(this,"mail_receive_{$plid}","aid","{$aid}","pt_ml")'>{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-25' replace='true'}{$app_name|escape}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-26' replace='true'}<wbr>&nbsp;{$account.count}&nbsp;{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-27' replace='true'}</a><wbr>&nbsp;{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-28' replace='true'}</div>
   {else}
    &nbsp;<a href="javascript:document.mail_receive_{$plid}.submit()" target='_parent' onclick='document.forms["mail_receive_{$plid}"].elements["aid"].value="{$aid}";'>{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-29' replace='true'}{$app_name|escape}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-30' replace='true'}<wbr>&nbsp;{$account.count}&nbsp;{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-31' replace='true'}</a><wbr>&nbsp;{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-32' replace='true'}</div>
   {/if}
   </td>
  </tr>
   {*/if*}
  {/foreach}
  {if $counter == 0}
  <tr><td>{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-33' replace='true'}{$app_name|escape}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-34' replace='true'}</td></tr>
  {/if}
 {else}
  <tr><td>{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-35' replace='true'}</td></tr>
 {/if}
 </tbody></table>
 <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
</form>

