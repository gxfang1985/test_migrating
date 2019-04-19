{capture name='body'}
{if $item.type == 'attendee'}
    {* 在席情報 *}
    {if $item.value}
        {$item.value.value|escape}{if $item.value.timestamp}&nbsp;({grn_date_format date=$item.value.timestamp format="DateTimeCompact"}){/if}
    {else}
        {cb_msg module='grn.grn' key='GRN_GRN-1396' replace='true'}
    {/if}
{elseif $item_id == 'display_name'}
    {if $builtin_items.nickname}
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
        <td nowrap style="border: 0px; width: auto;">{cb_msg module='grn' key='GRN_GRN-199' replace='true'}:</td>
        <td nowrap style="border: 0px; width: auto;">{if $item.sso == 0}{grn_format body=$item.value span_mode=1}{else}{$item.value}{/if} ({cb_language_name code=$builtin_items.display_name_language.value})</td>
        </tr>
        <tr>
        <td nowrap style="border: 0px; width: auto;">{cb_msg module='grn' key='GRN_GRN-200' replace='true'}:
        </td>
        <td nowrap style="border: 0px; width: auto;">{$builtin_items.nickname.value}
        </td>
        </tr>
        </table>
    {else}
        {if $item.sso == 0}{grn_format body=$item.value}{else}{$item.value}{/if}
    {/if}
{elseif $item.value !== NULL && $item.value !== FALSE}
    {if $item.type == 'url'}
        {* URL *}
        {grn_format body=$item.value}
    {elseif $item.type == 'image_url'}
        {* 画像URL *}
        {if $item.value != ''}{grn_image image=$item.value direct=true}{/if}
    {elseif $item.type == 'email_address'}
        {* E-Mailアドレス *}
        {if $item.sso == 0}{grn_format body=$item.value}{else}{$mailto}{/if}
    {elseif $item.type == 'file'}
        {* ファイル *}
        {assign var='file' value=$item.value}
        {grn_filename dpage='grn/file_download' uid=$user_id fid=$file.oid name=$file.name mime=$file.mime hash=$file.hash inline=true}
    {elseif $item.type == 'callto'}
        {* IP電話 *}
        {assign var=callto value=$item.value|escape}
        {assign var=callto_caption value=$item.value}
        {if $item.sso == 0}{grn_link page="callto:$callto" page_direct=true caption=$callto_caption}{else}{$callto}{/if}
    {elseif $item.type == 'usergroups'}
        {* 所属する組織 *}
            {foreach from=$item.value key=group_id item=group}
                {if $item.sso == 0}{$group.title|escape}&nbsp;({$group.path|escape})<br>{else}{$group.title|escape} ({$group.path|escape}){/if}
            {/foreach}
    {elseif $item.type == 'primary_group'}
        {* 優先する組織 *}
        {foreach from=$item.value key=group_id item=group}
            {if $item.sso == 0}{$group.title|escape}&nbsp;({$group.path|escape})<br>{else}{$group.title} ({$group.path}){/if}
        {/foreach}
    {elseif $item.type == 'locale'}
        {* Loacle *}
        {if $item.sso == 0}{grn_format body=$item.value.localname}{else}{$item.value.localname}{/if}
    {elseif $item.type == 'base'}
        {* Base *}
        {if $item.sso == 0}{grn_format body=$item.value.local_name}{else}{$item.value.local_name}{/if}
    {elseif $item.type == 'multiple_string'}
        {* 複数行文字列 *}
        {if $item.sso == 0}{grn_format body=$item.value}{else}{$item.value}{/if}
    {else}
        {* 1行文字列 *}
        {if $item.sso == 0}{grn_format body=$item.value}{else}{$item.value}{/if}
    {/if}
{/if}
{/capture}