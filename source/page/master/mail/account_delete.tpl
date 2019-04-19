<form name="mail/account_delete" method="post" action="{grn_pageurl page='mail/command_account_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
{cb_msg module='grn.mail' key='GRN_MAIL-81' replace='true'}<span class="bold">{grn_sentence class='mailaccount20' caption=$set.title truncated_caption=$truncate_len}</span>{cb_msg module='grn.mail' key='GRN_MAIL-82' replace='true'}<br>
{cb_msg module='grn.mail' key='GRN_MAIL-83' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-84' replace='true'}
 </p>
 <p>
<span class="attention">{cb_msg module='grn.mail' key='GRN_MAIL-85' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-86' replace='true'}</span>
 </p>
 <input type="hidden" name="aid" value="{$account_id}">
 <input type="hidden" name="cid" value="{$category_id}">
 <input type="hidden" name="sid" value="{$status_id}">
</form>
