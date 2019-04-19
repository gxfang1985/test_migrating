{include file='schedule/_check_error_add_modify_schedule.tpl' handle_type='modify'}
{if $use_attendance_check && $schedule_event.attendance_check}
{include file='schedule/_attendance_confirm_dialog.tpl'}
{/if}
<div class="mTop10 buttonArea-grn">
    {strip}
        {capture name='grn_schedule_GRN_SCH_174'}{cb_msg module='grn.schedule' key='GRN_SCH-174' replace='true'}{/capture}
        {capture name='schedule_submit_button_onclick'}
            {if $use_attendance_check && $schedule_event.attendance_check}
                if (!grn.component.button(this).isDisabled()) grn.page.schedule.attendance_confirm_dialog.checkShowDialog();
            {else}
                if (!grn.component.button(this).isDisabled()) grn.page.schedule.add.schedule_submit('{$form_name}', grn.component.url.page('schedule/command_modify'));
            {/if}
        {/capture}
        {grn_button ui="main" spacing="normal" caption=$smarty.capture.grn_schedule_GRN_SCH_174 onclick=$smarty.capture.schedule_submit_button_onclick id="schedule_submit_button"}

        {capture name='schedule_cancel_url'}
            {cb_pageurl page='schedule/view' event=$schedule_event.event_id bdate=$bdate referer_key=$referer_key span_cover="1"}
        {/capture}
        {capture name='schedule_cancel_onclick'}
            grn.page.schedule.add.schedule_cancel('{$smarty.capture.schedule_cancel_url|htmlspecialchars_decode}');
        {/capture}
        {grn_button action="cancel" onclick=$smarty.capture.schedule_cancel_onclick id="schedule_button_cancel"}
    {/strip}
</div>