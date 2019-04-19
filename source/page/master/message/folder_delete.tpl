<form name="message/folder_delete" method="post" action="{grn_pageurl page='message/command_folder_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
  {cb_msg module='grn.message' key='GRN_MSG-321' replace='true'}<br>
  {grn_sentence caption=$folder_name|cb_mb_truncate image='folder20.gif' class='bold'}
 </p>
 <p class="explanation">{cb_msg module='grn.message' key='GRN_MSG-322' replace='true'}{$app_name}{cb_msg module='grn.message' key='GRN_MSG-323' replace='true'}<p>
 {if $use_garbagebox eq 1}
  <p class="attention">
   {cb_msg module='grn.message' key='GRN_MSG-324' replace='true'}<br>
   {cb_msg module='grn.message' key='GRN_MSG-325' replace='true'}<br>
  </p>
 {/if}
 </p>
<input type="hidden" name="cid" value="{$category_id}">
</form>

