{include file="sysapi/header.tpl"}

<admin:GetChildOrgsResponse>
<returns>
  <parent_orgId>
    {$parent_orgId}
  </parent_orgId>
  <number_child_orgs>
    {$child_orgIds|@count}
  </number_child_orgs>
{foreach from=$child_orgIds item=orgId}
  <orgId>
    {$orgId}
  </orgId>
{/foreach}
</returns>
</admin:GetChildOrgsResponse>

{include file="sysapi/footer.tpl"}