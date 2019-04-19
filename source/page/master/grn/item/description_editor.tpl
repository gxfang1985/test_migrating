{if $item.description_editor == 1}
     {$item.description|grn_noescape}
{else}
     {grn_format body=$item.description}
{/if}

