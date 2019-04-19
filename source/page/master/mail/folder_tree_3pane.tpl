{**
 * Folder Tree View
 * Coyp from grn/org_tree_26.tpl
 *
 * Parameters:
 * [folder_tree] => [tree_name],        REQUIRE     ID of tree
 *                  [async_url],        REQUIRE     URL to retrieve children nodes
 *                  [link_url],         REQUIRE     URL of node
 *                  [link_url_params],              URL parameter of node
 *                  [page_name],        REQUIRE     page name
 *                  [selected_oid],     REQUIRE     ID of selected node
 *                  [oid_key],                      Name of URL parameter used for node. Default: 'oid'
 *                  [json_template],                Template file used for JSON data of tree
 *                  [root_caption],                 Caption of root node. Default: '（ルート）'
 *                  [root_subscribed],              Specify TRUE to display notify icon (mark_subscribe10.png) beside root node. Default: 'FALSE'
 *                  [on_select],                    Name of javascript function will be call when a node is selected
 *                  [tree_view_ele_id],             ID of HTML element, the container of tree. Default: 'tree-view'
 *                  [view_part_ele_id],             ID of HTML element, the container of view part. Default: 'view-part'
 *                  [set_tree_height],              Specify FALSE, if don't want to set size of tree on page load.
 *
 *}

{assign var="folder_tree_id"    value=$folder_tree.tree_name|default:"folder_tree"}
{assign var="tree_view_ele_id"  value=$folder_tree.tree_view_ele_id|default:"tree_view"}
{assign var="view_part_ele_id"  value=$folder_tree.view_part_ele_id|default:"view_part"}
{assign var="obj_folder_tree"   value='obj_'|cat:$folder_tree_id}

{grn_load_javascript file="fw/yui/build/yahoo/yahoo-min.js"}
{grn_load_javascript file="fw/yui/build/event/event-min.js"}
{grn_load_javascript file="fw/yui/build/dom/dom-min.js"}
{grn_load_javascript file="fw/yui/build/treeview/treeview-min.js"}
{grn_load_javascript file="fw/yui/build/connection/connection-min.js"}
{grn_load_javascript file="grn/html/page/mail/folder_tree_3pane.js"}
<script language="javascript">
<!--
YAHOO.grn.mail.folderTree.csrf_ticket= "{$csrf_ticket}";
YAHOO.grn.mail.folderTree.app_path= "{$app_path}";
var ft_mp = grn.page.mail.mail_3pane;
//-->
</script>
<div id="{$tree_view_ele_id}" class="tree_view_scroll_grn">
  <div id="{$folder_tree_id}" class="tree_style1_grn"></div>
  <div class="border-partition-common-grn"></div>
  <div class="folder_menu_grn action_text_grn">
    <span class="menu_item_dropdown_grn">
      <a href="javascript:void(0);" class="action_grn nowrap-grn" id="menu_dropdown_folder_option"><span class="icon_folder_grn">{cb_msg module='grn.mail' key='GRN_MAIL-407' replace='true'}</span><span class="arrow_down_small_icon_grn"></span></a>
      <div class="mail-dropdownContents">
        <ul>
          <li>
            <a href="javascript:void(0);" onclick="window.location='{grn_pageurl page=mail/folder_add aid=$category.aid}&cid='+grn.page.mail.mail_3pane.cid"><span class="icon_add_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-144' replace='true'}</span></a>
          </li>
          <li id="folder_order_li">
            <a id="folder_order_show" href="javascript:void(0);" onclick="window.location='{grn_pageurl page=mail/folder_order aid=$category.aid}&cid='+ft_mp.cid"><span class="icon_order_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-145' replace='true'}</span></a>
            <span id="folder_order_hide" class="disable_style_grn"><span class="icon_order_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-146' replace='true'}</span></span>
          </li>
          <li id="folder_view_li">
            <span id="folder_view_hide" class="disable_style_grn"><span class="icon_detail_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-147' replace='true'}</span></span>
            <a id="folder_view_show" href="javascript:void(0);" onclick="window.location='{grn_pageurl page=mail/folder_view aid=$category.aid}&cid='+ft_mp.cid"><span class="icon_detail_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-147' replace='true'}</span></a>
          </li>
        </ul>
      </div>
    </span>
  </div>
</div>
<script language="javascript">
<!--
    var tree_id   = '{$folder_tree_id}';
    var async_url = '{grn_pageurl page=$folder_tree.async_url}';
    var page_name = '{$folder_tree.page_name|escape:"url"}';
    var link_url  = '#';
    var trash_id  = {if $folder_tree.trash_enable}{$folder_tree.trash_id}{else}null{/if};
{if $folder_tree.selected_oid}
    var selected_oid = '{$folder_tree.selected_oid|escape:javascript}';
{else}
    var selected_oid = 0;
{/if}
{if $folder_tree.json_template}
    var tree_data = {include org=$folder_tree.root file=$folder_tree.json_template};
{else}
    var tree_data = {include org=$folder_tree.root file='grn/org_json_26.tpl'};
{/if}
    var tree_params = '';
{foreach from=$tree_params key=param item=value}
    tree_params += "&{$param|escape:javascript}={$value|escape:javascript}";
{/foreach}
    var {$obj_folder_tree} = new YAHOO.grn.mail.folderTree(tree_id, async_url, page_name, link_url, selected_oid, tree_params);
{if $folder_tree.on_select}
    {$obj_folder_tree}.setOnSelect('{$folder_tree.on_select|escape:javascript}');
{/if}
{if $folder_tree.oid_key}
    {$obj_folder_tree}.setOidKey('{$folder_tree.oid_key|escape:javascript}');
{/if}
    {$obj_folder_tree}.setTrashid(trash_id);
    {$obj_folder_tree}.setSubscribeTitle('{cb_msg module="grn.grn" key="GRN_GRN-1553" replace="true"}');
{literal}
function afterExpandComplete(select_id)
{
    if (select_id)
    {
        ft_mp.changeCategorySelectStatus(select_id);
    }
    jQuery('.ygtvitem').each(function()
    {
        if (jQuery(this).children().get(0).nodeName == 'TABLE')
        {
            var table_obj = jQuery(this).children('table');
            table_obj.addClass('menu_unselect_grn');
            table_obj.click(function(e)
            {
                var target_obj = jQuery(e.target);
                if ( target_obj.hasClass('ygtvtp') || target_obj.hasClass('ygtvtm') ||
                     target_obj.hasClass('ygtvtph') || target_obj.hasClass('ygtvtmh') ||
                     target_obj.hasClass('ygtvlp') || target_obj.hasClass('ygtvlm') ||
                     target_obj.hasClass('ygtvlph') || target_obj.hasClass('ygtvlmh') )
                {
                    return;
                }
                if ( target_obj.hasClass('ygtvspacer') &&
                     ( target_obj.parent().hasClass('ygtvtph') || target_obj.parent().hasClass('ygtvtmh') ||
                       target_obj.parent().hasClass('ygtvtp') || target_obj.parent().hasClass('ygtvtm') ||
                       target_obj.parent().hasClass('ygtvlph') || target_obj.parent().hasClass('ygtvlmh') ||
                       target_obj.parent().hasClass('ygtvlp') || target_obj.parent().hasClass('ygtvlm') ) )
                {
                    return;
                }
                if ( target_obj.get(0).nodeName == 'A' || target_obj.get(0).nodeName == 'TD' || target_obj.get(0).nodeName == 'SPAN' || target_obj.hasClass('ygtvspacer') )
                {
                    target_obj = target_obj.parent().parent();
                }
                var clicked_a = jQuery(target_obj.find('a[id^='+tree_id+'-node-]').get(0));
                cid = clicked_a.attr('id').split(tree_id+'-node-');
                window.location = link_url + '&{/literal}{$folder_tree.oid_key|escape:javascript}{literal}=' + cid[1];
            });
        }
    });
    jQuery('#'+tree_id+'-selected_node').parent().parent().parent().parent().addClass('menu_selected_grn').removeClass('menu_unselect_grn');
    jQuery('a.ygtvspacer').each(function(){this.href='javascript:void(0);'});
}
{/literal}
    {$obj_folder_tree}.setAfterExpandCompleteFunction(afterExpandComplete);

    YAHOO.util.Event.onDOMReady(function()
    {ldelim}
        {$obj_folder_tree}.initWithNumber(tree_data);
        ft_mp.folder_order_show = jQuery('#folder_order_show');
        ft_mp.folder_order_hide = jQuery('#folder_order_hide');
        {if $has_sibling_folders}jQuery('#folder_order_hide').remove();{else}jQuery('#folder_order_show').remove();{/if}
        ft_mp.folder_view_show = jQuery('#folder_view_show');
        ft_mp.folder_view_hide = jQuery('#folder_view_hide');
        {if $category.type eq "4"}jQuery('#folder_view_show').remove();{else}jQuery('#folder_view_hide').remove();{/if}
    {rdelim});
//-->
</script>
