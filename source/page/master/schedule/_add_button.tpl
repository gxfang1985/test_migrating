{include file='schedule/_check_error_add_modify_schedule.tpl'}
{if $top_button && $kintone_dialog_mode}
<div class="relation_subwindow_menupart_grn">
    <div class="buttonArea-grn nowrap-grn">
{else}
<div class="mTop10 buttonArea-grn">
{/if}

    {strip}
        <script>
            {literal}
                function update_back_step()
                {
                    grn.page.schedule.add.update_back_step();
                }
            {/literal}
        </script>

        {capture name='grn_schedule_GRN_SCH_149'}{cb_msg module='grn.schedule' key='GRN_SCH-149' replace='true'}{/capture}
        {capture name='schedule_submit_button_onclick'}
            if (!grn.component.button(this).isDisabled()) grn.page.schedule.add.schedule_submit('{$form_name}', grn.component.url.page('schedule/command_add'));
        {/capture}
        {grn_button ui="main" spacing="normal" caption=$smarty.capture.grn_schedule_GRN_SCH_149 onclick=$smarty.capture.schedule_submit_button_onclick id="schedule_submit_button$button_id_suffix"}

        {if $kintone_dialog_mode}
            {grn_button action="cancel" onclick="javascript:window.close();" id="schedule_button_cancel"}
        {else}
            {grn_button action="cancel" onclick="grn.page.schedule.add.schedule_cancel('back');return false;" id="schedule_button_cancel"}
        {/if}
    {/strip}

</div>
{if $top_button && $kintone_dialog_mode}
    </div>
<div class="fix_menupart_margin_grn"></div>
{/if}
