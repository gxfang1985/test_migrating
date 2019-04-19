{include file='cbpapi/header.tpl'}
<schedule:ScheduleGetAddAllowUsersResponse>
<returns>
{foreach from=$user_ids item=user_id}
<user_id>{$user_id}</user_id>
{/foreach}
</returns>
</schedule:ScheduleGetAddAllowUsersResponse>
{include file='cbpapi/footer.tpl'}