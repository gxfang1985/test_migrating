<form name="link/delete_multi" method="post" action="{grn_pageurl page='link/command_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
 {cb_msg module='grn.link' key='GRN_LNK-38' replace='true'}<br>
 {cb_msg module='grn.link' key='GRN_LNK-39' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$category.name|cb_mb_truncate}</span><br>
 {cb_msg module='grn.link' key='GRN_LNK-40' replace='true'}<span class="bold delete_count"></span><br>
 </p>
<input type="hidden" name="cid" value="{$category.cid}">
</form>
