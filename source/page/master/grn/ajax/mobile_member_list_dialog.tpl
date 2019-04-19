{if !$is_ajax}
    {if $dialog_id}
        {assign var='dialog_id' value=$dialog_id}
    {else}
        {assign var='dialog_id' value='member_list_dialog'}
    {/if}
    <div data-role="popup" id="{$dialog_id}" data-position-to="#positionPopup" data-corners="false"
         data-overlay-theme="b" data-shadow="false">
        <div class="mobile_select_menu_titlebar_div_grn">
            <div class="mobile_titlebar_grn">
                <span class="mobile_text_grn js_dialog_title"></span>
                <a href="javascript:void(0)" data-rel="back"
                   class="mobile_titlebar_right_grn mobile_colse_icon_grn"></a>
            </div>
            <ul data-role="listview" data-theme="{$data_theme}"
                class="js_member_list mobile-top-listview-member-grn mobile-bottom-listview-member-grn mobile_ul_grn">
            </ul>
            <div class="mobile_select_button_area_grn">
                <div class="mobile_cancel_grn">
                    <input class="cancel_button js_close_button" type="reset"
                           value="{cb_msg module='grn.mobile' key='GRN_MOBILE-14' replace='true'}" data-inline="true"
                           data-theme="{$data_theme}"/>
                </div>
            </div>
        </div>
    </div>
    <div id="positionPopup" style="position:fixed;top:0px;display=none"></div>
{else}
    {strip}
        {foreach from=$display_members_id key=key item=user_id}
            <li data-icon="false"
                class="mobile-list-member-grn ui-li-has-thumb {if $smarty.foreach.user_info.first}ui-first-child {elseif $smarty.foreach.user_info.last} ui-last-child{/if}">
                <a href="{if $smarty.const.ON_FOREST == 1}{$users_info.$user_id.forestUserUrl|escape}{else}{grn_pageurl page='grn/user_view' uid=$user_id}{/if}"
                   class="ui-btn" target="_blank">
                    {grn_mobile_user_image_icon userInfo=$users_info.$user_id photoUrl=$users_info.$user_id.photoUrl userId=$user_id loginId=$login_user_id app_id=$app_id}
                    <div class="mobile_info_grn">
                        <div class="mobile_position_center_grn">
                            <div class="mobile_position_width_grn">
                                <div class="mobile_user_grn">{$users_info.$user_id.col_display_name}</div>
                                <div class="mobile_text_grn"></div>
                            </div>
                        </div>
                    </div>
                </a>
            </li>
        {/foreach}
        {if $page_navigation.next_page_on}
            <li class="js_more_item mobile-showMore-grn ui-li-static ui-body-inherit" id="ul_favour_list_popup"
                data-pager="{$page_navigation.next_page_number}">
                <div class="ui-btn ui-input-btn ui-btn-c ui-corner-all ui-shadow">{cb_msg module='grn.space' key='space_mobile-1' replace='true'}
                    <input type="button" data-inline="true" data-theme="{$data_theme}"/>
                </div>
            </li>
        {/if}
    {/strip}
{/if}