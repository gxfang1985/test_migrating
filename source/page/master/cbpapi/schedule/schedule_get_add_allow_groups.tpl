{include file='cbpapi/header.tpl'}
<schedule:ScheduleGetAddAllowGroupsResponse>
<returns>
{foreach from=$user_group_list item=grp_id}
<group_id>{$grp_id}</group_id>
{/foreach}
</returns>
</schedule:ScheduleGetAddAllowGroupsResponse>
{include file='cbpapi/footer.tpl'}