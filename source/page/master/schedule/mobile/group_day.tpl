{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_css file="grn/html/mobile_list.css"}

{grn_load_javascript file="grn/html/component/mobile_autocomplete_user_facility.js"}
{grn_load_javascript file="grn/html/page/schedule/mobile/group_day.js"}

{assign var='count_user' value=$schedule.users|@count}{*compute result to show text contextual *}
{assign var='group_id_context' value=$group_id}
{assign var='search_text_context' value =$search_text}

{if $group_id eq 'search' && $count_user eq 0}
    {assign var='group_id_context' value =''}
    {assign var='search_text_context' value =''}
{/if}
{literal}
<script type="text/javascript">
    grn.Component.Autocomplete.AutocompleteUserFaci.Parameters = {
        'url':"{/literal}{grn_pageurl page='schedule/mobile/ajax/ajax_get_user_facility'}{literal}",
        'referer_key': "{/literal} {$referer_key}{literal}"};

    grn.Component.Autocomplete.AutocompleteUserFaci.Msg = {
        'place_holder': '{/literal}{$place_holder|escape|escape:javascript}{literal}',
        'search_text':  '{/literal}{$search_text_context|escape|escape:javascript}{literal}'
    };
    grn.page.schedule.mobile.group_day.Parameters = {
        'href': "{/literal}{grn_pageurl page='schedule/mobile/add'}{literal}",
        'referer_key': "{/literal}{$referer_key}{literal}",
        'bdate': "{/literal}{$bdate}{literal}",
        'selected_users_sUID': "{/literal}{$selected_users_sUID}{literal}",
        'sITEM': "{/literal}{$sITEM}{literal}",
        'uid': "{/literal}{$login_id}{literal}"
    }
</script>
{/literal}
{strip}
{assign var=navi value=$view_set.navi}
<!-- group day view-->
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-withList-grn">
    <div class="mobile_breadcrumbtitle_grn mobile_titlebar_content_withList_grn">
        <div class="mobile_breadcrumbtitle_right_grn">
            <span class="mobile_icon_breadcrumb_grn mobile_app_schedule_s_b_grn"></span>
            {$page_title}
        </div>
    </div>
    <!--end title-bar-->
    {*Begin switch command group day => personal week *}
    <div class="mobile_schedule_week_header_grn">
        <div class="mobile_left_grn mobile_unselected_grn">
            <a href="{grn_pageurl page='schedule/mobile/personal_week' event=$event_id bdate=$bdate uid=$user_id
            gid='' search_text=''}" >
                {cb_msg module='grn.schedule' key='GRN_SCH-982' replace='true'}
            </a>
        </div>
        <div class="mobile_right_grn mobile_selected_grn">
            <span>{cb_msg module='grn.schedule' key='GRN_SCH-660' replace='true'}</span>
        </div>
        <a href="javascript:void(0);" id="icon_search_grn" class="mobile_schedulelist_icon_search_grn"></a>

    </div>
    {*search part*}
    {include file="schedule/mobile/mobile_search_header.tpl"}
    {*end search part*}

    {*end week header*}
    <div class="mobile_schedule_day_header_grn">
        <div class="mobile_switch_button_grn">
            <div class="mobile_left_grn mobile_selected_grn mobile_img_user_on_grn"></div>
            <a href="#" class="mobile_right_grn mobile_unselected_grn mobile_img_facility_off_grn"></a>
        </div>
        {*switch command*}

        <div class="mobile_select_control_grn" >
            <div data-role="fieldcontain" class="mobile_select_grn" >
                <div class="ui-select">
                    <a id="user_category_{$sUID}" href="#popup_user_category_{$sUID}" data-rel="popup" data-transition="pop" data-shadow="true" data-wrapperels="span" class="mobile_select_view_grn">
                        <span class="mobile_event_menu_content_grn">{$default_group_name}</span>
                        <span class="mobile_select_icon_grn"></span>
                    </a>
                    <a class="ui-link-inherit" href="#_group_select">
                        <div class="mobile_group_icon_grn"></div>
                    </a>
                    <input type="hidden" value="{$group_id}" id="hf_user_facility_selected_{$sUID}" />
                    <input type="hidden" value="{$group_id}" id="hf_user_facility_title_{$sUID}" />
                    {capture name="GRN_MOBILE_22"}{cb_msg module="grn.mobile" key="GRN_MOBILE-22" replace='true'}{/capture}
                    {include file="grn/mobile_select_menu.tpl"
                    select_items=$group
                    selectMenuUI='user_category_'|cat:$sUID
                    selectMenuValue='hf_user_facility_selected_'|cat:$sUID
                    popupMenu='popup_user_category_'|cat:$sUID previous_page='_'|cat:$sUID
                    name_value = 'id'
                    name_title = 'name'
                    selected_value = $group_id_focus
                    expandMenuSelect='hf_user_facility_title_'|cat:$sUID
                    selectMenuTitle=$smarty.capture.GRN_MOBILE_22
                    }
                </div>
            </div>
        </div>
        <a href="#_popup_{$user_categories_tree.tree_name}" class="mobile_schedulelist_icon_organization_grn"></a>
    </div>
    {*end dropdown menu*}
    {* previous ,today, next *}
    <div class="mobile_schedule_week_menu_grn">
        <a href="{grn_pageurl
        page=$page_info.all
        bdate=$bdate_prevday
        uid=$user_id
        gid=$group_id_context
        event=$navi.params.event
        event_date=$navi.params.event_date
        sp=$view_set.offset
        search_text=$search_text_context
        uids=$navi.params.uids
        fids=$navi.params.fids
        }" class="mobile_left_array_grn"></a>

        <a href="{grn_pageurl
        page=$page_info.all
        bdate=''
        uid=$user_id
        gid=$group_id_context
        event=$navi.params.event
        event_date=$navi.params.event_date
        sp=$view_set.offset
        search_text=$search_text_context
        uids=$navi.params.uids
        fids=$navi.params.fids
        }" class="mobile_text_grn">
            {cb_msg module='grn.schedule' key='GRN_SCH-230' replace='true'}
        </a>
        <a href="{grn_pageurl
        page=$page_info.all
        bdate=$bdate_nextday
        uid=$user_id
        gid=$group_id_context
        event=$navi.params.event
        event_date=$navi.params.event_date
        sp=$view_set.offset
        search_text=$search_text_context
        uids=$navi.params.uids
        fids=$navi.params.fids
        }" class="mobile_right_array_grn"> </a>
        {grn_mobile_select_date id='start' icon_only='true' icon_class='mobile_right_icon_grn' date=$bdate}{*datepicker*}

    </div>
    {*end*}
    <div class="mobile_week_day_title_grn">
        {assign var='style_of_day' value=$date_type|substr:7 }
        {if $style_of_day eq 'sunday'}
            {assign var='style_of_day' value='holiday'}
        {/if}

        <div class="mobile_week_date_grn mobile_week_{$style_of_day}_grn">{grn_date_format date=$bdate format="DateFull_YMDW"}</div>
        <div class="mobile_right_text_grn">
            <div class="mobile_holiday_table_grn">
                {foreach name=schedule1 from=$schedule.users item=schedule1}
                    {if $schedule1.schedule_event.calendar}
                        {foreach from=$schedule1.schedule_event.calendar item=calendar}
                            <div>
                                {*grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon class='group_day_calendar_event_item'*}
                                {$calendar.data}
                            </div>
                        {/foreach}
                    {/if}
                {/foreach}
            </div>
        </div>
    </div>


    {if $count_user  gt 0}
        {foreach name=schedule from=$schedule.users key=num item=schedule}
                <!-- loop each user-->
            {if $num neq 0}
                <div class="mobile_schedule_subtitle_space_grn"></div>
            {/if}
            <div class="mobile_schedule_day_subtitle_grn">
                {assign var='uid' value=$schedule.user_id}
                {if $schedule.facility_id}
                    <div class="mobile_icon_grn mobile_img_facilityPlofile_grn"></div>
                    <div class="mobile_title_grn">
                        {$schedule.facility_title}
                    </div>
                {else}
                    {capture name="prefix"}{$uid|substr:0:1}{/capture}
                        {*this is a user*}
                    {if $smarty.capture.prefix != 'g'}
                        {if !empty($users_info[$uid].col_valid)}
                            <div class="mobile_icon_grn mobile_img_userInvalidPlofile_grn">
                        {elseif $uid eq $login_id}
                            <div class="mobile_icon_grn mobile_img_userLoginPlofile_grn">
                        {else}
                            <div class="mobile_icon_grn mobile_img_userPlofile_grn">
                        {/if}
                            </div>
                        {*end of img*}
                        <div class="mobile_title_grn">
                            {grn_user_name uid=$uid users_info=$users_info mobi_display_user_group=1 only_text=1}
                        </div>
                        <div class="mobile_subtitle_grn">
                            {$users_info[$uid].primary_group.col_name|escape}
                       </div>
                    {else}
                        <div class="mobile_icon_grn mobile_img_cal_group_profile_grn"></div>
                        <div class="mobile_title_grn">
                            {grn_schedule_member_name id=$schedule.user_id groups_info=$groups_info referer_key=$referer_key noimage=1}
                        </div>
                    {/if}
                {/if}
                {if $schedule.access.add}
                    <a href="{grn_pageurl page='schedule/mobile/add' uid=$uid bdate=$bdate referer_key=$referer_key}" class="mobile_icon_add_grn"></a>
                {/if}
                <a data-answer="{$uid}" er href="javascript:void(0);" class="mobile_icon_week_grn"></a>
            </div>
        {if $show_todos eq true}
            {include file="schedule/mobile/mobile_todo_group_day.tpl" event=$schedule.schedule_event}
        {/if}

            {assign var='count_banner_event' value=$schedule.banner_event|@count}
            {assign var='count_event' value=$schedule.schedule_event.event|@count}
            <!-- banner event-->

            <ul data-role="listview" data-theme="{$data_theme}" class="mobile_schedule_ul_grn mobile-ul-top-grn mobile-ul-bottom-grn mobile_list_normal_padding_grn">
                {foreach from=$schedule.banner_event item=banner_event}
                    <li data-icon="false">
                        <a class="mobile-list-text-grn mobile_list_table_grn" href="{grn_pageurl page='schedule/mobile/view' event=$banner_event.id bdate=$bdate uid=$schedule.user_id gid=$group_id referer_key=$referer_key}">
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
                                            <span class="mobile_list_subcontent_grn">{*banner not use facility*}&nbsp;</span>
                                        </li>
                                    </ul>
                                </div>
                            </div><!--table-cell-->
                            <span class="mobile_list_icon_arraylist_grn"></span>
                        </a>
                    </li>
                {/foreach}
                {if $count_banner_event gt 0 && $count_event lte 0}
                <li data-icon="false" style="height: 0;padding: 0"></li>{*created under line in for last event*}
                {/if}
            </ul>
            <!--end-->

            <ul data-role="listview" data-theme="{$data_theme}" class="mobile_schedule_ul_grn mobile-ul-top-grn mobile-ul-bottom-grn mobile_list_normal_padding_grn">
                {foreach from=$schedule.schedule_event.event item=event}
                <li data-icon="false">
                   {if !$event.private}
                        <a class="mobile-list-text-grn mobile_list_table_grn" href="{grn_pageurl page='schedule/mobile/view' event=$event.id bdate=$bdate uid=$schedule.user_id gid=$group_id referer_key=$referer_key}">
                   {else}
                        <a class="mobile-list-text-grn mobile_list_table_grn" href="javascript:void(0)">
                   {/if}
                        <div class="mobile_list_table_td_grn">
                               <div class="mobile_list_lines_grn">
                                   <ul>
                                       {if !$event.allday}
                                           <li>
                                               {if $event.unread eq true}
                                               <span class='mobile_list_icon_unread_grn'></span>
                                               {/if}
                                               <span class="mobile_list_users_grn">
                                                   {$event.time_schedule|grn_noescape}
                                               </span>
                                           </li>
                                       {else}
                                           <li>
                                               {if $event.unread eq true}
                                                    <span class='mobile_list_icon_unread_grn'></span>
                                               {/if}
                                                <span class="mobile_list_users_grn">
                                                    {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-81' replace='true'}
                                                </span>
                                           </li>
                                       {/if}
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

                                                {*GTM-1631 Attendance check logic for mobile*}
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
            </ul>
            {if $count_event eq 0 && $count_banner_event eq 0}
                <ul data-role="listview" data-theme="{$data_theme}" class="mobile_schedule_ul_grn mobile-ul-top-grn mobile-ul-bottom-grn mobile_list_normal_padding_grn mobile_no_appointment_ul_grn">
                    <li data-icon="false">
                       {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-78' replace='true'}
                    </li>
                </ul>
            {/if}
        {/foreach}
        {*end loop each user*}


        {if $navi.page}
            {assign var=page value=$navi.page}
        {else}
            {assign var=page value=$page_info.all}
        {/if}
        {* previous ,today, next *}
        <div class="mobile_schedule_week_menu_grn mobile_schedule_week_menu_bottom_grn">
                <a href="{grn_pageurl
                page=$page_info.all
                bdate=$bdate_prevday
                uid=$user_id
                gid=$group_id_context
                event=$navi.params.event
                event_date=$navi.params.event_date
                sp=$view_set.offset
                search_text=$search_text_context
                uids=$navi.params.uids
                fids=$navi.params.fids
                }" class="mobile_left_array_grn"></a>

                <a href="{grn_pageurl
                page=$page_info.all
                bdate=''
                uid=$user_id
                gid=$group_id_context
                event=$navi.params.event
                event_date=$navi.params.event_date
                sp=$view_set.offset
                search_text=$search_text_context
                uids=$navi.params.uids
                fids=$navi.params.fids
                }" class="mobile_text_grn">{cb_msg module='grn.schedule' key='GRN_SCH-230' replace='true'}</a>

                <a href="{grn_pageurl
                page=$page_info.all
                bdate=$bdate_nextday
                uid=$user_id
                gid=$group_id_context
                event=$navi.params.event
                event_date=$navi.params.event_date
                sp=$view_set.offset
                search_text=$search_text_context
                uids=$navi.params.uids
                fids=$navi.params.fids
                }" class="mobile_right_array_grn"> </a>
                    {grn_mobile_select_date id='date_select_footer' icon_only='true' icon_class='mobile_right_icon_grn'
                    date=$bdate}{*datepicker*}

        </div>
                        {*end*}
        <div class="mobile_paging_grn">
            {if $navi.previous_page_start_position != -1}
            <a class="mobile_back_first_grn" href="{grn_pageurl page=$page sp=0 params=$navi.params search_text=$search_text_context}"></a>
            {else}
            <a href="javascript:void(0);" class="mobile_back_first_grn mobile_base_disable_grn "></a>
            {/if}
            {if $navi.previous_page_start_position != -1}
            <a class="mobile_back_grn" href="{grn_pageurl page=$page sp=$navi.previous_page_start_position params=$navi.params search_text=$search_text_context }" ></a>
            {else}
            <a href="javascript:void(0);" class="mobile_back_grn mobile_base_disable_grn "></a>
            {/if}
            {if $navi.next_page_start_position != -1}
            <a class="mobile_advance_grn" href="{grn_pageurl page=$page sp=$navi.next_page_start_position params=$navi.params search_text=$search_text_context }" ></a>
            {else}
            <a href="javascript:void(0);" class="mobile_advance_grn mobile_base_disable_grn "></a>
            {/if}
            <span class="mobile_page_text_grn">{$view_set.start_count}-{$view_set.end_count}</span>
        </div>
    {elseif $group_id eq 'search'}{*display message there are no user match*}
        <div class="mobile_balloon_grn">{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-79' replace='true'}</div>
        <div class="mobile_balloon_down_grn"><div class="mobile_triangle_grn"></div></div>
        <div class="mobile_balloon_icon_grn"><div class="mobile_search_b_grn"></div></div>
    {/if}
        <input type="hidden" name="bdate" value="{$bdate|escape}" />
        <input type="hidden" name="hfClearTbSearch" id="hfClearTbSearch" />
        <input type="hidden" name="hfPageLoad" id="hfPageLoad" />

</div>
{include file="grn/mobile_footer_for_multipage.tpl"}
{/strip}

                {if $page_user}
                {include file='grn/mobile_group_select.tpl'
                group_tree=$user_categories_tree
                radio_name='user_facility_group_select'
                associate_value_element_back='hf_user_facility_selected_'|cat:$sUID
                associate_title_element_back='hf_user_facility_title_'|cat:$sUID
                user=true
                need_margin=true
                }
                {else}
                {include file='grn/mobile_group_select.tpl'
                group_tree=$user_categories_tree
                radio_name='user_facility_group_select'
                associate_value_element_back='hf_user_facility_selected_'|cat:$sUID
                associate_title_element_back='hf_user_facility_title_'|cat:$sUID
                need_margin=true
                facility=true
                }
                {/if}
