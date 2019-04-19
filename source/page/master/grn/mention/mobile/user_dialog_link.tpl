{strip}
<li class="{$params.wrap_class}">
    {if $smarty.const.ON_FOREST == 1}
        <a href="{$params.forest_url}" target="_blank" class="ui-link">
    {else}
        <a href="{grn_pageurl page='grn/user_view' uid=$params.user_id}"  class="ui-link" target="_blank">
    {/if}
    <span class="mobile_user_item_grn">{$params.name|grn_noescape}</span></a>
</li>
{/strip}