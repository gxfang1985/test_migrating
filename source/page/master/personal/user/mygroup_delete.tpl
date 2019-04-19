<form name="personal/user/mygroup_delete" method="post" action="{grn_pageurl page='personal/user/command_mygroup_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
  {cb_msg module='grn.personal.user' key='GRN_PRS_US-15' replace='true'}<br>
  <span class="bold">{grn_sentence image="mygroup20.gif" caption=$mygroup.name|cb_mb_truncate}</span><br>
 </p>
 <br>
 <input type="hidden" name="mgid" value="{$mygroup.id}">
</form>
