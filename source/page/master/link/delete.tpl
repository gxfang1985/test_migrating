<form name="link/delete" method="post" action="{grn_pageurl page='link/command_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.link' key='GRN_LNK-6' replace='true'}<br>
<span class="bold">{grn_sentence caption=$link.title|cb_mb_truncate image='linklist20.gif'}</span>
 </p>
<input type="hidden" name="cid" value="{$category.cid}">
<input type="hidden" name="lid" value="{$link.lid}">
</form>
