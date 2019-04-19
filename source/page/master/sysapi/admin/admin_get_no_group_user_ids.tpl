{include file="sysapi/header.tpl"}

<admin:GetNoGroupUserIdsResponse>
<returns>
  <number_users>
    {$userIds|@count}
  </number_users>
{foreach from=$userIds item=userId}
  <userId>
    {$userId}
  </userId>
{/foreach}
</returns>
</admin:GetNoGroupUserIdsResponse>

{include file="sysapi/footer.tpl"}