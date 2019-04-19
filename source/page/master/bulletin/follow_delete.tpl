<form name="bulletin/follow_delete" method="post" action="{grn_pageurl page='bulletin/command_follow_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn' key='grn.comment.delete.confirm' replace='true'}<br>
 <span class="bold" id="msgbox_follow"></span>
 </p>
<input type="hidden" name="cid" value="{$category_id}">
<input type="hidden" name="aid" value="{$article_id}">
</form>
