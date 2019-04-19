{include file="sysapi/header.tpl"}

<admin:RemoveUsersFromOrgResponse>
<returns>
  <number_relationships_affected>
    {$affected_userIds|@count}
  </number_relationships_affected>
  <affected_orgId>
    {$affected_orgId}
  </affected_orgId>
  {foreach from=$affected_userIds item=userId}
  <affected_userId>
    {$userId}
  </affected_userId>
  {/foreach}
</returns>
</admin:RemoveUsersFromOrgResponse>

{include file="sysapi/footer.tpl"}