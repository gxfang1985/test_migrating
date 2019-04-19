{**
 * Mobile Sub Folder Tree List
 *
 * Call grn\grn\mobile\MobileFolderList->constructSubFolderList()
 *   to get sub tree.
 *}
{if $folder_tree.org|@count > 0}
{foreach from=$folder_tree.org key=key item=item}
  <li id="parent_child_{$item.parent}_{$key}" data-icon="false" style="padding-left: {$folder_tree.deep*8}px !important;">
    {assign var="icon_arrow" value=""}
    {if $item.count > 0}
      {if $item.expanded}
        {assign var="icon_arrow" value="mobile_folderlist_icon_arrowopen_grn"}
      {else}
        {assign var="icon_arrow" value="mobile_folderlist_icon_arrowclose_grn"}
      {/if}
    {/if}
    {if $folder_tree.oid_key}
        {assign var="oid_key" value=$folder_tree.oid_key}
    {else}
        {assign var="oid_key" value='oid'}
    {/if}
    <div id="{$key}" style="margin-left: {$folder_tree.deep*8}px !important;" class="{$icon_arrow} mobile_folderlist_icon_grn mobile_folderlist_icon_size_grn"{if $item.count eq 0} onclick="location.href='{grn_pageurl page=$folder_tree.link_url params=$folder_tree.link_url_params}&{$oid_key}={$key}'"{/if}></div>
    <a href="{grn_pageurl page=$folder_tree.link_url params=$folder_tree.link_url_params}&{$oid_key}={$key}" class="mobile_folderlist_list_text_grn">
      <span id="deepth_{$folder_tree.deep}_{$key}" class="mobile_folderlist_text_overflow_grn">{$item.name|escape}</span>
      {if $item.unread > 0}
        <span class="mobile_notify_sum_grn">{$item.unread}</span>
      {/if}
      <span class="mobile_folderlist_icon_arraylist_grn"></span>
    </a>
  </li>
{/foreach}
{else}
none{/if}