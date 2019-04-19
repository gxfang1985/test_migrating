<table class="list_column" {$font_size}>
    <tr>
        {foreach from=$builtin_items item=item}
            {if $item.use && $item.show && $item.display}
                <th nowrap>
                    {$item.display_name|escape}
                </th>
            {/if}
        {/foreach}
        {foreach from=$extended_items item=item}
            {if $item.use && $item.show && $item.display}
                <th nowrap>
                    {$item.display_name|escape}
                </th>
            {/if}
        {/foreach}
    </tr>
    {foreach from=$user_list key=user_id item=user_info}
        <tr>
            {assign var='card' value=$user_info.builtin_items}
            {foreach from=$builtin_items key=item_id item=item}
                {if $item.use && $item.show && $item.display}
                    {capture name='body'}{/capture}
                    {if $item_id == 'display_name'}
                       {* 名前 *}
                        {if $imageIcon}
                            {capture name='body'}{grn_user_name uid=$user_id nolink=true noimage=true users_info=$users_info}<div class="profileImageUserList">{grn_user_image_icon userInfo=$users_info.$user_id photoUrl=$users_info.$user_id.photoUrl userId=$user_id loginId=$login_id alt=$user_info.display_name size=$iconSize noLink=true}</div>{/capture}
                        {else}
                            {capture name='body'}{grn_user_name uid=$user_id nolink=true users_info=$users_info}{/capture}
                        {/if}
                    {elseif $item.type == 'attendee'}
                        {* 在席情報 *}
                        {if $card.attendee.value.value && $card.attendee.value.timestamp}
                            {capture name='body'}{$card.attendee.value.value|escape}&nbsp;({grn_date_format date=$card.attendee.value.timestamp format="DateTimeCompact"}){/capture}
                        {else}
                            {capture name='body'}{cb_msg module='grn.grn' key='GRN_GRN-841' replace='true'}{/capture}
                        {/if}
                    {elseif $item.type == 'base'}
                        {capture name='body'}{$card.$item_id.value.local_name}{/capture}
                    {elseif $item.type == 'locale'}
                        {capture name='body'}{$card.$item_id.value.localname}{/capture}
                    {elseif $card.$item_id.value}
                        {if $item.type == 'file'}
                            {* ファイル *}
                            {assign var=file value=$card.$item_id.value}
                            {capture name='body'}{$file.name|escape}{/capture}
                        {elseif $item.type == 'usergroups'}
                            {* 所属する組織 *}
                            {capture name='body'}
                               {foreach from=$card.$item_id.value key=group_id item=group}
                                   {$group.title|escape}&nbsp;({$group.path|escape})<br>
                               {/foreach}
                            {/capture}
                       {elseif $item.type == 'primary_group'}
                           {* 優先する組織 *}
                           {foreach from=$card.$item_id.value key=group_id item=group}
                               {capture name='body'}{$group.title|escape}&nbsp;({$group.path|escape})<br>{/capture}
                           {/foreach}
                       {elseif $item.type == 'multiple_string'}
                           {* 複数行文字列 *}
                           {capture name='body'}{$card.$item_id.value|escape|nl2br}{/capture}
                       {else}
                           {* 1行文字列 *}
                           {capture name='body'}{$card.$item_id.value|escape}{/capture}
                       {/if}
                   {/if}
                   <td nowrap>{$smarty.capture.body|grn_noescape}</td>
               {/if}
            {/foreach}

            {assign var='card' value=$user_info.extended_items}
            {foreach from=$extended_items key=item_id item=item}
                {if $item.use && $item.show && $item.display}
                    {capture name='body'}{/capture}
                    {if $card.$item_id.value}
                        {if $item.type == 'file'}
                            {* ファイル *}
                            {assign var=file value=$card.$item_id.value}
                            {capture name='body'}{$file.name|escape}{/capture}
                        {elseif $item.type == 'multiple_string'}
                            {* 複数行文字列 *}
                            {capture name='body'}{$card.$item_id.value|escape|nl2br}{/capture}
                        {else}
                            {* 1行文字列 *}
                            {capture name='body'}{$card.$item_id.value|escape}{/capture}
                        {/if}
                    {/if}

                    <td nowrap>{$smarty.capture.body|grn_noescape}</td>
                {/if}
            {/foreach}
        </tr>
    {/foreach}
</table>
