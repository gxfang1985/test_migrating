<form name="message/delete" method="post" action="{grn_pageurl page='message/command_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{if $folder_type eq '4' or $use_garbage eq "0"}
 <p>
  {cb_msg module='grn.message' key='GRN_MSG-54' replace='true'}<br>
  <span class="bold">{grn_sentence caption=$message.subject|cb_mb_truncate class='msg20'}</span><br>
  {if $folder_type eq '4'}
   <br>
   {cb_msg module='grn.message' key='GRN_MSG-55' replace='true'} 
  {/if}
 </p>
{else}
 <p>
  {cb_msg module='grn.message' key='GRN_MSG-57' replace='true'}<br>
  <span class="bold">{grn_sentence caption=$message.subject|cb_mb_truncate class='msg20'}</span><br>
 </p>
{/if}
{if $folder_type neq '4'}
 {if $is_operator}
 <p class="explanation">
  {cb_msg module='grn.message' key='GRN_MSG-58' replace='true'}{$app_name}{cb_msg module='grn.message' key='GRN_MSG-58-2' replace='true'}
  {if $use_garbage eq "1"}
  <div class="attention">{cb_msg module='grn.message' key='GRN_MSG-60' replace='true'}</div>
  {/if}
 </p>
 <p>{capture name='grn_message_GRN_MSG_62'}{cb_msg module='grn.message' key='GRN_MSG-62' replace='true'}{/capture}{grn_checkbox name='complete' id='checkbox_id' value='1' caption=$smarty.capture.grn_message_GRN_MSG_62}</p>
 {/if}
{/if}
<input type="hidden" name="cid" value="{$category_id}">
<input type="hidden" name="rid" value="{$rid}">
<input type="hidden" name="mid" value="{$mid}">
</form>
