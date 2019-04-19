<form name="bulletin/delete" method="post" action="{grn_pageurl page='bulletin/command_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
{cb_msg module='grn.bulletin' key='GRN_BLLT-306' replace='true'}<br>
{grn_sentence caption=$article.title|cb_mb_truncate image='bulletin20.gif' class='bold'}
  <div class="attention">{cb_msg module='grn.bulletin' key='GRN_BLLT-307' replace='true'}</div>
 </p>
<input type="hidden" name="aid" value="{$article.aid}">
<input type="hidden" name="cid" value="{$category_id}">
</form>

