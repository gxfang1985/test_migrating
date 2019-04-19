{literal}
<style type="text/css">
    #spinner-loading-{/literal}{$CGID}{literal} {
        background-image: url( {/literal}{$app_path}{literal}/grn/image/cybozu/spinner.gif?{/literal}{$build_date});
    }
</style>
{grn_load_javascript file="grn/html/component/pubsub.js"}
{grn_load_javascript file="grn/html/component/member_add.js"}
{grn_load_javascript file="grn/html/component/member_select_list.js"}
{grn_load_javascript file="grn/html/component/pulldown_menu/pulldown_menu.js"}
<script language="JavaScript" type="text/javascript">
    <!--
    new grn.component.member_add.MemberAdd("{$name}", "{$form_name}", ["{$sUID}"], "{$CID}",
            {ldelim}
                categorySelectUrl: grn.component.url.page('grn/ajax_user_add_select_by_group'),
                searchBoxOptions: {$search_box_options|@json_encode},
                pulldownPartsOptions: {$pulldown_parts_options|@json_encode},
                appId: "{$app_id}",
                isCalendar: {if $is_calendar}true{else}false{/if},
                showGroupRole: {if $show_group_role}true{else}false{/if},
                includeOrg: "{$include_org}",
                accessPlugin: true,
                accessPluginEncoded: "{$access_plugin_encoded}",
                pluginSessionName: "{$plugin_session_name}",
                pluginDataName: "{$plugin_data_name}",
                addOrgWithUsers: {if $add_org_with_users}true{else}false{/if},
                showOmitted: {if $show_omitted}true{else}false{/if},
                useCandidateSupportParts: {if $use_candidate_support_parts}true{else}false{/if},
                operatorAddName: "{$operator_add_name}",
                selectAllUsersInSearch: {if $select_all_users_in_search}true{else}false{/if}
            {rdelim}
    );
    //-->
</script>
<input type="hidden" name="selected_users_{$sUID}" value="">
<input type="hidden" name="selected_groups_{$sUID}" value="">
<input type="hidden" name="selected_roles_{$sUID}" value="">

{* GRB-18258: This input tag avoids redirect error of exceeding LimitRequestFieldSize at non command_* page. *}
<input type="hidden" name="for_redirect_at_non_command_page[]" value="">

<table class="table_plain_grn selectlist_base_grn">
    <tr>
        <td class="vAlignTop-grn" style="padding-left:0">
            <table class="table_plain_grn">
                <tr>
                    {if $order_parts_options.is_use eq true}
                        <td class="buttonSlectOrder-grn">
                            <div id="{$sUID}_order_top" class="mBottom10">
                                <a class="order_top_grn"
                                   aria-label="{cb_msg module='grn.grn' key='GRN_GRN-1564' replace='true'}"
                                   title="{cb_msg module='grn.grn' key='GRN_GRN-1564' replace='true'}"
                                   href="javascript:void(0)"></a>
                            </div>
                            <div id="{$sUID}_order_up" class="mBottom10">
                                <a class="order_up_grn"
                                   aria-label="{cb_msg module='grn.grn' key='GRN_GRN-1565' replace='true'}"
                                   title="{cb_msg module='grn.grn' key='GRN_GRN-1565' replace='true'}"
                                   href="javascript:void(0)"></a>
                            </div>
                            <div id="{$sUID}_order_down" class="mBottom10">
                                <a class="order_down_grn"
                                   aria-label="{cb_msg module='grn.grn' key='GRN_GRN-1566' replace='true'}"
                                   title="{cb_msg module='grn.grn' key='GRN_GRN-1566' replace='true'}"
                                   href="javascript:void(0)"></a>
                            </div>
                            <div id="{$sUID}_order_bottom" class="mBottom10">
                                <a class="order_bottom_grn"
                                   aria-label="{cb_msg module='grn.grn' key='GRN_GRN-1567' replace='true'}"
                                   title="{cb_msg module='grn.grn' key='GRN_GRN-1567' replace='true'}"
                                   href="javascript:void(0)"></a>
                            </div>
                        </td>
                    {else}
                        <td style="padding-left:0; padding-bottom:0"></td>
                    {/if}
                    <td class="item_select">
                        {grn_member_select_list selected_item_options=$selected_users list_name=$sUID div_class_name='selectlist_l_grn focus_grn' select_all=true is_calendar=$is_calendar}
                    </td>
                </tr>
            </table>
        </td>
        <td class="vAlignTop-grn item_right_left">
            <div class="buttonSelectMove-grn">
                <div class="mBottom15">
            <span class="aButtonStandard-grn">
                <a role="button" id="btn_add_{$sUID}" style="padding-left:0;" href="javascript:void(0);">
                    {strip}
                        <span class="icon-buttonArrowLeft-grn"></span>
                        <span class="aButtonText-grn">{cb_msg module='grn.grn' key='GRN_GRN-1543' replace='true'}</span>
                    {/strip}
                </a>
            </span>
                </div>
                <div>
            <span class="aButtonStandard-grn">
                <a role="button" id="btn_rmv_{$sUID}" style="padding-right:0;" href="javascript:void(0);">
                    {strip}
                        <span class="aButtonText-grn">{cb_msg module='grn.grn' key='GRN_GRN-1544' replace='true'}</span>
                        <span class="icon-buttonArrowRightBehind-grn"></span>
                    {/strip}
                </a>
            </span>
                </div>
            </div>
        </td>
        <td class="vAlignTop-grn">
            {if $search_box_options.is_use eq true}
                <div class="mTop3 mBottom7 clearFix-cybozu">
                    {capture name="placeholder"}{cb_msg module='grn.grn' key='GRN_GRN-1563' replace='true'}{/capture}
                    {include file="grn/_search_box.tpl" id_searchbox=$search_box_options.id_searchbox placeholder=$smarty.capture.placeholder}
                </div>

            {/if}

            {if $pulldown_parts_options.is_use eq true}
                <!-- category select -->
                {include file='grn/_pull_down_parts.tpl' pulldown_id=$pulldown_parts_options.pulldown_id}
                <!-- category select -->
            {/if}

            {grn_member_select_list selected_item_options=$candidate_users list_name=$CID div_class_name=$select_list_div_class_name select_all=true view_detail=$view_detail is_calendar=$is_calendar form_name=$form_name}

        </td>
    </tr>
</table>