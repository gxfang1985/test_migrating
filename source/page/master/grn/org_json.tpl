[
{foreach from=$org key=key item=item}
{ldelim}
"oid":"{$item.oid|escape:javascript}", "name":"{$item.name|escape|escape:javascript}", "expanded":"{$item.expanded|escape:javascript}", "count":"{$item.count|escape:javascript}", 
{if $item.count>0}
"children":{include org=$item.children file='grn/org_json.tpl'}
{else}
"children":[]
{/if}
{rdelim},
{/foreach}
]
