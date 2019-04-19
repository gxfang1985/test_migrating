{include file="cbpapi/header.tpl"}
<mail:{$action}Response>
    <returns>
        {include file="cbpapi/mail/_mail_personal_profile.tpl"}

        {if $include_system_profile}
            <system_profile disable_mail_client="{if $general_settings.disable_mail=='1'}true{else}false{/if}"
                            check_new_mail_at_login="{if $general_settings.check_mail_on_login=='1'}true{else}false{/if}">
                {if $general_settings.auto_receive.is_setting == "1"}
                    <auto_receive interval="{$general_settings.auto_receive.interval_time}">
                        {foreach from=$scheduled_times item=scheduled_time}
                            <receive_time>{$scheduled_time->format()}</receive_time>
                        {/foreach}
                    </auto_receive>
                {/if}
                <limit {grn_attr name="total_kb" value=$total_kb}
                        {grn_attr name="receive_kb" value=$receive_kb}
                        {grn_attr name="send_kb" value=$send_kb} />
                <authority allow_account_all_permission="{if $system_setting.all_permission == '1'}true{else}false{/if}"
                           allow_account_modification="{if $system_setting.modify_account == '1'}true{else}false{/if}"
                           allow_store_on_server="{if $system_setting.leave == '1'}true{else}false{/if}"
                           allow_new_mail_check="{if $system_setting.check_mails == '1'}true{else}false{/if}"
                           allow_collective_reception="{if $system_setting.all_receive == '1'}true{else}false{/if}"
                           allow_send_markup_body="{if $system_setting.send_html_mail == '1'}true{else}false{/if}"
                           allow_display_markup_image="{if $system_setting.use_html_pict == '1'}true{else}false{/if}"
                           allow_message_disposition_notification="{if $system_setting.use_confirm == '1'}true{else}false{/if}"
                           allow_status="{if $system_setting.use_status == '1'}true{else}false{/if}"
                           allow_history="{if $system_setting.use_history == '1'}true{else}false{/if}"/>
            </system_profile>
        {/if}
    </returns>
</mail:{$action}Response>
{include file="cbpapi/footer.tpl"}