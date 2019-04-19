{if $report_count > 0}
    <div>
        <table class="view_table" width="97%">
            <colgroup>
                <col style="width:1%">
                <col style="width:50%">
                <col style="width:10%">
                <col style="width:30%">
                <col style="width:10%">
            </colgroup>
            <tr>
                <th nowrap="" style="width:1%;">{capture name='grn_report_schedule_GRN_RPRT_SCH_17'}{cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-17' replace='true'}{/capture}{grn_image image='access16.gif' alt=$smarty.capture.grn_report_schedule_GRN_RPRT_SCH_17}</th>
                <th nowrap="">{cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-19' replace='true'}</th>
                <th nowrap="">{cb_msg module='grn.report.schedule' key='grn.report.schedule.mdate' replace='true'}</th>
                <th nowrap="">{cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-18' replace='true'}</th>
                <th nowrap=""></th>
            </tr>
            {foreach from=$report_list item=report name=report}
                <tr>
                    <td nowrap="" style="width: 1%; text-align: center;">
                        {if $report.private}
                            {capture name='grn_report_schedule_GRN_RPRT_SCH_21'}{cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-21' replace='true'}{/capture}{grn_image image='access16.gif' alt=$smarty.capture.grn_report_schedule_GRN_RPRT_SCH_21}
                        {/if}
                    </td>
                    <td style="width:50%;">
                        {grn_link page='report/view' caption="`$report.name`" rid=$report.id}
                    </td>
                    <td style="width:10%;" nowrap="">
                        {$report.mdate}
                    </td>
                    <td nowrap="" style="width:30%;">
                        {grn_user_name uid=$report.creator name=$report.creator_name users_info=$users_info}
                    </td>
                    <td style="width:10%;">
                        {if $report.isDeletable}
                              {grn_delete title=$report.delete_info.title page=$report.delete_info.page no_confirm=$report.delete_info.no_confirm data=$report.delete_info.data handler=$report.delete_info.handler}
                            {capture name='grn_report_schedule_GRN_RPRT_SCH_22'}{cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-22' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_schedule_GRN_RPRT_SCH_22 image='delete20.gif' id="lnk_report_delete_`$report.id`" script='javascript:void(0);'}
                        {/if}
                    </td>
                </tr>
            {/foreach}
        </table>
    </div>
{/if}