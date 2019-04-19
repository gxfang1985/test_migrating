{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="address"}<br>
{cb_msg module='grn.address.cellular' key="view"}
<hr />
{cb_msg module='grn.address.cellular' key='GRN_ADDR_CELL-1' replace='true'}{if isset( $default_item_names.sort_key ) }({$default_item_names.sort_key}) {/if}<BR>
{$default_information.display_name.value} {if isset( $default_item_names.sort_key )}({$default_information.sort_key.value}){/if}<BR>
{foreach from=$default_information item=item_value key=item_key}{* 組み込み項目 *}
{if $item_key != 'display_name' && $item_key != 'sort_key'}
{cb_msg module='grn.address.cellular' key='GRN_ADDR_CELL-2' replace='true'}{$default_item_names.$item_key|escape}<BR>
{if $item_key == 'usergroups'}
{foreach from=$item_value item=group}
{$group.path}<BR>
{/foreach}
{elseif $item_key == 'primary_group'}{* 優先する組織 *}
{$item_value.path}<BR>
{elseif $item_key == 'attendee'}{* 在籍情報 *}
{if $item_value.value.timestamp}{$item_value.value.value|escape} [{grn_date_format date=$item_value.value.timestamp}]{/if}<BR>
{elseif $item_key == 'email_address'}{* メールアドレス *}
{grn_cellular_mailto mail=$item_value.value}<BR>
{elseif $item_key == 'telephone_number'}{* 連絡先 *}
{grn_cellular_tel tel=$item_value.value}<BR>
{elseif $item_key == 'url'}{* URL *}
{$item_value.value|escape}<BR>
{elseif $item_key == 'description'}{* メモ *}
{grn_cellular_string_split string=$item_value.value page_paraname="description"}<BR>
{else}{* その他 *}
{ $item_value.value|escape }<BR>
{/if}
{/if}
{/foreach}
{foreach from=$extension_information item=item_value key=item_key}{* カスタマイズ項目*}
{cb_msg module='grn.address.cellular' key='GRN_ADDR_CELL-3' replace='true'}{$extension_item_names.$item_key|escape}<BR>
{if $item_value.type == 'multiple_string'}{* 複数行 *}
{grn_cellular_string_split string=$item_value.value page_paraname=$item_value.id}<BR>
{elseif $item_value.type == 'url'}{* URL *}
{$item_value.value}<BR>
{elseif $item_value.type == 'email_address'}{* メールアドレス *}
{grn_cellular_mailto mail=$item_value.value}<BR>
{elseif $item_value.type == 'callto'}{* IP電話 *}
{grn_cellular_tel tel=$item_value.value}<BR>
{else}{* その他 *}
{$item_value.value|escape}<BR>
{/if}
{/foreach}
{grn_cellular_link_array caption_module='grn.address.cellular' caption_key="link_back" params=$back_link}
<hr />
{/strip}
{grn_cellular_link page="$pagepath/search" aid=$aid accesskey=7 caption_module='grn.address.cellular' caption_key="link_address"}<BR>
{grn_cellular_link page="$pagepath/my_address_select" aid=$aid accesskey=8 caption_module='grn.address.cellular' caption_key="link_my_address_group"}<BR>
{include file="cellular/footer.tpl"}
