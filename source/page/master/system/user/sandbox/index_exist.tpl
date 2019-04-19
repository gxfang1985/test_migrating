{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
<div class="mainarea">
    {grn_title title=$page_title class=$page_info.parts[0]}
    {assign var="form_name" value=$smarty.template|basename}

    <form id="sandbox_form" name="{$form_name}" method="post" action="{grn_pageurl page='system/user/sandbox/command_index'}">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

        <div id="one_parts">
            {* 一般的な説明 *}
            <div class="explanation mTop15 mBottom15">
                {cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-6' replace='true'}
            </div>

            {* 組織/ユーザーの設定リンク *}
            <div class="mBottom20">
                {capture name='grn_system_user_org_list'}{cb_msg module='grn.system.user' key='org_list'}{/capture}
                {grn_link class='icon_organization_b_grn' page='system/user/sandbox/org_list' caption=$smarty.capture.grn_system_user_org_list}
            </div>

            {* 反映タイミングの設定 *}
            <div class="sub_title mBottom7">{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-7' replace='true'}</div>
            <div class="mLeft15">
                {capture name="grn_system_user_sandbox_GRN_SY_SANDBOX_INDEX_8"}{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-8' replace='true'}{/capture}
                {grn_radio caption=$smarty.capture.grn_system_user_sandbox_GRN_SY_SANDBOX_INDEX_8 id="system_user_sandbox_apply_now" name="set_time" value="" class="mRight10"
                           checked=!$preset_exist disabled=$preset_exist}
                {capture name="grn_system_user_sandbox_GRN_SY_SANDBOX_INDEX_9"}{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-9' replace='true'}{/capture}
                {grn_radio caption=$smarty.capture.grn_system_user_sandbox_GRN_SY_SANDBOX_INDEX_9 id="system_user_sandbox_set_time" name="set_time" value=""
                           checked=$preset_exist}
                <div class="attention mTop5">
                    {cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-10' replace='true'}
                </div>
                <div class="set_part_frame_grn mTop10" {if !$preset_exist}style="display:none;"{/if}>
                    <div class="float_left">
                        <span class="sub_title">{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-18' replace='true'}</span>
                        <span id="sandbox_preset_date_select" {if $preset_exist}style="display:none;"{/if}>
                            {grn_select_date prefix='sandbox_' date=$preset_datetime_current_timezone form_name=$form_name no_delimiter=true}
                            {grn_select_time prefix='sandbox_' minute_interval=30 time=$preset_datetime_current_timezone necessary=true}
                        </span>
                        <span id="sandbox_set_time" {if !$preset_exist}style="display:none;"{/if}>
                            {strip}
                            <span class="bold_grn mRight20 nowrap-grn">
                                {grn_date_format format='DateTimeFull_YMDW_HM' date=$preset_datetime_current_timezone}
                            </span>
                            <span class="mRight20 nowrap-grn">
                                UTC: {grn_date_format format='DateTimeFull_YMDW_HM' date=$preset_datetime_UTC}
                            </span>
                            {/strip}
                        </span>
                    </div>
                    <div class="float_right" id="preset_setting_update_item" {if !$preset_exist}style="display:none;"{/if}>
                        {strip}
                        <span class="menu_item">
                            <span class="nowrap-grn">
                                {*  日時を変更する *}
                                <a href="#" class="menu_item update_sandbox_preset_date">
                                    <span>
                                        {grn_image image="modify20.gif"}
                                        {cb_msg module="grn.system.user.sandbox" key="GRN_SY_SANDBOX-INDEX-26" replace="true"}
                                    </span>

                                </a>
                            </span>
                        </span>
                        <span class="menu_item">
                             <span class="nowrap-grn">
                               {*  設定した日時を取り消す *}
                               <a href="#" class="icon_cancel_b_grn">
                                 <span class="nowrap-grn">
                                   {grn_image image="image-common/cancel_b20.png"}
                                   {cb_msg module="grn.system.user.sandbox" key="GRN_SY_SANDBOX-INDEX-27" replace='true'}
                                 </span>
                               </a>
                             </span>
                        </span>
                        {/strip}
                    </div>
                    <div class="clear_both_0px"></div>
                </div>
            </div>
            <div class="mLeft15 mRight20">
                <input type="hidden" name="command" value="apply">
                {* 時限設定の反映 *}
                <div class="float_left mTop10">
                    {capture name='grn_system_user_GRN_SY_SANDBOX_INDEX_11'}{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-11' replace='true'}{/capture}
                    {grn_button_submit class="mRight15" caption=$smarty.capture.grn_system_user_GRN_SY_SANDBOX_INDEX_11 id="system_user_sandbox_submit" button_type="submit" onclick="return false;"}
                    {grn_button_cancel class="left" id="system_user_sandbox_cancel" page="system/user/sandbox/index"}
                </div>
                {* 削除 *}
                <span class="menu_item float_right mTop10">
                    <span class="nowrap-grn">
                        <a href="#" id="delete_sand_box_grn" class="icon-delete-grn">
                            {cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-12' replace='true'}
                        </a>
                    </span>
                </span>
                <div class="clear_both_0px"></div>
            </div>
        </div>
    </form>
</div>

{include file="grn/system_footer.tpl"}
{grn_delete title=$delete_sandbox_info.title page=$delete_sandbox_info.page data=$delete_sandbox_info.data handler=$delete_sandbox_info.handler}
<script type="text/javascript">
    {grn_get_date_format_js function_name_prefix="sandbox_"}
</script>
{grn_load_javascript file="grn/html/page/system/user/sandbox/index_exist.js"}
{* 文言の設定 *}
<script type="text/javascript">
    var page = grn.page.system.user.sandbox.index_exist;
    {literal}
    page.resources = {};
    page.resources.messageBox = {};
    page.resources.removePresetMessageBox = {};
    {/literal}
    page.resources.messageBox.yes = "{cb_msg module='grn.common' key='yes' replace='true'}";
    page.resources.messageBox.no = "{cb_msg module='grn.common' key='no' replace='true'}";
    page.resources.messageBox.title = "{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-19' replace='true'}";
    page.resources.messageApplyNow = "{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-20' replace='true'}";
    page.resources.messageSetTime = "{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-21' replace='true'}";
    page.resources.messageApplyNowButton = "{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-22' replace='true'}";
    page.resources.messageSetTimeButton = "{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-11' replace='true'}";
    page.resources.updateSetTimeButton = "{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-23' replace='true'}";
    page.resources.removePresetMessageBox.title = "{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-24' replace='true'}";
    page.resources.removePresetMessageBox.message = "{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-INDEX-25' replace='true'}";
    page.resources.dateFormat = "{cb_msg module='fw.date' key='DateTimeLong_YMDW_HM24'}"; {* Use Dynamic Resources *}

    page.setupIndexExists({$preset_exist});
</script>
