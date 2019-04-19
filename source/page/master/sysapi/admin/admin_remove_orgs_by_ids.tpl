{include file="sysapi/header.tpl"}

<admin:RemoveOrgsByIdsResponse>
<returns>
  <number_orgs_affected>
    {$affected_orgIds|@count}
  </number_orgs_affected>
  {foreach from=$affected_orgIds item=orgId}
  <affected_orgId>
    {$orgId}
  </affected_orgId>
  {/foreach}
</returns>
</admin:RemoveOrgsByIdsResponse>

{include file="sysapi/footer.tpl"}