{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{if !$isProcessed}
    {grn_load_javascript file="grn/html/page/schedule/operation/facility_approve.js"}
{/if}
{if $isSameDay}
    {assign var='string_format_datetime' value='TimeShort_HM'}
{else}
    {assign var='string_format_datetime' value='DateTimeLong_YMDW_HM'}
{/if}
{strip}
<div class="mainareaSchedule-grn">
    <div class="fullmenu_grn">
        <div class="detail_title_grn">
            <div id="event_list">
                <span class="title_mark_schedule_grn"></span>
                {grn_title title=$page_title class=$page_info.parts[0]}
            </div>
        </div>
        <table class="viewTable-grn">
            <tr>
                <th nowrap>
                    {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-207' replace='true'}
                </th>
                <td>
                   <span class="schedule_text_noticeable_grn">
                        {grn_date_format date=$scheduleEvent.startDate format="DateLong_YMDW"}
                        <span class="mLeft15">
                            {grn_date_format date=$scheduleEvent.startDate format="TimeLong_HM"}
                            {if $scheduleEvent.endDate}
                                &nbsp;
                                {cb_msg module='grn.schedule' key='GRN_SCH-281' replace='true'}
                                &nbsp;
                                {grn_date_format date=$scheduleEvent.endDate format=$string_format_datetime}
                            {/if}
                        </span>
                </span>
                </td>
            </tr>
            <tr>
                <th nowrap>
                    {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-208' replace='true'}
                </th>
                <td>
                    <div class="schedule_member_base_grn">
                        <span class="facility-grn">
                            {grn_facility_name faid=$facility.faid}
                        </span>
                    </div>
                </td>
            </tr>
            <tr valign="top">
                <th nowrap>
                    {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-209' replace='true'}
                </th>
                <td style="max-width: 500px;">
                    {grn_format body=$scheduleEvent.purpose}
                </td>
            </tr>
            <tr>
                <th nowrap>
                    {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-210' replace='true'}
                </th>
                <td>
                    <div class="schedule_member_base_grn">
                        <span class="user-grn">{grn_schedule_member_name id=$scheduleEvent.creator_uid name=$scheduleEvent.creator_name is_popup=TRUE}
                        </span>
                        {if $scheduleEvent.facilityApplyTime neq "" }
                            <span class="viewTableSubInfo-grn">
                                &nbsp;{grn_date_format date=$scheduleEvent.facilityApplyTime format="DateTimeMiddle_YMDW_HM"}
                            </span>
                        {/if}
                    </div>
                </td>
            </tr>
        </table>
    {if !$isProcessed}
        <form id="formFacilityApprove" method="post" action="{grn_pageurl page='schedule/operation/command_facility_approve'}">
            <div class="post_info_area_grn mTop15 mBottom20">
                <div class="icon_information_grn">
                    <span>
                        {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-211' replace='true'}
                        <span class="bold_grn">
                            {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-212' replace='true'}
                        </span>
                        {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-213' replace='true'}
                    </span>
                </div>
                <table class="form_table01_grn">
                    <tr valign="top">
                        <th>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-214' replace='true'}</th>
                        <td>
                            {grn_user_name uid=$loginId}
                        </td>
                    </tr>
                    <tr valign="top">
                        <th>
                            {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-215' replace='true'}

                        </th>
                        <td>
                            <div class="form_text_base_grn">
                                {grn_textarea name="data" wrap="virtual" no_cols=true no_rows=true style="width:689px;" class="textarea_sub_grn form_textarea_grn"}
                            </div>
                        </td>
                    </tr>
                    <tr valign="top">
                        <th></th>
                        <td>
                            <div class="mTop3">
                                <span class="buttonPostMain-grn button_r_margin3_grn">
                                    <a id="linkApprove" class="button_min_width2_grn" href="javascript:void(0);">
                                        {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-216' replace='true'}
                                    </a>
                                </span>
                                <span class="button_attention_grn">
                                    <a id="linkReject" class="button_min_width2_grn" href="javascript:void(0);">
                                        {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-217' replace='true'}
                                    </a>
                                </span>

                                <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                                <input name="referer_key" type="hidden" value="{$refererKey}"/>
                                <input name="event" type="hidden" value="{$scheduleEvent.eventId}"/>
                                <input name="faid" type="hidden" value="{$facility.faid}"/>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
        {else}
        {*Show infomations of facility was approved*}
        <div class="view_info_area_grn mTop15 mBottom20">
            <div class="icon_information_grn">
                <span>
                    {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-218' replace='true'}&nbsp;
                    <span class="bold_grn">
                        {if $approveForView->getStatus() eq 1}
                            {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-219' replace='true'}
                        {else}
                            {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-224' replace='true'}
                        {/if}
                    </span>
                    {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-220' replace='true'}&nbsp;
                </span>
            </div>
            <table class="view_table01_grn">
                <tbody>
                <tr valign="top">
                    <th>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-221' replace='true'}</th>
                    <td>:</td>
                    <td>{grn_date_format date=$approveForView->getApprovalTime() format="DateTimeMiddle_YMDW_HM"}</td>
                </tr>
                <tr valign="top">
                    <th>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-222' replace='true'}</th>
                    <td>:</td>
                    <td>{grn_user_name uid=$approveForView->getUser() name=$approveForView->getUserName()}</td>
                </tr>
                <tr valign="top">
                    <th>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-223' replace='true'}</th>
                    <td>:</td>
                    <td>{grn_format body=$approveForView->getComment()}</td>
                </tr>
                </tbody>
            </table>
        </div>
    {/if}
    </div>{*End of div fullmenu_grn*}
</div>{*end of div mainareaSchedule-grn*}
{/strip}
{include file='grn/footer.tpl'}
