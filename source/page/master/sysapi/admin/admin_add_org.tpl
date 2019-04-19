{include file="sysapi/header.tpl"}

<admin:AddOrgResponse>
<returns>
  <org_info>
    <orgId>
      {$orgId}
    </orgId>
    <org_code>
      {$org_code}
    </org_code>
    <org_name>
      {$org_name}
    </org_name>
  </org_info>
{if $parent_orgId ne ''}
  <parent_orgId>
    {$parent_orgId}
  </parent_orgId>
{/if}
  
</returns>
</admin:AddOrgResponse>

{include file="sysapi/footer.tpl"}