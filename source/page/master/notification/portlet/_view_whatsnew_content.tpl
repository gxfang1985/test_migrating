{if $module_data_list}

    {strip}
        {assign var="moduleSchedule" value="grn.schedule"}
        {if $module_data_list.numbers.$moduleSchedule && $module_data_list.numbers.$moduleSchedule.AttendanceCheckEventCount}
            {assign var="attendanceCheckEventCount" value=$module_data_list.numbers.$moduleSchedule.AttendanceCheckEventCount}
        {elseif $module_data_list.indexes.$moduleSchedule && $module_data_list.indexes.$moduleSchedule.AttendanceCheckEventCount}
            {assign var="attendanceCheckEventCount" value=$module_data_list.indexes.$moduleSchedule.AttendanceCheckEventCount}
        {/if}
        {if $module_data_list.numbers.$moduleSchedule && $module_data_list.numbers.$moduleSchedule.FacilityApprovalRequestNum}
            {assign var="facilityApprovalRequestNum" value=$module_data_list.numbers.$moduleSchedule.FacilityApprovalRequestNum}
        {elseif $module_data_list.indexes.$moduleSchedule && $module_data_list.indexes.$moduleSchedule.FacilityApprovalRequestNum}
            {assign var="facilityApprovalRequestNum" value=$module_data_list.indexes.$moduleSchedule.FacilityApprovalRequestNum}
        {/if}
        {if $attendanceCheckEventCount && $attendanceCheckEventCount > 0}
            {capture name="attendanceCheckEventCountInfo"}{strip}
                <div class="portal_update_info_grn">
                    <span class="icon_list_style_grn icon_inline_grn">
                        <a href="{grn_pageurl page='schedule/attendance_list' status=1}" class="schedule20">{cb_msg module='grn.notification' key='GRN_NTFC-194' replace='true'} {$attendanceCheckEventCount} {cb_msg module='grn.notification' key='GRN_NTFC-195' replace='true'}</a> {cb_msg module='grn.notification' key='GRN_NTFC-196' replace='true'}
                    </span>
                </div>
            {/strip}{/capture}
        {/if}
        {if $facilityApprovalRequestNum && $facilityApprovalRequestNum > 0}
            {capture name="facilityApprovalRequestInfo"}{strip}
                <div class="portal_update_info_grn">
                    <span class="icon_list_style_grn icon_inline_grn">
                        {capture name="test"}{cb_msg module='grn.notification' key='GRN_NTFC-197' replace='true'} {$facilityApprovalRequestNum} {cb_msg module='grn.notification' key='GRN_NTFC-198' replace='true'}{/capture}
                        {grn_link page="schedule/operation/approval_facility_list" caption=$smarty.capture.test status=1} {cb_msg module='grn.notification' key='GRN_NTFC-199' replace='true'}
                    </span>
                </div>
            {/strip}{/capture}
        {/if}
        {capture name="appNotificationInfo"}{strip}
            {foreach from=$module_data_list.numbers key=module_id item=module_data}
                {if $module_data.count > 0}
                    <div class="portal_update_info_grn">
                        <span class="icon_list_style_grn icon_inline_grn">
                            {grn_notification_number_link
                            module_id=$module_id
                            count=$module_data.count
                            class="schedule20"
                            page='notification/index'
                            is_read=$is_read
                            is_to_me=$is_to_me
                            }
                        </span>
                    </div>
                {/if}
            {/foreach}
        {/strip}{/capture}

        {capture name='has_unread_all_notification_message'}
            {if (!$total_unread_to_me && $total_unread_all && $is_to_me && !$is_read)}
                <div class="list_message_grn">
                    <div class="list_message_balloon_grn">
                        {cb_msg module='grn.notification' key='GRN_NTFC-206' replace='true'}
                        <a class="js_has_unread_all" href="javascript:">
                            <span class="bold_grn">{cb_msg module='grn.notification' key='GRN_NTFC-207' replace='true'}</span>
                        </a>
                        {cb_msg module='grn.notification' key='GRN_NTFC-208' replace='true'}
                    </div>
                </div>
            {/if}
        {/capture}

        {if $smarty.capture.has_unread_all_notification_message
        || $smarty.capture.facilityApprovalRequestInfo
        || $smarty.capture.attendanceCheckEventCountInfo
        || $smarty.capture.appNotificationInfo}
            <tr>
                <td colspan="6">
                    {strip}
                        {$smarty.capture.facilityApprovalRequestInfo|grn_noescape}
                        {$smarty.capture.attendanceCheckEventCountInfo|grn_noescape}
                        {$smarty.capture.appNotificationInfo|grn_noescape}
                        {$smarty.capture.has_unread_all_notification_message|grn_noescape}
                    {/strip}
                </td>
            </tr>
        {/if}
        <tr>
            <td colspan="6" class="portal_update_partition_grn">
                <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}" />
                <input type="hidden" name="is_to_me" value="{$is_to_me}" />
            </td>
        </tr>
        {counter start=0 assign='counter' print=false}

        {if $is_read == 0}
            {assign var="is_unread" value=1}
        {else}
            {assign var="is_unread" value=0}
        {/if}

        {foreach from=$module_data_list.indexes key=module_id item=module_data}
            {if ($module_data.rows !== 0) && ($module_data.count !== 0)}
                {counter print=false}
                <tr>
                    {if !$is_read}
                        <td></td>
                    {/if}
                    <td class="portal_update_app_name_grn" colspan="5" nowrap><span class="bold">{$module_data.name|escape}</span></td>
                </tr>
                {if $module_data.id==='grn.space'}
                    {foreach from=$module_data.data_list key=sid item=space}
                        <tr>
                            {if !$is_read}
                                <td></td>
                            {/if}
                            <td colspan="5" nowrap>
                                {if $space.icon}
                                    <img class="notify_icon" src="{$space.icon}">
                                {/if}
                                <span style="font-weight:bold;font-size:90%;">{$space.name|cb_mb_truncate:$subject_cols|escape}</span>
                            </td>
                        </tr>
                        {foreach from=$space.data key=nid item=notify}
                            <tr>
                                {grn_notification_data_row
                                notify=$notify data_type='whatsnew'
                                subject_cols=$subject_cols
                                abstract_cols=$abstract_cols
                                name_cols=$name_cols
                                checkbox=$is_unread
                                no_space_name=true
                                no_abstract=$no_abstract
                                no_name=$no_sender_name
                                no_date=$no_timestamp
                                fontsize=$fontsize
                                users_info=$users_info}
                            </tr>
                        {/foreach}
                    {/foreach}
                {else}
                    {foreach from=$module_data.data_list key=nid item=notify}
                        <tr>
                            {grn_notification_data_row
                            notify=$notify
                            data_type='whatsnew'
                            subject_cols=$subject_cols
                            abstract_cols=$abstract_cols
                            name_cols=$name_cols
                            checkbox=$is_unread
                            no_space_name=true
                            no_abstract=$no_abstract
                            no_name=$no_sender_name
                            no_date=$no_timestamp
                            fontsize=$fontsize
                            users_info=$users_info}
                        </tr>
                    {/foreach}
                {/if}
            {/if}
        {/foreach}

        <tr>
            <td colspan="6">
                {if $counter > 0 && !$is_read}
                    <div class="portlet_form_base_grn portlet_notification_check_grn">
                        <span class="check_button_base_grn">
                            <span class="aButtonStandard-grn mRight7">
                                <a href="javascript:void(0)"
                                   onclick="grn_check_all(jQuery(this).parents('form').get(0), 'notification[]');return false;">
                                    <span title="{cb_msg module='grn.grn' key='GRN_GRN-431' replace='true'}"
                                          class="check_button_grn"></span>
                                </a>
                            </span>
                        </span>
                        <span class="aButtonStandard-grn js_button_mark_as_read">
                            <a href="javascript:void(0)"
                               onclick="if(! grn_is_checked(jQuery(this).parents('form').get(0), 'notification[]')) return false;jQuery(this).parents('form').submit();return false;">
                                <span>{cb_msg module='grn.notification' key='GRN_NTFC-71' replace='true'}</span>
                            </a>
                        </span>
                    </div>
                {/if}
                <div class="m_small mTop7">
                    {grn_link image='notify20.gif' page='notification/index' is_to_me=$is_to_me read=$is_read caption=$notification_app_name}
                </div>
            </td>
        </tr>
    {/strip}
{/if}