<form name="{$form_name}" method="post" action="{grn_pageurl page='memo/command_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.memo' key='GRN_MEM-180' replace='true'}{$app_name}{cb_msg module='grn.memo' key='GRN_MEM-181' replace='true'}<br><br>
  {grn_image image='memo20.gif'}<span class="bold">{$memo.title|cb_mb_truncate|escape}</span>
 </p>
 <p>
  {capture name='grn_memo_GRN_MEM_14'}{cb_msg module='grn.memo' key='GRN_MEM-14' replace='true'}{/capture}
  {capture name='grn_memo_GRN_MEM_15'}{cb_msg module='grn.memo' key='GRN_MEM-15' replace='true'}{/capture}
 </p>
<input type="hidden" name="did" value="{$folder_id}">
<input type="hidden" name="iid" value="{$item_id}">
</form>
