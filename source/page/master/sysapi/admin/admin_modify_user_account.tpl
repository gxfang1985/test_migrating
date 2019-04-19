{include file="sysapi/header.tpl"}

<admin:ModifyUserAccountResponse>
<returns>
  <userAccount>
    <userId>{$userId}</userId>
    <login_name>{$login_name}</login_name>
    <display_name>{$display_name}</display_name>
  </userAccount>
</returns>
</admin:ModifyUserAccountResponse>

{include file="sysapi/footer.tpl"}