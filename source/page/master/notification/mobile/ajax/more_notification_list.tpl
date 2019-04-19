{if $data_list|@count >=1 }
    {foreach from=$data_list key=key item=item}
        {include file='notification/mobile/_items.tpl' list=$item.list short_id=$item.short_id}
    {/foreach}
{/if}