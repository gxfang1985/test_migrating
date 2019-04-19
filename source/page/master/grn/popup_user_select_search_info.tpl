{grn_load_javascript file="grn/html/component/member_select_search_info.js"}
{strip}
{capture name='grn_grn_GRN_GRN_205'}{cb_msg module='grn.grn' key='GRN_GRN-205' replace='true'}{/capture}
{capture name='grn_grn_GRN_GRN_1552'}{cb_msg module='grn.grn' key='GRN_GRN-1552' replace='true'}{/capture}
<span>
    <span class="textSub-grn vAlignMiddle-grn"></span>
    <a id="searchtarget_info_icon" class="mLeft2" href="javascript:void(0);" title="{$smarty.capture.grn_grn_GRN_GRN_1552}">
        <span class="icon_information_sub16_grn icon_inline_grn icon_only_grn vAlignMiddle-grn"></span>
    </a>
</span>
<div class="bubble has-top-prong balloon_sub_daialog_grn" id="searchtarget_info_tooltip" style="display:none">
    <div style="display: true;"></div>
    <div class="balloon_sub_dialog_base_grn balloon_search_target_grn">
        <div class="sub_title">{$smarty.capture.grn_grn_GRN_GRN_205}</div>
        {if ! $selected_tab}
            {if $url_params.system_display}{grn_user_search_column_names is_system=TRUE}{else}{grn_user_search_column_names}{/if}
        {else}
            {cb_msg module='grn.grn' key='GRN_GRN-1095' replace='true'}
        {/if}
        <div style="left: 90px;" class="top-prong">
            <div class="prong-dk"></div>
            <div class="prong-lt"></div>
        </div>
    </div>
</div>
{/strip}