{assign var='outgoing' value=$server.outgoing}
{assign var='incoming' value=$server.incoming}
<server id="{$server.id}" 
        {grn_attr name="server_code" value=$server.server_code} 
        {grn_attr name="server_name" value=$server.server_name}>
    <outgoing   {grn_attr name="server_name" value=$outgoing.server_name}
                {grn_attr name="port_number" value=$outgoing.port_number}
                {grn_attr name="encrypted_connection" value=$outgoing.encrypted_connection}
                {grn_attr name="smtp_auth" value=$outgoing.smtp_auth}
                {if $outgoing.smtp_auth != 'NONE'}
                    {grn_attr name="account_for_send" value=$outgoing.account_for_send}
                {else}
                    {grn_attr name="pop_before_smtp" value=$outgoing.pop_before_smtp}
                    {grn_attr name="pop_before_smtp_wait_time" value=$outgoing.pop_before_smtp_wait_time}
                {/if}
                {grn_attr name="timeout" value=$outgoing.timeout}
                xmlns="http://schemas.cybozu.co.jp/mail/2008"
    />
    <incoming   {grn_attr name="receive_protocol" value=$incoming.receive_protocol}
                {grn_attr name="server_name" value=$incoming.server_name}
                {grn_attr name="port_number" value=$incoming.port_number}
                {grn_attr name="use_ssl" value=$incoming.use_ssl}
                {if $incoming.receive_protocol == 'POP3'}
                    {grn_attr name="apop_auth_for_pop3" value=$incoming.apop_auth_for_pop3}
                {/if}
                {grn_attr name="timeout" value=$incoming.timeout}
                xmlns="http://schemas.cybozu.co.jp/mail/2008"
    />
</server>