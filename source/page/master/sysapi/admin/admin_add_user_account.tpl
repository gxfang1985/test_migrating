{include file="sysapi/header.tpl"}

<admin:AddUserAccountResponse>
<returns>
  <userAccount>
    <userId>{$userId}</userId>
    <login_name>{$login_name}</login_name>
    <display_name>{$display_name}</display_name>
  </userAccount>
</returns>
</admin:AddUserAccountResponse>

{include file="sysapi/footer.tpl"}