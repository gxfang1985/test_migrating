{**
 * Mobile Folder Tree View
 *
 * Parameters:
 * [folder_tree] => [tree_name],                    ID of tree
 *                  [async_url],        REQUIRE     URL to retrieve children nodes
 *                  [link_url],         REQUIRE     URL of node
 *                  [link_url_params],              URL parameter of node
 *                  [oid_key],                      Name of URL parameter used for node. Default: 'oid'
 *                  [root_caption],                 Caption of root node. Default: '（ルート）'
 *                  [no_root],                      Specify TRUE to hide root node. Default: 'FALSE'
 *                  [root],             REQUIRE     $tree->getRoot()
 *
 *}
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var="folder_tree_id" value=$folder_tree.tree_name|default:"folder_tree"}

{grn_load_javascript file="grn/html/component/mobile_folder_tree.js"}

<ul data-role="listview" data-theme="{$data_theme}" class="mobile-ul-top-grn mobile-ul-bottom-grn mobile_folderlist_grn" id="{$folder_tree_id}">
  {if !$folder_tree.no_root}
    <li id="{$folder_tree_id}_top" data-icon="false" class="mobile_folderlist_list_father_grn">
      <a href="{grn_pageurl page=$folder_tree.link_url params=$folder_tree.link_url_params}">
        {capture assign='root_folder_caption'}
          {if (! is_null($folder_tree.root_caption)) && (strlen($folder_tree.root_caption) > 0) }
            {$folder_tree.root_caption}
          {else}
            {cb_msg module='grn.grn' key='GRN_GRN-173' replace='true'}
          {/if}
        {/capture}
        <span id="deepth_0_top" class="mobile_folderlist_text_overflow_grn">{$root_folder_caption}</span>
        <span class="mobile_folderlist_icon_arraylist_grn"></span>
      </a>
    </li>
  {/if}
  {grn_mobile_folder_tree data=$folder_tree}
</ul>
<script language="javascript">
<!--
    var __thisPage = grn.component.mobile_folder_tree;
    __thisPage.asyncUrl = '{grn_pageurl page=$folder_tree.async_url}';
    __thisPage.paramName = '{$folder_tree.oid_key|default:"oid"}';
    __thisPage.treeName = '{$folder_tree_id}';
    {foreach from=$folder_tree.link_url_params key=key item=param }
        {literal}
        if (typeof __thisPage.linkUrlParams == 'undefined')
        {
            __thisPage.linkUrlParams = "";
        }
        else
        {
            __thisPage.linkUrlParams += "&";
        }
        {/literal}
    __thisPage.linkUrlParams += "{$key}={$param}";
    {/foreach}

//-->
</script>
