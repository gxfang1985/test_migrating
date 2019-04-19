<!-- GTM-101 -->
<!-- Drag drop schedule -->
{if not ( $browser.type == 'msie' ) && false}
{grn_load_javascript file="fw/jquery/jquery-ui-1.12.1.custom.min.js"}
<script type="text/javascript">
    var _short_date_format = "{$short_date_format|grn_noescape}";
    var _locale = "{$html_tag_lang}";
    var is_group_day = 1;
    var plid_tmp = "{$portlet.plid}";
    {literal}
    if(typeof plid_list != "undefined" && plid_list != "")
    {
        plid_list[plid_list.length] = plid_tmp;
    }
    else
    {
        var plid_list = new Array();
        plid_list[0] = plid_tmp;
    }
    {/literal}
</script>
{/if}
<!-- End GTM-101 -->

{if $portlet.settings.font_size == "large"}
    {assign var="font_size" value='font-size:140%;'}
{elseif $portlet.settings.font_size == "normal"}
    {assign var="font_size" value=''}
{elseif $portlet.settings.font_size == "small"}
    {assign var="font_size" value='font-size:70%;'}
{/if}
{assign var=plid value=$portlet.plid}
{include file="schedule/_show_full_short_title.tpl" function_click="showFullShortTitle('show_full_title$plid','event_list$plid','view_group_day',true);" schedule_id="event_list$plid"}

    <div style="{$font_size}" id="view_group_day_main{$portlet.plid}">
        <table class="top_title">{strip}
            <tbody>
            <tr>
                <td>
                    <span class="portlet_title_grn">
                        <a href="{grn_pageurl page='schedule/group_day'}">{$page_title}</a>
                    </span>
                </td>
                <td align="right">
                    {include file='schedule/portlet/_search_part.tpl' portletId=$portlet.plid page='schedule/group_day'}
                </td>
            </tr>
            </tbody>
        </table>{/strip}

        <form name="personal_day{$portlet.plid}" method="GET" action="{grn_pageurl page='schedule/group_day'}">
        <div id="portal_frame{$portlet.plid}" class="portal_frame portal_frame_schedule_groupday_grn">
          <div class="groupDayPortletUpper-grn">
            <table class="top_day_navi group_day_calendar_portal_frame">
                <tr>
                    <td class="v-allign-middle" width="40%" nowrap>
                        <table cellspacing="0" cellpadding="0" border="0">
                            <tbody>
                                <tr>
                                    <td nowrap="nowrap">

<script language="JavaScript" type="text/javascript">
{if $use_star}
{literal}
//GRN2-2286
// star process
function grn_schedule_star_on_update{/literal}{$portlet.plid}{literal}(star_ele, params)
{
    var status = GRN_StarList.getStatus(star_ele);
    var event = params.event;
    var bdate = params.bdate;
    GRN_StarList.getItems('event_list{/literal}{$portlet.plid}{literal}').each(function(){
        var item_params = GRN_StarList.parseParam(this);
        if( event == item_params.event)
        {
            if( params.repeat && params.repeat == '1' )
            {
                if( bdate == item_params.bdate )
                    GRN_StarList.setStatus(this, status);
            }
            else
            {
                GRN_StarList.setStatus(this, status);
            }
        }
    });
}
// end star process
{/literal}
{/if}
{if $is_first_ajax_portlet}
var plid_array = new Array();
{/if}
plid_array[{$portlet.plid}] = {ldelim}"name":"view_group_day", "ajax_path":"{grn_pageurl page='schedule/portlet/ajax_view_group_day'}bdate={$bdate}&uid={$user_id}&gid={$group_id}&plid={$portlet.plid}&referer_key={$referer_key}", "bdate":"{$bdate}"{rdelim};
</script>
{if $use_star}{include file="star/star_init.tpl" list_id="event_list`$portlet.plid`" on_update="grn_schedule_star_on_update`$portlet.plid`"}{/if}
{if $is_first_ajax_portlet}
{include file="schedule/portlet/_sync_event_list.tpl"}
{/if}
{* _select_group.tpl start *}
{include file="schedule/portlet/_dropdown_part.tpl" detail_page_url="schedule/group_day"}
{* _select_group.tpl end *}

                                    </td>
                                    <td nowrap="nowrap">
                                        {if $page_info.last == 'personal_day' || $page_info.last == 'personal_week'}
                                            {capture name='grn_schedule_portlet_GRN_SCH_PO_135'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-135' replace='true'}{/capture}{grn_popup_user_select_link_schedule caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_135 send_cgi_parameter=true include_org=$include_org system=false system_display=false access_plugin=$access_plugin extension_items=$extension_items}
                                        {elseif $page_info.last == 'group_day' || $page_info.last == 'index'}
                                            {capture name='grn_schedule_portlet_GRN_SCH_PO_136'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-136' replace='true'}{/capture}{grn_popup_user_select_link caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_136 app_id=$schedule_app_id form_name=$form_name include_org=$include_org system=false system_display=false multi_apply=true access_plugin=$access_plugin return_page='schedule/group_day' module="schedule"}
                                        {else}
                                            {assign var="window_url" value='schedule/popup_group'}
                                            {assign var="no_multiple" value='0'}
                                            {assign var="onChange" value='0'}
                                            <a href="javascript:popupWin('{grn_pageurl page='schedule/popup_group' bdate=$bdate return_url=$page_info.all}','html','','',0,0,1,1,0,1);">{grn_image image='blank20.gif'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-137' replace='true'}</a>
                                        {/if}
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td class="v-allign-middle" width="20%" align="center" nowrap>
                        <div class="bold">{grn_date_format date=$bdate format="DateFull_YMDW"}</div>
                    </td>
                    <td class="v-allign-middle" width="40%" align="right" nowrap>
                        <div class="moveButtonBlock-grn">
                        {strip}
                            <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-139' replace='true'}">
                                <a href="{grn_pageurl page=$page_info.all bdate=$bdate_prevweek uid=$schedule.users[0].user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset}">
                                    <span class="moveButtonArrowLeftTwo-grn"></span>
                                </a>
                            </span>
                            <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-141' replace='true'}">
                                <a href="{grn_pageurl page=$page_info.all bdate=$bdate_prevday uid=$schedule.users[0].user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset}">
                                    <span class="moveButtonArrowLeft-grn"></span>
                                </a>
                            </span>
                            <span class="moveButtonBase-grn" title="">
                                <a href="{grn_pageurl page=$page_info.all bdate=$date uid=$schedule.users[0].user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset}">
                                    {cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-142' replace='true'}
                                </a>
                            </span>
                            <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-143' replace='true'}">
                                <a href="{grn_pageurl page=$page_info.all bdate=$bdate_nextday uid=$schedule.users[0].user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset}">
                                    <span class="moveButtonArrowRight-grn"></span>
                                </a>
                            </span>
                            <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-145' replace='true'}">
                                <a href="{grn_pageurl page=$page_info.all bdate=$bdate_nextweek uid=$schedule.users[0].user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset}">
                                    <span class="moveButtonArrowRightTwo-grn"></span>
                                </a>
                            </span>
                        {/strip}
                        </div>
                        {include file='schedule/_display_options.tpl' page_key='view_group_day' schedule_id='event_list'|cat:$plid group_day='true' plid=$plid show_full_title_option='true' apply_users_timezone='true' show_todos_option='true'}
                    </td>
                </tr>
                {if ! $hidden_navi}
                <tr>
                    <td colspan="3">
                            <div class="sub_title smart_data_count_navi">{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-147' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
                        
                    </td>
                </tr>
                {/if}
            </table>
          </div>
          {strip}
                <table class="day_table scheduleWrapper scheduleWrapperTimezoneBar portlet_group_day {if !$show_full_title}hideEventTitle tableFixed{/if} {if $show_absent_schedule == 0}hideScheduleAbsent{/if} group_day_calendar js_customization_schedule_view_type_GROUP_DAY"  id="event_list{$portlet.plid}">
                    {capture assign="bar_login_timezone"}{include file="schedule/_login_timezone.tpl"}{/capture}
                    {foreach name=schedule from=$schedule.users item=schedule}
                        <tr class="day_table_time_login bar_user_timezone" {if !$member_tz}style="display:none"{/if}>
                            <td class="group_day_calendar_timebar1"><span class='domain'>{cb_msg module='fw.timezone' key=$schedule.timezone}</span></td>
                            <td class="group_day_calendar_timebar2"><br></td>
                            {grn_schedule_time_header set_hour=$schedule_params.set_hour end_hour=$schedule_params.end_hour unit=$schedule_params.unit class_morning='m' class_evening='e' class_night='a' facility_id=$schedule.facility_id timezone=$schedule.timezone bdate=$bdate}
                        </tr>
                        <tr class="day_table_time_login bar_user_timezone" {if !$member_tz}style="display:none"{/if}>
                            <td class="group_day_calendar_timebar_sec1">{grn_image image='spacer1.gif'}</td>
                            <td class="group_day_calendar_timebar_sec2">{grn_image image='spacer1.gif'}</td>
                            {grn_schedule_time_header2 set_hour=$schedule_params.set_hour end_hour=$schedule_params.end_hour unit=$schedule_params.unit class_morning='m' class_evening='e' class_night='a' timezone=$schedule.timezone bdate=$bdate}
                        </tr>
                        {$bar_login_timezone|grn_noescape}
                        <tr class="js_customization_schedule_user_id_{$schedule.user_id}">
                            <td {if $show_full_title}class="userBox group_day_calendar_user"{else}class="userBox group_day_calendar_user nowrap_class"{/if}>
                                {if $schedule.facility_id}
                                    {grn_link image='facility20.gif' page='schedule/facility_info' faid=$schedule.facility_id caption=$schedule.facility_title referer_key=$referer_key}
                                    <div class="shortcut_box_facility_grn">
                                        {capture name='grn_schedule_GRN_SCH_619'}{cb_msg module='grn.schedule' key='GRN_SCH-619' replace='true'}{/capture}{grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pday20.gif' page='schedule/personal_day' bdate=$bdate uid=$schedule.user_id gid=selected search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_619 class='small_link'}
                                        {capture name='grn_schedule_portlet_GRN_SCH_PO_150'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-150' replace='true'}{/capture}{grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pweek20.gif' page='schedule/personal_week' bdate=$bdate uid=$schedule.user_id gid=selected caption='' alt=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_150 class='small_link'}
                                        {capture name='grn_schedule_portlet_GRN_SCH_PO_151'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-151' replace='true'}{/capture}{grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pmon20.gif' page='schedule/personal_month' bdate=$bdate uid=$schedule.user_id gid=$group_id caption='' alt=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_151 class='small_link'}
                                        {$schedule.facility_memo|grn_noescape}
                                    </div>
                                {else}
                                    {assign var='uid' value=$schedule.user_id}
                                    {capture name="prefix"}{$uid|substr:0:1}{/capture}
                                    {if $imageIcon && $smarty.capture.prefix != 'g'}
                                        <div class="userElement profileImageBase-grn profileImageBaseSchedule-grn">
                                            <dl>
                                                <dt>{grn_user_image_icon userInfo=$users_info.$uid photoUrl=$users_info.$uid.photoUrl userId=$uid loginId=$login_id size=$iconSize is_popup=false referer_key=$referer_key}</dt>
                                                <dd>{grn_schedule_member_name id=$schedule.user_id users_info=$users_info groups_info=$groups_info referer_key=$referer_key noimage=true}</dd>
                                            </dl>
                                            <div class="clear_both_0px"></div>
                                        </div>
                                        {else}
                                        <div class="userElement"><span class="span_user">{grn_schedule_member_name id=$schedule.user_id users_info=$users_info groups_info=$groups_info referer_key=$referer_key}</span></div>
                                    {/if}
                                    {capture name='grn_schedule_GRN_SCH_621'}{cb_msg module='grn.schedule' key='GRN_SCH-621' replace='true'}{/capture}
                                    {capture name='grn_schedule_portlet_GRN_SCH_PO_152'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-152' replace='true'}{/capture}
                                    {capture name='grn_schedule_portlet_GRN_SCH_PO_153'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-153' replace='true'}{/capture}
                                    <div class="shortcut_box_full" {if !$show_full_title}style="display:none"{/if}>
                                        {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pday20.gif' page='schedule/personal_day' bdate=$bdate uid=$schedule.user_id gid=selected search_text=$search_text caption=$smarty.capture.grn_schedule_GRN_SCH_621 alt=$smarty.capture.grn_schedule_GRN_SCH_621 class='small_link'}
                                        {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pweek20.gif' page='schedule/personal_week' bdate=$bdate uid=$schedule.user_id gid=selected caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_152 alt=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_152 class='small_link'}
                                        {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pmon20.gif' page='schedule/personal_month' bdate=$bdate uid=$schedule.user_id gid=$group_id caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_153 alt=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_153 class='small_link'}
                                        {foreach from=$interaction_info_list item='interaction_info'}
                                            {if $interaction_info.$uid}
                                                {grn_link wrapper_class='schedule_userbox_item_grn' image=$interaction_info.$uid.image page=$interaction_info.$uid.page uid=$uid caption=$interaction_info.$uid.caption alt=$interaction_info.$uid.alt disabled=$interaction_info.$uid.disabled class='small_link'}
                                            {/if}
                                        {/foreach}
                                    </div>
                                    <div class="shortcut_box_short" {if $show_full_title}style="display:none"{/if}>
                                        {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pday20.gif' page='schedule/personal_day' bdate=$bdate uid=$schedule.user_id gid=selected search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_621 class='small_link'}
                                        {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pweek20.gif' page='schedule/personal_week' bdate=$bdate uid=$schedule.user_id gid=selected caption='' alt=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_152 class='small_link'}
                                        {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pmon20.gif' page='schedule/personal_month' bdate=$bdate uid=$schedule.user_id gid=$group_id caption='' alt=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_153 class='small_link'}
                                        {foreach from=$interaction_info_list item='interaction_info'}
                                            {if $interaction_info.$uid}
                                                {grn_link wrapper_class='schedule_userbox_item_grn' image=$interaction_info.$uid.image page=$interaction_info.$uid.page uid=$uid caption='' alt=$interaction_info.$uid.alt disabled=$interaction_info.$uid.disabled class='small_link'}
                                            {/if}
                                        {/foreach}
                                    </div>
                                    {if $active_presence}
                                        {assign var='presence' value=$schedule.presence}
                                        <span class="schedule_userbox_item_grn schedule_userbox_presence_grn">
                                            {grn_link page=$presence.page image=$presence.image caption=$presence.info uid=$uid disabled=$presence.disabled br=true class='small_link'}
                                            {if $presence.mtime}
                                                {if $presence.old}<span class="attention">{/if}
                                                <span class="group_day_calendar_presence">[{grn_date_format date=$presence.mtime format="DateTimeCompact"}]</span>
                                                {if $presence.old}</span>{/if}
                                            {/if}
                                        </span>
                                    {/if}
                                    {if $login_timezone != $schedule.timezone}<span class='domain'>{cb_msg module='fw.timezone' key=$schedule.timezone}</span>{/if}
                                {/if}
                            </td>
                            <td class="normalEvent group_day_calendar_event_cell" rel="{grn_pageurl page='schedule/simple_add' uid=$schedule.user_id gid=$group_id bdate=$bdate referer_key=$referer_key}" plid="{$portlet.plid}"{if $schedule.facility_id} utype="facility"{/if}>
                                <div class="js_customization_schedule_date_{$bdate}"></div>
                                {if $schedule.schedule_event.calendar}
                                    {foreach from=$schedule.schedule_event.calendar item=calendar}
                                        {grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon class='group_day_calendar_event_item'}
                                    {/foreach}
                                {/if}
                                {include file="schedule/todo.tpl" event=$schedule.schedule_event}
                                {if $schedule.schedule_event.event}
                                    {foreach from=$schedule.schedule_event.event item=event}
                                        {if $event.allday}
                                            {if $event.star_date}
                                                {assign var='star_date' value=$event.star_date}
                                            {else}
                                                {assign var='star_date' value=$bdate}
                                            {/if}
                                            {if $use_star}
                                                {assign var="unique_id" value=$event.id}
                                                {assign var="repeate_type" value=""}
                                                {if $event.type eq 'repeat' || $event.type eq 'share_repeat'}
                                                    {assign var="unique_id" value="rp_`$event.id`_$bdate"}
                                                    {assign var="repeate_type" value="1"}
                                                {/if}
                                            {/if}
                                            {capture name="star"}{strip}
                                                {if $event.absent === 1}
                                                    <div class='schedule_absent'>
                                                {/if}
                                                
                                                    <div class="normalEventElement">{grn_image image="allday.gif"}
                                                        {if ! $event.private}
                                                        <a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$bdate uid=$user.id gid=$group_id referer_key=$referer_key}">{/if}
                                                            {if $event.attendance_check_show}
                                                                {capture name='grn_schedule_GRN_SCH_1036'}{cb_msg module='grn.schedule' key='GRN_SCH-1036' replace='true'}{/capture}
                                                                {grn_image alt=$smarty.capture.grn_schedule_GRN_SCH_1036 class="unanswered_icon_base_grn" image="image-app-schedule/event_unanswered16.png"}
                                                            {/if}
                                                            {*GTM-103*}
                                                            {if !$event.private && $event.event_menu neq '' && $event.event_menu_color neq '' && $event.event_menu_color neq '0'}
                                                                <span class="event_color{$event.event_menu_color}_grn">
                                                                        {$event.event_menu|grn_noescape}
                                                                </span>
                                                                {$event.event_detail|grn_noescape}
                                                            {else}
                                                                {$event.data|grn_noescape}
                                                            {/if}
                                                            {*End GTM-103*}
                                                            {if $event.is_private}{grn_image image="image-common/privateMark_sub16.png"}{/if}{if $event.type == 'share_repeat' || $event.type == 'repeat'}{grn_image image="repeat16.gif"}{/if}{if $event.report}{grn_image image="report16.gif"}{/if}{if ! $event.private}</a>{/if}</div>

                                                {if $event.absent === 1}
                                                    </div>
                                                {/if}
                                            {/strip}{/capture}
                                            {$smarty.capture.star|grn_noescape}
                                            {assign var='alldays' value=true}
                                        {/if}
                                    {/foreach}
                                {/if}
                                {if ! $alldays}
                                    &nbsp;
                                {/if}
                            </td>
                            {grn_schedule_group_day
                                data=$schedule.schedule_event.event
                                bdate=$schedule.schedule_event.date
                                uid=$schedule.user_id
                                gid=$group_id
                                unit=$schedule_params.unit
                                set_hour=$schedule_params.set_hour
                                end_hour=$schedule_params.end_hour
                                page='schedule/view'
                                access=$schedule.access
                                disable_link=false
                                facility_id=$schedule.facility_id
                                timezone=$schedule.timezone
                                type='normalEvent'
                                plid=$portlet.plid
                                referer_key=$referer_key
                            }
                        </tr>
                        {foreach from=$schedule.schedule_event.event item=event}
                            {if $event.conflict}
                                <tr>
                                    <td class="group_day_calendar_conflict_head1"><br></td>
                                    <td class="group_day_calendar_conflict_head2" rel="{grn_pageurl page='schedule/simple_add' uid=$schedule.user_id gid=$group_id bdate=$bdate referer_key=$referer_key}" plid="{$portlet.plid}"{if $schedule.facility_id} utype="facility"{/if}><br></td>
                                    {grn_schedule_group_day_conflict 
                                        menu=$event.event_menu 
                                        menu_color=$event.event_menu_color 
                                        detail=$event.event_detail 
                                        facility_name=$event.event_facility_name 
                                        facility_after = $event.facility_name_after
                                        faci_items = $event.faci_items
                                        start_date=$event.start_date 
                                        end_date=$event.end_date 
                                        page='schedule/view' 
                                        event=$event.id 
                                        bdate=$schedule.schedule_event.date 
                                        uid=$schedule.user_id 
                                        gid=$group_id 
                                        unit=$schedule_params.unit 
                                        set_hour=$schedule_params.set_hour 
                                        end_hour=$schedule_params.end_hour 
                                        private=$event.private 
                                        title=$event.data 
                                        referer_key=$referer_key 
                                        timezone=$schedule.timezone 
                                        event_type=$event.type 
                                        no_endtime=$event.no_endtime
                                        attendance_check_show=$event.attendance_check_show
                                    }
                                </tr>
                            {/if}
                        {/foreach}
                        {if $schedule.banner_event}
                            {foreach from=$schedule.banner_event item=banner_event}
                                {if $banner_event.star_date}
                                    {assign var='star_date' value=$banner_event.star_date}
                                {else}
                                    {assign var='star_date' value=$bdate}
                                {/if}
                                <tr>
                                    <td class="group_day_calendar_banner_head1"><br></td>
                                    <td class="group_day_calendar_banner_head2" rel="{grn_pageurl page='schedule/simple_add' uid=$schedule.user_id gid=$group_id bdate=$bdate referer_key=$referer_key}" plid="{$portlet.plid}"{if $schedule.facility_id} utype="facility"{/if}><br></td>
                                    <td class="banner_color group_day_calendar_banner_item" colspan="{$schedule_params.col_span}">{if $banner_event.absent === 1}<div class="schedule_absent">{/if}<div class=""><a href="{grn_pageurl page='schedule/view' event=$banner_event.id bdate=$bdate uid=$schedule.user_id gid=$group_id}">{grn_image image='banner16.gif'}
                                                    {if $schedule.attendance_check_show}
                                                        {capture name='grn_schedule_GRN_SCH_1036'}{cb_msg module='grn.schedule' key='GRN_SCH-1036' replace='true'}{/capture}
                                                        {grn_image alt=$smarty.capture.grn_schedule_GRN_SCH_1036 class="unanswered_icon_base_grn" image="image-app-schedule/event_unanswered16.png"}
                                                    {/if}
                                                    <!--GTM-103-->
                                        {if $banner_event.event_menu neq '' && $banner_event.event_menu_color neq '' && $banner_event.event_menu_color neq '0'}
                                            <span class="event_color{$banner_event.event_menu_color}_grn">{$banner_event.event_menu|grn_noescape}</span>{$banner_event.event_detail|grn_noescape}
                                        {else}
                                            {$banner_event.data|grn_noescape}
                                        {/if}
                                        <!--End GTM-103-->
                                        {if $banner_event.report}{grn_image image="report16.gif"}{/if}</a></div>{if $banner_event.absent === 1}</div>{/if}</td>
                                </tr>
                            {/foreach}
                        {/if}
                    {/foreach}
                </table>
            {/strip}

            {if ! $hidden_navi}
                <div class="navi portlet_groupday_navi_grn"><nobr>{include file="grn/word_navi.tpl" navi=$view_set.navi}</nobr></div>
            {/if}

            <input type="hidden" name="bdate" value="{$bdate}">
        </div>
    </form>
</div> <!--end of portal_frame -->
{grn_load_javascript file="fw/yui/build/dragdrop/dragdrop-min.js"}
{grn_load_javascript file="fw/yui/build/selector/selector-min.js"}
{grn_load_javascript file="grn/html/schedule.js"}
{include file="grn/error_handler.tpl"}
