{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/personal/command_'|cat:$page_info.last}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

    <table class="std_form mTop15">
        <tr>
            <th>{cb_msg module='grn.bulletin.personal' key='adjust_subscribe.checkbox.label' replace='true'}</th>
            <td>
                {capture name='grn_bulletin_personal_ADJUST_SUBSCRIBE_CHECKBOX'}{cb_msg module='grn.bulletin.personal' key='adjust_subscribe.checkbox' replace='true'}{/capture}
                {grn_checkbox name="adjust_subscribe" id="allow_setting_group_role_to_watchers" value="1" checked=$adjust_subscribe caption=$smarty.capture.grn_bulletin_personal_ADJUST_SUBSCRIBE_CHECKBOX}
                <div class="sub_explanation">
                    {cb_msg module='grn.bulletin.personal' key='adjust_subscribe.explanation' replace='true'}
                </div>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                {strip}
                    {capture name='grn_bulletin_personal_ADJUST_SUBSCRIBE_SUBMIT'}{cb_msg module='grn.bulletin.personal' key='adjust_subscribe.submit' replace='true'}{/capture}
                    {grn_button_submit class="margin" caption=$smarty.capture.grn_bulletin_personal_ADJUST_SUBSCRIBE_SUBMIT}
                    {grn_button_cancel}
                {/strip}
            </td>
        </tr>
    </table>

</form>

{include file="grn/personal_footer.tpl"}