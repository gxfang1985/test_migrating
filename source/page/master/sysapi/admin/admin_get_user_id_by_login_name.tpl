{include file="sysapi/header.tpl"}

<admin:GetUserIdByLoginNameResponse>
<returns>
  <login_name>
    {$login_name}
  </login_name>
  <userId>
    {$userId}
  </userId>
</returns>
</admin:GetUserIdByLoginNameResponse>

{include file="sysapi/footer.tpl"}