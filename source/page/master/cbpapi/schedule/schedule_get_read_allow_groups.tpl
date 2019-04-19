{include file="cbpapi/header.tpl"}
<schedule:ScheduleGetReadAllowGroupsResponse>
<returns>
{foreach from=$read_allow_groups item=group}
  <group_id>{$group._id}</group_id>
{/foreach}
</returns>
</schedule:ScheduleGetReadAllowGroupsResponse>
{include file="cbpapi/footer.tpl"}
