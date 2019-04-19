{include file="sysapi/header.tpl"}

<admin:ModifyOrgInfoResponse>
<returns>
  <org_info>
    <orgId>
      {$orgId}
    </orgId>
  {if $org_code ne ''}
    <org_code>
      {$org_code}
    </org_code>
  {/if}
  {if $org_name ne ''}
    <org_name>
      {$org_name}
    </org_name>
  {/if}
  </org_info>
</returns>
</admin:ModifyOrgInfoResponse>

{include file="sysapi/footer.tpl"}