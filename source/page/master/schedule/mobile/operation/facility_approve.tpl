{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var='schedule_prefix' value='schedule/mobile'}
    {grn_load_javascript file="grn/html/page/schedule/operation/facility_approve.js"}
{literal}
<script>
    grn.page.schedule.operation.facility_approve.OperationFacilityApprove.Parameters = {
        'mobileNotificationPage': '{/literal}{grn_pageurl page='notification/mobile/index' module_id=all}{literal}'
    };
</script>
{/literal}
{if $isSameDay}
    {assign var='string_format_datetime' value='TimeShort_HM'}
{else}
    {assign var='string_format_datetime' value='DateTimeLong_YMDW_HM'}
{/if}
{strip}
<div role="main" data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn">
    <!-- breadcrumb -->
    {include file="grn/mobile_breadcrumb.tpl" not_need_withList=true}
    {* End breadcrumb *}

    {*Show infomations of facility was approved*}
    <div class="mobile-list-login-grn mobile-cmt-operate-grn mobile-todoBodyText-grn">
        {if $isProcessed}
            <div class="mobile-div-title-grn">
                <div class="mobile_box_area_grn">
                    <div class="mobile_box_message_grn">
                        <span class="mobile_icon_information_grn"></span>
                        {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-218' replace='true'}&nbsp;
                        <span class="mobile_bold_grn">
                            {if $approveForView->getStatus() eq 1}
                                {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-219' replace='true'}
                            {else}
                                {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-224' replace='true'}
                            {/if}
                        </span>
                        {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-220' replace='true'}
                    </div>
                    <div class="mobile-list-todoDetail-grn">
                        <div class="mobile-label-small-grn">
                            {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-221' replace='true'}
                        </div>
                        <div class="mobile_contents_detail_grn">
                            {grn_date_format date=$approveForView->getApprovalTime() format="DateTimeMiddle_YMDW_HM"}
                        </div>
                    </div>
                    <div class="mobile-list-todoDetail-grn">
                        <div class="mobile-label-small-grn">
                            {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-222' replace='true'}
                        </div>
                        <div class="mobile_contents_detail_grn">
                            {grn_user_name only_text=true uid=$approveForView->getUser() name=$approveForView->getUserName()}
                        </div>
                    </div>
                    <div class="mobile-list-todoDetail-grn">
                        <div class="mobile-label-small-grn">
                            {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-223' replace='true'}
                        </div>
                        <div class="mobile_contents_detail_grn">
                            {grn_format body=$approveForView->getComment()}
                        </div>
                    </div>
                </div>
                <!--end of mobile_box_area_grn-->
            </div>
            <!-- end of mobile-div-title-grn-->
        {/if}
        {*Event Date time*}
        <div class="mobile-list-todoDetail-grn">
            <div class="mobile-label-small-grn">
                {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-207' replace='true'}
            </div>
            <div class="mobile_contents_detail_grn">
                {if $isSameDay}
                    {grn_date_format date=$scheduleEvent.startDate format="DateLong_YMDW"}
                    {if $scheduleEvent.endDate}
                        <br/>
                        {grn_date_format date=$scheduleEvent.startDate format="TimeLong_HM"}&nbsp;
                        <span>{cb_msg module='grn.schedule' key='GRN_SCH-281' replace='true'}</span>
                        &nbsp;
                        {grn_date_format date=$scheduleEvent.endDate format=$string_format_datetime}
                    {else}
                        &nbsp;{grn_date_format date=$scheduleEvent.startDate format="TimeLong_HM"}
                    {/if}
                {else}
                    <span class="mobile_detail_datetime_grn">
                    {grn_date_format date=$scheduleEvent.startDate format="DateLong_YMDW"}
                    &nbsp;
                    {if $scheduleEvent.endDate}
                        {grn_date_format date=$scheduleEvent.startDate format="TimeLong_HM"}&nbsp;
                        <span>
                            {cb_msg module='grn.schedule' key='GRN_SCH-281' replace='true'}
                        </span>
                        </span>
                        <br/>
                        {grn_date_format date=$scheduleEvent.endDate format=$string_format_datetime}
                    {else}
                        {grn_date_format date=$scheduleEvent.startDate format="TimeLong_HM"}</span>
                    {/if}
                {/if}
            </div>
        </div>
        <div class="mobile-separation-grn"></div>
        {*end Event date time*}
        {*Facility name*}
        <div class="mobile-list-todoDetail-grn">
            <div class="mobile-label-small-grn">
                {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-208' replace='true'}
            </div>
            <div class="mobile-contents-todoDetail-grn mobile-font-warp-grn ">
                {$facility.title|escape}
                {*grn_facility_name faid=$facility.faid noimage=1 no_link=TRUE*}
            </div>
        </div>
        {*End facility name*}
        {*Purpose *}
        <div class="mobile-separation-grn"></div>
        <div class="mobile-list-todoDetail-grn">
            <div class="mobile-label-small-grn">
                {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-209' replace='true'}
            </div>
            <div class="mobile_contents_detail_grn">
                {grn_format body=$scheduleEvent.purpose}
            </div>
        </div>
        <div class="mobile-separation-grn"></div>
        {*End Purpose *}
        <div class="mobile-list-todoDetail-grn">
            <div class="mobile-label-small-grn">
                {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-210' replace='true'}
            </div>
            <div class="mobile-contents-todoDetail-grn">
                {grn_user_name uid=$scheduleEvent.creator_uid name=$scheduleEvent.creator_name only_text=true}
                {if $scheduleEvent.facilityApplyTime neq "" }
                    <span class="mobile-date-list-grn">
                        {grn_date_format date=$scheduleEvent.facilityApplyTime format="DateTimeMiddle_YMDW_HM"}
                    </span>
                {/if}
            </div>
        </div>
        {* Registrant *}

    </div>
    <!--mobile-todoBodyText-grn end-->
    {if !$isProcessed}
        <div class="mobile-separation-grn"></div>
        <form id="formFacilityApprove" method="post"
              action="{grn_pageurl page='schedule/mobile/operation/command_facility_approve'}">
            <div class="mobile_detail_information_comment_grn">
                <span class="mobile_icon_information_grn"></span>
                    <span class="mobile_text_information_grn">
                        {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-211' replace='true'}
                        {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-212' replace='true'}
                        {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-213' replace='true'}
                    </span>
            </div>
            <div class="mobile_facility_approval_textarea_grn">
                <div class="mobile-list-todoDetail-grn">
                    <div class="mobile-label-small-grn">
                        {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-214' replace='true'}
                    </div>
                    <div class="mobile_contents_detail_grn mobile_contents_detail_addtype_grn">
                        {grn_user_name uid=$loginId only_text=true}
                    </div>
                </div>
                <div class="mobile-div-title-grn">
                        <span class="mobile-label-grn">
                            {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-215' replace='true'}
                        </span>
                    {grn_textarea name="data" class="mobile-textarea-grn" wrap="virtual" cols="50" rows="50"}
                </div>
            </div>
            <input name="csrf_ticket" type="hidden" value="{$csrf_ticket}">
            <input name="referer_key" type="hidden" value="{$refererKey}"/>
            <input name="event" type="hidden" value="{$scheduleEvent.eventId}"/>
            <input name="faid" type="hidden" value="{$facility.faid}"/>

            <div class="mobile-buttonArea-grn">
                <div class="mobile-buttonMain-grn mobile-button-left-grn">
                    <input type="submit"
                           value="{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-216' replace='true'}"
                           data-inline="true" data-theme="{$data_theme}"/>
                </div>
                <div class="mobile_button_attention_grn mobile-button-right-grn">
                    <input type="reset"
                           value="{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-217' replace='true'}"
                           data-inline="true" data-theme="{$data_theme}"/>
                </div>
            </div>
        </form>
    {/if}
    </div>{*End div content*}
{/strip}
