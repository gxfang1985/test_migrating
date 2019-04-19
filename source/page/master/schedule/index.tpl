{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}

{include file='schedule/_title_search.tpl'}
<div class="mainarea">
<div class="mainareaSchedule-grn">
{assign var='form_name' value=$smarty.template|basename}

{include file="schedule/_tab_menu.tpl"}
{include file="schedule/_show_full_short_title.tpl" function_click="showFullShortTitle('show_full_titleindex','schedule_groupweek','index',true);" schedule_id='schedule_groupweek'}
{include file="schedule/_show_users_timezone.tpl" function_click="showUsersTimezone('show_users_timezone','schedule_groupweek','index', false);"}
{literal}
<script type="text/javascript" language="javascript">
    var command_show_hide_absent_schedule_url = "{grn_pageurl page='schedule/command_show_hide_absent_schedule'}";
    function syncEventList()
    {
        var Y = YAHOO.util, Dom = Y.Dom;
        var search_txt = encodeURIComponent('{/literal}{$search_text}{literal}');
        var url = '{/literal}{grn_pageurl page="schedule/index"}{literal}'
                +  '{/literal}bdate={$bdate}&uid={$user_id}&gid={$group_id}&ajax=1&sp={$nsp}&search_text=' + search_txt + '&event={literal}';
        if (arguments.length == 2)
        {
            url += arguments[1];
        }
        AjaxObject.sendRequest('GET', url, function(o){
            var event_container = Dom.get('event_list');
            if (YAHOO.env.ua.ie)
            {
                var dummy = Dom.get('event_list_dummy');
                if (!dummy)
                {
                    dummy = document.createElement('div');
                    dummy.id = "event_list_dummy";
                    document.body.appendChild(dummy);
                }
                dummy.innerHTML = '<table><tbody id="event_list"' + o.responseText + '</tbody></table>';
                event_container.parentNode.replaceChild(dummy.firstChild.firstChild, event_container);
                dummy.innerHTML = '';
            }
            else
            {
                event_container.innerHTML = o.responseText;
            }

            showFullShortTitle("show_full_titleindex", "schedule_groupweek", "index", true);

            if (grn.base.isNamespaceDefined("garoon.schedule.data")
                && garoon.schedule.data.isCustomizationAvailable) {
                var week = [];
                jQuery(".js_customization_schedule_week_date").each(function (index, element) {
                    var date = jQuery(element).data('date');
                    week.push(date);
                });
                var event_data = {"viewType": "GROUP_WEEK", "dates": week};
                garoon.events.trigger('schedule.calendar.groupWeekIndex.show', event_data);
            }
        });
    }
</script>
{/literal}

{if $use_star}
<script type="text/javascript" language="javascript">
{literal}
/*
 Event.observe(window, 'load', function() {
    show_hide_absent_schedule_group_week('show_absent_schedule_groupweek','table.group_week','group_week',0)
   });
*/
function DisplayElement_group_week(rootElement, valueCheck)
{
    var scheduleWrapper = $$(rootElement)[0];
    var absentSchedule = scheduleWrapper.select('div.schedule_absent');
    if(!valueCheck)
    {
      
      absentSchedule.each(function(e){
                e.stopObserving("mouseover");
                e.stopObserving("mouseout");
                e.childElements().each(function(e1){
                    e1.show();
                });
                e.className = "schedule_absent_hide";
            });
    }
    else
    {
        absentSchedule.each(function(e){
                e.childElements().each(function(e1){
                    e1.hide();
                })
                e.className = "schedule_absent_show";
                e.observe("mouseover", function(event){
                    e.childElements().each(function(e1){
                    e1.show();
                    })
                    e.className = "schedule_absent_hide";
                });
                e.observe("mouseout", function(event){
                    e.childElements().each(function(e1){
                    e1.hide();
                    });
                    e.className = "schedule_absent_show";
                });
       });
    }
}

function show_hide_absent_schedule_group_week(id,tag_name,screen,flag)
{
   valueCheck = $(id);
  if(screen == 'group_week')
  {
      if( valueCheck.checked)
      {
        DisplayElement_group_week(tag_name,false);
        status = 1;
      }
      else
      {
        DisplayElement_group_week(tag_name,true);
        status = 0;
      }
      
      if(flag == 1)
      {
        new Ajax.Request(
                    command_show_hide_absent_schedule_url,
                    {
                        'method':'POST',
                        'parameters':'status='+status + '&page=group_day' +
                            '&csrf_ticket={/literal}{$csrf_ticket}{literal}'
                    }
                );
       }
  }
}
{/literal}
</script>
{/if}
{strip}
<form name="{$form_name}" method="GET" action="{grn_pageurl page=$page_info.all bdate=$bdate uid=$user_id gid=$group_id}">
    {include file="schedule/_day_navi.tpl" detail_page_url="schedule/index"}
    {include file="schedule/_schedule_navi_calendar.tpl" navi_cal_display_flag=$navi_cal_display_flag location='schedule/index' selected_group_type=$selected_group_type}


        {*&nbsp;&nbsp;&nbsp;<!--GRN2-2286-->{capture assign='grn_schedule_show_absent_schedule'}{cb_msg module='grn.schedule' key='show_absent_schedule'}{/capture}{grn_checkbox name='show_absent_schedule_groupweek' id='show_absent_schedule_groupweek' value=1 caption=$grn_schedule_show_absent_schedule checked=$show_absent_schedule onclick="show_hide_absent_schedule_group_week('show_absent_schedule_groupweek','table.group_week','group_week',1)"}&nbsp;<!--GRN2-2286-->*}

    <div class="clear_both_1px">&nbsp;</div>

        <table id="schedule_groupweek" class="calendar scheduleWrapper scheduleWrapperGroupWeek group_week {if !$show_full_title}hideEventTitle tableFixed{/if} group_week_calendar js_customization_schedule_view_type_GROUP_WEEK">
            <colgroup>
                <col class="group_week_calendar_column_first">
                <col class="group_week_calendar_column_common">
                <col class="group_week_calendar_column_common">
                <col class="group_week_calendar_column_common">
                <col class="group_week_calendar_column_common">
                <col class="group_week_calendar_column_common">
                <col class="group_week_calendar_column_common">
                <col class="group_week_calendar_column_common">
            </colgroup>
            <tbody  id="event_list">
                {foreach name='user' from=$schedule.users item=user}
                    {if ($smarty.foreach.user.iteration-1)%5 == 0}
                        {if $smarty.foreach.user.iteration != 1}
                            {include file="schedule/_day_navi2.tpl" aname=$smarty.foreach.user.iteration}
                        {/if}
                        <tr>
                            <td class="s_domain_week"><span class='domain'>{cb_msg module='fw.timezone' key=$display_timezone}</span></td>
                            {foreach from=$user.schedule_event item=item}
                                <td class="{$item.date_type}_week" align="center">
                                    &nbsp;{grn_schedule_date_header date=$item.date format='DateShort_MDW' image='' page='schedule/group_day' gid=$group_id search_text=$search_text caption='' title='' p=$selected_group_type br=true}
                                </td>
                            {/foreach}
                        </tr>
                    {/if}
                    <tr class="js_customization_schedule_user_id_{$user.id}">
                        <td valign="top" class="calendar_rb_week userBox">
                            {capture name='grn_schedule_GRN_SCH_742'}{cb_msg module='grn.schedule' key='GRN_SCH-742' replace='true'}{/capture}
                            {if $user.facility_id}
                            {grn_link image='facility20.gif' page='schedule/facility_info' faid=$user.facility_id caption=$user.facility_title referer_key=$referer_key}
                            <div class="shortcut_box_facility_grn">
                                {capture name='grn_schedule_GRN_SCH_619'}{cb_msg module='grn.schedule' key='GRN_SCH-619' replace='true'}{/capture}
                                {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pday20.gif' page='schedule/personal_day' bdate=$bdate uid=$user.id gid=selected search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_619 class='small_link'}
                                {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pweek20.gif' page='schedule/personal_week' bdate=$bdate uid=$user.id gid=selected search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_742 class='small_link'}
                                {capture name='grn_schedule_GRN_SCH_620'}{cb_msg module='grn.schedule' key='GRN_SCH-620' replace='true'}{/capture}
                                {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pmon20.gif' page='schedule/personal_month' bdate=$bdate uid=$user.id gid=$group_id search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_620 class='small_link'}
                                {$user.facility_memo|grn_noescape}
                            </div>
                            {else}
                                {assign var='uid' value=$user.id}
                                {capture name="prefix"}{$uid|substr:0:1}{/capture}
                                {if $imageIcon && $smarty.capture.prefix != 'g'}
                                    <div class="userElement profileImageBase-grn profileImageBaseSchedule-grn">
                                        <dl>
                                            <dt>{grn_user_image_icon userInfo=$users_info.$uid photoUrl=$users_info.$uid.photoUrl userId=$uid loginId=$login_id size=$iconSize is_popup=false referer_key=$referer_key}</dt>
                                            <dd>{grn_schedule_member_name id=$user.id users_info=$users_info groups_info=$groups_info referer_key=$referer_key noimage=true}</dd>
                                        </dl>
                                        <div class="clear_both_0px"></div>
                                    </div>
                                {else}
                                    <div class="userElement"><span class="span_user">{grn_schedule_member_name id=$user.id users_info=$users_info groups_info=$groups_info referer_key=$referer_key}&nbsp;</span></div>
                                {/if}
                                {capture name='grn_schedule_GRN_SCH_621'}{cb_msg module='grn.schedule' key='GRN_SCH-621' replace='true'}{/capture}
                                {capture name='grn_schedule_GRN_SCH_622'}{cb_msg module='grn.schedule' key='GRN_SCH-622' replace='true'}{/capture}
                                <div class="shortcut_box_full" {if !$show_full_title}style="display:none"{/if}>
                                    {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pday20.gif' page='schedule/personal_day' bdate=$bdate uid=$user.id gid=selected search_text=$search_text caption=$smarty.capture.grn_schedule_GRN_SCH_621 alt=$smarty.capture.grn_schedule_GRN_SCH_621 class='small_link' event=$event_id}
                                    {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pweek20.gif' page='schedule/personal_week' bdate=$bdate uid=$user.id gid=selected search_text=$search_text caption=$smarty.capture.grn_schedule_GRN_SCH_742 alt=$smarty.capture.grn_schedule_GRN_SCH_742 class='small_link'}
                                    {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pmon20.gif' page='schedule/personal_month' bdate=$bdate uid=$user.id gid=$group_id search_text=$search_text caption=$smarty.capture.grn_schedule_GRN_SCH_622 alt=$smarty.capture.grn_schedule_GRN_SCH_622 class='small_link' event=$event_id}
                                    {foreach from=$interaction_info_list item='interaction_info'}
                                        {if $interaction_info.$uid}
                                            {grn_link wrapper_class='schedule_userbox_item_grn' image=$interaction_info.$uid.image page=$interaction_info.$uid.page uid=$uid caption=$interaction_info.$uid.caption alt=$interaction_info.$uid.alt disabled=$interaction_info.$uid.disabled class='small_link'}
                                        {/if}
                                    {/foreach}
                                </div>
                                <div class="shortcut_box_short" {if $show_full_title}style="display:none"{/if}>
                                    {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pday20.gif' page='schedule/personal_day' bdate=$bdate uid=$user.id gid=selected search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_621 event=$event_id}
                                    {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pweek20.gif' page='schedule/personal_week' bdate=$bdate uid=$user.id gid=selected search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_742 class='small_link'}
                                    {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pmon20.gif' page='schedule/personal_month' bdate=$bdate uid=$user.id gid=$group_id search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_622 event=$event_id}
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
                        {foreach from=$user.schedule_event item=schedule_event}
                            <td valign="top" class="s_user_week normalEvent" {if $user.access.add}rel="{grn_pageurl page='schedule/simple_add' bdate=$schedule_event.date uid=$user.id gid=$group_id referer_key=$referer_key}"{if $user.facility_id} utype="facility"{/if}{/if}>
                                {if $user.access.add}
                                    <div class="addEvent">
                                        <a title="{cb_msg module='grn.schedule' key='GRN_SCH-624' replace='true'}" href="{grn_pageurl page='schedule/add' bdate=$schedule_event.date uid=$user.id gid=$group_id referer_key=$referer_key}"><div class="iconWrite-grn"></div></a>
                                    </div>
                                {/if}

                                <div class="js_customization_schedule_date_{$schedule_event.date}"></div>

                                <div class="groupWeekInfo">
                               {foreach from=$schedule_event.calendar item=calendar}
                                   {grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon class='group_week_calendar_item_event'}
                               {/foreach}
                               </div>
                               {if $schedule_event.date === $today && $login_id === $user.id}
                                   {include file="schedule/expired_todo.tpl"}
                               {/if}
                               {include file="schedule/todo.tpl" event=$schedule_event}
                                {foreach from=$schedule_event.event item=event}
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
                                        <div class="{if $event.type != 'share_temporary' && $event.type != 'temporary'}{$event.type}{/if} normalEventElement {$event_tz_class} {if $event.absent === 1}schedule_absent{/if} group_week_calendar_item{if $event.id eq $simple_add_eid} newevent-grn{/if}">
                                            <div class="listTime">
                                                {if ! $event.private}
                                                    <a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$schedule_event.date uid=$user.id gid=$group_id referer_key=$referer_key start_day=$event.start_day end_day=$event.end_day}">
                                                {/if}
                                                    {$event.time_schedule|grn_noescape}
                                                {if ! $event.private}
                                                    </a>
                                                {/if}
                                            </div>
                                            <div class="{if $event.allday}groupWeekEventTitleAllday{else}groupWeekEventTitle{/if}">
                                                {if ! $event.private}
                                                    {if $event.type == "share_temporary" || $event.type == "temporary"}<span class="{$event.type}">{/if}
                                                    <a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$schedule_event.date uid=$user.id gid=$group_id referer_key=$referer_key start_day=$event.start_day end_day=$event.end_day}">
                                                    {if $event.conflict}
                                                        {capture name='grn_schedule_GRN_SCH_914'}{cb_msg module='grn.schedule' key='GRN_SCH-914' replace='true'}{/capture}
                                                        {grn_image image="attention16.gif" alt=$smarty.capture.grn_schedule_GRN_SCH_914}

                                                    {/if}
                                                    {*GTM-1625*}
                                                    {if $event.attendance_check_show}
                                                        {capture name='grn_schedule_GRN_SCH_1036'}{cb_msg module='grn.schedule' key='GRN_SCH-1036' replace='true'}{/capture}
                                                        {grn_image alt=$smarty.capture.grn_schedule_GRN_SCH_1036 class="unanswered_icon_base_grn" image="image-app-schedule/event_unanswered16.png"}
                                                    {/if}
                                                {/if}
                                                {*$event.event_title_for_view|grn_noescape*}
                                                {*GTM-103*}
                                                {if !$event.private && $event.event_menu neq '' && $event.event_menu_color neq '' && $event.event_menu_color neq '0'}
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
                                                {/if}{*End GTM-103*}
                                               {if $event.is_private}
                                                   {grn_image image="image-common/privateMark_sub16.png"}
                                               {/if}
                                               {if $event.type == 'share_repeat' || $event.type == 'repeat'}
                                                   {grn_image image="repeat16.gif"}
                                               {/if}
                                               {if $event.report}{grn_image image="report16.gif"}{/if}
                                        {if ! $event.private}</a>
                                            {if $event.type == "share_temporary" || $event.type == "temporary"}</span>{/if}{*close tag span open in the line 271*}
                                        {/if}
                                     </div>
                                </div>
                                    {if $event.absent === 1}
                                        </div>
                                    {/if}
                                {/foreach}
                            </td>
                        {/foreach}
                    </tr>
                    {grn_schedule_weekbanner banner_events=$user.banner_event page='schedule/view' week_type='group' setdate=$week_start enddate=$week_end banner_class='s_banner' blank_class='br_banner' banner_image='banner16.gif' uid=$user.id gid=$group_id referer_key=$referer_key show_users_timezone=$show_users_timezone}
                {/foreach}
            </tbody>
        </table>

    <div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$view_set.navi}</nobr></div>
    <input type="hidden" name="bdate" value="{$bdate|escape}">
</form>
</div>
{/strip}
{grn_load_javascript file="fw/yui/build/dragdrop/dragdrop-min.js"}
{grn_load_javascript file="fw/yui/build/selector/selector-min.js"}
{grn_load_javascript file="grn/html/schedule.js"}
{include file="grn/error_handler.tpl"}
{grn_load_customization_js_css}
{include file='grn/footer.tpl'}
