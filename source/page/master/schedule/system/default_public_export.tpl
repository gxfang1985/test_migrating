{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class='schedule'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_default_public_export' postfix='schedule_default_public.csv'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

    <table class="std_form">
        <tr>
            <th nowrap>
                {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-354' replace='true'}
            </th>
            <td>
                {grn_charset name="charset" bom='TRUE'}
            </td>
        </tr>
        <tr>
            <th nowrap>
                {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-355' replace='true'}
            </th>
            <td>
                {capture name='grn_schedule_system_GRN_SCH_SY_356'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-356' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_356 checked=false}&nbsp;{capture name='grn_schedule_system_GRN_SCH_SY_357'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-357' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_357 checked=true}
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                {capture name='grn_schedule_system_GRN_SCH_SY_358'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-358' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_358}
                {grn_button_cancel class='margin' page='schedule/system/export_index'}
            </td>
        </tr>
    </table>
    <p>
    <hr>
    <p>
        {include file='schedule/system/_default_public_csv_columns.tpl' type='export'}
        {include file='grn/csv_columns.tpl' columns=$columns column_explanation=$smarty.capture.explanation type='export'}
</form>

{include file="grn/system_footer.tpl"}
