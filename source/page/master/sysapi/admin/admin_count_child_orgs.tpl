{include file="sysapi/header.tpl"}

<admin:CountChildOrgsResponse>
<returns>
  <parent_orgId>
    {$parent_orgId}
  </parent_orgId>
  <number_child_orgs>
    {$num_child_orgs}
  </number_child_orgs>
</returns>
</admin:CountChildOrgsResponse>

{include file="sysapi/footer.tpl"}