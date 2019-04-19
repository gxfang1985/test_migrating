{include file="sysapi/header.tpl"}

<admin:GetUserIdsResponse>
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
</admin:GetUserIdsResponse>

{include file="sysapi/footer.tpl"}