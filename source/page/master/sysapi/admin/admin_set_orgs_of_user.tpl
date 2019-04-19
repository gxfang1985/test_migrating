{include file="sysapi/header.tpl"}

<admin:SetOrgsOfUserResponse>
<returns>
  <number_relationships_affected>
    {$affected_orgIds|@count}
  </number_relationships_affected>
  <affected_userId>
    {$affected_userId}
  </affected_userId>
  {foreach from=$affected_orgIds item=orgId}
  <affected_orgId>
    {$orgId}
  </affected_orgId>
  {/foreach}
</returns>
</admin:SetOrgsOfUserResponse>

{include file="sysapi/footer.tpl"}