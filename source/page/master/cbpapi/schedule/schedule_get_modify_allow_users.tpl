{include file='cbpapi/header.tpl'}
<schedule:ScheduleGetModifyAllowUsersResponse>
<returns>
{foreach from=$user_ids item=user_id}
<user_id>{$user_id}</user_id>
{/foreach}
</returns>
</schedule:ScheduleGetModifyAllowUsersResponse>
{include file='cbpapi/footer.tpl'}