{include file="cbpapi/header.tpl"}
<bulletin:{$action}Response>
<returns>
{foreach from=$topics item=topic}
    <topic_item id="{$topic.id}" version="{$topic.version}" operation="{$topic.operation}" />
{/foreach}
</returns>
 </bulletin:{$action}Response>
{include file="cbpapi/footer.tpl"}