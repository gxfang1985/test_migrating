{include file="cbpapi/header.tpl"}
<mail:{$action}Response>
<returns>
{foreach from=$accounts item=account}
    <account id="{$account.id}"
             {grn_attr name="name" value=$account.name} 
             {grn_attr name="email" value=$account.email} 
             {if isset($account.disabled)}
                {grn_attr name="disabled" value=$account.disabled} 
             {elseif isset($account.deleted)}
                {grn_attr name="deleted" value=$account.deleted} 
             {else}
                {grn_attr name="new_mails" value=$account.new_mails} 
             {/if}
             />
{/foreach}
</returns>
</mail:{$action}Response>
{include file="cbpapi/footer.tpl"}