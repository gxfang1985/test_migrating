{include file="sysapi/header.tpl"}

<admin:GetUserIdsInOrgResponse>
<returns>
  <orgId>
    {$orgId}
  </orgId>
  <number_users>
    {$userIds|@count}
  </number_users>
{foreach from=$userIds item=userId}
  <userId>
    {$userId}
  </userId>
{/foreach}
</returns>
</admin:GetUserIdsInOrgResponse>

{include file="sysapi/footer.tpl"}