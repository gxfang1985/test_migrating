<form name="draft/delete" method="post" action="{grn_pageurl page='mail/command_draft_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
{if $folder_type eq '4' or $use_garbage eq '0'}
  {cb_msg module='grn.mail' key='GRN_MAIL-375' replace='true'}<br>
  <span class="bold">{grn_sentence caption=$mail.subject class='draft20' truncated_caption=$truncate_len}</span>
{/if}
 </p>
<input type="hidden" name="aid" value="{$mail.aid}">
<input type="hidden" name="cid" value="{$mail.cid}">
<input type="hidden" name="mid" value="{$mail.mid}">
</form>