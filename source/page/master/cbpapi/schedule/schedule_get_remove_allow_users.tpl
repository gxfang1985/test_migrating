{include file="cbpapi/header.tpl"}
<schedule:ScheduleGetRemoveAllowUsersResponse>
<returns>
{foreach from=$remove_allow_users item=user}
  <user_id>{$user._id}</user_id>
{/foreach}
</returns>
</schedule:ScheduleGetRemoveAllowUsersResponse>
{include file="cbpapi/footer.tpl"}
