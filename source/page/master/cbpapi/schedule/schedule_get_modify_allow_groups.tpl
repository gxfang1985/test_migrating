{include file="cbpapi/header.tpl"}
<schedule:ScheduleGetModifyAllowGroupsResponse>
<returns>
{foreach from=$modify_allow_groups item=group}
  <group_id>{$group._id}</group_id>
{/foreach}
</returns>
</schedule:ScheduleGetModifyAllowGroupsResponse>
{include file="cbpapi/footer.tpl"}
