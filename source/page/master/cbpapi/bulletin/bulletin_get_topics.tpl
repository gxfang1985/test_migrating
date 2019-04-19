{include file="cbpapi/header.tpl"}
<bulletin:{$action}Response>
    <returns xmlns="">
    {if is_array($categories) && count($categories) > 0 }
    {foreach from=$categories item=category}
        {if is_array($category.topics) && count($category.topics) > 0 }
        <category category_id="{$category.category_id}">
            {foreach from=$category.topics item=topic}
                <topic id="{$topic.aid}" />
            {/foreach}
        </category>
        {/if}        
    {/foreach}
    {/if}
    </returns>
</bulletin:{$action}Response>
{include file="cbpapi/footer.tpl"}