{include file="cbpapi/header.tpl"}
<schedule:ScheduleGetRemoveAllowGroupsResponse>
<returns>
{foreach from=$remove_allow_groups item=group}
  <group_id>{$group._id}</group_id>
{/foreach}
</returns>
</schedule:ScheduleGetRemoveAllowGroupsResponse>
{include file="cbpapi/footer.tpl"}
