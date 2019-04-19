<form name="mail/delete_all" method="post" action="{grn_pageurl page='mail/command_delete_all'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
{if $category.type eq '4' and $use_garbagebox eq '0'}
  {cb_msg module='grn.mail' key='GRN_MAIL-405' replace='true'}<br>
{else}
  {cb_msg module='grn.mail' key='GRN_MAIL-386' replace='true'}<br>
{/if}
<br>
<span class="bold">{grn_mail_get_folder_name folder_id=$category.cid truncated_caption=$truncate_len}</span><br>
{if $category.child}
 <p>{cb_msg module='grn.mail' key='GRN_MAIL-387' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-388' replace='true'}</p>
 <p>{capture name='grn_mail_GRN_MAIL_389'}{cb_msg module='grn.mail' key='GRN_MAIL-389' replace='true'}{/capture}{grn_checkbox name='subfolder' id='checkbox_1' value='1' caption=$smarty.capture.grn_mail_GRN_MAIL_389}</p>
{/if}
<input type="hidden" name="aid" value="{$category.aid}">
<input type="hidden" name="cid" value="{$category.cid}">
</form>