{literal}
<style type="text/css">
    #spinner-loading-{/literal}{$CGID}{literal} {
        background-image: url( {/literal}{$app_path}{literal}/grn/image/cybozu/spinner.gif?{/literal}{$build_date});
    }
</style>
{grn_load_javascript file="grn/html/component/member_add.js"}
{grn_load_javascript file="grn/html/component/member_select_list.js"}
{grn_load_javascript file="grn/html/component/pulldown_menu/pulldown_menu.js"}
<script language="JavaScript" type="text/javascript">
    <!--
    new grn.component.member_add.MemberAdd("{$name}", "{$form_name}",
            {$member_list_names|@json_encode nofilter},
            "{$CID}",
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
                showOmitted: true/*this is used to show (Omitted) item*/
            {rdelim}
    );
    //-->
</script>

{* GRB-18258: This input tag avoids redirect error of exceeding LimitRequestFieldSize at non command_* page. *}
<input type="hidden" name="for_redirect_at_non_command_page[]" value="">

<div class="wf_request_route_grn">
    <table class="borderTable selectlist_base_grn ">
        <tr>
            <th><br></th>
            <th>{cb_msg module='grn.workflow' key='path_class' replace='true'}</th>
            <th>{cb_msg module='grn.workflow' key='path_step' replace='true'}</th>
            <th colspan="2" nowrap>{cb_msg module='grn.workflow' key='processor' replace='true'}</th>
            {*please don't add more spaces between path_step_count and 1 in below code*}
            <td rowspan="{$path_step_count+1}" class="vAlignTop-grn">{strip}
                    <div class="wf_request_route_selectlist_grn">
                        <div class="mTop3 mBottom7 clearFix-cybozu">
                            {capture name="placeholder"}{cb_msg module='grn.grn' key='GRN_GRN-1563' replace='true'}{/capture}
                            {include file="grn/_search_box.tpl" id_searchbox=$search_box_options.id_searchbox placeholder=$smarty.capture.placeholder}
                        </div>
                        <!-- category select -->
                        {include file='grn/_pull_down_parts.tpl' pulldown_id=$pulldown_parts_options.pulldown_id}
                        <!-- category select -->
                        {grn_member_select_list selected_item_options=$selected_item_options list_name=$CID div_class_name='selectlist_r_grn' select_all=true view_detail=true is_calendar=$is_calendar form_name=$form_name}
                    </div>
                {/strip}
            </td>
        </tr>
        <tr>
            <td class="wf_route_arrow_area_grn" align=center rowspan="{$path_step_count}">
                <span class="wf_route_arrow_grn">{cb_msg module='grn.workflow' key='arrow_down' replace='true'}</span>
            </td>
            {foreach from=$path_step_list key=psid item=path_step name=approval_routes}
            {if $smarty.foreach.approval_routes.index > 0}</tr><tr>{/if}
            <td align="center">
                {if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
                    {cb_msg module='grn.workflow' key='pass_along' replace='true'}
                {else}
                    {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}
                {/if}
            </td>
            <td align="center">{$path_step.col_role|escape}</td>
            <td class="item_select processor_area_grn">
                {capture name="list_name" assign="list_name"}all_path_step_{$psid}_{$sUID}{/capture}
                {grn_member_select_list selected_item_options=$path_step.users list_name=$list_name div_class_name='selectlist_l_grn focus_grn workflow_select_list'}
                <input type="hidden" name="selected_users_{$list_name}" value="">
                <input type="hidden" name="selected_groups_{$list_name}" value="">
                <input type="hidden" name="selected_roles_{$list_name}" value="">
            </td>
            <td class="vAlignMiddle-grn tAlignCenter-grn">
                <div class="buttonSelectMove-grn">
                    <div class="mBottom15">
                        <span id="btn_add_{$list_name}{if $is_preview}_preview_mode{/if}" class="aButtonStandard-grn{if $path_step.col_deny_change_path} button_disable_filter_grn{/if}">
                            <a role="button" style="padding-left:0;" href="javascript:void(0);">
                            {strip}
                                <span class="icon-buttonArrowLeft-grn"></span>
                                <span class="aButtonText-grn">{cb_msg module='grn.grn' key='GRN_GRN-1543' replace='true'}</span>
                            {/strip}
                            </a>
                        </span>
                    </div>
                    <div>
                        <span id="btn_rmv_{$list_name}{if $is_preview}_preview_mode{/if}" class="aButtonStandard-grn{if $path_step.col_deny_change_path} button_disable_filter_grn{/if}">
                            <a role="button" style="padding-right:0;" href="javascript:void(0);">
                            {strip}
                                <span class="aButtonText-grn">{cb_msg module='grn.grn' key='GRN_GRN-1544' replace='true'}</span>
                                <span class="icon-buttonArrowRightBehind-grn"></span>
                            {/strip}
                            </a>
                        </span>
                    </div>
                </div>
            </td>
            {/foreach}
        </tr>
    </table>
</div>
