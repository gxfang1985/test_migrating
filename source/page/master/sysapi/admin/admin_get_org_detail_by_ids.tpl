{include file="sysapi/header.tpl"}

<admin:GetOrgDetailByIdsResponse>
<returns>
  <number_orgs>
    {$orgDetails|@count}
  </number_orgs>
{foreach from=$orgDetails item=orgDetail}
  <OrgDetail>
    <orgId>
      {$orgDetail.orgId}
    </orgId>
    <org_code>
      {$orgDetail.org_code}
    </org_code>
    <org_name>
      {$orgDetail.org_name}
    </org_name>
  </OrgDetail>
{/foreach}
</returns>
</admin:GetOrgDetailByIdsResponse>

{include file="sysapi/footer.tpl"}