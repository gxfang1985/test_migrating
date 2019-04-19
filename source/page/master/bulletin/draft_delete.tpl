<form name="bulletin/draft_delete" method="post" action="{grn_pageurl page='bulletin/command_draft_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.bulletin' key='GRN_BLLT-525' replace='true'}<br>
 {grn_sentence caption=$article.title|cb_mb_truncate image='draft20.gif' class='bold' truncated_caption=33}
 </p>
<input type="hidden" name="aid" value="{$article.aid}">
</form>

