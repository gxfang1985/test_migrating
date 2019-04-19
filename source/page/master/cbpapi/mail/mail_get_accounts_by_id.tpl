{include file="cbpapi/header.tpl"}
<mail:{$action}Response>
<returns>
    {foreach from=$accounts item=account}
        <account xmlns:account="http://schemas.cybozu.co.jp/mail/2008" key="{$account.id}" version="{$account.version}" server_id="{$account.server_id}" 
        {grn_attr name="email" value=$account.email require=true} user_id="{$account.user_id}" {grn_attr name="username" value=$account.username require=true} {grn_attr name="order" value=$account.order} password="{$account.password}" >
        {* MailBox *}
        <account:mailbox account="{$account.id}">
            {grn_mail_folder_tree_mobile_api account_id=$account.id}
            {* Filters *}
            {if is_array($account.filters) && count($account.filters) > 0 }
                <account:filters>
                    {foreach from=$account.filters item=filter}
                        <account:filter {grn_attr name="name" value=$filter.name require=true} {grn_attr name="folder" value=$filter.folder_name require=true} {if $filter.or } operator="OR" {else} operator="AND" {/if}
                        {grn_attr name="status" value=$filter.status.name require=true}>
                        {foreach from=$filter.conditions item=condition}
                            {if $condition.type == 'SZ'}
                            <account:size target="Mail" {grn_attr name="content" value=$condition.string } {grn_attr name="method" value=$condition.method require=true} />
                            {else}
                            <account:expr {grn_attr name="target" value=$condition.target require=true} {grn_attr name="content" value=$condition.string } {grn_attr name="method" value=$condition.method require=true} />
                            {/if}
                        {/foreach}
                        </account:filter>
                    {/foreach}
                </account:filters>
            {/if}
        </account:mailbox>
        
        {* Signatures *}
        {if is_array($account.signatures)&& count($account.signatures) > 0 }
        <account:signatures>
            {foreach from=$account.signatures item=signature}
                <account:signature {grn_attr name="name" value=$signature.name require=true}>{grn_papi_text_format value=$signature.data}</account:signature>
            {/foreach}
        </account:signatures>
        {/if}
        </account>
    {/foreach}
</returns>
</mail:{$action}Response>
{include file="cbpapi/footer.tpl"}