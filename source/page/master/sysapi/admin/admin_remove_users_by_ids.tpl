{include file="sysapi/header.tpl"}

<admin:RemoveUsersByIdsResponse>
<returns>
  <number_accounts_affected>
    {$affected_userIds|@count}
  </number_accounts_affected>
  {foreach from=$affected_userIds item=userId}
  <affected_userId>
    {$userId}
  </affected_userId>
  {/foreach}
</returns>
</admin:RemoveUsersByIdsResponse>

{include file="sysapi/footer.tpl"}