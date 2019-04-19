{include file="sysapi/header.tpl"}

<admin:CountOrgsOfUserResponse>
<returns>
  <userId>
    {$userId}
  </userId>
  <number_orgs>
    {$num_orgs}
  </number_orgs>
</returns>
</admin:CountOrgsOfUserResponse>

{include file="sysapi/footer.tpl"}