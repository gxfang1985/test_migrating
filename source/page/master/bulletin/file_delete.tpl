<form name="bulletin/file_delete" method="post" action="{grn_pageurl page='bulletin/command_file_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.bulletin' key='GRN_BLLT-386' replace='true'}<br>
 {grn_sentence caption=$file.filename|cb_mb_truncate image='file20.gif' class='bold'}<br>
 <div class="attention">{cb_msg module='grn.bulletin' key='GRN_BLLT-387' replace='true'}</div>
 </p>
<input type="hidden" name="fid" value="{$file.id}">
<input type="hidden" name="cid" value="{$category_id}">
<input type="hidden" name="aid" value="{$article_id}">
<input type="hidden" name="follow_id" value="{$follow_id}">
</form>
