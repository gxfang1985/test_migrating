{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{include file='grn/common.tpl'}
{grn_load_javascript file='grn/html/page/schedule/system/facility_set.js'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

{if $privileges_count == 0 || $facility_group_id}
    <script type="text/javascript">
        <!--
        var __thisPage = grn.page.schedule.system.facility_set;

        {if $privileges_count == 0}
        __thisPage.noticeMessage = "<div>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-615' replace='true'}</div>";
        __thisPage.noticeMessage += "<div>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-616' replace='true'}</div>";
        __thisPage.noticeMessage += "<p>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-617' replace='true'}</p>";
        {/if}

        {if $facility_group_id}
        __thisPage.confirmDialogTitle = "{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-614' replace='true'}";
        __thisPage.confirmDialogAsyncURL = "{grn_pageurl page='schedule/system/ajax/confirm_facility_group_privilege'}";
        __thisPage.facilityGroupId = "{$facility_group_id|escape:javascript}";
        __thisPage.facilityId = "{$faid|escape:javascript}";
        {/if}
        //-->
    </script>
{/if}

<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="faid" value="{$faid}">
    <input type="hidden" name="fagid" value="{$fagid}">
    <div class="explanation">
        {if $is_group}
            <span class="bold">{grn_image image='facilitygroup20.gif'}{$group_name}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-543' replace='true'}
        {else}
            <span class="bold">{grn_image image='facility20.gif'}{$facility_name}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-543' replace='true'}
        {/if}
    </div>
    <p></p>
    <table class="std_form">
        {if $is_group }
            <tr>
                <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-552' replace='true'}</th>
                <td>
                    {if $apply_from_parent eq '1'}{capture name='grn_schedule_system_GRN_SCH_SY_553'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-553' replace='true'}{/capture}{grn_checkbox name='apply_from_parent' id='apply_from_parent' value='1' checked=TRUE caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_553}{else}{capture name='grn_schedule_system_GRN_SCH_SY_553'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-553' replace='true'}{/capture}{grn_checkbox name='apply_from_parent' id='apply_from_parent' value='1' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_553}{/if}
                </td>
            </tr>
        {elseif $belong_group}
            <tr>
                <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-552' replace='true'}</th>
                <td>
                    {if $apply_from_parent eq '1'}{capture name='grn_schedule_system_GRN_SCH_SY_553'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-553' replace='true'}{/capture}{grn_checkbox name='apply_from_parent' id='apply_from_parent' value='1' checked=TRUE caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_553}{else}{capture name='grn_schedule_system_GRN_SCH_SY_553'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-553' replace='true'}{/capture}{grn_checkbox name='apply_from_parent' id='apply_from_parent' value='1' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_553}{/if}
                </td>
            </tr>
        {else}
            <tr>
                <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-552' replace='true'}</th>
                <td>
                    {if $apply_from_parent eq '1'}{capture name='grn_schedule_system_GRN_SCH_SY_553'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-553' replace='true'}{/capture}{grn_checkbox name='apply_from_parent' id='apply_from_parent' value='1' checked=TRUE caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_553}{else}{capture name='grn_schedule_system_GRN_SCH_SY_553'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-553' replace='true'}{/capture}{grn_checkbox name='apply_from_parent' id='apply_from_parent' value='1' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_553}{/if}
                </td>
            </tr>
        {/if}
        <tr>
            <th nowrap>
                {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-492' replace='true'}
            </th>
            <td>
                <select name="advance_select" id="advance_select">
                    <option value="0">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-493' replace='true'}</option>
                    <option value="1" {if $advance_select}selected="selected"{/if}>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-495' replace='true'}</option>
                </select>
                <span id="advance_span" {if ! $advance_select}style="display: none;"{/if}>
                    {grn_text name='advance' id='advance' size='3' maxlength='3' value=$advance disable_return_key=true}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-494' replace='true'}
                    <span class="attention">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-496' replace='true'}</span>
                </span>
                <div>
                    <font color="red" style="font-size:10pt;">
                        {capture name='grn_schedule_system_GRN_SCH_SY_497'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-497' replace='true'}{/capture}
                        {validate form=$form_name criteria="isRegExp" field="advance" expression='/^\d+$/' message=$smarty.capture.grn_schedule_system_GRN_SCH_SY_497}
                        {validate form=$form_name criteria="isRange" field="advance" low="1" high="999" message=$smarty.capture.grn_schedule_system_GRN_SCH_SY_497}
                    </font>
                </div>
            </td>
        </tr>
        <tr>
            <th nowrap rowspan=2>
                {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-502' replace='true'}
            </th>
            <td>
                <div>
                    {capture name='grn_schedule_system_GRN_SCH_SY_515'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-515' replace='true'}{/capture}
                    {if $max_time == 0}
                        {grn_radio name='max_time' id='max_time_1' value=0 checked=1 caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_515}
                    {else}
                        {grn_radio name='max_time' id='max_time_1' value=0 caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_515}
                    {/if}
                </div>
            </td>
        </tr>
        <tr>
            <td>
                {if $max_time > 0}
                    {grn_radio name='max_time' id='max_time_2' value=1 checked=1 caption=''}
                {else}
                    {grn_radio name='max_time' id='max_time_2' value=1 caption=''}
                {/if}
                <select name="scheduled_time_hour" id="scheduled_time_hour">
                    <option value="">--{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-572' replace='true'}</option>
                    {section name=hour loop=23 step=1}
                        <option value="{$smarty.section.hour.iteration}" {if ! is_null($hour) && $smarty.section.hour.iteration === $hour}selected{/if}>{$smarty.section.hour.iteration}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-573' replace='true'}</option>
                    {/section}
                </select>
                <select name="scheduled_time_minute" id="scheduled_time_minute">
                    <option value="">--{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-574' replace='true'}</option>
                    {section name=minute loop=60 step=30}
                        <option value="{$smarty.section.minute.index}" {if ! is_null($minute) && $smarty.section.minute.index === $minute}selected{/if}>
                            {if $smarty.section.minute.index < 10}0{/if}{$smarty.section.minute.index}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-575' replace='true'}
                        </option>
                    {/section}
                </select>
            </td>
        </tr>
        <tr>
            <th nowrap>
                {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-516' replace='true'}
            </th>
            <td>
                {if $modify_user == 'creator'}{capture name='grn_schedule_system_GRN_SCH_SY_517'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-517' replace='true'}{/capture}{grn_radio name='modify_user' id='creator' value='creator' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_517 checked=TRUE}{else}{capture name='grn_schedule_system_GRN_SCH_SY_518'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-518' replace='true'}{/capture}{grn_radio name='modify_user' id='creator' value='creator' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_518}{/if}&nbsp;
                {if $modify_user == 'member'}{capture name='grn_schedule_system_GRN_SCH_SY_519'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-519' replace='true'}{/capture}{grn_radio name='modify_user' id='member' value='member' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_519 checked=TRUE}{else}{capture name='grn_schedule_system_GRN_SCH_SY_520'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-520' replace='true'}{/capture}{grn_radio name='modify_user' id='member' value='member' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_520}{/if}&nbsp;
                {if $modify_user == 'grantuser'}{capture name='grn_schedule_system_GRN_SCH_SY_521'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-521' replace='true'}{/capture}{grn_radio name='modify_user' id='grantUser' value='grantuser' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_521 checked=TRUE}{else}{capture name='grn_schedule_system_GRN_SCH_SY_522'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-522' replace='true'}{/capture}{grn_radio name='modify_user' id='grantUser' value='grantuser' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_522}{/if}
            </td>
        </tr>
        <tr>
            <th nowrap>
                {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-523' replace='true'}
            </th>
            <td>
                {if $show_memo}{capture name='grn_schedule_system_GRN_SCH_SY_524'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-524' replace='true'}{/capture}{grn_checkbox name='show_memo' id='show_memo' value='1' checked=TURE caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_524}{else}{capture name='grn_schedule_system_GRN_SCH_SY_525'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-525' replace='true'}{/capture}{grn_checkbox name='show_memo' id='show_memo' value='1' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_525}{/if}
            </td>
        </tr>
        <tr>
            <th nowrap>
                {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-526' replace='true'}
            </th>
            <td>
                {if $regularly}{capture name='grn_schedule_system_GRN_SCH_SY_527'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-527' replace='true'}{/capture}{grn_checkbox name='regularly' id='regularly' value='1' checked=TURE caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_527}{else}{capture name='grn_schedule_system_GRN_SCH_SY_528'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-528' replace='true'}{/capture}{grn_checkbox name='regularly' id='regularly' value='1' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_528}{/if}
            </td>
        </tr>
        <tr>
            <th nowrap>
                {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-606' replace='true'}
            </th>
            <td>
                {capture name='grn_schedule_system_GRN_SCH_SY_607'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-607' replace='true'}{/capture}
                {grn_checkbox name='approval' id='approval' value='1' checked=$approval caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_607}
                {if $facility_group_id}
                    {include file='grn/window_simple_dialog.tpl'}
                    <a class="icon-blankB-grn mLeft10" href="javascript:void(0);" id="confirm_privilege">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-608' replace='true'}</a>
                {/if}
                <div class="sub_explanation_under_grn">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-618' replace='true'}<br>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-619' replace='true'}</div>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                {capture name='grn_schedule_system_GRN_SCH_SY_536'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-536' replace='true'}{/capture}
                {if $privileges_count > 0}
                    {grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_536}
                {else}
                    <input type="button" class="margin" onclick="grn.page.schedule.system.facility_set.submitForm(this.form);" value="{$smarty.capture.grn_schedule_system_GRN_SCH_SY_536}">
                {/if}
                {grn_button_cancel page='schedule/system/facility_select_set' fagid=$fagid}
            </td>
        </tr>
    </table>
</form>

{include file='grn/system_footer.tpl'}
