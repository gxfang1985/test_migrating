{foreach from=$actions item=action}
    {if $action.actionName eq 'grn.mail.automatic.forward'}
        {foreach from=$action.message.forwardTo item=address}
            <div>{grn_image image='mailaccount20.gif'}{$address}</div>
        {/foreach}
    {/if}
{/foreach}
