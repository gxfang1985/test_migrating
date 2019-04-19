<form name="phonemessage/delete_multi" method="post" action="{grn_pageurl page='phonemessage/command_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.phonemessage' key='GRN_PHM-85' replace='true'}<span class="bold delete_count"></span>{cb_msg module='grn.phonemessage' key='GRN_PHM-40' replace='true'}</p>
<input type="hidden" name="cid" value="{$category_id}">
<input type="hidden" name="gid" value="{$group_id}">
<input type="hidden" name="uid" value="{$user_id}">
{foreach from=$message_ids item=message_id}
<input type="hidden" name="mid[]" value="{$message_id}">
{/foreach}
</form>
