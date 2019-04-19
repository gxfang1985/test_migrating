{strip}
{assign var="form_name" value=$smarty.template|basename}
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_javascript file="grn/html/component/validator_mobile.js"}
{grn_load_javascript file="grn/html/page/schedule/mobile/confirmation.js"}
{literal}
<script language="Javascript" text="text/javascript">
(function()
{
    var G = grn.page.schedule.mobile.confirmation;
    G.formName = '{/literal}{$form_name}{literal}';
    G.ERRMSG_SCOPE_SELECT_IS_REQUIRED = '{/literal}{cb_msg module='grn.schedule' key='GRN_SCH-178' replace='true'}{literal}';
    G.backUrl = '{/literal}{grn_pageurl page=$breadcrumb_upper_page.page params=$breadcrumb_upper_page.params}{literal}';
})();
</script>
{/literal}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-grn">
    <!--breadcrumb-->
    {include file="grn/mobile_breadcrumb.tpl"}
    <!--end breadcrumb-->
    <form method="post" name="{$form_name}" action="{cb_pageurl page='schedule/mobile/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <div class="mobile_delete_confirm_grn mobile_schedule_delete_confirm_grn">
            <span class="mobile_icon_attention_grn"></span>
            <span class="mobile_text_grn">{cb_msg module='grn.schedule' key='GRN_SCH-832' replace='true'}</span>
            <span class="mobile_delete_confirm_text_grn">{$schedule_event.data}</span>
        </div>
        <div class="mobile_schedule_grn">
            <div class="mobile_list_grn">
                {** -------------- VCBSCH0010 START ----------------- **}
                {if $netmeeting}
                    <p>
                        {cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-42' replace='true'}
                    </p>
                {/if}
                {** -------------- VCBSCH0010 END   ----------------- **}
                <div id="FieldToShowErrorMessage" class="mobile-error-area-grn"></div>
                {if ($schedule_event.type == "share_repeat") or ($schedule_event.type == "repeat")}
                    <div class="mobile_title_grn">{cb_msg module='grn.schedule' key='GRN_SCH-177' replace='true'}<span class="mobile_important_grn">*</span></div>
                    <ul id="apply">
                        <li>
                            <span class="mobile_icon_radiobutton_grn mobile_icon_radiobuttonoff_grn"></span><span class="mobile_radiobutton_grn"><input name="apply" type="radio" value="this"></span>
                            <span class="mobile_text_grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-11' replace='true'}<span class="mobile_subtext_grn">{$schedule_event.str_date}</span></span>
                            <div class="mobile_text_grn"></div>
                        </li>
                        <li>
                            <span class="mobile_icon_radiobutton_grn mobile_icon_radiobuttonoff_grn"></span><span class="mobile_radiobutton_grn"><input name="apply" type="radio" value="after"></span>
                            {capture name='grn_schedule_GRN_SCH_850'}{cb_msg module='grn.schedule' key='GRN_SCH-850' replace='true'}{/capture}
                            {if $smarty.capture.grn_schedule_GRN_SCH_850 == ''}
                                <span class="mobile_text_grn">{$schedule_event.str_date}<span class="mobile_subtext_grn">{cb_msg module='grn.schedule' key='GRN_SCH-851' replace='true'}</span></span>
                            {else}
                                <span class="mobile_text_grn">{$smarty.capture.grn_schedule_GRN_SCH_850}<span class="mobile_subtext_grn">{$schedule_event.str_date}</span></span>
                            {/if}
                        </li>
                        <li>
                            <span class="mobile_icon_radiobutton_grn mobile_icon_radiobuttonoff_grn"></span><span class="mobile_radiobutton_grn"><input name="apply" type="radio" value="all"></span>
                            <span class="mobile_text_grn mobile_important_grn">{cb_msg module='grn.schedule' key='GRN_SCH-182' replace='true'}</span>
                        </li>
                    </ul>
                {/if}
            </div>
        </div>
        <div data-theme="{$data_theme}" class="mobile_button_area_grn mobile_button_delete_grn">
            <div class="mobile_ok_grn mobile_show_overlay_js">
                <input type="submit" value="{cb_msg module='grn.schedule' key='GRN_SCH-154' replace='true'}" data-inline="true" data-theme="{$data_theme}" />
            </div>
            <div class="mobile_cancel_grn mobile_show_overlay_js">
                <input type="reset" value="{cb_msg module='grn.schedule' key='GRN_SCH-155' replace='true'}" data-inline="true" data-theme="{$data_theme}" />
            </div>
        </div>
        <input type="hidden" name="event" value="{$schedule_event.event_id|escape}">
        <input type="hidden" name="uid" value="{$user_id|escape}">
        <input type="hidden" name="gid" value="{$group_id|escape}">
        <input type="hidden" name="bdate" value="{$schedule_event.date|escape}">
        <input type="hidden" name="referer_key" value="{$referer_key|escape}">
    </form>
</div>
{/strip}