{assign var='form_name' value=$smarty.template|basename}
{strip}
<form name="{$form_name}" id="{$form_name}">
    <div style="min-height: 120px;" class="content">
        <table class="std_form sub_window_content_table_grn">
            <tr valign="top">
                <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-1059' replace='true'}</th>
                <td>
                    {grn_member_add name='member_select' form_name=$form_name selected_users=$users_orgs
                       app_id='schedule' access_plugin=$add_plugin include_org=$show_organize popup_include_org=$show_organize org_direct=TRUE is_calendar=TRUE}
                </td>
            </tr>
            <tr valign="top">
                <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-1060' replace='true'}</th>
                <td>
                    {include file='schedule/facility_add.tpl' initialize_item=$facilities all_facilities=$all_facilities}
                </td>
            </tr>
        </table>
    </div>
    <div class="buttonArea-grn">{strip}
        {capture name="grn_schedule_GRN_SCH_1061"}{cb_msg module='grn.schedule' key='GRN_SCH-1061' replace='true'}{/capture}
        {capture name="grn_schedule_GRN_SCH_1062"}{cb_msg module='grn.schedule' key='GRN_SCH-1062' replace='true'}{/capture}
        {grn_button ui="main" spacing="normal" caption=$smarty.capture.grn_schedule_GRN_SCH_1061 class="js_button_apply"}
        {grn_button caption=$smarty.capture.grn_schedule_GRN_SCH_1062 class="js_button_cancel"}
    {/strip}</div>
</form>
{/strip}