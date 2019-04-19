{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='notification/system/command_'|cat:$page_info.last}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

    <div class="explanation">
        {cb_msg module='grn.notification.system' key='GRN_NTFC_SY-50' replace='true'}
    </div>
    <p>
        <table class="std_form">
            <tr>
                <th nowrap>
                    {cb_msg module='grn.notification.system' key='GRN_NTFC_SY-51' replace='true'}
                </th>
                <td>
                    {capture name='grn_notification_system_GRN_NTFC_SY_52'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-52' replace='true'}{/capture}{grn_link page=$page.info.all caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_52 image="check20.gif" disabled=TRUE}
                    {foreach from=$display_items item=display_item key=key}
                        {assign var='unique_key' value='display_item_'|cat:$key}
                        {if $display_item.checked}
                            {grn_checkbox name=$unique_key id=$unique_key value='1' caption=$display_item.caption|escape checked=TRUE}
                        {else}
                            {grn_checkbox name=$unique_key id=$unique_key value='1' caption=$display_item.caption|escape}
                        {/if}
                    {/foreach}
                </td>
            </tr>
            <tr>
                <th nowrap>
                    {cb_msg module='grn.notification.system' key='GRN_NTFC_SY-53' replace='true'}
                </th>
                <td>
                    {if '' === $setting.count}
                        {grn_select_numbers select_name='display_count' options=$select1.options selected=$select1.selected padding=$select1.padding}&nbsp;{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-54' replace='true'}
                    {else}
                        {grn_select_numbers select_name='display_count' options=$select1.options selected=$setting.count padding=$select1.padding}&nbsp;{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-55' replace='true'}
                    {/if}
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    {capture name='grn_notification_system_GRN_NTFC_SY_56'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-56' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_56}
                    {grn_button_cancel}
                </td>
            </tr>
        </table>
    </p>
</form>

{include file='grn/system_footer.tpl'}
