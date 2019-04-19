{if !$data_theme}{assign var='data_theme' value='c'}{/if}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn">
    {include file="grn/mobile_breadcrumb.tpl" not_need_withList=true}
    <!-- GTM-1630 -->
    {if $is_attendance_check_view}
        <div class="mobile_schedulelist_menu_grn mobile_attendance_userListSwitch_grn">
            <div class="ui-grid-b">
                {if $tab_id eq 1}
                    <div class="ui-block-a"><span class="mobile_schedulelist_menuhover_grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-30' replace='true'}</span></div>
                    <div class="ui-block-b"><a href="{grn_pageurl page='schedule/mobile/attendee_list' event=$event_id bdate=$bdate uid=$user_id gid=$group_id referer_key=$referer_key tab_id=2}" class="ui-link">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-31' replace='true'}</a></div>
                    <div class="ui-block-c"><a href="{grn_pageurl page='schedule/mobile/attendee_list' event=$event_id bdate=$bdate uid=$user_id gid=$group_id referer_key=$referer_key tab_id=3}" class="ui-link">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-29' replace='true'}</a></div>
                {elseif $tab_id eq 2}
                    <div class="ui-block-a"><a href="{grn_pageurl page='schedule/mobile/attendee_list' event=$event_id bdate=$bdate uid=$user_id gid=$group_id referer_key=$referer_key tab_id=1}" class="ui-link">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-30' replace='true'}</a></div>
                    <div class="ui-block-b"><span class="mobile_schedulelist_menuhover_grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-31' replace='true'}</span></div>
                    <div class="ui-block-c"><a href="{grn_pageurl page='schedule/mobile/attendee_list' event=$event_id bdate=$bdate uid=$user_id gid=$group_id referer_key=$referer_key tab_id=3}" class="ui-link">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-29' replace='true'}</a></div>
                {elseif $tab_id eq 3}
                    <div class="ui-block-a"><a href="{grn_pageurl page='schedule/mobile/attendee_list' event=$event_id bdate=$bdate uid=$user_id gid=$group_id referer_key=$referer_key tab_id=1}" class="ui-link">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-30' replace='true'}</a></div>
                    <div class="ui-block-b"><a href="{grn_pageurl page='schedule/mobile/attendee_list' event=$event_id bdate=$bdate uid=$user_id gid=$group_id referer_key=$referer_key tab_id=2}" class="ui-link">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-31' replace='true'}</a></div>
                    <div class="ui-block-c"><span class="mobile_schedulelist_menuhover_grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-29' replace='true'}</span></div>
                {/if}
            </div>
        </div>
        <div class="mobile-title-member-grn">
            {if $tab_id eq 1}
                {cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-30' replace='true'}
            {elseif $tab_id eq 2}
                {cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-31' replace='true'}
            {elseif $tab_id eq 3}
                {cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-29' replace='true'}
            {/if}
            {cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-35' replace='true'}{$count}{cb_msg module='grn.mobile' key='GRN_MOBILE-1' replace='true'}
        </div>
    {else}
        <div class="mobile-title-member-grn">
            {if $isUserToBelong}
                {$list_title}{cb_msg module='grn.mobile' key='GRN_MOBILE-26' replace='true'}{$count}{cb_msg module='grn.mobile' key='GRN_MOBILE-27' replace='true'}
            {else}
                {$list_title}&nbsp;:&nbsp;{$count}{cb_msg module='grn.mobile' key='GRN_MOBILE-27' replace='true'}
            {/if}
        </div>
    {/if}

    <!-- End GTM-1630 -->
    <div class="mobile-padding-leftright-grn">
        <ul data-role="listview" data-theme="{$data_theme}" id="member_list" class="mobile-top-listview-member-grn mobile-bottom-listview-member-grn mobile_attendance_userListUl_grn">
            {include file='grn/mobile_member_list.tpl'}
        </ul>
        {include file='grn/mobile_list_more_view.tpl' request_page=$request_page list_id='member_list'}
    </div>
</div>
