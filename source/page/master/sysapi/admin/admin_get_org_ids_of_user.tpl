{include file="sysapi/header.tpl"}

<admin:GetOrgIdsOfUserResponse>
<returns>
  <userId>
    {$userId}
  </userId>
  <number_orgs>
    {$orgIds|@count}
  </number_orgs>
{foreach from=$orgIds item=orgId}
  <orgId>
    {$orgId}
  </orgId>
{/foreach}
</returns>
</admin:GetOrgIdsOfUserResponse>

{include file="sysapi/footer.tpl"}