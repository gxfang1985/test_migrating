{include file="sysapi/header.tpl"}

<admin:GetParentOrgIdResponse>
<returns>
  <child_orgId>
    {$childOrgId}
  </child_orgId>
  <parent_orgId>
    {$parentOrgId}
  </parent_orgId>
</returns>
</admin:GetParentOrgIdResponse>

{include file="sysapi/footer.tpl"}