{include file="sysapi/header.tpl"}

<admin:CountUsersInOrgResponse>
<returns>
  <orgId>
    {$orgId}
  </orgId>
  <number_users>
    {$num_users}
  </number_users>
</returns>
</admin:CountUsersInOrgResponse>

{include file="sysapi/footer.tpl"}