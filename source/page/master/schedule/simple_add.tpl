{if $private_setting == 1}
    {assign var='event_non_private' value=false}
    {assign var='event_private' value=true}
    {assign var='event_private_select' value=false}
{elseif $private_setting == 2}
    {assign var='event_non_private' value=false}
    {assign var='event_private' value=false}
    {assign var='event_private_select' value=true}
{else}
    {assign var='event_non_private' value=true}
    {assign var='event_private' value=false}
    {assign var='event_private_select' value=false}
{/if}
<form method="post" action="{grn_pageurl page='schedule/command_simple_add'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="bdate" value="{$bdate}">
    <input type="hidden" name="gid" value="{$group_id}">
    <input type="hidden" name="from_simple_add" value="1">
    {foreach from=$users_info key=uid item=attendee}
        <input type="hidden" name="sUID[]" value="{$uid}">
    {/foreach}
    {foreach from=$facilities_info item=facility key=faid}
        <input type="hidden" name="sITEM[]" value="{$faid}">
        {if $facility.approval}
            {assign var="is_approval_facility" value=`$facility.approval`}
        {/if}
    {/foreach}
    <table class="simpleAddTable-grn">
        <tr valign="top" id="schedule_simple_add-header">
            <td colspan="2" class="header-grn">
                <div class="date-grn">{grn_date_format format='DateFull_YMDW' date=$bdate}</div>
                <div class="simpleAddClose-grn" title="{cb_msg module='grn.grn' key='GRN_GRN-44' replace='true'}"></div>
                <div class="clear_both_0px"></div>
            </td>
        </tr>
        <tr valign="top">
            <th>{cb_msg module='grn.schedule' key='GRN_SCH-145' replace='true'}</th>
            <td>{strip}
                <div class="simpleAddEventUser-grn">
                    {foreach from=$users_info item=attendee name=attendees}
                        {if $smarty.foreach.attendees.first}
                            <span class="nowrap-grn">{$attendee}</span>
                        {else}
                            {if $smarty.foreach.attendees.iteration le 5}
                                <span class="simple_add_item_separator_grn">,</span>
                                <span class="nowrap-grn">{$attendee}</span>
                            {/if}
                        {/if}
                    {/foreach}
                    {if $smarty.foreach.attendees.total gt 5}
                        {capture name="grn_schedule_GRN_SCH_1046"}<span class="mLeft7 textSub-grn">{cb_msg module='grn.schedule' key='GRN_SCH-1046' replace='true'}</span>{/capture}
                        {math equation="total - 5" total=$smarty.foreach.attendees.total format=`$smarty.capture.grn_schedule_GRN_SCH_1046`}
                    {/if}
                </div>
                {if count( $no_add_permission_users_info ) > 0}
                    <div class="item_message_grn">
                        <div class="attentionMessage-grn mBottom3">{cb_msg module="grn.schedule" key="GRN_SCH-1047" replace="true"}</div>
                        <div class="simpleAddEventUser-grn">
                            {foreach from=$no_add_permission_users_info  item=no_permission_user name=no_permission_users}
                                {if $smarty.foreach.no_permission_users.first}
                                    <span class="nowrap-grn">{$no_permission_user}</span>
                                {else}
                                    <span class="simple_add_item_separator_grn">,</span>
                                    <span class="nowrap-grn">{$no_permission_user}</span>
                                {/if}
                            {/foreach}
                        </div>
                    </div>
                {/if}
            {/strip}</td>
        </tr>
        {if $facilities_info || $no_add_permission_facilities_info}
            <tr valign="top">
                <th>{cb_msg module='grn.schedule' key='GRN_SCH-146' replace='true'}</th>
                <td>{strip}
                    <div class="simpleAddEventUser-grn">
                        {foreach from=$facilities_info item=facility name=facilities}
                            {if $smarty.foreach.facilities.first}
                                <span class="nowrap-grn">{$facility.col_name}</span>
                            {else}
                                <span class="simple_add_item_separator_grn">,</span>
                                <span class="nowrap-grn">{$facility.col_name}</span>
                            {/if}
                        {/foreach}
                    </div>
                    {if count( $no_add_permission_facilities_info ) > 0}
                        <div class="item_message_grn">
                            <div class="attentionMessage-grn mBottom3">{cb_msg module="grn.schedule" key="GRN_SCH-1048" replace="true"}</div>
                            <div class="simpleAddEventUser-grn">
                                {foreach from=$no_add_permission_facilities_info item=facility name=facilities}
                                    {if $smarty.foreach.facilities.first}
                                        <span class="nowrap-grn">{$facility.col_name}</span>
                                    {else}
                                        <span class="simple_add_item_separator_grn">,</span>
                                        <span class="nowrap-grn">{$facility.col_name}</span>
                                    {/if}
                                {/foreach}
                            </div>
                        </div>
                    {/if}
                {/strip}</td>
            </tr>
        {/if}
        <tr valign="top">
            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-119' replace='true'}</th>
            <td>
                {grn_select_time prefix='start_' minute_interval=$minute_interval time=$start_time}&nbsp;{cb_msg module='grn.schedule' key='GRN_SCH-120' replace='true'}&nbsp;{grn_select_time prefix='end_' minute_interval=$minute_interval time=$end_time}
                <div class="attentionMessage-grn simpleAddEventAttentionMessage-grn">
                    <span style="display:none;">{cb_msg module='grn.schedule' key='validate_repeat_date' replace='true'}</span>
                    <span style="display:none;">{cb_msg module='grn.schedule' key='invalid_time' replace='true'}</span>
                    <span style="display:none;">{cb_msg module='grn.schedule' key='GRN_SCH-919' replace='true'}</span>
                </div>
            </td>
        </tr>
        <tr valign="top">
            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-144' replace='true'}</th>
            <td nowrap>
                <select menu="scuedule_menu" name="menu" class="hidden"><option value="">-----</option>{foreach from=$menus key=menu_id item=menu}<option value="{$menu[0]|escape};#{$menu[1]|escape}">{$menu[0]|escape}</option>{/foreach}</select>{grn_text name="title" value=$schedule_event.title disable_return_key=true class="inputFrame-grn simpleAddTitle-grn" maxlength=100}
            </td>
        </tr>

        {** GTM-1676 START **}
        {if $is_approval_facility}
            <tr valign="top">
                <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-1100' replace='true'}<span class="attention">*</span></th>
                <td>
                    <div class="attention" name="using_purpose_error" id="using_purpose_error" style="display:none;">
                        <span class="bold"><span class="nowrap-grn"><span class="subnotify16">{cb_msg module='grn.schedule' key='GRN_SCH-1104' replace='true'}</span></span></span>
                    </div>
                    {grn_textarea name="using_purpose" value="" class="autoexpand inputFrame-grn simpleAddMemo-grn" simple_add=true}</td>
            </tr>
        {/if}
        {** GTM-1676 END **}

        <tr valign="top">
            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-148' replace='true'}</th>
            <td>{grn_textarea name="memo" value=$schedule_event.memo class="autoexpand inputFrame-grn simpleAddMemo-grn" simple_add=true}</td>
        </tr>
        {if $use_private}
            {strip}
                <tr>
                    <th>{cb_msg module='grn.schedule' key='GRN_SCH-392' replace='true'}</th>
                    <td class="nowrap-grn">
                        {capture name='grn_schedule_GRN_SCH_393'}{cb_msg module='grn.schedule' key='GRN_SCH-393' replace='true'}{/capture}{grn_radio name="private" id=1|rand:$smarty.now value="0" caption=$smarty.capture.grn_schedule_GRN_SCH_393 checked=$event_non_private span_cover="1"}
                        {capture name='grn_schedule_GRN_SCH_394'}{cb_msg module='grn.schedule' key='GRN_SCH-394' replace='true'}{/capture}{grn_radio name="private" id=1000|rand:$smarty.now value="1" caption=$smarty.capture.grn_schedule_GRN_SCH_394 checked=$event_private span_cover="1"}
                        {capture name='grn_schedule_GRN_SCH_1057'}{cb_msg module='grn.schedule' key='GRN_SCH-1057' replace='true'}{/capture}{grn_radio name="private" id=100000|rand:$smarty.now value="2" caption=$smarty.capture.grn_schedule_GRN_SCH_1057 checked=$event_private_select span_cover="1"}
                        <div style="display:none;" class="attentionMessage-grn simpleAddEventPrivateSet-grn">
                            <span>{cb_msg module='grn.schedule' key='GRN_SCH-1058' replace='true'}</span>
                        </div>
                    </td>
                </tr>
            {/strip}
        {/if}
        {if $use_attendance_check}
            {strip}
                <tr>
                    <th>{cb_msg module='grn.schedule' key='GRN_SCH-997' replace='true'}</th>
                    <td>
                        {capture name='grn_schedule_system_GRN_SCH_998'}{cb_msg module='grn.schedule' key='GRN_SCH-998' replace='true'}{/capture}{grn_checkbox name='attendance_check' id='attendance_check'|cat:$smarty.now value='1' checked=$default_attendance_check caption=$smarty.capture.grn_schedule_system_GRN_SCH_998 span_cover="1"}
                    </td>
                </tr>
            {/strip}
        {/if}
        <tr>
            <td></td>
            <td>{strip}
                    <div class="buttonPostMain-grn">
                        <a href="javascript:void(0);">{cb_msg module='grn.schedule' key='GRN_SCH-917' replace='true'}</a>
                    </div>
                    <span class="nowrap-grn mLeft15">
                    <a href="{grn_pageurl page='schedule/add'}" class="icon-advance-grn" referer="{$referer_key}">{cb_msg module='grn.schedule' key='GRN_SCH-918' replace='true'}</a>
                </span>
                {/strip}
            </td>
        </tr>
    </table>
</form>