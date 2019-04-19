[
{foreach from=$org key=key item=item}
{ldelim}
"oid":"{$item.oid|escape:javascript}",
    "name":"{$item.name|escape|escape:javascript}",
    "expanded":"{$item.expanded|escape:javascript}",
    "count":"{$item.count|escape:javascript}",
    {if $item.subscribed} "subscribed":"{$item.subscribed|escape:javascript}",{/if}
    {if $item.link_url} "link_url":"{$item.link_url|escape:javascript}",{/if}
    {if $item.unread} "unread":"{$item.unread}",{/if}
    {if $item.checkbox} "checkbox":"{$item.checkbox}",{/if}
    {if $item.deleted} "deleted":"{$item.deleted}",{/if}
    {if $item.new_group} "new_group":"{$item.new_group}",{/if}
    {if $item.update_group} "update_group":"{$item.update_group}",{/if}
{if $item.count>0}
    "children":{include org=$item.children file='grn/org_json_26.tpl'}
{else}
    "children":[]
{/if}
{rdelim},
{/foreach}
]
