{strip}
    <input type='hidden' id='{$dialog_name}_top_page_number' value='{$page_navigation.top_page_number}'>
    <input type='hidden' id='{$dialog_name}_prev_page_number' value='{$page_navigation.prev_page_number}'>
    <input type='hidden' id='{$dialog_name}_next_page_number' value='{$page_navigation.next_page_number}'>

    <input type='hidden' id='{$dialog_name}_display_mode' value='{$display_mode}'>
    <input type='hidden' id='{$dialog_name}_sub_primary_key' value='{$sub_primary_key}'>
    <input type='hidden' id='{$dialog_name}_switch_tab_id' value='{$switch_tab_id}'>

    <input type='hidden' id='{$dialog_name}_prev_current_page_number' value='{$prev_current_page_number}'>
    <input type='hidden' id='{$dialog_name}_prev_switch_tab_id' value='{$prev_switch_tab_id}'>
    <input type='hidden' id='{$dialog_name}_prev_search_word' value='{$prev_search_word}'>
    <div class="mBottom10">
        {if $use_switch_tab}
            {if is_array($switch_tab_caption)}
                {if count($switch_tab_caption) >= 2}
                    {assign var='caption1' value=$switch_tab_caption[0]}
                    {assign var='caption2' value=$switch_tab_caption[1]}
                {elseif count($switch_tab_caption) == 1}
                    {assign var='caption1' value=$switch_tab_caption[0]}
                {/if}
            {/if}
            {capture name='grn_grn_GRN_SWITCH_TAB_CAPTION1'}{if $caption1}{$caption1}{/if}{/capture}
            {capture name='grn_grn_GRN_SWITCH_TAB_CAPTION2'}{if $caption2}{$caption2}{/if}{/capture}
            <div class="navi_viewchange_grn float_left mRight10">
                <ul id="">
                    {if $switch_tab_id == 1}
                        <li class="navi_viewchange_base_select_grn navi_viewchange_left_select_grn"><span>{$smarty.capture.grn_grn_GRN_SWITCH_TAB_CAPTION1}</span></li>
                        <li><a id="2" href="javascript:void(0)" class="navi_viewchange_base_grn navi_viewchange_right_grn" >{$smarty.capture.grn_grn_GRN_SWITCH_TAB_CAPTION2}</a></li>
                    {elseif $switch_tab_id == 2}
                        <li><a id="1"  href="javascript:void(0)" class="navi_viewchange_base_grn navi_viewchange_left_grn" >{$smarty.capture.grn_grn_GRN_SWITCH_TAB_CAPTION1}</a></li>
                        <li class="navi_viewchange_base_select_grn navi_viewchange_right_select_grn"><span>{$smarty.capture.grn_grn_GRN_SWITCH_TAB_CAPTION2}</span></li>
                    {/if}
                </ul>
            </div>
        {/if}
        {if $use_search}
            {** search start **}
            <div class="search_navi float_right">
                <div class="searchbox-grn">
                    <div id="searchbox-select-cybozu"></div>
                    <div id="searchbox-keyword-cybozu" class="input-text-outer-cybozu">
                        <input maxlength="100" class="input-text-schedule input-text-cybozu focus_grn" id="{$dialog_name}_searchword" name="searchword" autocomplete="on" value="{$search_word}" type="text">
                        <button class="searchbox-submit-cybozu" id="{$dialog_name}_searchbutton" type="submit" title="{cb_msg module='grn.grn' key='GRN_GRN-1568' replace='true'}" aria-label="{cb_msg module='grn.grn' key='GRN_GRN-1568' replace='true'}""></button>
                    </div>
                </div>
            </div>
            <div class="clear_both_0px"></div>
            {** search end **}
        {/if}
    </div>
    <div style="min-width:470px; max-width:870px; min-height:30px; max-height:480px; display:block;" class="content">
        {if $no_exists_result}
            {include file="grn/ajax/_member_list_dialog_spinner.tpl"}
            <div id="{$dialog_name}_result">
                <div class="list_message_grn">
                    <div class="list_message_balloon_grn">
                        <span class="bold_grn">{$no_exists_message}</span>
                    </div>
                    <div class="balloon_arrow_down_grn"></div>
                    <div class="list_message_icon_grn">
                        <span class="message_middle_icon_size_grn information_message_middle_icon_grn"></span>
                    </div>
                </div>
            </div>
        {else}
            <div style="max-height: 420px; overflow-y: auto;" class="list_column_li_base_style2_grn mTop5">
                <div class="list_column_li_style2_grn">
                    {include file="grn/ajax/_member_list_dialog_spinner.tpl" dialog_name=$dialog_name}
                    <div id="{$dialog_name}_result">
                        <ul>
                            {capture name='grn_grn_GRN_DATA_LINE_GROUP'}{cb_msg module='grn.grn' key='GRN_GRN-ORGANIZATION' replace='true'}{/capture}
                            {capture name='grn_grn_GRN_DATA_LINE_ROLE'}{cb_msg module='grn.grn' key='GRN_GRN-ROLE' replace='true'}{/capture}
                            {foreach from=$display_members_id key=key item=user_id}
                                {assign var='line_prefix' value='_'|explode:$key}
                                {if $line_prefix[0] == 'u'}
                                    <li>
                                        <div class="profileImage-grn v-allign-middle mRight7">
                                            <div class="profileImageFrame-grn">
                                                {grn_user_image_icon userInfo=$users_info.$user_id photoUrl=$users_info.$user_id.photoUrl userId=$user_id loginId=$login_user_id size=$iconSize addImageTitle=TRUE app_id=$app_id}
                                            </div>
                                        </div>
                                        <span class="js_label">{grn_user_name uid=$user_id noimage="true"}</span>
                                    </li>
                                {else}
                                    {if $line_prefix[0] == 'g'}
                                        {assign  var='use_drill_down' value=$groups_info[$user_id].use_drill_down}
                                    {elseif $line_prefix[0] == 'sr'}
                                        {assign  var='use_drill_down' value=$static_roles_info[$user_id].use_drill_down}
                                    {elseif $line_prefix[0] == 'dr'}
                                        {assign  var='use_drill_down' value=$dynamic_roles_info[$user_id].use_drill_down}
                                    {/if}
                                    <li class="member_list_drilldown_base_grn">
                                        {if $use_drill_down }
                                        <a href="javascript:void(0)" class="block_grn">
                                            {/if}
                                            <span class="float_left inline_block_grn">
                                        <div class="profileImage-grn v-allign-middle mRight7">
                                            <div class="profileImageFrame-grn"><div class="profileImage-grn">
                                                    <div class="profileImageFrame-grn">
                                                        {if $line_prefix[0] == 'g'}
                                                            <div title="{$smarty.capture.grn_grn_GRN_DATA_LINE_GROUP}" aria-label="{$smarty.capture.grn_grn_GRN_DATA_LINE_GROUP}" class="profile_image_organization_grn"></div>
                                                        {else}
                                                            <div title="{$smarty.capture.grn_grn_GRN_DATA_LINE_ROLE}" aria-label="{$smarty.capture.grn_grn_GRN_DATA_LINE_ROLE}" class="profile_image_role_grn"></div>
                                                        {/if}
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <span class="js_label">
                                            {if $line_prefix[0] == 'g'}{grn_organize_name gid=$user_id noimage=true}{elseif $line_prefix[0] == 'sr'}{grn_role_name rid=$user_id}{elseif $line_prefix[0] == 'dr'}{$user_id|escape}{/if}
                                        </span>
                                    </span>
                                            <span class="advance_list_base_grn float_right">
                                        {if $use_drill_down }
                                            <span class="icon_advance_list_grn" >
                                            <input type="hidden" id="{$dialog_name}_sub_search_key" value="{$key}">
                                        </span>
                                        {/if}
                                    </span>
                                            <div class="clear_both_0px"></div>
                                            {if $use_drill_down }
                                        </a>
                                        {/if}
                                    </li>
                                {/if}
                            {/foreach}
                        </ul>
                    </div>
                </div>
            </div>
        {/if}
        <div class="list_paging_grn mTop5 js_navi_space_dialog">
            {** To Top **}
            {capture name='grn_grn_GRN_DIALOG_NAVIGATOR_TO_FIRST'}{cb_msg module='grn.grn' key='grn.dialog.navigator.to_first' replace='true'}{/capture}
            {if $page_navigation.top_page_on}
                <span class="top_page_on js_top_page_on" style="" data-page="top">
                <a href="javascript:void(0);" aria-label="{$smarty.capture.grn_grn_GRN_DIALOG_NAVIGATOR_TO_FIRST}" title="{$smarty.capture.grn_grn_GRN_DIALOG_NAVIGATOR_TO_FIRST}" class="action_grn">
                    <span class="arrow_first_button_grn"></span>
                </a>
            </span>
            {else}
                <span style="display: inline-block;" class="action_disable_grn top_page_off js_top_page_off" aria-disabled="true">
                <span aria-label="{$smarty.capture.grn_grn_GRN_DIALOG_NAVIGATOR_TO_FIRST}" title="{$smarty.capture.grn_grn_GRN_DIALOG_NAVIGATOR_TO_FIRST}" class="arrow_first_button_grn"></span>
            </span>
            {/if}
            {** To Prev **}
            {capture name='grn_grn_GRN_DIALOG_NAVIGATOR_TO_PREV'}{cb_msg module='grn.grn' key='grn.dialog.navigator.to_prev_suffix' replace='true'}{$page_navigation.display_limit}{cb_msg module='grn.grn' key='grn.dialog.navigator.to_prev_prefix' replace='true'}{/capture}
            {if $page_navigation.prev_page_on}
                <span class="prev_page_on js_prev_page_on" style="" data-page="prev">
            <a href="javascript:void(0);" aria-label="{$smarty.capture.grn_grn_GRN_DIALOG_NAVIGATOR_TO_PREV}" title="{$smarty.capture.grn_grn_GRN_DIALOG_NAVIGATOR_TO_PREV}" class="action_grn">
                <span class="arrow_left_button_grn"></span>
            </a>
        </span>
            {else}
                <span style="display: inline-block;" class="action_disable_grn prev_page_off js_prev_page_off" aria-disabled="true">
                <span aria-label="{$smarty.capture.grn_grn_GRN_DIALOG_NAVIGATOR_TO_PREV}" title="{$smarty.capture.grn_grn_GRN_DIALOG_NAVIGATOR_TO_PREV}" class="arrow_left_button_grn"></span>
            </span>
            {/if}
            {** To Next **}
            {capture name='grn_grn_GRN_DIALOG_NAVIGATOR_TO_NEXT'}{cb_msg module='grn.grn' key='grn.dialog.navigator.to_next_suffix' replace='true'}{$page_navigation.display_limit}{cb_msg module='grn.grn' key='grn.dialog.navigator.to_next_prefix' replace='true'}{/capture}
            {if $page_navigation.next_page_on}
                <span class="next_page_on js_next_page_on" style="" data-page="next">
            <a href="javascript:void(0);" aria-label="{$smarty.capture.grn_grn_GRN_DIALOG_NAVIGATOR_TO_NEXT}" title="{$smarty.capture.grn_grn_GRN_DIALOG_NAVIGATOR_TO_NEXT}" class="action_grn">
                <span class="arrow_right_button_grn"></span>
            </a>
        </span>
            {else}
                <span class="action_disable_grn next_page_off js_next_page_off" style="" aria-disabled="true">
            <span aria-label="{$smarty.capture.grn_grn_GRN_DIALOG_NAVIGATOR_TO_NEXT}" title="{$smarty.capture.grn_grn_GRN_DIALOG_NAVIGATOR_TO_NEXT}" class="arrow_right_button_grn"></span>
        </span>
            {/if}
            <span class="sub_title numberList vAlignMiddle-grn mLeft10">
            <span class="start_num js_start_num">{$page_navigation.start_num}</span>
            -
            <span class="end_num js_end_num">{$page_navigation.end_num}</span>
        </span>
        </div>
    </div>
{/strip}