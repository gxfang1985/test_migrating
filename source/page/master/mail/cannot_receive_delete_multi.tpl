<form name="mail/cannot_receive_delete_multi" method="post" action="{grn_pageurl page='mail/command_cannot_receive_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
  {cb_msg module='grn.mail' key='GRN_MAIL-277' replace='true'}<br>
  {cb_msg module='grn.mail' key='GRN_MAIL-278' replace='true'}<span class="bold delete_count"></span>
 </p>
<input type="hidden" name="cmd" value="delete">
<input type="hidden" name="aid" value="{$category.aid}">
<input type="hidden" name="cid" value="{$category.cid}">
</form>
