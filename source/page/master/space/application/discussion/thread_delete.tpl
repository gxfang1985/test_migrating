<form name="thread/delete" method="post" action="{grn_pageurl page='space/application/discussion/command_delete'}">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-24' replace='true'}<br>
{grn_image image='spaceDiscussion20.png'}<span class="bold">{$thread_obj->getTitle()|cb_mb_truncate|escape}</span><br>
{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-40' replace='true'}</p>
<input type="hidden" name="is_system" value="{$thread_obj->isSystemUse()}">
<input type="hidden" name="spid" value="{$space_id}">
<input type="hidden" name="tid" value="{$thread_obj->getId()}">
</form>