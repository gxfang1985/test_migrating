{assign var='form_name' value='notification'}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <p>
        <table class="std_form">
            <tr>
                <th nowrap>
                    {cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-24' replace='true'}
                </th>
                <td>
                    {grn_select name='font_size' options=$font_options}
                </td>
            </tr>
            <tr>
                <th nowrap>
                    {cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-25' replace='true'}
                </th>
                <td>
                    {grn_image image='check16.gif'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-26' replace='true'}
                    {if $available_space}
                        {if $settings.display_item.space_name}
                            {capture name='grn_notification_portlet_GRN_NTFC_PO_55'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-55' replace='true'}{/capture}{grn_checkbox name="space_name" id="space_name" value="1" checked=true caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_55}
                        {else}
                            {capture name='grn_notification_portlet_GRN_NTFC_PO_56'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-56' replace='true'}{/capture}{grn_checkbox name="space_name" id="space_name" value="1" checked=false caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_56}
                        {/if}
                    {/if}
                    {if $settings.display_item.abstract}
                        {capture name='grn_notification_portlet_GRN_NTFC_PO_27'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-27' replace='true'}{/capture}{grn_checkbox name="abstract" id="abstract" value="1" checked=true caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_27}
                    {else}
                        {capture name='grn_notification_portlet_GRN_NTFC_PO_28'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-28' replace='true'}{/capture}{grn_checkbox name="abstract" id="abstract" value="1" checked=false caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_28}
                    {/if}
                    {if $settings.display_item.sender_name}
                        {capture name='grn_notification_portlet_GRN_NTFC_PO_29'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-29' replace='true'}{/capture}{grn_checkbox name="sender_name" id="sender_name" value="1" checked=true caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_29}
                    {else}
                        {capture name='grn_notification_portlet_GRN_NTFC_PO_30'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-30' replace='true'}{/capture}{grn_checkbox name="sender_name" id="sender_name" value="1" checked=false caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_30}
                    {/if}
                    {if $settings.display_item.timestamp}
                        {capture name='grn_notification_portlet_GRN_NTFC_PO_31'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-31' replace='true'}{/capture}{grn_checkbox name="timestamp" id="timestamp" value="1" checked=true caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_31}
                    {else}
                        {capture name='grn_notification_portlet_GRN_NTFC_PO_32'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-32' replace='true'}{/capture}{grn_checkbox name="timestamp" id="timestamp" value="1" checked=false caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_32}
                    {/if}
                </td>
            </tr>
            <tr>
                <th nowrap>
                    {cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-33' replace='true'}
                </th>
                <td>
                    <select name="module_id">
                    {if ! $selected_module_id}
                        <option value="" selected>{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-34' replace='true'}
                    {else}
                        <option value="">{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-35' replace='true'}
                    {/if}
                    {foreach from=$settings.application item=module key=module_id}
                        {if $selected_module_id == $module_id}
                        <option value="{$module_id}" selected>{$module.name|escape}
                        {else}
                        <option value="{$module_id}">{$module.name|escape}
                        {/if}
                    {/foreach}
                    </select>
                </td>
            </tr>
            <tr>
                <th nowrap>
                    {cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-36' replace='true'}
                </th>
                <td>
                    {grn_select_numbers select_name="rows" padding='&nbsp;' options=$rows_numbers selected=$settings.rows}
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    {capture name='grn_notification_portlet_GRN_NTFC_PO_37'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-37' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_37}
                    {if $display == 'set-system'}
                        {capture name='grn_notification_portlet_GRN_NTFC_PO_38'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-38' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_38 page='portal/system/view' pid=$portlet.pid}
                    {elseif $display == 'set-operation'}
                        {capture name='grn_notification_portlet_GRN_NTFC_PO_39'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-39' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_39 page='portal/operation/view' pid=$portlet.pid}
                    {else}
                        {capture name='grn_notification_portlet_GRN_NTFC_PO_40'}{cb_msg module='grn.notification.portlet' key='GRN_NTFC_PO-40' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_notification_portlet_GRN_NTFC_PO_40 page='portal/personal/view' pid=$portlet.pid}
                    {/if}
                </td>
            </tr>
        </table>
    </p>
    <input type="hidden" name="pid" value="{$portlet.pid}">
    <input type="hidden" name="plid" value="{$portlet.plid}">
    <input type="hidden" name="ppid" value="{$portlet.ppid}">
    <input type="hidden" name="display" value="{$display}">
</form>
