{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}

{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='favour/system/command_common_set'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    {if !$apps_info}
        <div class="mLeft10 mTop10 mBottom10">
            <table>
                <tr>
                    <td valign="top"><span class="icon_information_grn">&nbsp;</span></td>
                    <td><span>{cb_msg module='grn.favour.system' key='GRN_FAV_SY-5' replace='true'}</span></td>
                </tr>
            </table>
        </div>
    {else}
        <table class="std_form mTop10">
            <tr>
                <th nowrap>
                    {cb_msg module='grn.favour.system' key='GRN_FAV_SY-1' replace='true'}
                </th>
                <td>
                    {foreach from=$apps_info item=app_info}
                        {grn_checkbox name=checked_`$app_info.app_id` id=favour_checkbox_`$app_info.app_id` value="checked" checked=$app_info.checked caption=$app_info.name }
                        <br>
                    {/foreach}
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    {capture name='grn_favour_save'}{cb_msg module='grn.favour.system' key='GRN_FAV_SY-2' replace='true'}{/capture}
                    {grn_button_submit id="system_favour_button_save" class='margin' caption=$smarty.capture.grn_favour_save}
                    {grn_button_cancel id="system_favour_button_cancel"}
                </td>
            </tr>
        </table>
    {/if}
</form>


{include file="grn/system_footer.tpl"}