<script type="text/javascript" src="{$app_path}/grn/html/schedule_tz.js?{$build_date}" ></script>
<div class="overlay" style="display:none;" id="background"></div>
<div id="timezone_dialog" class="msgbox center" style="width:auto;display:none;">
    <div id="timezone_title" class="title">{cb_msg module='grn.schedule' key='select_timezone' replace='true'}<a id="closeRelationDialog" style="position: absolute; right: 5px;top:5px;text-decoration:none;" onclick="GRN_ScheduleSelectTimezone.closeTimezoneDialog();" href="javascript:;">{grn_image image="close20.gif"}</a></div>
    <div id="timezone_content" class="content" style="width:450px;">
        <div class="sub_text">{cb_msg module='grn.schedule' key='select_timezone_to_apply' replace='true'}</div>
        <div id="timezone_block" class="timezone_block">
            {if !$disable_different_timezones}<div id="timezone_message" class="sub_text">{cb_msg module='grn.schedule' key='start_timezone' replace='true'}</div>{/if}
            <div id="div_timezone" class="select_timezone">{grn_select_timezone select_timezone=$timezone key='timezone_candidate'}</div>
        </div>
        {if !$disable_different_timezones}
        <div id="end_timezone_block" class="timezone_block">
            <div id="end_timezone_message" class="sub_text">{cb_msg module='grn.schedule' key='end_timezone' replace='true'}</div>
            <div id="div_end_timezone" class="select_timezone">{grn_select_timezone select_timezone=$end_timezone key='end_timezone_candidate'}</div>
        </div>
        {/if}
    </div>
    <div id="timezone_dialog_buttons" class="command">
        {strip}
            {capture name='grn_schedule_apply_button'}{cb_msg module='grn.schedule' key='apply_button' replace='true'}{/capture}
            {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_schedule_apply_button onclick="GRN_ScheduleSelectTimezone.applyTimezone();" id="apply_timezone" disabled=false auto_disable=false}

            {capture name='grn_schedule_cancel_button'}{cb_msg module='grn.schedule' key='cancel_button' replace='true'}{/capture}
            {grn_button action="cancel" caption=$smarty.capture.grn_schedule_cancel_button onclick="GRN_ScheduleSelectTimezone.closeTimezoneDialog();" id="cancel_timezone" disabled=false auto_disable=false}
        {/strip}
    </div>
</div>
<input type='hidden' id='timezone' name='timezone' value='{$timezone}' />
<input type='hidden' id='end_timezone' name='end_timezone' value='{$end_timezone}' />
