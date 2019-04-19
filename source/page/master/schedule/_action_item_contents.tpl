{foreach from=$extended_items key=item_id item=item}
    {if $item.use}
        {if $item.type == GRN_SCHEDULE_ITEM_MULTIPLE_STRING}
            <tr valign="top">
                {else}
            <tr>
        {/if}
        <th>{grn_show_input_title title=$item.display_name}</th>
        <td>
            {if $item.type == GRN_SCHEDULE_ITEM_MULTIPLE_STRING}
                {grn_textarea name=$item_id rows='5' value=$item.value class="js_item" code=$item.id type=$item.type}
            {elseif $item.type == GRN_SCHEDULE_ITEM_MENU}
                <select name="{$item.oid}" class="js_item" data-code="{$item.id}" data-type="{$item.type}">
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
                {grn_text name=$item_id size='50' value=$item.value disable_return_key=true class="js_item" code=$item.id type=$item.type}
            {/if}
        </td>
        </tr>
    {/if}
{/foreach}
