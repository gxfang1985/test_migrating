{include file="cbpapi/header.tpl"}
<mail:{$action}Response>
    <returns>
        {foreach from=$account_info key=account_id item=user_acc }
            <user_accounts>
                <account_info account_id="{$account_id}" user_id="{$user_acc.user_id}" user_acount_code="{$user_acc.user_acount_code}" user_account_name="{$user_acc.user_acount_name}"/>
                <mail_setting mail_server_id="{$user_acc.mail_server_id}" email="{$user_acc.email}" acount_name="{$user_acc.acount_name}" leave_server_mail="{$user_acc.leave_server_mail}" deactivate_user_account="{$user_acc.status}"/>
            </user_accounts>
        {/foreach}
    </returns>
</mail:{$action}Response>
{include file="cbpapi/footer.tpl"}