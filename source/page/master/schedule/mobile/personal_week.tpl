{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_css file="grn/html/mobile_list.css"}

{grn_load_javascript file="grn/html/component/mobile_autocomplete_user_facility.js"}
{grn_load_javascript file="grn/html/page/schedule/mobile/group_day.js"}
{grn_load_javascript file="grn/html/page/schedule/mobile/personal_week.js"}

{literal}
<script type="text/javascript">
    grn.Component.Autocomplete.AutocompleteUserFaci.Parameters = {
        'url': "{/literal}{grn_pageurl page='schedule/mobile/ajax/ajax_get_user_facility'}{literal}",
        'csrf_ticket': "{/literal} {$referer_key}{literal}"};

    grn.Component.Autocomplete.AutocompleteUserFaci.Msg = {
        'place_holder': '{/literal}{$place_holder|escape|escape:javascript}{literal}',
        'search_text':  '{/literal}{$search_text|escape|escape:javascript}{literal}'
    };
    // footer add schedule function
    grn.page.schedule.mobile.personal_week.Parameters = {
        'bdate': '{/literal}{$bdate}{literal}',
        'uid': '{/literal}{$uid}{literal}',
        'gid': '{/literal}{$group_id|escape|escape:javascript}{literal}',
        'referer_key': '{/literal}{$referer_key}{literal}',
        'url': "{/literal}{grn_pageurl page='schedule/mobile/add'}{literal}"
    };
</script>
{/literal}
{strip}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-withList-grn">
    <div class="mobile_breadcrumbtitle_grn mobile_titlebar_content_withList_grn">
        <div class="mobile_breadcrumbtitle_right_grn">
            <span class="mobile_icon_breadcrumb_grn mobile_app_schedule_s_b_grn"></span>
            {$app_name}
        </div>
    </div>
    {*--end title-bar--*}
    {*Begin switch command personal week and group day *}
    <div class="mobile_schedule_week_header_grn">
        <div class="mobile_left_grn mobile_selected_grn">
            <span>{cb_msg module='grn.schedule' key='GRN_SCH-982' replace='true'}</span>
        </div>
        <div class="mobile_right_grn mobile_unselected_grn">
            <a href="{grn_pageurl page='schedule/mobile/group_day' bdate=$bdate uid=$user_id gid=$group_id search_text=''}" >
            {cb_msg module='grn.schedule' key='GRN_SCH-660' replace='true'}
            </a>
        </div>
        <a href="javascript:void(0);" id="icon_search_grn" class="mobile_schedulelist_icon_search_grn"></a>
    </div>
    {*end switch command*}
    {*search part*}
    {include file="schedule/mobile/mobile_search_header.tpl"}
    {*end search part*}
    {* previous ,today, next *}
    <div class="mobile_schedule_week_menu_grn">
        <a href="{grn_pageurl page=$page_info.all bdate=$bdate_prevweek uid=$user_id search_text=$search_text uids=$view_set.navi.params.uids fids=$vew_set.navi.params.fids}" class="mobile_left_array_grn"></a>
        <a href="{grn_pageurl page=$page_info.all bdate='' uid=$user_id search_text=$search_text uids=$view_set.navi.params.uids fids=$vew_set.navi.params.fids}" class="mobile_text_grn">
            {cb_msg module='grn.schedule' key='GRN_SCH-230' replace='true'}
        </a>
        <a href="{grn_pageurl page=$page_info.all bdate=$bdate_nextweek uid=$user_id  search_text=$search_text uids=$view_set.navi.params.uids fids=$vew_set.navi.params.fids}" class="mobile_right_array_grn"> </a>
        {grn_mobile_select_date id='start' icon_only='true' icon_class='mobile_right_icon_grn' date=$bdate}{*datepicker*}
    </div>
    {* end previous ,today, next *}

{if $user_id neq $login_id}
    <div class="mobile_schedule_day_subtitle_grn">
        {assign var='uid' value=$schedule.user_id}
        {capture name="prefix"}{$uid|substr:0:1}{/capture}
        {if $schedule.facility_id || $smarty.capture.prefix eq 'f'}
            <div class="mobile_icon_grn mobile_img_facilityPlofile_grn">
        {else}
            {if $smarty.capture.prefix != 'g'}
                {if !empty($users_info.$user_id.col_valid)}
                    <div class="mobile_icon_grn mobile_img_userInvalidPlofile_grn">
                {else}
                    <div class="mobile_icon_grn mobile_img_userPlofile_grn">
                {/if}
            {else}
                <div class="mobile_icon_grn mobile_img_groupPlofile_grn">
                {*is group*}
            {/if}
        {/if}
        </div>{*end of img*}

        <div class="mobile_title_grn">
            {if $schedule.facility_id || $smarty.capture.prefix eq 'f'}
                {$schedule.facility_title}
            {else}
                {capture name="prefix"}{$uid|substr:0:1}{/capture}
                {if $smarty.capture.prefix != 'g'}
                    {$users_info.$user_id.col_display_name|escape}
                    {if !empty($users_info.$user_id.col_nickname)}
                        ({$users_info.$user_id.col_nickname|escape})
                    {/if}
                {else}
                    {grn_schedule_member_name id=$schedule.user_id groups_info=$groups_info referer_key=$referer_key noimage=1}
                    {*group title*}
                {/if}
            {/if}
        </div>
        <div class="mobile_subtitle_grn">
            {$users_info.$user_id.primary_group.col_name|escape}
        </div>

    </div>
{/if}
    <!--weekday start-->

    {foreach from=$schedule.schedule_event key=num item=schedule_event}

        <div class="mobile_week_day_title_grn">
            {assign var='style_of_day' value=$schedule_event.date_type|substr:7 }
            {if $style_of_day eq 'sunday'}
                {assign var='style_of_day' value='holiday'}
            {/if}
            <div class="mobile_week_date_grn mobile_week_{$style_of_day}_grn">
               {grn_date_format date=$schedule_event.date format="DateFull_YMDW"}

            </div>
            {if $schedule_event.calendar|@count gt 0}
            <div class="mobile_holiday_name_grn">
                <div class="mobile_holiday_table_grn">
                    {foreach from=$schedule_event.calendar item=calendar}
                        <div>{$calendar.data}</div>
                    {/foreach}
                </div>
            </div>
            {/if}
            {if $schedule.access.add}
                <div class="mobile_right_icon_grn" data-bdate='{$schedule_event.date}' data-ref_key='{$referer_key}' data-uid='{$user_id}' data-gid='{$group_id}' ></div>
            {/if}
        </div>
        {*end of date info week_day*}

        <ul data-role="listview" data-theme="{$data_theme}" class="mobile_schedule_ul_grn mobile-ul-top-grn mobile-ul-bottom-grn mobile_list_normal_padding_grn">
        {if $show_todos eq true}
            {include file="schedule/mobile/todo_personal_week.tpl" event=$schedule_event}
        {/if}
            {*Loop on every day*}{*banner event for every day*}

            {assign var='count_banner_event' value=$schedule.banner_event[$num]|@count}

            {foreach from=$schedule.banner_event[$num] key=num_banner item=banner_event}

                <li data-icon="false">
                    <a class="mobile-list-text-grn mobile_list_table_grn" href="{grn_pageurl page='schedule/mobile/view' event=$banner_event.id bdate=$schedule_event.date uid=$user_id gid=$group_id referer_key=$referer_key}">
                        <div class="mobile_list_table_td_grn">
                            <div class="mobile_list_lines_grn">
                                <ul>
                                    <li>
                                        {if $banner_event.unread eq true}
                                        <span class='mobile_list_icon_unread_grn'></span>
                                        {/if}
                                        <span class="mobile_list_users_grn mobile_allday_grn">
                                            <span class="mobile_event_menu_grn mobile_allday_color_grn">
                                                {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-80' replace='true'}
                                            </span>
                                            {grn_date_format date=$banner_event.start_date format="DateFull_YMDW"}
                                             {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-77' replace='true'}
                                            {grn_date_format date=$banner_event.end_date format="DateFull_YMDW"}
                                            {*$banner_event.time_schedule|grn_noescape*}
                                        </span>
                                    </li>
                                    <li>
                                        <span class="mobile_list_content_grn">
                                            {*menu color banner*}
                                            {if !empty($banner_event.event_menu_color) && !empty($banner_event.event_menu)}
                                                <span class="mobile_event_menu_grn mobile_event_menu_color{$banner_event.event_menu_color}_grn">
                                                    {$banner_event.event_menu|grn_noescape}
                                                </span>
                                            {elseif !empty($banner_event.event_menu)}
                                                {$banner_event.event_menu|grn_noescape}:
                                            {/if}{*end menu color banner*}
                                            {$banner_event.event_detail|grn_noescape}
                                        </span>
                                    </li>
                                    <li>
                                        <span class="mobile_list_subcontent_grn">{* banner event not use facility, emulate the white space *}&nbsp;</span>
                                    </li>
                                </ul>
                            </div>
                        </div><!--table-cell-->
                        <span class="mobile_list_icon_arraylist_grn"></span>
                    </a>
                </li>
            {/foreach}

            {assign var='count_event' value=$schedule_event.event|@count}

            {if $schedule.schedule_event}
                {*event for every day*}
                {foreach from=$schedule_event.event key=num_event item=event}
                    <li data-icon="false" >
                        {if !$event.private}
                            <a class="mobile-list-text-grn mobile_list_table_grn" href="{grn_pageurl page='schedule/mobile/view' event=$event.id bdate=$schedule_event.date uid=$user_id gid=$group_id referer_key=$referer_key}">
                        {else}
                            <a class="mobile-list-text-grn mobile_list_table_grn" href="javascript:void(0)">
                        {/if}
                            <div class="mobile_list_table_td_grn">
                                <div class="mobile_list_lines_grn">
                                    <ul>
                                        <li>
                                            {if $event.unread eq true}
                                                <span class='mobile_list_icon_unread_grn'></span>
                                            {/if}
                                            {if !$event.allday}
                                               <span class="mobile_list_users_grn">
                                                   {*grn_date_format date=$event.start_date page='mobile_schedule_groupview'}-{grn_date_format date=$event.end_date page='mobile_schedule_groupview'*}
                                                   {$event.time_schedule|grn_noescape}
                                               </span>
                                            {else}
                                             <span class="mobile_list_users_grn">
                                                {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-81' replace='true'}
                                            </span>
                                             {/if}
                                        </li>
                                        <li>
                                        {if $event.type eq 'share_temporary' || $event.type eq 'temporary'}
                                            {* is share_repeat OR share AND is_private then mobile_list_textposition_2icon_grn *}
                                            {* is share_repeat OR share type OR is_private then mobile_list_textposition_1icon_grn *}
                                            {if $event.is_private && ($event.type == 'share_repeat' || $event.type == 'repeat')}
                                                <span class="mobile_list_content_grn mobile_tentative_text_grn mobile_list_textposition_2icon_grn">
                                            {elseif !$event.private && ($event.is_private || $event.type == 'share_repeat' || $event.type == 'repeat')}
                                                <span class="mobile_list_content_grn mobile_tentative_text_grn mobile_list_textposition_1icon_grn">
                                            {elseif !$event.private }
                                               <span class="mobile_list_content_grn mobile_tentative_text_grn ">
                                            {else}
                                               <span class="mobile_list_content_grn">{*private*}
                                            {/if}
                                            {if $event.conflict && !$event.private}
                                                <span class="mobile_list_icon_attentions_grn"></span>
                                            {/if}
                                        {else}
                                                {* is share_repeat OR share AND is_private then mobile_list_textposition_2icon_grn *}
                                                {* is share_repeat OR share type OR is_private then mobile_list_textposition_1icon_grn *}
                                            {if $event.is_private && ($event.type == 'share_repeat' || $event.type == 'repeat')}
                                                <span class="mobile_list_content_grn mobile_list_textposition_2icon_grn">
                                            {elseif !$event.private && ($event.is_private || $event.type == 'share_repeat' || $event.type == 'repeat')}
                                                <span class="mobile_list_content_grn mobile_list_textposition_1icon_grn">
                                            {else}
                                               <span class="mobile_list_content_grn">
                                            {/if}
                                            {if $event.conflict && !$event.private}
                                                <span class="mobile_list_icon_attentions_grn"></span>
                                            {/if}
                                       {/if}
                                               {*GTM-1631 Attendance check icons for mobile view*}
                                               {if !$event.private && $event.attendance_check_show}
                                                   <span class="mobile_list_icon_unanswered_grn"></span>
                                               {/if}
                                                    {*menu color *}
                                                {if !empty($event.event_menu_color) && !empty($event.event_menu)}
                                                    <span class="mobile_event_menu_grn mobile_event_menu_color{$event.event_menu_color}_grn">
                                                        {$event.event_menu|grn_noescape}
                                                    </span>
                                                {elseif !empty($event.event_menu)}
                                                    {$event.event_menu|grn_noescape}:
                                                {/if}{*end menu color*}

                                                {$event.event_detail|grn_noescape}
                                                </span>{*end of title event*}
                                                {if !$event.private && ($event.type == 'share_repeat' || $event.type == 'repeat')}
                                                    <span class="mobile_list_icon_repeatssub_grn mobile_list_iconposition_grn"></span>
                                                {/if}
                                                {if $event.is_private}
                                                    <span class="mobile_list_icon_privatessub_grn mobile_list_iconposition_grn"></span>
                                                {/if}

                                        </li>
                                        {if !$event.private && !empty($event.event_facility_name)}
                                        <li>
                                            <span class="mobile_list_subcontent_grn">{$event.event_facility_name}</span>
                                        </li>
                                        {else}
                                        <li>
                                            <span class="mobile_list_subcontent_grn">&nbsp;</span>
                                        </li>
                                        {/if}
                                    </ul>
                                </div>
                            </div>
                            {if !$event.private}
                            <span class="mobile_list_icon_arraylist_grn"></span>
                            {/if}
                        </a>
                    </li>
                {/foreach}
            {/if}
            {if $count_event eq 0 && $count_banner_event eq 0}

            <li data-icon="false" class="no-appointment">
                {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-78' replace='true'}
            </li>
            {/if}
        </ul>
    {/foreach}
    {* previous ,today, next *}
    <div class="mobile_schedule_week_menu_grn mobile_schedule_week_menu_creditTitle_grn">
        <a href="{grn_pageurl page=$page_info.all bdate=$bdate_prevweek uid=$user_id search_text=$search_text uids=$view_set.navi.params.uids fids=$vew_set.navi.params.fids}" class="mobile_left_array_grn"></a>
        <a href="{grn_pageurl page=$page_info.all bdate='' uid=$user_id search_text=$search_text uids=$view_set.navi.params.uids fids=$vew_set.navi.params.fids}" class="mobile_text_grn">
            {cb_msg module='grn.schedule' key='GRN_SCH-230' replace='true'}
        </a>
        <a href="{grn_pageurl page=$page_info.all bdate=$bdate_nextweek uid=$user_id  search_text=$search_text uids=$view_set.navi.params.uids fids=$vew_set.navi.params.fids}" class="mobile_right_array_grn"> </a>
        {grn_mobile_select_date id='date_select_footer' icon_only='true' icon_class='mobile_right_icon_grn' date=$bdate}{*datepicker*}
    </div>
    {* end previous ,today, next *}
    <input type="hidden" name="hfClearTbSearch" id="hfClearTbSearch" />
    <input type="hidden" name="hfPageLoad" id="hfPageLoad" />
</div><!-- end of content-->
{/strip}