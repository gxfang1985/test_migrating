{include file="grn/xss_prevent.tpl"}
{if $space_active}
    <ul>
        {foreach from=$list_my_space item=space}
            <li>
                <a href='{$space.link}'><span><img src='{$space.icon_link}' alt=""/></span>{$space.name|escape}</a>
            </li>
        {/foreach}
        {if $link_more}
            <li class="cloudHeader-dropdownContents-grn-my-spaces-more-link">
                <a href='{$link_to_space}'>{cb_msg module='grn' key='GRN_GRN-206' replace='true'}</a>
            </li>
        {/if}
    </ul>
{/if}
{include file="grn/end_xss_prevent.tpl"}
