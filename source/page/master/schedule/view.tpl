{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{if ! $cols}{assign var="cols" value="100"}{/if}
{if ! $rows}{assign var="rows" value="8"}{/if}

{if $allow_file_attachment}
{if ! $page_prefix}{assign var='page_prefix' value='schedule'}{/if}
{if ! $file_dpage}{assign var='file_dpage' value=$page_prefix|cat:'/file_download'}{/if}
{if ! $file_vpage}{assign var='file_vpage' value=$page_prefix|cat:'/file_view'}{/if}
{if ! $file_tpage}{assign var='file_tpage' value=$page_prefix|cat:'/file_image_view'}{/if}
{/if}
{if $schedule_event.isAttendanceCheckEvent}
    {grn_load_javascript file="grn/html/page/schedule/attendance_confirm.js"}
{/if}
{grn_load_javascript file="grn/html/page/schedule/view.js"}
<div class="mainareaSchedule-grn">
{grn_delete title=$delete_follow.title page=$delete_follow.page no_confirm=$delete_follow.no_confirm data=$delete_follow.data handler=$delete_follow.handler before_delete=$delete_follow.before_delete}

{if $javascript_identifier_value_list}
    {literal}
    <script language="javascript" type="text/javascript">
    <!--
        {/literal}
            {foreach from=$javascript_identifier_value_list key=name item=value}
                var {$name} = {$value|grn_noescape};
            {/foreach}
        {literal}
    //--->
    </script>
    {/literal}
{/if}

<!--menubar-->
<div class="fullmenu_grn">
<div id="main_menu_part">
    {if ! $schedule_event.access.add}
        {assign var='add_disabled' value=true}
    {/if}
    {if ! $schedule_event.access.modify}
        {assign var='mod_disabled' value=true}
    {/if}
  <div class="mainMenuGroup-grn">
    <span class="menu_item">{if ($schedule_event.type == 'share_repeat') or ($schedule_event.type == 'repeat')}{capture name='grn_schedule_GRN_SCH_247'}{cb_msg module='grn.schedule' key='GRN_SCH-247' replace='true'}{/capture}{grn_link page='schedule/repeat_modify' caption=$smarty.capture.grn_schedule_GRN_SCH_247 image='modify20.gif' event=$schedule_event.event_id bdate=$bdate uid=$schedule_event.user_id disabled=$mod_disabled referer_key=$referer_key alt=''}
    {elseif ($schedule_event.type == 'share_banner') or ($schedule_event.type == 'banner')}{capture name='grn_schedule_GRN_SCH_248'}{cb_msg module='grn.schedule' key='GRN_SCH-248' replace='true'}{/capture}{grn_link page='schedule/banner_modify' caption=$smarty.capture.grn_schedule_GRN_SCH_248 image='modify20.gif' event=$schedule_event.event_id bdate=$bdate uid=$schedule_event.user_id  disabled=$mod_disabled referer_key=$referer_key alt=''}
    {elseif ($schedule_event.type == 'share_temporary') or ($schedule_event.type == 'temporary')}{capture name='grn_schedule_GRN_SCH_249'}{cb_msg module='grn.schedule' key='GRN_SCH-249' replace='true'}{/capture}{grn_link page='schedule/adjust_modify' caption=$smarty.capture.grn_schedule_GRN_SCH_249 image='modify20.gif' event=$schedule_event.event_id bdate=$bdate uid=$schedule_event.user_id  disabled=$mod_disabled referer_key=$referer_key alt=''}
    {else}{capture name='grn_schedule_GRN_SCH_250'}{cb_msg module='grn.schedule' key='GRN_SCH-250' replace='true'}{/capture}{grn_link page='schedule/modify' caption=$smarty.capture.grn_schedule_GRN_SCH_250 image='modify20.gif' event=$schedule_event.event_id bdate=$bdate uid=$schedule_event.user_id  disabled=$mod_disabled referer_key=$referer_key alt=''}{/if}</span>
    {if ! $schedule_event.access.delete}
        {assign var='del_disabled' value=true}
    {/if}

    <span class="menu_item">{capture name='grn_schedule_GRN_SCH_251'}{cb_msg module='grn.schedule' key='GRN_SCH-251' replace='true'}{/capture}{grn_link page='schedule/delete' caption=$smarty.capture.grn_schedule_GRN_SCH_251 image='delete20.gif' event=$schedule_event.event_id bdate=$bdate uid=$schedule_event.user_id gid=$group_id disabled=$del_disabled referer_key=$referer_key alt=''}</span>
    <span class="menu_item">{if ($schedule_event.type == 'share_repeat') or ($schedule_event.type == 'repeat')}{capture name='grn_schedule_GRN_SCH_252'}{cb_msg module='grn.schedule' key='GRN_SCH-252' replace='true'}{/capture}{grn_link page='schedule/repeat_add' caption=$smarty.capture.grn_schedule_GRN_SCH_252 image='reuse20.gif' event=$schedule_event.event_id bdate=$bdate uid=$schedule_event.user_id disabled=$add_disabled referer_key=$referer_key alt=''}
    {elseif ($schedule_event.type == 'share_banner') or ($schedule_event.type == 'banner')}{capture name='grn_schedule_GRN_SCH_253'}{cb_msg module='grn.schedule' key='GRN_SCH-253' replace='true'}{/capture}{grn_link page='schedule/banner_add' caption=$smarty.capture.grn_schedule_GRN_SCH_253 image='reuse20.gif' event=$schedule_event.event_id bdate=$bdate uid=$schedule_event.user_id disabled=$add_disabled referer_key=$referer_key alt=''}
    {elseif ($schedule_event.type == 'share_temporary') or ($schedule_event.type == 'temporary')}{capture name='grn_schedule_GRN_SCH_254'}{cb_msg module='grn.schedule' key='GRN_SCH-254' replace='true'}{/capture}{grn_link page='schedule/add' caption=$smarty.capture.grn_schedule_GRN_SCH_254 image='reuse20.gif' event=$schedule_event.event_id bdate=$bdate uid=$schedule_event.user_id disabled=true referer_key=$referer_key alt=''}{else}{capture name='grn_schedule_GRN_SCH_255'}{cb_msg module='grn.schedule' key='GRN_SCH-255' replace='true'}{/capture}{grn_link page='schedule/add' caption=$smarty.capture.grn_schedule_GRN_SCH_255 image='reuse20.gif' event=$schedule_event.event_id bdate=$bdate uid=$schedule_event.user_id disabled=$add_disabled referer_key=$referer_key alt=''}{/if}</span>
    {if ($schedule_event.type == 'share_temporary') or ($schedule_event.type == 'temporary')}
        {assign var='mod_disabled' value=true}
    {/if}
    {if $schedule_event.participate}
        {if $schedule_event.type == 'temporary' or $schedule_event.type == 'share_temporary' or ($schedule_event.users_count == 1 and !$schedule_event.facility)}
            {assign var='leave_disabled' value=true}
        {/if}
        <span class="menu_item">{capture name='grn_schedule_GRN_SCH_831'}{cb_msg module='grn.schedule' key='GRN_SCH-831' replace='true'}{/capture}{grn_link page='schedule/leave' caption=$smarty.capture.grn_schedule_GRN_SCH_831 image='out_schedule20.gif' event=$schedule_event.event_id bdate=$bdate uid=$schedule_event.user_id gid=$group_id referer_key=$referer_key disabled=$leave_disabled alt=''}</span>
    {else}
        <span class="menu_item">{capture name='grn_schedule_GRN_SCH_256'}{cb_msg module='grn.schedule' key='GRN_SCH-256' replace='true'}{/capture}{grn_link page='schedule/participate' caption=$smarty.capture.grn_schedule_GRN_SCH_256 image='loginuser20.gif' event=$schedule_event.event_id bdate=$bdate uid=$schedule_event.user_id gid=$group_id referer_key=$referer_key disabled=$mod_disabled alt=''}</span>
    {/if}
    <span class="menu_item">{capture name='grn_schedule_GRN_SCH_259'}{cb_msg module='grn.schedule' key='GRN_SCH-259' replace='true'}{/capture}
        {if $schedule_event.type == 'repeat' || $schedule_event.type == 'share_repeat'}
            {grn_link page='schedule/print' caption=$smarty.capture.grn_schedule_GRN_SCH_259 image='print20.gif' event=$schedule_event.event_id event_date=$bdate bdate=$bdate uid=$schedule_event.user_id start_day= $start_day alt=''}
        {else}
            {grn_link page='schedule/print' caption=$smarty.capture.grn_schedule_GRN_SCH_259 image='print20.gif' event=$schedule_event.event_id event_date=$bdate bdate=$bdate uid=$schedule_event.user_id alt=''}
        {/if}
    </span>
    <span class="menu_item">
        {include file='schedule/_view_options.tpl'}
    </span>
    {if !($schedule_event.type == 'temporary' or $schedule_event.type == 'share_temporary')}
        {if $isEnableReport && ($report_count > 0 || $schedule_event.participate)}
        <span class="menu_item">
                <span class="extension_main_part">{include file='report/schedule/_relation_report_menu.tpl'}</span>
        </span>
        {/if}
    {/if}
  <span class="menu_item">
    <span class="nowrap-grn">
    <a href="javascript:void(0);display_on_off('display_day_open:display_swith_image_open:display_swith_image_close')"><span id="display_swith_image_open">{cb_msg module='grn.schedule' key='GRN_SCH-241' replace='true'}{capture name='grn_schedule_GRN_SCH_242'}{cb_msg module='grn.schedule' key='GRN_SCH-242' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_243'}{cb_msg module='grn.schedule' key='GRN_SCH-243' replace='true'}{/capture}{grn_image image='addressee_on20.gif' alt=$smarty.capture.grn_schedule_GRN_SCH_242 title=$smarty.capture.grn_schedule_GRN_SCH_243}</span><span id="display_swith_image_close" style="display:none;">{cb_msg module='grn.schedule' key='GRN_SCH-244' replace='true'}{capture name='grn_schedule_GRN_SCH_245'}{cb_msg module='grn.schedule' key='GRN_SCH-245' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_246'}{cb_msg module='grn.schedule' key='GRN_SCH-246' replace='true'}{/capture}{grn_image image='addressee_off20.gif' alt=$smarty.capture.grn_schedule_GRN_SCH_245 title=$smarty.capture.grn_schedule_GRN_SCH_246}</span></a>
    </span>
  </span>
  </div>
    <div class="clear_both_0px"></div>
    {if !($schedule_event.type == 'temporary' or $schedule_event.type == 'share_temporary')}
        {if $isEnableReport && ($report_count > 0 || $schedule_event.participate)}
        <div class="menuReportBase-grn"  id="display_report_open" style="display:none;">
            {if $isEnableReport}
                
                    {if $isEnableReport}
                        <div class="menuReport-grn">
                        
                            {if $schedule_event.participate}
                                <span class="extension_main_menu_part">
                                    {if $isEnableReport}
                                        {include file='report/schedule/_menu.tpl'}
                                    {/if}
                                </span>
                            {/if}
                    {else}
                        <div class="extension_menus_loading" id="loading">{grn_image image="spinner.gif"}</div>
                        <div id="extension_menu_position" class="extension_menu" style="display:none;">
                    {/if}

                    {if $schedule_event.type == 'repeat' || $schedule_event.type == 'share_repeat'}
                        <span class="nowrap-grn">
                        {strip}
                            <span class="icon-informationSub-grn mLeft10 mRight3"></span>
                            <span id="repeat_event_warnning" class="messageSub-grn">{cb_msg module='grn.schedule' key='GRN_SCH-260' replace='true'}
                            </span>
                        {/strip}
                        </span>
                    {/if}

                    </div>
                    <div>{include file='report/schedule/_report_list.tpl'}</div>
                    <div class="clear_both_0px"></div>
            {/if}
        </div>
        {/if}
    {/if}

</div>
{if $isEnableReport}
    {include file='report/schedule/_view.tpl'}
{/if}
<!--menubar_end-->

<div id="display_day_open" style="display:none;">
    {assign var='view_conflict' value=false}
    <div class="groupDayCalendarDate-grn">{grn_date_format date=$bdate format="DateFull_YMDW"}</div>
    {include file='schedule/_member_day.tpl'}
</div>

<!--menubar_end-->
<!--view-->
{strip}
{if $schedule_event.isAttendanceCheckEvent}
    {if $schedule_event.attendanceStatus eq 'unconfirmed'}
        <form name="attendance_confirm" method="post" action="{grn_pageurl page='schedule/command_attendance_confirm'}">
            <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type="hidden" name="status" value="">
            <input type="hidden" name="event" value="{$schedule_event.event_id|escape}">
            <input type="hidden" name="uid" value="{$user_id|escape}">
            <input type="hidden" name="bdate" value="{$bdate|escape}">
            <input type="hidden" name="gid" value="{$group_id|escape}">
            <input type="hidden" name="referer_key" value="{$referer_key|escape}">
            <div class="reaction_info_area_grn mBottom10" id="attendance_confirm_part">
                <div class="icon_information_grn"><span class="attention_message_sub_grn bold_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1003' replace='true'}</span></div>
                <div class="mLeft20 mTop7">
                    <div class="form_text_base_grn">
                        {capture name="prefixMessage"}{cb_msg module='grn.schedule' key='GRN_SCH-1004' replace='true'}{/capture}
                        {grn_textarea name="message" value=$smarty.capture.prefixMessage no_cols=true no_rows=true style="width:689px; height: 30px;" class="form_textarea_grn prefix-grn"}
                    </div>
                    {if $schedule_event.attention[$loginId]}
                        <div class="mTop10">
                            <span class="icon_attention_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1005' replace='true'}</span>
                        </div>
                    {/if}
                    <div class="mTop10">
                        <span class="buttonPostMain-grn button_r_margin_grn"><a href="javascript:void(0);" class="button_min_width1_grn" id="btnAttendance">{cb_msg module='grn.schedule' key='GRN_SCH-1006' replace='true'}</a></span>
                        <span class="button_post_normal_grn"><span class="aButtonStandard-grn button_r_margin_grn"><a href="javascript:void(0);" class="button_min_width1_grn" id="btnAbsent">{cb_msg module='grn.schedule' key='GRN_SCH-1007' replace='true'}</a></span></span>
                    </div>
                </div>
            </div>
        </form>
    {/if}
{/if}
{if $use_star}
    {include file="star/star_init.tpl" list_id="event_list"}
    <div class="detail_title_grn">
    <div id="event_list">{capture name="star_event_id"}{if $schedule_event.type eq 'repeat' || $schedule_event.type eq 'share_repeat'}rp_{$schedule_event.event_id}_{$bdate}{else}{$schedule_event.event_id}{/if}{/capture}{grn_star_icon module="grn.schedule" star_infos=$star_infos unique_id=$smarty.capture.star_event_id event=$schedule_event.event_id bdate=$bdate no_style=1}
{/if}
<span class="title_mark_schedule_grn"></span>{grn_title title=$schedule_event.title event_detail=$schedule_event.event_detail event_menu=$schedule_event.event_menu event_menu_color=$schedule_event.event_menu_color class=$page_info.parts[0]|cat:" inline_block_grn" is_private=$schedule_event.is_private no_style=1}
{/strip}
{if $use_star}
    </div>{* end of event_list *}
    </div>{* end of detail_title_grn *}
{/if}
{if $is_same_day}
{assign var='string_format_datetime' value='TimeShort_HM'}
{else}
{assign var='string_format_datetime' value='DateTimeLong_YMDW_HM'}
{/if}
{if $schedule_event.type != 'temporary' && $schedule_event.type != 'share_temporary'}
<div class="js_customization_schedule_header_space"></div>
{/if}
<table class="viewTable-grn">
    {if $schedule_event.type == 'banner' || $schedule_event.type == 'share_banner'}
        <tr>
            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-922' replace='true'}</th>
            <td><span class="schedule_text_noticeable_grn">{grn_date_format date=$schedule_event.start_date format="DateLong_YMDW"}<span class="mLeft5">{grn_date_format date=$schedule_event.start_date format="TimeLong_HM"}<span class="mLeft15 mRight15">{cb_msg module='grn.schedule' key='GRN_SCH-264' replace='true'}</span>{grn_date_format date=$schedule_event.end_date format=$string_format_datetime}</span></span></td>
        </tr>
    {elseif $schedule_event.type == 'repeat' || $schedule_event.type == 'share_repeat'}
        <tr>
            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-265' replace='true'}</th>
            <td><span class="schedule_text_noticeable_grn">{if $schedule_event.start_time}{grn_date_format date=$schedule_event.start_time format="DateLong_YMDW"}<span class="mLeft15">{grn_date_format date=$schedule_event.start_time format="TimeLong_HM"}{/if}{if $schedule_event.end_time}&nbsp;{cb_msg module='grn.schedule' key='GRN_SCH-266' replace='true'}&nbsp;{grn_date_format date=$schedule_event.end_time format=$string_format_datetime}{/if}</span></span></td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-268' replace='true'}</th>
            <td>{$schedule_event.repeat_data}<span class="mLeft15">{if $schedule_event.start_date}{grn_date_format date=$schedule_event.start_date format="DateLong_YMDW"}{/if}{if $schedule_event.end_date}{cb_msg module='grn.schedule' key='GRN_SCH-269' replace='true'}{grn_date_format date=$schedule_event.end_date format="DateLong_YMDW"}{/if}</span>
                {if $schedule_event.last_repeat_event}
                {strip}
                    <div class="nowrap-grn mTop5">
                        <span class="icon-informationSub-grn mRight3"></span>
                        <span class="attentionMessage-grn">{cb_msg module='grn.schedule' key='GRN_SCH-270' replace='true'}</span>
                    </div>
                {/strip}
                {/if}
            </td>
        </tr>
    {elseif $schedule_event.type == 'temporary' || $schedule_event.type == 'share_temporary'}
        <form name="temporary" method="post" action="{grn_pageurl page='schedule/command_temporary'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type="hidden" name="event" value="{$schedule_event.event_id|escape}">
            <input type="hidden" name="bdate" value="{$bdate|escape}">
            <input type="hidden" name="did" value="">
            <input type="hidden" name="uid" value="{$user_id|escape}">
            <input type="hidden" name="referer_key" value="{$referer_key|escape}">
            {literal}
            <script language="JavaScript" type="text/javascript">
            <!--
            function schedule_submit(f, did)
            {
                f.did.value = did;
                return true;
            }
            //-->
            </script>
            {/literal}

            <tr valign="top">
                <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-271' replace='true'}</th>
                <td nowrap>
                  <div class="candidacy_date_grn">
                    {if $schedule_event.temporary_type == 'or'}
                        {foreach from=$schedule_event.temporary item=facility_data}
                            <strong>{$facility_data.facility_name|escape}</strong>
                            {foreach from=$facility_data.dates item=temporary}
                            <div class="mBottom10">
                                {cb_msg module='grn.schedule' key='GRN_SCH-272' replace='true'} <span class="schedule_text_noticeable_grn">{grn_date_format date=$temporary.setdatetime format="DateLong_YMDW"}<span class="mLeft5">{grn_date_format date=$temporary.setdatetime format="TimeLong_HM"}{cb_msg module='grn.schedule' key='GRN_SCH-273' replace='true'}{grn_date_format date=$temporary.enddatetime format=$temporary.string_datetime}</span></span>&nbsp;{if $facility_data.determine}<input class="buttonStandard-grn" type=submit name="{$temporary.temporary_id}" value="{cb_msg module='grn.schedule' key='GRN_SCH-274' replace='true'}" onclick="schedule_submit(this.form, {$temporary.temporary_id} );">{/if}</div>
                            {/foreach}
                        {/foreach}
                    {else}
                        {foreach from=$schedule_event.temporary item=temporary}
                            <div class="mBottom10">
                            {cb_msg module='grn.schedule' key='GRN_SCH-275' replace='true'} <span class="schedule_text_noticeable_grn">{grn_date_format date=$temporary.setdatetime format="DateLong_YMDW"}<span class="mLeft15">{grn_date_format date=$temporary.setdatetime format="TimeLong_HM"}{cb_msg module='grn.schedule' key='GRN_SCH-276' replace='true'}{grn_date_format date=$temporary.enddatetime format=$temporary.string_datetime}</span></span>&nbsp;{if $schedule_event.access.determine}<input class="buttonStandard-grn" type=submit name="{$temporary.temporary_id}" value="{cb_msg module='grn.schedule' key='GRN_SCH-277' replace='true'}" onclick="schedule_submit(this.form, {$temporary.temporary_id} );">{/if}</div>
                        {/foreach}
                    {/if}
                  </div>
                </td>
            </tr>
        </form>
    {else}
        <tr>
            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-278' replace='true'}</th>
            <td><span class="schedule_text_noticeable_grn">{if $schedule_event.allday}{grn_date_format date=$schedule_event.start_date format="DateLong_YMDW"}<span class="mLeft15">{grn_date_format date=$schedule_event.start_date format="TimeLong_HM"}<span class="mLeft15 mRight15">{cb_msg module='grn.schedule' key='GRN_SCH-279' replace='true'}</span>{grn_date_format date=$schedule_event.end_date format=$string_format_datetime}{cb_msg module='grn.schedule' key='GRN_SCH-280' replace='true'}</span>{else}{grn_date_format date=$schedule_event.start_date format="DateLong_YMDW"}<span class="mLeft15">{grn_date_format date=$schedule_event.start_date format="TimeLong_HM"}{if $schedule_event.end_date}&nbsp;{cb_msg module='grn.schedule' key='GRN_SCH-281' replace='true'}&nbsp;{grn_date_format date=$schedule_event.end_date format=$string_format_datetime}{/if}</span>{/if}</span></td>
        </tr>
    {/if}
    {if $schedule_event.address}
        <tr valign="top">
            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-283' replace='true'}</th>
            <td>
                <table class="address" cellpadding="3">
                    <colgroup>
                        <col width="5%">
                        <col width="95%">
                    </colgroup>
                    <tr valign="top">
                        <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-284' replace='true'}</th>
                        <td>{$schedule_event.address.company_name|escape}</td>
                    </tr>
                    <tr valign="top">
                        <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-285' replace='true'}</th>
                        <td>{$schedule_event.address.zip_code|escape}</td>
                    </tr>
                    <tr valign="top">
                        <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-286' replace='true'}</th>
                        <td>{$schedule_event.address.physical_address|escape}</td>
                    </tr>
                    {if $schedule_event.address.map_image}
                        <tr valign="top">
                            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-287' replace='true'}</th>
                            <td>
                                {if $schedule_event.address.map_image}
                                    {strip}
                                        {capture name='grn_schedule_GRN_WBS_5'}{cb_msg module='grn.cbwebsrv' key='GRN_WBS-5' replace='true'}{/capture}
                                        {if $mp}
                                            {capture name='grn_schedule_GRN_SCH_288'}{cb_msg module='grn.schedule' key='GRN_SCH-288' replace='true'}{/capture}
                                            {grn_link page='schedule/view' caption=$smarty.capture.grn_schedule_GRN_SCH_288 image='hideup20.gif'
                                            event=$schedule_event.event_id bdate=$bdate uid=$schedule_event.user_id mp='0' referer_key=$referer_key wrapper_class="mRight15"}
                                            <span class="icon_information_sub_grn messageSub-grn">{$smarty.capture.grn_schedule_GRN_WBS_5}</span>
                                            <br>
                                            {grn_image image=$schedule_event.address.map_image direct=true}
                                        {else}
                                            {capture name='grn_schedule_GRN_SCH_289'}{cb_msg module='grn.schedule' key='GRN_SCH-289' replace='true'}{/capture}
                                            {grn_link page='schedule/view' caption=$smarty.capture.grn_schedule_GRN_SCH_289 image='showdown20.gif'
                                            event=$schedule_event.event_id bdate=$bdate uid=$schedule_event.user_id mp='1' referer_key=$referer_key wrapper_class="mRight15"}
                                            <span class="icon_information_sub_grn messageSub-grn">{$smarty.capture.grn_schedule_GRN_WBS_5}</span>
                                        {/if}
                                    {/strip}
                                {/if}
                            </td>
                        </tr>
                    {/if}
                    <tr valign="top">
                        <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-290' replace='true'}</th>
                        <td>{$schedule_event.address.route|escape}<br>{$schedule_event.address.route_time|escape}&nbsp;{cb_msg module='grn.schedule' key='GRN_SCH-291' replace='true'}<br>{$schedule_event.address.route_fare|escape}&nbsp;{cb_msg module='grn.schedule' key='GRN_SCH-292' replace='true'}</td>
                    </tr>
                    <tr valign="top">
                        <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-293' replace='true'}</th>
                        <td>{$schedule_event.address.company_telephone_number|escape}</td>
                    </tr>
                </table>
            </td>
        </tr>
    {/if}
    {if $schedule_event.type != 'banner'}
    <tr valign="top">
        <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-294' replace='true'}</th>
        <td>
          <!--GTM-1677-->
          <div class="schedule_member_base_grn">
            {grn_schedule_members_name members=$schedule_event.facility member_type='facility' nobr=true approval_status=$facilityApprovalData.currentStatus}
            {if count($facilityApprovalData.history) > 0}
                {if $facilityApprovalData.isExpandedHistory}
                    {capture name="history_display_style"}{/capture}
                    {capture name="history_display_class"}icon_hide_element_b_grn{/capture}
                {else}
                    {capture name="history_display_style"}display: none;{/capture}
                    {capture name="history_display_class"}icon_show_element_b_grn{/capture}
                {/if}
                <span class="action_text_grn mTpo3 mLeft15">
                    <a id="history_link" href="javascript:void(0);">
                        <span id="history_icon_inline" class="icon_inline_grn {$smarty.capture.history_display_class}"></span><span>{cb_msg module='grn.schedule' key='GRN_SCH-1038' replace='true'}</span>
                    </a>
                    <span style="{$smarty.capture.history_display_style}" id="history_balloon_inline" class="balloon_inline_arrow_up_grn mTop2"></span>
                </span>
            {/if}
          </div>
          {if count($facilityApprovalData.history) > 0}
            <div style="{$smarty.capture.history_display_style}" id="history_table" class="facility_approval_history_grn">
                <table class="list_column">
                    <colgroup>
                        <col width="15%">
                        <col width="5%">
                        <col width="30%">
                        <col width="50%">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>{cb_msg module='grn.schedule' key='GRN_SCH-1099' replace='true'}</th>
                            <th>{cb_msg module='grn.schedule' key='GRN_SCH-1040' replace='true'}</th>
                            <th>{cb_msg module='grn.schedule' key='GRN_SCH-1041' replace='true'}</th>
                            <th>{cb_msg module='grn.schedule' key='GRN_SCH-1042' replace='true'}</th>
                        </tr>
                        {foreach from=$facilityApprovalData.history item=history}
                            <tr>
                                <td rowspan="1" nowrap="">{grn_facility_name faid=$history.col_facility name=$history.col_facility_name noimage=TRUE no_link_if_not_exist=TRUE}</td>
                                <td class="tAlignCenter-grn" nowrap="">
                                    {if $history.col_status == 0 || $history.col_status == 1}
                                    <div class="action_result_mark_grn">{$history.col_status_text}</div>
                                    {/if}
                                </td>
                                <td nowrap="">{grn_date_format date=$history.col_approval_time format="DateTimeMiddle_YMDW_HM"}</td>
                                <td>
                                    <div>
                                        <span class="history_user_grn">{grn_user_name uid=$history.col_user users_info=$users_info name=$history.col_user_name}</span>
                                        <div class="history_comment_grn">{grn_format body=$history.col_comment}</div>
                                    </div>
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
          {/if}
          <!--End GTM-1677-->
          {if $use_extended_item}
            <table class="view_table mTop10">
                {foreach from=$extended_items key=item_id item=item}
                    {if $item.use}
                        <tr>
                            <th valign="top">{grn_show_input_title title=$item.display_name}</th>
                            <td>
                                {if $item.type == GRN_SCHEDULE_ITEM_MENU}
                                    {$item.value|escape}
                                {elseif $item.type == GRN_SCHEDULE_ITEM_MULTIPLE_STRING}
                                    {grn_format body=$item.value}
                                {else}
                                    {$item.value|escape}
                                {/if}
                            </td>
                        </tr>
                    {/if}
                {/foreach}
            </table>
          {/if}
        </td>
    </tr>
    <!--GTM-1677-->
    {if count($facilityApprovalData.currentStatus) > 0 }
        <tr valign="top">
            <th nowrap="">{cb_msg module='grn.schedule' key='GRN_SCH-1043' replace='true'}</th>
            <td style="max-width: 500px;">{grn_format body=$facilityApprovalData.usingPurpose}</td><!--hack wrap text in table td-->
        </tr>
    {/if}
    <!--End GTM-1677-->
    {/if}
    {if $kintone_available}{grn_schedule_kintone_relation use_type='view' event_id=$schedule_event.event_id event_menu=$schedule_event.event_menu}{/if}
    <tr valign="top">
        <th nowrap>
        {strip}
            {if $schedule_event.isAttendanceCheckEvent}
                <span style="min-width: 65px" class="schedule_view_member_list inline_block_grn">{cb_msg module='grn.schedule' key='GRN_SCH-303' replace='true'}</span>
            {else}
                <span class="schedule_view_member_list">{cb_msg module='grn.schedule' key='GRN_SCH-303' replace='true'}&nbsp;
                    {cb_msg module='grn.schedule' key='GRN_SCH-308' replace='true'}{$schedule_event.users_count}{cb_msg module='grn.schedule' key='GRN_SCH-309' replace='true'}
                </span>
            {/if}
        {/strip}
        </th>
        <td {if $schedule_event.isAttendanceCheckEvent}id="attendanceStatusSection"{/if}>
            {if $schedule_event.isAttendanceCheckEvent}
                <script language="javascript" type="text/javascript">{literal}
                    /**
                     * Refresh current page after changing the status.
                     */
                    function updateHtmlFn()
                    {
                        var attendanceStatTab = jQuery("#attendanceStatusTab");
                        var tabActive = attendanceStatTab.find("li.active");
                        var currentUrl = getPageUrl();
                        currentUrl += "&tab=" + tabActive.index();
                        location.href = currentUrl;
                    }

                    /**
                     * Get current page  url. It is called inside attendance_confirm.js
                     * @returns {string}
                     */
                    function getPageUrl()
                    {
                    var currentUrl='{/literal}{grn_pageurl page="schedule/view" event=$schedule_event.event_id bdate=$bdate uid=$user_id gid=$group_id referer_key=$referer_key}{literal}';
                    currentUrl = currentUrl.replace(/&amp;/g, "&");
                    return currentUrl;
                    }
                {/literal}</script>
                {if $schedule_event.attendanceStatus}
                    {strip}
                    <div class="mBottom10">
                        <span class="label_sub_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1011' replace='true'}</span>
                        {if $schedule_event.attendanceStatus eq 'unconfirmed'}
                            <span class="event_status_unanswered_grn mLeft3">{cb_msg module='grn.schedule' key='GRN_SCH-1008' replace='true'}</span>
                        {else}
                            {if $schedule_event.attendanceStatus eq 'absent'}
                                <span class="event_status_absence_grn mLeft3">{cb_msg module='grn.schedule' key='GRN_SCH-1007' replace='true'}
                            {elseif $schedule_event.attendanceStatus eq 'attendant'}
                                <span class="event_status_attendance_grn mLeft3">{cb_msg module='grn.schedule' key='GRN_SCH-1006' replace='true'}
                            {/if}
                            </span><span class="mLeft15"><a href="javascript:GRN_ScheduleAttendanceStatus.getScheduleAttendanceStatus('{$schedule_event.event_id}')" class="icon_edit_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1012' replace='true'}</a></span>
                        {/if}
                    </div>
                    {/strip}
                    {if $schedule_event.attendanceStatus neq 'unconfirmed'}
                        {include file="schedule/_change_attendance_status.tpl"}
                        {include file="grn/error_handler.tpl"}
                    {/if}
                {/if}
                {if $schedule_event.users}
                    {capture name="tabAllDisplayText"}{cb_msg module='grn.schedule' key='GRN_SCH-1016' replace='true'}{/capture}
                    {capture name="tabAttendDisplayText"}{cb_msg module='grn.schedule' key='GRN_SCH-1013' replace='true'}{$schedule_event.userAttendances.attendantCount}{cb_msg module='grn.schedule' key='GRN_SCH-1017' replace='true'}{/capture}
                    {capture name="tabAbsentDisplayText"}{cb_msg module='grn.schedule' key='GRN_SCH-1014' replace='true'}{$schedule_event.userAttendances.absentCount}{cb_msg module='grn.schedule' key='GRN_SCH-1017' replace='true'}{/capture}
                    {capture name="tabUnconfirmDisplayText"}{cb_msg module='grn.schedule' key='GRN_SCH-1015' replace='true'}{$schedule_event.userAttendances.unconfirmedCount}{cb_msg module='grn.schedule' key='GRN_SCH-1017' replace='true'}{/capture}
                    {strip}
                    <ul class="tab_sub_grn" id="attendanceStatusTab" data-display-limit="{$schedule_event.displayLimit}">
                        <li {if $tab == 0}class="active"{/if} data-group-count="{$schedule_event.userAttendances.groupCount}" data-user-count="{$schedule_event.users_count}" data-display-text="{$smarty.capture.tabAllDisplayText}">
                            {if $tab == 0}
                                <p><span>{$smarty.capture.tabAllDisplayText}</span></p>
                            {else}
                                <p><a href="javascript:void(0);">{$smarty.capture.tabAllDisplayText}</a></p>
                            {/if}
                        </li>
                        <li {if $tab == 1}class="active"{/if} data-user-count="{$schedule_event.userAttendances.attendantCount}" data-display-text="{$smarty.capture.tabAttendDisplayText}">
                            {if $tab == 1}
                                <p><span>{$smarty.capture.tabAttendDisplayText}</span></p>
                            {else}
                                <p><a href="javascript:void(0);">{$smarty.capture.tabAttendDisplayText}</a></p>
                            {/if}
                        </li>
                        <li {if $tab == 2}class="active"{/if} data-user-count="{$schedule_event.userAttendances.absentCount}" data-display-text="{$smarty.capture.tabAbsentDisplayText}">
                            {if $tab == 2}
                                <p><span>{$smarty.capture.tabAbsentDisplayText}</span></p>
                            {else}
                                <p><a href="javascript:void(0);">{$smarty.capture.tabAbsentDisplayText}</a></p>
                            {/if}
                        </li>
                        <li {if $tab == 3}class="active"{/if} data-user-count="{$schedule_event.userAttendances.unconfirmedCount}" data-display-text="{$smarty.capture.tabUnconfirmDisplayText}">
                            {if $tab == 3}
                                <p><span>{$smarty.capture.tabUnconfirmDisplayText}</span></p>
                            {else}
                                <p><a href="javascript:void(0);">{$smarty.capture.tabUnconfirmDisplayText}</a></p>
                            {/if}
                        </li>
                    </ul>
                    <span class="mLeft10 mTop2 inline_block_grn">
                      <a href="{grn_pageurl page='schedule/attendance_detail' event=$schedule_event.event_id bdate=$bdate uid=$user_id gid=$group_id referer_key=$referer_key}" class="icon_detail_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1009' replace='true'}</a>{if $schedule_event.hasUpdate}<span class="update_info_grn textSub-grn link_body_color_grn">（<a href="{grn_pageurl page='schedule/attendance_detail' event=$schedule_event.event_id bdate=$bdate uid=$user_id gid=$group_id referer_key=$referer_key}"><span class="icon_unread_mark_grn icon_inline_grn"></span>{cb_msg module='grn.schedule' key='GRN_SCH-1010' replace='true'}</a>）</span>{/if}
                    </span>
                    {/strip}
                    <div class="tab_sub_baseline_grn mBottom7"></div>
                {/if}
                <div class="schedule_member_base_grn">
                    {grn_schedule_members_name members=$schedule_event.users attention=$schedule_event.attention referer_key=$referer_key users_info=$users_info nobr=true attendanceStatusInfo=$schedule_event.userAttendances}
                    {if $schedule_event.users_count > 10 && $display_users}
                        <span class="nowrap-grn"><small>{cb_msg module='grn.schedule' key='GRN_SCH-311' replace='true'}<a href="{grn_pageurl page='schedule/view' event=$schedule_event.event_id bdate=$bdate uid=$user_id gid=$group_id referer_key=$referer_key}">{cb_msg module='grn.schedule' key='GRN_SCH-312' replace='true'}</a>{cb_msg module='grn.schedule' key='GRN_SCH-313' replace='true'}</small></span>
                    {elseif $schedule_event.users_count > 10}
                        <span class="nowrap-grn">{cb_msg module='grn.schedule' key='GRN_SCH-314' replace='true'}<small>{cb_msg module='grn.schedule' key='GRN_SCH-315' replace='true'}<a href="{grn_pageurl page='schedule/view' event=$schedule_event.event_id bdate=$bdate du=1 uid=$user_id gid=$group_id referer_key=$referer_key}">{cb_msg module='grn.schedule' key='GRN_SCH-316' replace='true'}</a>{cb_msg module='grn.schedule' key='GRN_SCH-317' replace='true'}</small></span>
                    {/if}
                </div>
            {else}
                <div class="schedule_member_base_grn">
                    {grn_schedule_members_name members=$schedule_event.users attention=$schedule_event.attention referer_key=$referer_key users_info=$users_info nobr=true}
                    {if $schedule_event.users_count > 10 && $display_users}
                        <span class="nowrap-grn"><small>{cb_msg module='grn.schedule' key='GRN_SCH-311' replace='true'}<a href="{grn_pageurl page='schedule/view' event=$schedule_event.event_id bdate=$bdate uid=$user_id gid=$group_id referer_key=$referer_key}">{cb_msg module='grn.schedule' key='GRN_SCH-312' replace='true'}</a>{cb_msg module='grn.schedule' key='GRN_SCH-313' replace='true'}</small></span>
                    {elseif $schedule_event.users_count > 10}
                        {cb_msg module='grn.schedule' key='GRN_SCH-314' replace='true'}<span class="nowrap-grn"><small>{cb_msg module='grn.schedule' key='GRN_SCH-315' replace='true'}<a href="{grn_pageurl page='schedule/view' event=$schedule_event.event_id bdate=$bdate du=1 uid=$user_id gid=$group_id referer_key=$referer_key}">{cb_msg module='grn.schedule' key='GRN_SCH-316' replace='true'}</a>{cb_msg module='grn.schedule' key='GRN_SCH-317' replace='true'}</small></span>
                    {/if}
                </div>
            {/if}
        </td>
    </tr>
    {if $schedule_event.private_users}
        <tr valign="top">
            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-318' replace='true'}</th>
            <td>
              <div class="schedule_member_base_grn">
              {grn_schedule_members_name_with_dialog members=$schedule_event.private_users}
              </div>
            </td>
        </tr>
    {/if}
    {** -------------- VCBSCH0010 START ----------------- **}
    {if $schedule_event.netmeeting}
        <tr valign="top">
            <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-1' replace='true'}</th>
            <td>
                {if $schedule_event.netmeeting.netmeeting_err_msg}
                    <div style="line-height:150%;">
                        {cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-28' replace='true'}
                        <span style="font-size: 90%;">
                            <a href="javascript:display_on_off('display_netmeeting_msg:display_netmeeting_msg_image_open:display_netmeeting_msg_image_close')"><span id="display_netmeeting_msg_image_open">{grn_image image='addressee_on20.gif'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-30' replace='true'}</span><span id="display_netmeeting_msg_image_close" style="display:none;">{grn_image image='addressee_off20.gif'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-31' replace='true'}</span></a>
                        </span>
                        <div id="display_netmeeting_msg" style="display:none;font-size: 90%;">{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-32' replace='true'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-33' replace='true'}{if $schedule_event.netmeeting.netmeeting_retry_btn}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-34' replace='true'}{/if}</div>
                    </div>
                {/if}
                {if $schedule_event.netmeeting.netmeeting_retry_btn}
                    {if $schedule_event.netmeeting.netmeeting_retry_now}<span style="font-size: 90%;">{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-43' replace='true'}</span>{/if}
                    <form name="netmeeting" method="post" action="{grn_pageurl page='schedule/command_netmeeting_retry'}">
                        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                        <input type="hidden" name="event" value="{$schedule_event.event_id|escape}">
                        <input type="hidden" name="uid" value="{$user_id|escape}">
                        <input type="hidden" name="gid" value="{$group_id|escape}">
                        <input type="hidden" name="date" value="{$bdate|escape}">
                        <input type="hidden" name="referer_key" value="{$referer_key|escape}">
                        <input type="submit" value="{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-29' replace='true'}">
                    </form>
                {/if}
                {if $schedule_event.netmeeting.netmeeting_retry_end}<span style="font-size: 90%;">{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-44' replace='true'}</span>{/if}
                <table class="address" cellpadding="3">
                    <colgroup>
                        <col width="5%">
                        <col width="95%">
                    </colgroup>
                    {if $schedule_event.netmeeting.invite_url}
                        <tr valign="top">
                            <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-11' replace='true'}</th>
                            <td>
							{if $isNetMeetingStartError}
								<div style="line-height:150%;">
									{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-46' replace='true'}
									<span style="font-size: 90%;">
										<a href="javascript:display_on_off('display_netmeeting_start_msg:display_netmeeting_start_msg_image_open:display_netmeeting_start_msg_image_close')"><span id="display_netmeeting_start_msg_image_open">{grn_image image='addressee_on20.gif'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-30' replace='true'}</span><span id="display_netmeeting_start_msg_image_close" style="display:none;">{grn_image image='addressee_off20.gif'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-31' replace='true'}</span></a>
									</span>
									<div id="display_netmeeting_start_msg" style="display:none;font-size: 90%;">{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-47' replace='true'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-48' replace='true'}</div>
								</div>
							{/if}
							<!-- <a href="{$schedule_event.netmeeting.invite_url|escape}" target="grn_to_netmeeting">{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-12' replace='true'}</a> -->
							<form name="netmeeting" method="post" action="{grn_pageurl page='schedule/command_netmeeting_start'}">
								<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
								<input type="hidden" name="event" value="{$schedule_event.event_id|escape}">
								<input type="hidden" name="uid" value="{$user_id|escape}">
								<input type="hidden" name="gid" value="{$group_id|escape}">
								<input type="hidden" name="date" value="{$bdate|escape}">
								<input type="hidden" name="referer_key" value="{$referer_key|escape}">
								{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-49' replace='true'}
								<input type="submit" value="{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-50' replace='true'}">
							</form>
							</td>
                        </tr>
                    {/if}
                    {if $schedule_event.netmeeting.password}
                        <tr valign="top">
                            <th nowrap>
                                {cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-2' replace='true'}
                                <span style="font-size: 90%;">
                                    <a href="javascript:display_on_off('display_netmeeting_pass_open:display_netmeeting_pass_close:display_netmeeting_pass_image_open:display_netmeeting_pass_image_close')"><span id="display_netmeeting_pass_image_open">{grn_image image='addressee_on20.gif' alt=$smarty.capture.grn_schedule_GRN_VCB_16 title=$smarty.capture.grn_schedule_GRN_VCB_17}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-15' replace='true'}{capture name='grn_schedule_GRN_VCB_16'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-16' replace='true'}{/capture}{capture name='grn_schedule_GRN_VCB_17'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-17' replace='true'}{/capture}</span><span id="display_netmeeting_pass_image_close" style="display:none;">{grn_image image='addressee_off20.gif' alt=$smarty.capture.grn_schedule_GRN_VCB_19 title=$smarty.capture.grn_schedule_GRN_VCB_20}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-18' replace='true'}{capture name='grn_schedule_GRN_VCB_19'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-19' replace='true'}{/capture}{capture name='grn_schedule_GRN_VCB_20'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-20' replace='true'}{/capture}</span></a>
                                </span>
                            </th>
                            <td>
                                <span id="display_netmeeting_pass_close" style="margin:5px;">**********</span>
                                <span id="display_netmeeting_pass_open" style="display:none;margin:5px;">{$schedule_event.netmeeting.password|escape}</span>
                            </td>
                        </tr>
                    {/if}
                    {if $schedule_event.netmeeting.outside_members}
                        <tr valign="top">
                            <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-4' replace='true'}</th>
                            <td>
                                <table class="netmeeting">
                                    <thead>
                                        <tr valign="top">
                                            <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-5' replace='true'}</th>
                                            {if $schedule_event.netmeeting.guests_show}
                                                <th style="width:60%;" nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-6' replace='true'}</th>
                                                {if $schedule_event.netmeeting.guest_type_show}
                                                    <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-9' replace='true'}</th>
                                                {/if}
                                            {/if}
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {foreach from=$schedule_event.netmeeting.outside_members item=vcb_outside_item}
                                            <tr valign="top">
                                                <td>{$vcb_outside_item.user_name|escape}</td>
                                                {if $schedule_event.netmeeting.guests_show}
                                                    <td style="width:60%;">{$vcb_outside_item.user_email|escape}</td>
                                                    {if $schedule_event.netmeeting.guest_type_show}
                                                        <td>{if $vcb_outside_item.user_type == $schedule_event.netmeeting.type_list[1]}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-14' replace='true'}{else}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-13' replace='true'}{/if}</td>
                                                    {/if}
                                                {/if}
                                            </tr>
                                        {/foreach}
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    {/if}
                </table>
            </td>
        </tr>
    {/if}
    {** -------------- VCBSCH0010 END   ----------------- **}

    <tr valign="top">
        <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-295' replace='true'}</th>
        <td style="max-width:500px;">{grn_format body=$schedule_event.memo}</td><!--hack wrap text in table td-->
    </tr>
    {if $allow_file_attachment}
    <tr valign="top">
        <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-942' replace='true'}</th>
        <td>
        {if $schedule_event.attach_files}
            <tt>
                {foreach from=$schedule_event.attach_files item=file}
                    {grn_attach_file_link name=$file.name dpage=$file_dpage vpage=$file_vpage size=$file.size mime=$file.mime fid=$file.id event=$schedule_event.event_id inline=$file_inline hash=$file.hash tpage=$file_tpage}<br>
                {/foreach}
            </tt>
        {/if}
        </td>
    </tr>
    {/if}
    {if $schedule_event.menupage}
        <tr>
            <th>{$schedule_event.menupage.menu|escape}</th>
            <td>{$schedule_event.menupage.data|grn_noescape}</td>
        </tr>
    {/if}
</table>

<div class="viewTableSubInfo-grn">
    <span class="nowrap-grn mRight15">
        {cb_msg module='grn.schedule' key='GRN_SCH-261' replace='true'}
        {grn_schedule_member_name id=$schedule_event.creator_uid name=$schedule_event.creator_name users_info=$users_info referer_key=$referer_key}&nbsp;{grn_date_format date=$schedule_event.ctime format="DateTimeMiddle_YMDW_HM"}
    </span>
    <span class="nowrap-grn">
        {cb_msg module='grn.schedule' key='GRN_SCH-262' replace='true'}
        {grn_schedule_member_name id=$schedule_event.modify_uid name=$schedule_event.modify_name users_info=$users_info referer_key=$referer_key}&nbsp;{grn_date_format date=$schedule_event.mtime format="DateTimeMiddle_YMDW_HM"}
    </span>
</div>

<div class="viewTableCommentArea-grn comment_std_grn">
    <div class="sub_title mBottom3">
        {cb_msg module='grn' key='grn.comment' replace='true'}
    </div>
    {if $schedule_event.access.follow}
        <form id="follow" name="follow" method="post" action="{grn_pageurl page='schedule/command_view'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type="hidden" name="event" value="{$schedule_event.event_id|escape}">
            <input type="hidden" name="uid" value="{$user_id|escape}">
            <input type="hidden" name="gid" value="{$group_id|escape}">
            <input type="hidden" name="date" value="{$bdate|escape}">
            <input type="hidden" name="referer_key" value="{$referer_key|escape}">
            <div class="form_text_base_grn">
                {grn_textarea name='data' value='' style="width:707px;height:130px;" cols=$cols rows=$rows class='form_textarea_grn'}
                <div class="clear_both_1px">&nbsp;</div>

                <div class="mTop10 mBottom20">
                    {capture name='grn_schedule_GRN_SCH_297'}{cb_msg module='grn.schedule' key='GRN_SCH-297' replace='true'}{/capture}
                    {grn_button ui="main" spacing="normal" caption=$smarty.capture.grn_schedule_GRN_SCH_297 id="schedule_button_post" auto_disable="true"}

                    {if $schedule_event.type == 'repeat' || $schedule_event.type == 'share_repeat'}
                    {strip}
                        <span class="nowrap-grn">
                            <span class="icon-informationSub-grn mLeft10m mRight3"></span>
                            <span class="messageSub-grn">{cb_msg module='grn.schedule' key='GRN_SCH-298' replace='true'}</span>
                        </span>
                    {/strip}
                    {/if}
                </div>
            </div>
        </form>
    {/if}
    {if $schedule_event.follow}
        <div class="border-partition-common-grn"></div>
        <a name="follow"></a>
        {include file="grn/word_navi.tpl" navi=$navi}
        <div class="border-partition-common-grn"></div>
            {foreach from=$schedule_event.follow item=follow name=commentlist}
                <div class="contents_area" id="thread_comment_{$follow.follow_id}">
                    <div class="profileImageBase-grn">
                {if $imageIcon}
                        <table class="comment_base_grn">
                            <tr>
                                <td class="vAlignTop-grn sub_grn" style="width:1%;">
                                    {assign var='userId' value=$follow.creator_uid}
                                    {grn_user_image_icon userInfo=$users_info.$userId photoUrl=$users_info.$userId.photoUrl userId=$userId loginId=$loginId size=$iconSize alt=$follow.creator_name}
                                </td>
                                <td class="vAlignTop-grn">
                {/if}
                                    <table class="comment_base_grn">
                                        <tr>
                                            <td class="vAlignTop-grn sub_grn nowrap-grn" style="width:60%;">
                {if $imageIcon}
                                                <span class="username_grn">{grn_user_name uid=$userId users_info=$users_info name=$follow.creator_name|cb_mb_truncate:$name_width noimage=true}</span><span class="commentDate-grn">{grn_date_format date=$follow.ctime format="DateTimeMiddle_YMDW_HM"}</span>
                {else}
                                                <span class="username_grn">{grn_user_name uid=$follow.creator_uid users_info=$users_info name=$follow.creator_name|cb_mb_truncate:$name_width}</span>{grn_date_format date=$follow.ctime format="DateTimeMiddle_YMDW_HM"}
                {/if}
                                            </td>
                                            <td class="comment-grn vAlignTop-grn nowrap-grn" style="width:40%;">
                                                <div>
                                                    {if $follow.creator_uid == $login.id}{capture name='grn_schedule_GRN_SCH_302'}{cb_msg module='grn.schedule' key='GRN_SCH-302' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_schedule_GRN_SCH_302 page='schedule/delete_follow' event=$schedule_event.event_id bdate=$bdate follow_id=$follow.follow_id  uid=$schedule_event.user_id gid=$group_id image="delete20.gif" referer_key=$referer_key id='lnk_delete_follow_'|cat:$follow.follow_id script='javascript:void(0);'}{/if}
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="vAlignTop-grn" colspan="2">
                                                <div class="margin_all" id="follow_{$follow.follow_id}">
                                                    <div>
                                                        {grn_format body=$follow.data}
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                {if $imageIcon}
                                </td>
                            </tr>
                        </table>
                {/if}
                    </div>
                </div>
                {if $smarty.foreach.commentlist.last}
                    <div class="border-partition-common-grn"></div>
                {else}
                    <div class="border-partition-follow-grn"></div>
                {/if}
            {/foreach}
        {include file="grn/word_navi.tpl" navi=$navi}
    {/if}
</div>
<!--view_end--->
</div>
</div>
{if $kintone_available}{include file='schedule/_kintone_relation.tpl' use_type='view'}{/if}
{include file='grn/footer.tpl'}
{grn_load_customization_js_css}
