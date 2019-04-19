<span class="display_report_detail_schedule" onclick="display_on_off('display_report_open:display_report_swith_image_open:display_report_swith_image_close')">
    <span id="display_report_swith_image_open">
        {grn_image image='report20.gif'}<a href="javascript:void(0);">{cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-37' replace='true'}</a>{if $report_count > 0}<span class="menuNum-grn">{$report_count}</span>{/if}{grn_image class="menu_arrow_grn" image='arrow_down_single_gray.gif'}
    </span>
    <span id="display_report_swith_image_close" style="display:none;">
        {grn_image image='report20.gif'}<a href="javascript:void(0);">{cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-37' replace='true'}</a>{if $report_count > 0}<span class="menuNum-grn">{$report_count}</span>{/if}{grn_image class="menu_arrow_grn" image='arrow_up_single_gray.gif'}
    </span>
</span>

