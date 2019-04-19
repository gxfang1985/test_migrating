{grn_load_javascript file="grn/html/page/schedule/attendance_confirm_dialog.js"}
{literal}
<script language="JavaScript" type="text/javascript">
<!--
grn.page.schedule.attendance_confirm_dialog.form_name = form_name;
grn.page.schedule.attendance_confirm_dialog.yesCallback = function(){
    grn.page.schedule.add.schedule_submit("{/literal}{$form_name}{literal}", grn.component.url.page("schedule/command_modify"));
};
//-->
</script>
{/literal}

{strip}
    <div class="overlay" style="display: none;" id="attendance_check_overlay"></div>
    <div class="msgbox msgbox_grn" style="display: none;" id="attendance_check_dialog">
        <div class="title">
            <div class="msgbox_title_grn float_left">{cb_msg module='grn.schedule' key='GRN_SCH-999' replace='true'}</div>
            <a href="javascript:void(0);" onclick="grn.page.schedule.attendance_confirm_dialog.closeDialog('attendance_check_dialog');" title="{cb_msg module='grn.grn' key='GRN_GRN-846' replace='true'}"><div class="subWindowClose-grn"></div></a>
            <div class="clear_both_0px"></div>
        </div>
        <div class="content" style="min-height: 120px;">
            <div class="daialog_message_grn">
                <div class="mBottom10">
                    <span class="text_color_sub_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1000' replace='true'}</span>
                    <span class="bold">
                        <span id="attendance_check_confirm_title" class="schedule20"></span>
                    </span>
                </div>
            </div>
            {capture name='grn_schedule_system_GRN_SCH_1001'}{cb_msg module='grn.schedule' key='GRN_SCH-1001' replace='true'}{/capture}{grn_checkbox name='refresh_status' id='refresh_status' value='1' caption=$smarty.capture.grn_schedule_system_GRN_SCH_1001 span_cover="1"}
        </div>
        <div class="buttonArea-grn">
            {strip}
                {capture name='grn_schedule_GRN_SCH_174'}{cb_msg module='grn.schedule' key='GRN_SCH-174' replace='true'}{/capture}
                {grn_button ui="main" spacing="normal" caption=$smarty.capture.grn_schedule_GRN_SCH_174 onclick="grn.page.schedule.attendance_confirm_dialog.closeDialog('attendance_check_dialog');" id="yes_button"}

                {capture name='grn_schedule_GRN_SCH_925'}{cb_msg module='grn.schedule' key='GRN_SCH-925' replace='true'}{/capture}
                {grn_button action="cancel" caption=$smarty.capture.grn_schedule_GRN_SCH_925 id="schedule_button_cancel_confirm" onclick="grn.page.schedule.attendance_confirm_dialog.closeDialog('attendance_check_dialog');"}
            {/strip}
        </div>
    </div>
{/strip}