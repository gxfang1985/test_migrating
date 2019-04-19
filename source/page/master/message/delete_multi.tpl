<form name="message/delete_multi" method="post" action="{grn_pageurl page='message/command_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
{if $messages.category_type neq "4" }
 {if $messages.use_garbagebox eq "1"}
  {cb_msg module='grn.message' key='GRN_MSG-146' replace='true'}<br>
 {else}
  {cb_msg module='grn.message' key='GRN_MSG-147' replace='true'}<br>
 {/if}
 {if ! $search}
  {cb_msg module='grn.message' key='GRN_MSG-148' replace='true'}<span class="bold">{grn_message_get_folder_name folder_id=$category_id}</span><br>
 {/if}
  {cb_msg module='grn.message' key='GRN_MSG-149' replace='true'}<span class="bold delete_count"></span><br>
 </p>
 <div class='create_message'>
 <p class="explanation">
  {cb_msg module='grn.message' key='GRN_MSG-150' replace='true'}{$app_name}{cb_msg module='grn.message' key='GRN_MSG-151' replace='true'}<span class="bold create_message_count"></span>{cb_msg module='grn.message' key='GRN_MSG-152' replace='true'}<br>
  {cb_msg module='grn.message' key='GRN_MSG-153' replace='true'}{$app_name}{cb_msg module='grn.message' key='GRN_MSG-154' replace='true'}
 </p>
     {if $messages.use_garbagebox eq "1"}
      <div class="attention">{cb_msg module='grn.message' key='GRN_MSG-156' replace='true'}</div>
     {/if}
 <p>{capture name='grn_message_GRN_MSG_158'}{cb_msg module='grn.message' key='GRN_MSG-158' replace='true'}{/capture}{grn_checkbox name='delete_complete' id='checkbox_id' value='1' caption=$smarty.capture.grn_message_GRN_MSG_158}</p>
 </div>
{else}
 <p class="explanation">
 {cb_msg module='grn.message' key='GRN_MSG-159' replace='true'}<br>
 {if ! $search}
  {cb_msg module='grn.message' key='GRN_MSG-160' replace='true'}<span class="bold">{grn_message_get_folder_name folder_id=$category_id}</span><br>
 {/if}
  {cb_msg module='grn.message' key='GRN_MSG-161' replace='true'}<span class="bold delete_count"></span><br>
     <div class='create_message'>
        <br>{cb_msg module='grn.message' key='GRN_MSG-162' replace='true'}
     </div>
 </p>
{/if}

{if $messages.category_type neq "4"}
<input type="hidden" name="cmd" value="move">
{else}
<input type="hidden" name="cmd" value="delete">
{/if}
<input type="hidden" name="cid" value="{$category_id}">
</form>
