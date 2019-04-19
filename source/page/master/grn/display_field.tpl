{* $item_code, $item_data *}
{if $item_code == 'usergroups'}
{if count( $item_data ) == 0}<BR>{/if}
{foreach from=$item_data item=group}
{$group.path|escape}<BR>
{/foreach}
{elseif $item_code == 'primary_group'}{* 優先する組織 *}
{$item_data.path|escape}<BR>
{elseif $item_code == 'attendee'}{* 在籍情報 *}
{if $item_data.value.timestamp}{$item_data.value.value|escape} [{grn_date_format date=$item_data.value.timestamp}]{/if}<BR>
{elseif $item_code == 'email_address'}{* メールアドレス *}
{grn_cellular_mailto mail=$item_data.value}<BR>
{elseif $item_code == 'telephone_number'}{* 連絡先 *}
{grn_cellular_tel tel=$item_data.value}<BR>
{elseif $item_code == 'url'}{* URL *}
{$item_data.value|escape}<BR>
{elseif $item_code == 'description'}{* メモ *}
{grn_cellular_string_split indent=2 string=$item_data.value page_paraname="description"}<BR>
{elseif $item_data.type == 'multiple_string'}{* カスタマイズ項目で特別扱いするもの *}{* 複数行 *}
{grn_cellular_string_split indent=2 string=$item_data.value page_paraname=$item_data.id}<BR>
{elseif $item_data.type == 'url'}{* URL *}
{$item_data.value}<BR>
{elseif $item_data.type == 'email_address'}{* メールアドレス *}
{grn_cellular_mailto mail=$item_data.value}<BR>
{elseif $item_data.type == 'callto'}{* IP電話 *}
{grn_cellular_tel tel=$item_data.value}<BR>
{else}
{ $item_data.value|escape }<BR>{* その他 *}
{/if}
