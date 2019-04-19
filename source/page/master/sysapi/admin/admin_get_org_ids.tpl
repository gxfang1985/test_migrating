{include file="sysapi/header.tpl"}

<admin:GetOrgIdsResponse>
<returns>
<number_orgs>
  {$orgIds|@count}
</number_orgs>
{foreach from=$orgIds item=orgId}
  <orgId>
    {$orgId}
  </orgId>
{/foreach}
</returns>
</admin:GetOrgIdsResponse>

{include file="sysapi/footer.tpl"}