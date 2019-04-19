{include file="sysapi/header.tpl"}

<admin:LoginResponse>
<returns>
<login_name>
  {$login_name}
</login_name>
<status>
  {$status}
</status>
<cookie>
  {$sess_name}={$sessID}; path={$sess_path}
</cookie>
</returns>
</admin:LoginResponse>

{include file="sysapi/footer.tpl"}