{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='notification/system/command_'|cat:$page_info.last}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <div class="explanation">{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-74' replace='true'}</div>
    <p></p>
    <table class="std_form">
        <colgroup><col style="width: 15em"></colgroup>
        <tr id="display_auto_delete_notification">
            <th nowrap="" valign="top">{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-75' replace='true'}</th>
            <td>
                <div id="fbox0">
                {grn_select_time prefix='scheduling_time_' minute_interval=$scheduled_times.minute_interval time=$scheduled_times.default_value necessary=true}
                {if $utc_time}<span class="bold"> UTC : ({$utc_time.hour} : {$utc_time.minute})</span>{/if}
                </div>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
            {capture name='grn_notification_system_GRN_NTFC_SY_76'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-76' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_76}
            {grn_button_cancel page='system/application_list' app_id='notification'}
            </td>
        </tr>
    </table>
</form>

{include file='grn/system_footer.tpl'}

