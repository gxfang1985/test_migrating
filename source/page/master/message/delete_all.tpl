<form name="message/delete_all" method="post" action="{grn_pageurl page='message/command_delete_all'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
{if $category_type neq '4' and $use_garbagebox neq '0'}
  {cb_msg module='grn.message' key='GRN_MSG-314' replace='true'}<br>
  <span class="bold">{grn_message_get_folder_name folder_id=$category_id}</span>
{else}
  {cb_msg module='grn.message' key='GRN_MSG-315' replace='true'}<br>
  <span class="bold">{grn_message_get_folder_name folder_id=$category_id}</span>
{/if}
 </p>
 <p class="explanation">
  {cb_msg module='grn.message' key='GRN_MSG-316' replace='true'}<br>
  {cb_msg module='grn.message' key='GRN_MSG-317' replace='true'}
 </p>
{if $category_child}
 <div class="explanation">{cb_msg module='grn.message' key='GRN_MSG-318' replace='true'}</div>
 <p>{capture name='grn_message_GRN_MSG_320'}{cb_msg module='grn.message' key='GRN_MSG-320' replace='true'}{/capture}{grn_checkbox name='subfolder' id='checkbox_1' value='1' caption=$smarty.capture.grn_message_GRN_MSG_320}</p>
{/if}
<input type="hidden" name="cid" value="{$category_id}">
</form>

