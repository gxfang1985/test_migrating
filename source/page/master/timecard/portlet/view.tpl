<script>
{literal}
function submitTimeCardForm(button, type){
    jQuery(button).parents('form').append(jQuery('<input>').attr('name', type).attr('type', 'hidden').prop('value', 1)).submit();
}
{/literal}
</script>

<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                <a href="{grn_pageurl page='timecard/index'}">{$page_title}</a>
            </span>
        </td>
        <td align="right">
            <span>
                <a href="{grn_pageurl page='timecard/modify' date=$portlet.card.date}" class="action_base_grn">
                    <span title="{cb_msg module='grn.timecard.portlet' key='GRN_TIM_PO-1' replace='true'}" class="icon_edit_grn icon_only_grn">
                        <span class="courteous_element_grn">{cb_msg module='grn.timecard.portlet' key='GRN_TIM_PO-1' replace='true'}</span>
                    </span>
                </a>
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_timecard_grn">
    <form name="timecard" method="post" action="{grn_pageurl page='timecard/portlet/command_view'}">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <input type="hidden" name="pid" value="{$portlet.pid}">
        <table class="admin_list_table timecardPortlet-grn">{strip}
            <tr bgcolor="#eeeeee">
                <th nowrap>{cb_msg module='grn.timecard.portlet' key='GRN_TIM_PO-2' replace='true'}</th>
                <th nowrap>{cb_msg module='grn.timecard.portlet' key='GRN_TIM_PO-3' replace='true'}</th>
                {if count($portlet.config.absence_max_list) > 0}
                <th nowrap>{cb_msg module='grn.timecard.portlet' key='GRN_TIM_PO-4' replace='true'}</th>
                <th nowrap>{cb_msg module='grn.timecard.portlet' key='GRN_TIM_PO-5' replace='true'}</th>
                {/if}
            </tr>
            <tr valign="top">
                <td align="center" nowrap>
                {if $portlet.card.start}
                    {grn_date_format format='TimeShort_HM' date=$portlet.card.start}
                {else}
                    <span class="aButtonStandard-grn">
                        <a href="javascript:void(0)" onclick="submitTimeCardForm(this, 'start');return false;">
                            <span>{cb_msg module='grn.timecard.portlet' key='GRN_TIM_PO-6' replace='true'}</span>
                        </a>
                    </span>
                    <input type="hidden" name="date" value="{$portlet.card.date}">
                {/if}
                </td>
                <td align="center" nowrap>
                    {if $portlet.card.finish}
                        {grn_date_format format='TimeShort_HM' date=$portlet.card.finish}
                    {elseif $portlet.card.start}
                        <span class="aButtonStandard-grn">
                            <a href="javascript:void(0)" onclick="submitTimeCardForm(this, 'finish');return false;">
                                <span>{cb_msg module='grn.timecard.portlet' key='GRN_TIM_PO-7' replace='true'}</span>
                            </a>
                        </span>
                        <input type="hidden" name="date" value="{$portlet.card.date}">
                    {else}
                        <br>
                    {/if}
                </td>
                {assign var="show_button" value=""}
                {assign var="show_column" value=""}
                {foreach name="absences" from=$portlet.card.absences item=absence}
                    {if ! $show_column && ((! $absence.trip || ! $absence.back) || $smarty.foreach.absences.last)}
                    <td align="center" nowrap>
                        {if $absence.trip}
                            {grn_date_format format='TimeShort_HM' date=$absence.trip}
                        {elseif ! $show_button && $portlet.card.start && ! $portlet.card.finish}
                            <span class="aButtonStandard-grn">
                                <a href="javascript:void(0)" onclick="submitTimeCardForm(this, 'trip');return false;">
                                    <span>{cb_msg module='grn.timecard.portlet' key='GRN_TIM_PO-8' replace='true'}</span>
                                </a>
                            </span>
                            <input type="hidden" name="date" value="{$portlet.card.date}">
                            {assign var="show_button" value="1"}
                        {else}
                            <br>
                        {/if}
                    </td>
                    <td align="center" nowrap>
                        {if $absence.back}
                            {grn_date_format format='TimeShort_HM' date=$absence.back}
                        {elseif ! $show_button && $portlet.card.start && ! $portlet.card.finish && $absence.trip}
                            <span class="aButtonStandard-grn">
                                <a href="javascript:void(0)" onclick="submitTimeCardForm(this, 'back');return false;">
                                    <span>{cb_msg module='grn.timecard.portlet' key='GRN_TIM_PO-9' replace='true'}</span>
                                </a>
                            </span>
                            <input type="hidden" name="date" value="{$portlet.card.date}">
                            {assign var="show_button" value="1"}
                        {else}
                            <br>
                        {/if}
                    </td>
                    {assign var="show_column" value="1"}
                    {/if}
                {/foreach}
            </tr>
        </table>{/strip}
    </form>
</div> <!--end of portal_frame -->
