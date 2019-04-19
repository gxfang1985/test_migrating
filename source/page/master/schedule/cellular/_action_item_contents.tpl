{if $item.type == GRN_SCHEDULE_ITEM_MULTIPLE_STRING}
    {* 複数行文字列 *}
<textarea name={$item_id} cols=16 rows=3 istyle="1" mode="hiragana">{$item.value|escape}</textarea>
{elseif $item.type == GRN_SCHEDULE_ITEM_MENU}
    {* プルダウンメニュー *}
<select name="{$item.oid}">
<option value="">------------</option>
    {foreach from=$item.item_menu_textarea key=menu_id item=menu}
        {if $menu == $item.item_menu_text}
<option value="{$menu|escape}" selected>{$menu|escape}</option>
        {else}
<option value="{$menu|escape}">{$menu|escape}</option>
        {/if}
    {/foreach}
</select>
{else}
    {* 1行文字列 *}
<input type=text name={$item_id} value="{$item.value|escape}" istyle="1" mode="hiragana">
{/if}
