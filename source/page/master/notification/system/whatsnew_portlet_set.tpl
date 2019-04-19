{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='notification/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <div class="explanation">
        {cb_msg module='grn.notification.system' key='GRN_NTFC_SY-1' replace='true'}
    </div>

    <table class="std_form">
        <tr>
            <td><div class="sub_title">{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-2' replace='true'}</div></td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-3' replace='true'}</th>
            <td colspan="2">
            {capture name='grn_notification_system_GRN_NTFC_SY_4'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-4' replace='true'}{/capture}{grn_link page=$page.info.all caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_4 image="check20.gif" disabled=TRUE}
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
            <td><br><div class="sub_title">{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-5' replace='true'}</div></td>
        </tr>
        {foreach name="appli" from=$application item=appli_id key=key}
            {assign var='unique_key' value='display_count_'|cat:$key}
            <tr>
                <th nowrap>{grn_link page=$page_info.all caption=$appli_id.name image=$appli_id.class disabled=TRUE}</th>
                <td colspan="2">
                    {if '' === $appli_id.count}
                        {grn_select_numbers select_name=$unique_key options=$select1.options selected=$select1.selected padding=$select1.padding}&nbsp;{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-6' replace='true'}
                    {else}
                        {grn_select_numbers select_name=$unique_key options=$select1.options selected=$appli_id.count padding=$select1.padding}&nbsp;{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-7' replace='true'}
                    {/if}
                </td>
            </tr>
        {/foreach}
        <tr>
            <td></td>
            <td colspan="2">
                {capture name='grn_notification_system_GRN_NTFC_SY_8'}{cb_msg module='grn.notification.system' key='GRN_NTFC_SY-8' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_notification_system_GRN_NTFC_SY_8}
                {grn_button_cancel}
            </td>
        </tr>
    </table>
</form>

{include file='grn/system_footer.tpl'}
