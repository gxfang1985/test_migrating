{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='notification/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

    <div class="explanation">
        {cb_msg module='grn.notification.system' key='GRN_NTFC_SY-35' replace='true'}
    </div>

    <div class="sub_title">{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-36' replace='true'}</div>
    <table class="std_form">
        {foreach from=$module_settings item=module_setting key=module_id name=module_settings}
            <tr valign="top">
                <th nowrap>{grn_link page=$page_info.all caption=$module_setting.name image=$module_setting.icon disabled=TRUE}</th>
                <td>
                    {capture name='grn_notification_system_GRN_NTFC_SY_37'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-37' replace='true'}{/capture}{grn_checkbox name='set_'|cat:$module_setting.html_escaped_id id='set_'|cat:$module_setting.html_escaped_id value=1 caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_37 checked=$module_setting.setting.set}<br>
                    {if $module_setting.setting.display_type !== 'number'}
                        {capture name='grn_notification_system_GRN_NTFC_SY_38'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-38' replace='true'}{/capture}{grn_radio name='display_type_'|cat:$module_setting.html_escaped_id id='index_'|cat:$module_setting.html_escaped_id value='index' caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_38 checked=TRUE}
                    {else}
                        {capture name='grn_notification_system_GRN_NTFC_SY_39'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-39' replace='true'}{/capture}{grn_radio name='display_type_'|cat:$module_setting.html_escaped_id id='index_'|cat:$module_setting.html_escaped_id value='index' caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_39}
                    {/if}
                    {if $module_setting.setting.display_type === 'number'}
                        {capture name='grn_notification_system_GRN_NTFC_SY_40'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-40' replace='true'}{/capture}{grn_radio name='display_type_'|cat:$module_setting.html_escaped_id id='num_'|cat:$module_setting.html_escaped_id value='number' caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_40 checked=TRUE}
                    {else}
                        {capture name='grn_notification_system_GRN_NTFC_SY_41'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-41' replace='true'}{/capture}{grn_radio name='display_type_'|cat:$module_setting.html_escaped_id id='num_'|cat:$module_setting.html_escaped_id value='number' caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_41}
                    {/if}
                </td>
            </tr>
        {/foreach}
    <tr>
        <td></td>
        <td>
            {capture name='grn_notification_system_GRN_NTFC_SY_42'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-42' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_42}
            {grn_button_cancel}
        </td>
        </tr>
    </table>
</form>

{include file='grn/system_footer.tpl'}
