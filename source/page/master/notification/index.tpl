{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}
{include file='notification/_title_search.tpl' search_action=$search_action}
{grn_load_javascript file="js/dist/notification.js"}

<div class="mainarea">
    {assign var='form_name' value=$smarty.template|basename}
    <table class="maincontents_list maincontents_list_notification_grn js_notification_index">
        <tbody>
            <tr>
                <td class="maincontents_list_td">
                    <form name="{$form_name}" method="post" action="{grn_pageurl page='notification/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                        <table class="table_plain_grn tree_style1_table_grn w_full_grn">
                            <tr valign="top">
                                <td id="tree_part">
                                    <ul class="tree_part_item_base_grn js_notification_application_list">{strip}
                                        {foreach from=$app_infos item=app key=module_id}
                                            <li class="tree_part_item_grn {$app.class}" data-module_id="{$app.value}">
                                                <a href="javascript:void(0)" class="tree_part_item_a_grn">
                                                    {if $app.icon}
                                                        {grn_image image=$app.icon class="tree_part_item_a_img_grn" noborder=1}
                                                    {/if}
                                                    {if $app.value}
                                                        <span class="tree_part_item_a_text_grn">{$app.label}</span>
                                                    {else}
                                                        {$app.label}
                                                    {/if}
                                                </a>
                                            </li>
                                        {/foreach}{/strip}
                                    </ul>
                                </td>
                                <td id="view_part" width="90%">
                                    {strip}
                                        <div class="notification_filter_base_grn">
                                            <div class="navi_viewchange_grn navi_viewchange_theme_grn mRight10">
                                                <div class="button_group_space_grn js_category"></div>
                                                <div class="inline_block_grn js_status"></div>
                                            </div>
                                        </div>
                                    {/strip}
                                    <div class="spinnerBoxBase-grn spinnerCentered js_notification_list_spinner" style="display: none;"><div class="spinnerBox-grn"></div></div>
                                    <div class="notification_list notification_list_grn js_content js_notification_list_content">
                                        <div class="js_pagination_top"></div>
                                        {include file="notification/_list_menu.tpl" menu_css="list_menu_top"}
                                        {include file="notification/_notification_list.tpl"}
                                        {include file="notification/_list_menu.tpl" menu_css="list_menu_bottom"}
                                        <div class="js_pagination_bottom"></div>
                                    </div> <!--end of portal_frame -->
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" name="module_id" value="{$module_id}">
                    </form>
                </td>
            </tr>
        </tbody>
    </table>
    <!--end of maincontents_list-->
    {literal}
    <script>
        (function () {
            {/literal}
            var $element = jQuery(".js_notification_index");
            {literal}
            new grn.js.page.notification.Index({
                element: $element,
                {/literal}
                params:{$data_page|@json_encode},
                pagination:{$notify_list.pagination_info|@json_encode}
                {literal}
            });
        })();
    </script>
    {/literal}
{include file="grn/footer.tpl"}
