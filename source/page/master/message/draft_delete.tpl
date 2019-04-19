<form name="message/draft_delete" method="post" action="{grn_pageurl page='message/command_draft_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
{if $folder_type eq '4' or $use_garbage eq "0"}
  {cb_msg module='grn.message' key='GRN_MSG-367' replace='true'}<br>
{else}
  {cb_msg module='grn.message' key='GRN_MSG-368' replace='true'}<br>
{/if}
  <span class="bold">{grn_sentence caption=$message.subject|cb_mb_truncate class='draft20'}</span><br>
 </p>
<input type="hidden" name="cid" value="{$category_id}">
<input type="hidden" name="rid" value="{$rid}">
<input type="hidden" name="mid" value="{$mid}">
</form>
