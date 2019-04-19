{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <p><div class="explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-713' replace='true'}</div>
    <table width="30%" class="view_table mTop10 mBottom5">
        <tr>
            <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-714' replace='true'}</th>
            <td nowrap>
                {capture assign='grn_grn_GRN_SY_US_715'}{cb_msg module='grn.system.user' key='GRN_SY_US-715' replace='true'}{/capture}{grn_checkbox name='permission_to_select_role' id='permission_to_select_role' value=1 checked=$permission_to_select_role caption=$grn_grn_GRN_SY_US_715}
                <br/>
                <input class="margin" type="submit" name="modify" value="{cb_msg module='grn.system.user' key='GRN_SY_US-716' replace='true'}">{grn_button_cancel}
            </td>
        </tr>
    </table>
</form>
{include file='grn/system_footer.tpl'}
