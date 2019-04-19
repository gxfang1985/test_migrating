<form name="link/category_delete" method="post" action="{grn_pageurl page='link/command_category_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.link' key='GRN_LNK-184' replace='true'}<br>
<span class="bold">{grn_sentence image='category20.gif' caption=$category.title|cb_mb_truncate}</span>
 </p>
 <div class="attention">{cb_msg module='grn.link' key='GRN_LNK-185' replace='true'}</div>
<input type="hidden" name="cid" value="{$category.cid}">
</form>
