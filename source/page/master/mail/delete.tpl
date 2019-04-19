<form name="mail/delete" method="post" action="{grn_pageurl page='mail/command_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{if $folder_type eq '4' or $use_garbagebox eq '0'}
 <p>
  {cb_msg module='grn.mail' key='GRN_MAIL-212' replace='true'}<br>
  <span class="bold">{grn_sentence caption=$mail.subject class='mail20' truncated_caption=$truncate_len}</span>
 </p>
{else}
 <p>
  {cb_msg module='grn.mail' key='GRN_MAIL-211' replace='true'}<br>
  <span class="bold">{grn_sentence caption=$mail.subject class='mail20' truncated_caption=$truncate_len}</span>
 </p>
{/if}
<input type="hidden" name="aid" value="{$mail.aid}">
<input type="hidden" name="cid" value="{$mail.cid}">
<input type="hidden" name="mid" value="{$mail.mid}">
</form>