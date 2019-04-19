{include file="sysapi/header.tpl"}

<admin:GetUserDetailByIdsResponse>
<returns>
  <number_users>
    {$userDetails|@count}
  </number_users>
{foreach from=$userDetails item=userDetail}
  <userDetail>
    <userId>
      {$userDetail.userId}
    </userId>
    <login_name>
      {$userDetail.login_name}
    </login_name>
    <display_name>
      {$userDetail.display_name}
    </display_name>
  </userDetail>
{/foreach}
</returns>
</admin:GetUserDetailByIdsResponse>

{include file="sysapi/footer.tpl"}