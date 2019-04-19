{grn_load_javascript file="grn/html/component/pulldown_menu/pulldown_menu.js"}
{grn_load_css file="grn/html/component/pulldown_menu/pulldown_menu.css"}
<div class="mBottom7 nowrap-grn">
    <dl id="{$pulldown_id}" class="selectmenu_grn selectmenu_base_grn">
        {strip}
            <dt>
                <a href="javascript:void(0)" class="nowrap-grn">
                    <span></span>
                    <span class="selectlist_selectmenu_item_grn pulldown_head"></span>
                    <span class="pulldownbutton_arrow_down_grn mLeft3"></span>
                </a>
            </dt>
            <dd>
                <div class="pulldown_menu_grn" style="display: none;">
                    <ul>
                        {foreach from=$category_options item=option}
                            {* $option.type == 2 means this option is priority group that is selected first.*}
                            <li data-value="{$option.value}" {if $option.type == 2}data-selected{/if}>
                                <a href="javascript:void(0)">
                                <span class="vAlignMiddle-grn">
                                    {grn_group_name group=$option}
                                    </span>
                                </a>
                            </li>
                        {/foreach}
                    </ul>
                </div>
            </dd>
    </dl>
    {if not $popup_target_list}{assign var="popup_target_list" value=$sUID}{/if}
    {if $access_plugin}
        {capture name='grn_grn_GRN_GRN_811'}{cb_msg module='grn.grn' key='GRN_GRN-811' replace='true'}{/capture}
        {grn_popup_user_select_link caption=$smarty.capture.grn_grn_GRN_GRN_811
                                    form_name=$form_name
                                    select_name=$popup_target_list
                                    system=false
                                    system_display=false
                                    include_org=$popup_include_org
                                    access_plugin=$access_plugin
                                    plugin_session_name=$plugin_session_name
                                    plugin_data_name=$plugin_data_name
                                    module='schedule'
                                    app_id=$app_id
                                    require_role_tab=$require_role_tab
                                    use_new_ui=true
                                    width="1014"
                                    height="675"
                                    is_calendar=$is_calendar
                                    show_group_role=$show_group_role
                                    reflect_to_additional_name=$reflect_to_additional_name}
    {else}
        {capture name='grn_grn_GRN_GRN_812'}{cb_msg module='grn.grn' key='GRN_GRN-812' replace='true'}{/capture}
        {grn_popup_user_select_link caption=$smarty.capture.grn_grn_GRN_GRN_812
                                    form_name=$form_name
                                    select_name=$sUID
                                    system=false
                                    system_display=false
                                    include_org=$popup_include_org
                                    module="schedule"
                                    app_id=$app_id
                                    require_role_tab=$require_role_tab
                                    use_new_ui=true
                                    width="1014"
                                    height="675"
                                    is_calendar=$is_calendar
                                    show_group_role=$show_group_role
                                    reflect_to_additional_name=$reflect_to_additional_name}
    {/if}
</div>
{/strip}