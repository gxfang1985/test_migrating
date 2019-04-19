{if $portlet.settings.font_size == "large"}
    {assign var="font_size" value='font-size:140%;'}
{elseif $portlet.settings.font_size == "normal"}
    {assign var="font_size" value='font-size:100%;'}
{elseif $portlet.settings.font_size == "small"}
    {assign var="font_size" value='font-size:70%;'}
{else}
    {assign var="font_size" value='font-size:100%;'}
{/if}
{assign var=plid value=$portlet.plid}
{include file="schedule/_show_full_short_title.tpl" function_click="showFullShortTitle('show_full_title$plid','schedule_groupweek_$plid','view_user_week',true);" schedule_id="schedule_groupweek_$plid"}
<script type="text/javascript" language="javascript">
{literal}
    // refresh showFullShortTitle when using ajax
    function refreshShowFullShortTitleByAjax(plid)
    {
        showFullShortTitle('show_full_title'+plid,'schedule_groupweek_'+plid,'view_user_week',false);
    }
    // refresh showUsersTimezone when using ajax
    function refreshShowUsersTimezoneByAjax(plid)
    {
        showUsersTimezone('show_users_timezone'+plid,'schedule_groupweek_'+plid,'view_user_week',false);
    }
{/literal}
</script>
{include file="schedule/_show_users_timezone.tpl" function_click="showUsersTimezone('show_users_timezone$plid','schedule_groupweek_$plid','view_user_week',false);"}

<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                <a href="{grn_pageurl page='schedule/index'}">{$page_title}</a>
            </span>
        </td>
        <td align="right">
            {include file='schedule/portlet/_search_part.tpl' portletId=$portlet.plid page='schedule/index'}
        </td>
    </tr>
    </tbody>
</table>{/strip}
<form name="personal_day{$portlet.plid}" method="GET" action="{grn_pageurl page='schedule/index'}">
    <input type="hidden" name="bdate" value="{$bdate|escape}">
    <div class="portal_frame portal_frame_schedule_groupweek_grn">
        <div class="groupWeekPortletUpper-grn">
        <table width="100%" class="top_day_navi" cellspacing="0" cellpadding="4" style="{$font_size}">
            <tr>
                <td class="v-allign-middle" width="40%" nowrap>
                    <table cellspacing="0" cellpadding="0" border="0">
                        <tbody>
                            <tr>
                                <td></td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap">

                                    {* _select_group.tpl start *}
                                    {include file="schedule/portlet/_dropdown_part.tpl" detail_page_url="schedule/index"}
                                    {* _select_group.tpl end *}

                                </td>
                                <td nowrap="nowrap">
                                    {if $page_info.last == 'personal_day' || $page_info.last == 'personal_week'}
                                        {capture name='grn_schedule_portlet_GRN_SCH_PO_180'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-180' replace='true'}{/capture}{grn_popup_user_select_link_schedule caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_180 send_cgi_parameter=true include_org=$include_org system=false system_display=false access_plugin=$access_plugin extension_items=$extension_items}
                                    {elseif $page_info.last == 'user_week' || $page_info.last == 'index'}
                                        {capture name='grn_schedule_portlet_GRN_SCH_PO_181'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-181' replace='true'}{/capture}{grn_popup_user_select_link caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_181 app_id=$schedule_app_id form_name=$form_name include_org=$include_org system=false system_display=false multi_apply=true access_plugin=$access_plugin return_page='schedule/index' module="schedule"}
                                    {else}
                                        {assign var="window_url" value='schedule/popup_group'}
                                        {assign var="no_multiple" value='0'}
                                        {assign var="onChange" value='0'}
                                        <a href="javascript:popupWin('{grn_pageurl page='schedule/popup_group' bdate=$bdate return_url=$page_info.all}','html','','',0,0,1,1,0,1);" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-182' replace='true'}">{grn_image image='image-common/blank16.png'}</a>
                                    {/if}
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                <td class="v-allign-middle" width="20%" align="center" nowrap>
                    <div id="schedule_gw_{$portlet.plid}_date_title" class="bold">{grn_date_format date=$bdate format="DateFull_YMDW"}</div>
                </td>
                <td class="v-allign-middle" width="40%" align="right" nowrap>
                    <div class="moveButtonBlock-grn">
                    {strip}
                        <span class="moveButtonBaseDisable-grn" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-184' replace='true'}">
                            <a onclick="if(check_disable(this))CyScheduleGw.ctrl('week_prev',{$portlet.plid});" href="javascript:void(0);">
                                <span class="moveButtonArrowLeftTwoDisable-grn"></span>
                            </a>
                        </span>
                        <span class="moveButtonBaseDisable-grn" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-186' replace='true'}">
                            <a onclick="if(check_disable(this))CyScheduleGw.ctrl('day_prev',{$portlet.plid});" href="javascript:void(0);">
                                <span class="moveButtonArrowLeftDisable-grn"></span>
                            </a>
                        </span>
                        <span class="moveButtonBaseDisable-grn" title="">
                            <a onclick="if(check_disable(this)) location.href='{grn_pageurl page=$page_info.all bdate=$date uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset}';return false;" href="javascript:void(0);">
                                {cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-187' replace='true'}
                            </a>
                        </span>
                        <span class="moveButtonBaseDisable-grn" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-188' replace='true'}">
                            <a onclick="if(check_disable(this))CyScheduleGw.ctrl('day_next',{$portlet.plid});" href="javascript:void(0);">
                                <span class="moveButtonArrowRightDisable-grn"></span>
                            </a>
                        </span>
                        <span class="moveButtonBaseDisable-grn" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-190' replace='true'}">
                            <a onclick="if(check_disable(this))CyScheduleGw.ctrl('week_next',{$portlet.plid});" href="javascript:void(0);">
                                <span class="moveButtonArrowRightTwoDisable-grn"></span>
                            </a>
                        </span>
                    {/strip}
                    </div>
                    {include file='schedule/_display_options.tpl' page_key='view_user_week' schedule_id='schedule_groupweek_'|cat:$plid plid=$plid expired_todo_option='true' show_full_title_option='true' apply_users_timezone='true' show_todos_option='true'}
                </td>
            </tr>
            {if ! $hidden_navi}
            <tr>
                <td colspan="3">
                        <div class="sub_title smart_data_count_navi">{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-201' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
                </td>
            </tr>
            {/if}
        </table>
        </div>
            <div id="gw_{$portlet.plid}_cal_div" class="js_customization_schedule_view_type_GROUP_WEEK">
                <table id="schedule_groupweek_{$plid}" class="calendar scheduleWrapper scheduleWrapperGroupWeek portlet_groupweek {if !$show_full_title}hideEventTitle tableFixed{/if}" width="100%" cellspacing="0" cellpadding="0" style="{$font_size};">
                    <colgroup>
                        <col width="15%">
                        <col width="11%">
                        <col width="11%">
                        <col width="11%">
                        <col width="11%">
                        <col width="11%">
                        <col width="11%">
                        <col width="11%">
                    </colgroup>
                    <tbody id="gw_{$portlet.plid}_cal_tbody">
                        {counter name='date_counter' assign='date_counter' start=0 print=false}
                        {counter name='user_counter' assign='user_counter' start=0 print=false}
                        {foreach name='user' from=$schedule.users item=user}
                            {if ($smarty.foreach.user.iteration-1)%5 == 0}
                                <tr>
                                    <td class="s_domain_week"><span class='domain'>{cb_msg module='fw.timezone' key=$display_timezone}</span></td>
                                    {foreach from=$user.schedule_event key=day_key item=item}
                                        <td class="{$item.date_type}_week" align="center">
                                            &nbsp;{grn_schedule_date_header date=$item.date format='DateShort_MDW' image='' page='schedule/group_day' gid=$group_id caption='' title='' br=true}
                                        </td>
                                    {/foreach}
                                </tr>
                                {counter name='date_counter' print=false}
                            {/if}{strip}
                            <tr class="schedule_user_tr js_customization_schedule_user_id_{$user.id}">
                                <td valign="top" class="calendar_rb_week userBox">
                                    {if $user.facility_id}
                                        {grn_link image='facility20.gif' page='schedule/facility_info' faid=$user.facility_id caption=$user.facility_title referer_key=$referer_key}
                                        <div class="shortcut_box_facility_grn">
                                            {capture name='grn_schedule_GRN_SCH_619'}{cb_msg module='grn.schedule' key='GRN_SCH-619' replace='true'}{/capture}{grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pday20.gif' page='schedule/personal_day' bdate=$bdate uid=$user.id gid=selected search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_619 class='small_link'}
                                            {capture name='grn_schedule_portlet_GRN_SCH_PO_150'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-150' replace='true'}{/capture}{grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pweek20.gif' page='schedule/personal_week' bdate=$bdate uid=$user.id gid=selected caption='' alt=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_150 class='small_link'}
                                            {capture name='grn_schedule_GRN_SCH_620'}{cb_msg module='grn.schedule' key='GRN_SCH-620' replace='true'}{/capture}{grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pmon20.gif' page='schedule/personal_month' bdate=$bdate uid=$user.id gid=$group_id search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_620 class='small_link'}
                                            {$user.facility_memo|grn_noescape}
                                        </div>
                                    {else}
                                        {assign var='uid' value=$user.id}
                                        {capture name="prefix"}{$uid|substr:0:1}{/capture}
                                        {if $imageIcon && $smarty.capture.prefix != 'g'}
                                            <div class="userElement profileImageBase-grn profileImageBaseSchedule-grn">
                                                <dl>
                                                    <dt>{grn_user_image_icon userInfo=$users_info.$uid photoUrl=$users_info.$uid.photoUrl userId=$uid loginId=$login_id size=$iconSize is_popup=false referer_key=$referer_key}</dt>
                                                    <dd>{grn_schedule_member_name id=$uid users_info=$users_info groups_info=$groups_info referer_key=$referer_key noimage=true}</dd>
                                                </dl>
                                                <div class="clear_both_0px"></div>
                                            </div>
                                        {else}
                                            <div class="userElement"><span class="span_user">{grn_schedule_member_name id=$uid users_info=$users_info groups_info=$groups_info referer_key=$referer_key}</span></div>
                                        {/if}
                                        {assign var='uid' value=$user.id}
                                        {capture name='grn_schedule_portlet_GRN_SCH_PO_152'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-152' replace='true'}{/capture}
                                        {capture name='grn_schedule_GRN_SCH_621'}{cb_msg module='grn.schedule' key='GRN_SCH-621' replace='true'}{/capture}
                                        {capture name='grn_schedule_GRN_SCH_622'}{cb_msg module='grn.schedule' key='GRN_SCH-622' replace='true'}{/capture}
                                        <div class="shortcut_box_full" {if !$show_full_title}style="display:none"{/if}>
                                            {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pday20.gif' page='schedule/personal_day' bdate=$bdate uid=$user.id gid=selected search_text=$search_text caption=$smarty.capture.grn_schedule_GRN_SCH_621 alt=$smarty.capture.grn_schedule_GRN_SCH_621 class='small_link'}
                                            {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pweek20.gif' page='schedule/personal_week' bdate=$bdate uid=$user.id gid=selected caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_152 alt=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_152 class='small_link'}
                                            {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pmon20.gif' page='schedule/personal_month' bdate=$bdate uid=$user.id gid=$group_id search_text=$search_text caption=$smarty.capture.grn_schedule_GRN_SCH_622 alt=$smarty.capture.grn_schedule_GRN_SCH_622 class='small_link'}
                                            {foreach from=$interaction_info_list item='interaction_info'}
                                                {if $interaction_info.$uid}
                                                    {grn_link wrapper_class='schedule_userbox_item_grn' image=$interaction_info.$uid.image page=$interaction_info.$uid.page uid=$uid caption=$interaction_info.$uid.caption alt=$interaction_info.$uid.alt disabled=$interaction_info.$uid.disabled class='small_link'}
                                                {/if}
                                            {/foreach}
                                        </div>
                                        <div class="shortcut_box_short" {if $show_full_title}style="display:none"{/if}>
                                            {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pday20.gif' page='schedule/personal_day' bdate=$bdate uid=$user.id gid=selected search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_621 class='small_link'}
                                            {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pweek20.gif' page='schedule/personal_week' bdate=$bdate uid=$user.id gid=selected caption='' alt=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_152 class='small_link'}
                                            {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pmon20.gif' page='schedule/personal_month' bdate=$bdate uid=$user.id gid=$group_id search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_622 class='small_link'}
                                            {foreach from=$interaction_info_list item='interaction_info'}
                                                {if $interaction_info.$uid}
                                                    {grn_link wrapper_class='schedule_userbox_item_grn' image=$interaction_info.$uid.image page=$interaction_info.$uid.page uid=$uid caption='' alt=$interaction_info.$uid.alt disabled=$interaction_info.$uid.disabled class='small_link'}
                                                {/if}
                                            {/foreach}
                                        </div>
                                        
                                        {if $active_presence}
                                            {assign var='presence' value=$user.presence}
                                            <span class="schedule_userbox_item_grn schedule_userbox_presence_grn">
                                                {grn_link page=$presence.page image=$presence.image caption=$presence.info uid=$uid disabled=$presence.disabled br=true class='small_link'}
                                                {if $presence.mtime}
                                                    {if $presence.old}<span class="attention">{/if}
                                                    <span class="group_week_calendar_presence">[{grn_date_format date=$presence.mtime format="DateTimeCompact"}]</span>
                                                    {if $presence.old}</span>{/if}
                                                {/if}
                                            </span>
                                        {/if}
                                        
                                        {if $display_timezone != $user.timezone}
                                            <span class='domain differ_timezone {if $show_users_timezone}differ_tz_color{/if}' >
                                        {else}
                                            <span class='domain like_timezone' {if !$show_users_timezone}style="display:none;"{/if}>
                                        {/if}
                                        {cb_msg module='fw.timezone' key=$user.timezone}</span>
                                    {/if}
                                </td>

                                {foreach from=$user.schedule_event key=day_key item=schedule_event}
                                    <td valign="top" class="s_user_week normalEvent"
                                        {if $user.access.add}rel="{grn_pageurl page='schedule/simple_add' bdate=$schedule_event.date uid=$user.id gid=$group_id referer_key=$referer_key}"
                                        plid="{$portlet.plid}"{if $user.facility_id} utype="facility"{/if}{/if}>
                                        {if $user.access.add}
                                            <div class="addEvent">
                                                <a title="{cb_msg module='grn.schedule' key='GRN_SCH-624' replace='true'}"
                                                   href="{grn_pageurl page='schedule/add' bdate=$schedule_event.date uid=$user.id gid=$group_id referer_key=$referer_key}">
                                                    <div class="iconWrite-grn"></div>
                                                </a>
                                            </div>
                                        {/if}

                                        <div class="js_customization_schedule_date_{$schedule_event.date}"></div>

                                        <div class="groupWeekInfo">
                                            {foreach from=$schedule_event.calendar item=calendar}
                                                {grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon}
                                            {/foreach}
                                        </div>
                                        {if $schedule_event.date === $today  && $login_id == $user.id}
                                            {include file="schedule/expired_todo.tpl"}
                                        {/if}
                                        {include file='schedule/todo.tpl' event=$schedule_event}
                                        {foreach from=$schedule_event.event item=event}
                                            {capture name="star"}
                                                {strip}
                                                    {if $event.absent === 1}<div class="schedule_absent">{/if}
                                                    {capture assign='event_tz_class'}
                                                        {if $event.only_view_tz === 1}
                                                            sh_title_normal {if $show_users_timezone}hide_event{/if}
                                                        {elseif $event.only_view_tz === 2}
                                                            sh_title_tz {if !$show_users_timezone}hide_event{/if}
                                                        {/if}
                                                    {/capture}
                                                    {if $event.star_date}
                                                        {assign var='star_date' value=$event.star_date}
                                                    {else}
                                                        {assign var='star_date' value=$schedule_event.date}
                                                    {/if}
                                                    <div class="{if $event.type != 'share_temporary' && $event.type != 'temporary'}{$event.type}{/if} normalEventElement {$event_tz_class} {if $event.absent === 1}schedule_absent{/if} group_week_calendar_item">
                                                        <div class="listTime">
                                                            {if ! $event.private}
                                                            <a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$schedule_event.date uid=$user.id gid=$group_id referer_key=$referer_key}">{/if}{$event.time_schedule|grn_noescape}{if ! $event.private}</a>{/if}
                                                        </div>
                                                        <div class="{if $event.allday}groupWeekEventTitleAllday{else}groupWeekEventTitle{/if}">
                                                            {if ! $event.private}
                                                            {if $event.type == "share_temporary" || $event.type == "temporary"}
                                                            <span class="{$event.type}">{/if}
                                                                <a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$schedule_event.date uid=$user.id gid=$group_id referer_key=$referer_key}">{/if}
                                                                    {if $event.conflict}
                                                                        {capture name='grn_schedule_GRN_SCH_914'}{cb_msg module='grn.schedule' key='GRN_SCH-914' replace='true'}{/capture}
                                                                        {grn_image image="attention16.gif" alt=$smarty.capture.grn_schedule_GRN_SCH_914}
                                                                    {/if}
                                                                    {*GTM-1625*}
                                                                    {if ! $event.private && $event.attendance_check_show}
                                                                        {capture name='grn_schedule_GRN_SCH_1036'}{cb_msg module='grn.schedule' key='GRN_SCH-1036' replace='true'}{/capture}
                                                                        {grn_image alt=$smarty.capture.grn_schedule_GRN_SCH_1036 class="unanswered_icon_base_grn" image="image-app-schedule/event_unanswered16.png"}
                                                                    {/if}
                                                                    {*GTM-103*}
                        {if ! $event.private && $event.event_menu neq '' && $event.event_menu_color neq '' && $event.event_menu_color neq '0'}
                            {if !$event.facility_name_after}
                                {$event.event_facility_name|grn_noescape}
                                <span class="event_color{$event.event_menu_color}_grn">
                                    {$event.event_menu|grn_noescape}
                                </span>
                                {$event.event_detail|grn_noescape}
                            {else}
                                <span class="event_color{$event.event_menu_color}_grn">
                                    {$event.event_menu|grn_noescape}
                                </span>
                                {$event.event_detail|grn_noescape}
                                {$event.event_facility_name|grn_noescape}
                            {/if}
                            {$event.creator_name|grn_noescape}
                            {$event.faci_items|grn_noescape}
                        {else}
                            {$event.data|grn_noescape}
                        {/if}
                    {*End GTM-103*}
{if $event.is_private}{grn_image image="image-common/privateMark_sub16.png"}{/if}{if $event.type == 'share_repeat' || $event.type == 'repeat'}{grn_image image="repeat16.gif"}{/if}{if $event.report}{grn_image image="report16.gif"}{/if}{if ! $event.private}</a>{if $event.type == "share_temporary" || $event.type == "temporary"}</span>{/if}{/if}
                                                            </div>
                                                        </div>
                                                    {if $event.absent === 1}
                                                        </div>
                                                    {/if}
                                                {/strip}
                                            {/capture}
                                            {$smarty.capture.star|grn_noescape}
                                        {/foreach}
                                    </td>
                                {/foreach}
                            </tr>{/strip}
                            {grn_schedule_weekbanner banner_events=$user.banner_event page='schedule/view' week_type='group' setdate=$week_start enddate=$week_end banner_class='s_banner' blank_class='br_banner' banner_image='banner16.gif' uid=$user.id gid=$group_id referer_key=$referer_key plid=$portlet.plid onclick="cy_gw_rd(this,$plid);" show_users_timezone=$show_users_timezone}
                            {counter name='user_counter' print=false}
                        {/foreach}
                    </tbody>
                </table>
            </div>

        {if ! $hidden_navi}
            <div class="navi portlet_groupweek_navi_grn"><nobr>{include file="grn/word_navi.tpl" navi=$view_set.navi ajax_flag=true plid=$portlet.plid}</nobr></div>
        {/if}

        {if $is_first_portlet}
            <script language="JavaScript" type="text/javascript">
                {grn_get_date_format_js function_name_prefix=cy_schedule_gw_ format=$current_date_format}
            </script>
            {grn_load_javascript file="grn/html/schedule_gw.js"}
        {/if}
        
        <script language="JavaScript" type="text/javascript">
        <!--
        {if $is_first_portlet}
            {literal}
            var gw_table_prefix_items = {
                'pre':'<table id="schedule_groupweek_id" class="',
                'classes':[
                    'calendar', 'scheduleWrapper', 'scheduleWrapperGroupWeek', 'portler_groupweek',
                    {/literal}{if !$show_full_title}'tableFixed','hideEventTitle'{/if}{literal}
                ],
            'suf':'" width="100%" cellspacing="0" cellpadding="0" style="{/literal}{$font_size}{literal}"><colgroup><col width="15%"><col width="11%"><col width="11%"><col width="11%"><col width="11%"><col width="11%"><col width="11%"><col width="11%"></colgroup><tbody id="gw_{/literal}{$portlet.plid}{literal}_cal_tbody">'
            };
            var gw_table_suffix = '</tbody></table>';
            var gw_date = new Object();
            var gw_user = new Object();
            var gw_banner = new Object();
            var gw_portlet_table_template = new Object();
            var gw_simple_add_url = new Object();
            {/literal}
        {/if}
        gw_date[{$portlet.plid}] = new Object();
        gw_user[{$portlet.plid}] = new Object();
        gw_banner[{$portlet.plid}] = new Object();
        gw_user[{$portlet.plid}]['user'] = new Object();
        gw_simple_add_url[{$portlet.plid}] = new Object();
        {literal}
        gw_portlet_table_template[{/literal}{$portlet.plid}{literal}] = {
            'template' : [ '<table id="schedule_groupweek_id" class="CLASSES_NAME" width="100%" cellspacing="0" cellpadding="0" style="{/literal}{$font_size}{literal}">',
                           '<colgroup>',
                           '<col width="15%">', 
                           '<col width="11%">', 
                           '<col width="11%">', 
                           '<col width="11%">', 
                           '<col width="11%">', 
                           '<col width="11%">', 
                           '<col width="11%">', 
                           '<col width="11%">', 
                           '</colgroup>',
                           '<tbody id="gw_PORTLET_ID_cal_tbody">'],
            'classes' : [ 'calendar','scheduleWrapper', 'scheduleWrapperGroupWeek', 'portler_groupweek',
                         {/literal}
                          {if !$show_full_title}
                           'tableFixed', 'hideEventTitle'
                          {/if}
                         {literal} ]
        };
        {/literal}
        {section name=counter start=0 loop=$user_counter}
            gw_user[{$portlet.plid}][{$smarty.section.counter.index}] = new Object();
            gw_banner[{$portlet.plid}][{$smarty.section.counter.index}] = new Object();
            gw_simple_add_url[{$portlet.plid}][{$smarty.section.counter.index}] = new Object();
        {/section}

        var cy_schedule_gw_day_buffer = new Object();
        {foreach from=$cy_schedule_gw_day_buffer key=name item=value}
            cy_schedule_gw_day_buffer['{$name}'] = '{$value}';
        {/foreach}
        var cy_schedule_gw_ajax_url = '{grn_pageurl page='schedule/portlet/ajax_view_user_week'}';
        var cy_schedule_gw_post_body = 'csrf_ticket={$csrf_ticket}&uid={$user_id|escape}&gid={$group_id|escape}&plid={$portlet.plid|escape}&referer_key={$referer_key|escape}&sp={$sp}';
        var cy_schedule_gw_startwday = '{$cy_schedule_gw_startwday}';
        var gw_property = new CyScheduleGwProperty(cy_schedule_gw_day_buffer,cy_schedule_gw_ajax_url,cy_schedule_gw_startwday,{$portlet.plid}, cy_schedule_gw_post_body);

        {if $is_first_ajax_portlet}
            var plid_array = new Array();
        {/if}
        plid_array[{$portlet.plid}] = gw_property;

        //-->
        </script>
        
        {if $is_first_ajax_loading_item}
            <div id="loading" class="loading" style="display:none;position:absolute;">{grn_image image="spinner.gif"}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-210' replace='true'}</div>
        {/if}
        {if $is_first_ajax_portlet}
            {include file="schedule/portlet/_sync_event_list.tpl"}
        {/if}
    </div> <!--end of portal_frame -->
</form>
{grn_load_javascript file="fw/yui/build/dragdrop/dragdrop-min.js"}
{grn_load_javascript file="fw/yui/build/selector/selector-min.js"}
{grn_load_javascript file="grn/html/schedule.js"}
{include file="grn/error_handler.tpl"}
