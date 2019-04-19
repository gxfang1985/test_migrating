<form name="mail/folder_delete" method="post" action="{grn_pageurl page='mail/command_folder_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
  {cb_msg module='grn.mail' key='GRN_MAIL-328' replace='true'}<br>
  <span class="bold">{grn_link image='folder20.gif' caption=$category.title disabled=TRUE truncated_caption=$truncate_len}</span><br>
 {if $use_garbagebox eq '1'}
  <div class="attention">
   {cb_msg module='grn.mail' key='GRN_MAIL-329' replace='true'}<br>
  </div>
 {else}
  <div class="attention">
   {cb_msg module='grn.mail' key='GRN_MAIL-330' replace='true'}<br>
  </div>
 {/if}
 </p>
<input type="hidden" name="aid" value="{$category.aid}">
<input type="hidden" name="cid" value="{$category.cid}">
</form>
