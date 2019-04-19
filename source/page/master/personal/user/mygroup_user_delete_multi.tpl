<form name="personal/user/mygroup_user_delete_multi" method="post" action="{grn_pageurl page='personal/user/command_mygroup_user_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
  {cb_msg module='grn.personal.user' key='GRN_PRS_US-11' replace='true'}<br>
  {cb_msg module='grn.personal.user' key='GRN_PRS_US-13' replace='true'}<span class="bold ">{grn_sentence image='mygroup20.gif' caption=$selected.name|cb_mb_truncate}</span><br>
  {cb_msg module='grn.personal.user' key='GRN_PRS_US-14' replace='true'}<span class="bold delete_count"></span><br>
 </p>
 <input type="hidden" name="mgid" value="{$selected.id}">
</form>
