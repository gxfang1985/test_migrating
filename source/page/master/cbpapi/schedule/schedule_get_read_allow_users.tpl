{include file="cbpapi/header.tpl"}
<schedule:ScheduleGetReadAllowUsersResponse>
<returns>
{foreach from=$read_allow_users item=user}
  <user_id>{$user._id}</user_id>
{/foreach}
</returns>
</schedule:ScheduleGetReadAllowUsersResponse>
{include file="cbpapi/footer.tpl"}
