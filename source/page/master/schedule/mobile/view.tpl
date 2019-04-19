{if $kintone_available}{grn_load_javascript file="grn/html/page/schedule/mobile/kintone_relation.js"}{/if}
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var='schedule_prefix' value='schedule/mobile'}
{if ! $file_dpage}{assign var='file_dpage' value='schedule/mobile/file_download'}{/if}
{literal}
<script language="JavaScript" text="text/javascript">
(function(){{/literal}
    var GS = grn.component.mobile_common;
    GS.comment_add_url = '{grn_pageurl page=$schedule_prefix|cat:"/comment_add"}';
    GS.add_comment_args = {ldelim}'event' : '{$event_id}', 'bdate' : '{$bdate}', 'uid' : '{$user_id}', 'gid' : '{$group_id}', 'referer_key' : '{$referer_key}'{rdelim};
{literal}
})();
</script>
{/literal}
{if $is_same_day}
{assign var='string_format_datetime' value='TimeShort_HM'}
{else}
{assign var='string_format_datetime' value='DateTimeLong_YMDW_HM'}
{/if}

<!--GTM-1684-->
{grn_load_javascript file="grn/html/page/schedule/mobile/view.js"}

<div data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn">
  <!-- breadcrumb -->
  {include file="grn/mobile_breadcrumb.tpl" not_need_withList=true}
  
  <!-- GTM-1630 attendance confirmation -->
  {if $attendance_status.unconfirmed}
  <form name="confirm_attendance" id="confirm_attendance" method="post" action="{grn_pageurl page=$schedule_prefix|cat:'/command_confirm_attendance'}">
  <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <input type="hidden" name="event" value="{$schedule_event.event_id|escape}">
  <input type="hidden" name="bdate" value="{$bdate|escape}">
  <input type="hidden" name="uid" value="{$user_id|escape}">
  <input type="hidden" name="gid" value="{$group_id|escape}">
  <input type="hidden" name="referer_key" value="{$referer_key|escape}">
  <input type="hidden" name="attendance_status" id="attendance_status" value="">
  
  <div class="mobile_div_attendance_grn">
    <div class="mobile_box_area_grn">
        <div class="mobile_box_message_attention_grn"><span class="mobile_icon_information_grn"></span>{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-22' replace='true'}</div>
        <div class="mobile-div-title-grn">
          <textarea id="comment_data" name="comment_data" class="mobile-textarea-auto-short-grn" wrap="virtual" cols="50" rows="50" placeholder="{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-23' replace='true'}"></textarea>
        </div>
        {if $conflict}
        <div class="mobile-list-todoDetail-grn mobile_schedule_information_alert_grn">
          <span class="mobile_iconposition_attentions_grn mobile_icon_attentions_grn"></span>
          <span class="mobile_text_information_grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-26' replace='true'}</span>
        </div>
        {/if}
        <div class="mobile-buttonArea-grn mobile_button_sub_width_grn">
          <div class="mobile-buttonMain-grn mobile-button-left-grn">
            <input type="submit" name="btn_attend" id="btn_attend" class="btn_confirm" value="{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-24' replace='true'}" data-inline="true" data-theme="{$data_theme}" />
          </div>
          <div class="mobile-buttonNormal-grn mobile-button-right-grn">
            <input type="submit" name="btn_absent" id="btn_absent" class="btn_confirm" value="{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-25' replace='true'}" data-inline="true"  data-theme="{$data_theme}"/>
          </div>
        </div>
    </div><!--end of mobile_box_area_grn-->  
  </div><!-- end of mobile-div-attendance-grn-->
  </form>
  {/if}
  <!-- End GTM-1630 attendance confirmation -->
  <!-- title -->
  <ul data-role="none" class="mobile-ul-withStar-grn mobile-textspace-withStar-grn mobile-detailTitle-grn">
    <li>
      {if $use_star}
        {include file="grn/mobile_star_init.tpl"}
        {capture name="star_event_id"}{if $schedule_event.type eq 'repeat' || $schedule_event.type eq 'share_repeat'}rp_{$schedule_event.event_id}_{$bdate}{else}{$schedule_event.event_id}{/if}{/capture}
        {grn_mobile_star_icon module="grn.schedule" star_infos=$star_infos unique_id=$smarty.capture.star_event_id event=$schedule_event.event_id bdate=$bdate}
      {/if}
      <span>
        {if $schedule_event.event_menu && $schedule_event.event_menu_color neq 0}
        <span class="mobile_event_menu_grn mobile_event_menu_color{$schedule_event.event_menu_color}_grn">{$schedule_event.event_menu}</span>
        {$schedule_event.event_detail}
        {else}
        {$schedule_event.title}
        {/if}
        {if $schedule_event.is_private}
        <span class="mobile_private_title_grn">（<span class="mobile_list_icon_privatessub_grn"></span>{cb_msg module='grn.schedule' key='GRN_SCH-394' replace='true'}）</span>
        {/if}
      </span>
    </li>
  </ul>
  <!-- content -->
  <div class="mobile-list-login-grn mobile-cmt-operate-grn mobile-todoBodyText-grn">
    <div class="mobile-separation-grn"></div>
    <!-- datetime -->
    <!-- banner -->
    {if $schedule_event.type == 'banner' || $schedule_event.type == 'share_banner'}
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-922' replace='true'}</div>
      <div class="mobile_contents_detail_grn">
      {strip}
        {if $is_same_day}
            {grn_date_format date=$schedule_event.start_date format="DateLong_YMDW"}<br/>
            {grn_date_format date=$schedule_event.start_date format="TimeLong_HM"}&nbsp;
            <span>{cb_msg module='grn.schedule' key='GRN_SCH-264' replace='true'}</span>&nbsp;
            {grn_date_format date=$schedule_event.end_date format=$string_format_datetime}
        {else}
            <span class="mobile_detail_datetime_grn">{grn_date_format date=$schedule_event.start_date format="DateLong_YMDW"}&nbsp;
            {grn_date_format date=$schedule_event.start_date format="TimeLong_HM"}&nbsp;
            <span>{cb_msg module='grn.schedule' key='GRN_SCH-264' replace='true'}</span></span><br/>
            {grn_date_format date=$schedule_event.end_date format=$string_format_datetime}
        {/if}
      {/strip}
      </div>
    </div>

    <!-- repeat -->
    {elseif $schedule_event.type == 'repeat' || $schedule_event.type == 'share_repeat'}
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-265' replace='true'}</div>
      <div class="mobile_contents_detail_grn">
      {strip}
        {if $is_same_day}
            {if $schedule_event.start_time}
                {grn_date_format date=$schedule_event.start_time format="DateLong_YMDW"}<br/>
                {grn_date_format date=$schedule_event.start_time format="TimeLong_HM"}
            {/if}
            {if $schedule_event.end_time}
                &nbsp;<span>{cb_msg module='grn.schedule' key='GRN_SCH-266' replace='true'}</span>
                &nbsp;{grn_date_format date=$schedule_event.end_time format=$string_format_datetime}
            {/if}
        {else}
            {if $schedule_event.start_time}
                <span class="mobile_detail_datetime_grn">{grn_date_format date=$schedule_event.start_time format="DateLong_YMDW"}&nbsp;{grn_date_format date=$schedule_event.start_time format="TimeLong_HM"}
            {/if}
            {if $schedule_event.end_time}
                &nbsp;<span>{cb_msg module='grn.schedule' key='GRN_SCH-266' replace='true'}</span></span><br/>
                {grn_date_format date=$schedule_event.end_time format=$string_format_datetime}
            {else}
                </span>
            {/if}
        {/if}
      {/strip}
      </div>
    </div>
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-268' replace='true'}</div>
      <div class="mobile_contents_detail_grn">
      {strip}
        {$schedule_event.repeat_data}<br/>
        {if $schedule_event.start_date}
            {grn_date_format date=$schedule_event.start_date format="DateLong_YMDW"}
        {/if}
        {if $schedule_event.end_date}
            &nbsp;<span>{cb_msg module='grn.schedule' key='GRN_SCH-269' replace='true'}</span><br/>
            {grn_date_format date=$schedule_event.end_date format="DateLong_YMDW"}
        {/if}
      {/strip}
      </div>
    </div>
    {if $schedule_event.last_repeat_event}
    <div class="mobile_schedule_alert_grn">
      <span class="mobile_icon_information_grn"></span>
      <span class="mobile_text_information_grn">{cb_msg module='grn.schedule' key='GRN_SCH-270' replace='true'}</span>
    </div>
    {/if}

    <!-- temporary -->
    {elseif $schedule_event.type == 'temporary' || $schedule_event.type == 'share_temporary'}
    <div class="mobile_tentative_list_grn">
    <form name="temporary" id="temporary" method="post" action="{grn_pageurl page=$schedule_prefix|cat:'/command_temporary'}">
      <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
      <input type="hidden" name="event" value="{$schedule_event.event_id|escape}">
      <input type="hidden" name="bdate" value="{$bdate|escape}">
      <input type="hidden" name="uid" value="{$user_id|escape}">
      <input type="hidden" name="gid" value="{$group_id|escape}">
      <input type="hidden" name="referer_key" value="{$referer_key|escape}">
      <input type="hidden" name="did" value="">
      {literal}
      <script language="JavaScript" type="text/javascript">
      <!--
      function temporary_submit(did)
      {
        var temporary_form = document.getElementById('temporary');
        temporary_form.did.value = did;
        temporary_form.submit();
      }
      //-->
      </script>
      {/literal}

      <div class="mobile_label_grn">{cb_msg module='grn.schedule' key='GRN_SCH-271' replace='true'}</div>
      {if $schedule_event.temporary_type == 'or'}
        {foreach from=$schedule_event.temporary item=facility_data}
          <strong>{$facility_data.facility_name|escape}</strong>
          {foreach from=$facility_data.dates item=temporary}
            {if ($temporary.setdatetime->year == $temporary.enddatetime->year) && ($temporary.setdatetime->month == $temporary.enddatetime->month) && ($temporary.setdatetime->day == $temporary.enddatetime->day) }
                {strip}
                <div class="mobile_date_grn">
                    {grn_date_format date=$temporary.setdatetime format="DateLong_YMDW"}
                </div>
                <div class="mobile_time_grn">
                    {grn_date_format date=$temporary.setdatetime format="TimeLong_HM"}&nbsp;
                    <span>{cb_msg module='grn.schedule' key='GRN_SCH-273' replace='true'}</span>&nbsp;
                    {grn_date_format date=$temporary.enddatetime format=$temporary.string_datetime}
                </div>
                {/strip}
            {else}
                {strip}
                <div class="mobile_date_grn">
                    <span class="mobile_detail_datetime_grn">{grn_date_format date=$temporary.setdatetime format="DateLong_YMDW"}&nbsp;
                    {grn_date_format date=$temporary.setdatetime format="TimeLong_HM"}&nbsp;
                    <span>{cb_msg module='grn.schedule' key='GRN_SCH-273' replace='true'}</span></span>
                </div>
                <div class="mobile_time_grn">
                    {grn_date_format date=$temporary.enddatetime format=$temporary.string_datetime}
                </div>
                {/strip}
            {/if}
            {if $schedule_event.access.determine}
              <a class="mobile_btn_grn" href="javascript:void(0)" onclick="temporary_submit({$temporary.temporary_id})">{cb_msg module='grn.schedule' key='GRN_SCH-274' replace='true'}</a>
            {/if}
          {/foreach}
          <br/>
        {/foreach}
      {else}
        {foreach from=$schedule_event.temporary item=temporary}
          {if ($temporary.setdatetime->year == $temporary.enddatetime->year) && ($temporary.setdatetime->month == $temporary.enddatetime->month) && ($temporary.setdatetime->day == $temporary.enddatetime->day) }
              {strip}
              <div class="mobile_date_grn">
                {grn_date_format date=$temporary.setdatetime format="DateLong_YMDW"}
              </div>
              <div class="mobile_time_grn">
                {grn_date_format date=$temporary.setdatetime format="TimeLong_HM"}&nbsp;
                <span>{cb_msg module='grn.schedule' key='GRN_SCH-276' replace='true'}</span>&nbsp;
                {grn_date_format date=$temporary.enddatetime format=$temporary.string_datetime}
              </div>
              {/strip}
          {else}
              {strip}
              <div class="mobile_date_grn">
                <span class="mobile_detail_datetime_grn">{grn_date_format date=$temporary.setdatetime format="DateLong_YMDW"}&nbsp;
                {grn_date_format date=$temporary.setdatetime format="TimeLong_HM"}&nbsp;
                <span>{cb_msg module='grn.schedule' key='GRN_SCH-276' replace='true'}</span></span>
              </div>
              <div class="mobile_time_grn">
                {grn_date_format date=$temporary.enddatetime format=$temporary.string_datetime}
              </div>
              {/strip}
          {/if}
          {if $schedule_event.access.determine}
            <a class="mobile_btn_grn" href="javascript:void(0)" onclick="temporary_submit({$temporary.temporary_id})">{cb_msg module='grn.schedule' key='GRN_SCH-277' replace='true'}</a>
          {/if}
        {/foreach}
      {/if}
    </form>
    </div>

    <!-- normal -->
    {else}
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-278' replace='true'}</div>
      <div class="mobile_contents_detail_grn">
      {strip}
        {if $schedule_event.allday}
            {if $is_same_day}
                {grn_date_format date=$schedule_event.start_date format="DateLong_YMDW"}<br/>
                {grn_date_format date=$schedule_event.start_date format="TimeLong_HM"}&nbsp;
                <span>{cb_msg module='grn.schedule' key='GRN_SCH-279' replace='true'}</span>&nbsp;
                {grn_date_format date=$schedule_event.end_date format=$string_format_datetime}
                <span class="mobile_detail_datetime_grn">{cb_msg module='grn.schedule' key='GRN_SCH-280' replace='true'}</span>
            {else}
                <span class="mobile_detail_datetime_grn">{grn_date_format date=$schedule_event.start_date format="DateLong_YMDW"}&nbsp;
                {grn_date_format date=$schedule_event.start_date format="TimeLong_HM"}&nbsp;
                <span>{cb_msg module='grn.schedule' key='GRN_SCH-279' replace='true'}</span></span><br/>
                {grn_date_format date=$schedule_event.end_date format=$string_format_datetime}
                <span class="mobile_detail_datetime_grn">{cb_msg module='grn.schedule' key='GRN_SCH-280' replace='true'}</span>
            {/if}
        {else}
            {if $is_same_day}
                {grn_date_format date=$schedule_event.start_date format="DateLong_YMDW"}
                {if $schedule_event.end_date}
                    <br/>
                    {grn_date_format date=$schedule_event.start_date format="TimeLong_HM"}&nbsp;
                    <span>{cb_msg module='grn.schedule' key='GRN_SCH-281' replace='true'}</span>&nbsp;
                    {grn_date_format date=$schedule_event.end_date format=$string_format_datetime}
                {else}
                    &nbsp;{grn_date_format date=$schedule_event.start_date format="TimeLong_HM"}
                {/if}
            {else}
                <span class="mobile_detail_datetime_grn">{grn_date_format date=$schedule_event.start_date format="DateLong_YMDW"}&nbsp;
                {if $schedule_event.end_date}
                    {grn_date_format date=$schedule_event.start_date format="TimeLong_HM"}&nbsp;
                    <span>{cb_msg module='grn.schedule' key='GRN_SCH-281' replace='true'}</span></span><br/>
                    {grn_date_format date=$schedule_event.end_date format=$string_format_datetime}
                {else}
                    {grn_date_format date=$schedule_event.start_date format="TimeLong_HM"}</span>
                {/if}
            {/if}
        {/if}
      {/strip}
      </div>
    </div>
    {/if}

    <!-- company info -->
    {if $schedule_event.address}
    <div class="mobile_company_info_grn">
     <div class="mobile_label_grn">{cb_msg module='grn.schedule' key='GRN_SCH-283' replace='true'}</div>
     <div class="mobile-list-todoDetail-grn">
       <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-284' replace='true'}</div>
       <div class="mobile_contents_detail_grn">{$schedule_event.address.company_name|escape}</div>
     </div>
     <div class="mobile-list-todoDetail-grn">
       <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-285' replace='true'}</div>
       <div class="mobile_contents_detail_grn">{$schedule_event.address.zip_code|escape}</div>
     </div>
     <div class="mobile-list-todoDetail-grn">
       <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-286' replace='true'}</div>
       <div class="mobile_contents_detail_grn"><a href="https://maps.google.com/?q={$schedule_event.address.physical_address|escape}">{$schedule_event.address.physical_address|escape}</a></div>
     </div>
     <div class="mobile-list-todoDetail-grn">
       <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-290' replace='true'}</div>
       <div class="mobile_contents_detail_grn">{$schedule_event.address.route|escape}<br>{$schedule_event.address.route_time|escape}&nbsp;{cb_msg module='grn.schedule' key='GRN_SCH-291' replace='true'}<br>{$schedule_event.address.route_fare|escape}&nbsp;{cb_msg module='grn.schedule' key='GRN_SCH-292' replace='true'}</div>
     </div>
     <div class="mobile-list-todoDetail-grn">
       <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-293' replace='true'}</div>
       <div class="mobile_contents_detail_grn">{$schedule_event.address.company_telephone_number|escape}</div>
     </div>
    </div>
    {/if}

    <!-- kintone infor-->
    {if $schedule_event.type eq "normal" || $schedule_event.type eq "share"}
    {if $kintone_available}
        <script language="JavaScript" text="text/javascript">
            jQuery(function(){literal}{{/literal}
                var __kintoneRelation = grn.page.schedule.mobile.kintoneRelation;
                {foreach from=$kintone_error_resource key=key item=value}
                    __kintoneRelation.setResource("{$key|escape}","{$value|escape}");
                {/foreach}
                {foreach from=$kintone_records key=key item=value}
                {if $value.record_id && $value.app_id && $value.field_code|@count > 0}
                __kintoneRelation.getRecordForView('{$value.item_id}','{$value.app_id}','{$value.record_id}',[{foreach from=$value.field_code name=f_name key=f_key item=item }{if $smarty.foreach.f_name.first}"{$item}"{else}, "{$item}"{/if}{/foreach}]);
                {/if}
                {/foreach}
                {literal}}{/literal});
        </script>
        {foreach from=$kintone_records key=key item=value}
            <div class="mobile-separation-grn"></div>
            <div class="mobile-list-todoDetail-grn">
                <div class="mobile-label-small-grn">{$value.item_name|escape}</div>
                <div class="mobile_detail_sub_grn" id="k_record_content_{$value.item_id}">
                </div>
            </div>
        {/foreach}
    {/if}
    {/if}

    <!-- facilitities, attendees, private_users -->
    <!-- GTM-1684 -->
    {if $schedule_event.facilities_count gt 0}
        {if !empty($facilityApprovalData.history)}
            {assign var='mobile_facility_process_history_class' value='mobile_facility_process_history_grn'}
        {else}
            {assign var='mobile_facility_process_history_class' value='mobile_facility_process_noHistory_grn'}
        {/if}
        <ul data-role="listview" data-theme="{$data_theme}" class="mobile-li-PersonInCharge-grn mobile-div-title-grn {$mobile_facility_process_history_class}">
            <div class="mobile-separation-grn"></div>
            <li data-icon="false">
                <a href="{grn_pageurl page=$schedule_prefix|cat:'/facility_list' event=$event_id bdate=$bdate uid=$user_id gid=$group_id referer_key=$referer_key}">
                    <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-294' replace='true'}</div>
                    <div class="mobile_for_totalnumber_grn">
                        {foreach from=$schedule_event.facilities_name key=facilityId item=facilities_name}
                            <div class="mobile-font-warp-grn">
                                {$facilities_name|escape}
                                <span class="mobile-label-small-grn">
                                    {$facilityApprovalData.currentStatus[$facilityId].textEnclosed}
                                </span>
                            </div>
                        {/foreach}
                    </div>
                    <!--mobile_for_totalnumber_grn-->
                    <span class="totalNumber-grn">{$schedule_event.facilities_count}</span>
                    <span class="mobile-array-todo-grn"></span>
                </a>
            </li>
            <!--facilities approval history link-->
            {if !empty($facilityApprovalData.history)}
                <div id="facility_approval_history_link">
                    <a href="#" class="mobile_process_history_link_grn mobile_switch_link_grn ui-link">
                        {if $facilityApprovalData.isExpandedHistory}
                            {assign var='link_icon_class' value='mobile_arrow_inline_up_grn'}
                        {else}
                            {assign var='link_icon_class' value='mobile_arrow_inline_down_grn'}
                        {/if}
                        <span id="facility_approval_history_link_icon" class="{$link_icon_class}"></span><span>{cb_msg module='grn.schedule' key='GRN_SCH-1038' replace='true'}</span>
                    </a>
                </div>
            {/if}
        </ul>
        {if !empty($facilityApprovalData.history)}
            <ul id="facility_approval_history_list" data-role="listview" data-theme="{$data_theme}"
                class="mobile-ul-top-grn mobile-ul-bottom-grn mobile_process_history_detail_grn"
                    {if !$facilityApprovalData.isExpandedHistory} style="display: none;" {/if}>
                {foreach from=$facilityApprovalData.history item=facilitiesHistory}
                    {if $users_info[$facilitiesHistory.col_user].valid == 'login_user'}
                        {assign var='user_icon_class' value=' mobile_icon_userLogin_grn'}
                    {else}
                        {if $users_info[$facilitiesHistory.col_user].valid == 'invalid_user'}
                            {assign var='user_icon_class' value=' mobile_icon_userInvalid_grn'}
                        {elseif $users_info[$facilitiesHistory.col_user].valid == 'invalidApp_user'}
                            {assign var='user_icon_class' value=' mobile_icon_userInvalidApp_grn'}
                        {else}
                            {assign var='user_icon_class' value=''}
                        {/if}
                    {/if}
                    <li data-icon="false" class="mobile_operation_grn mobile_under_line_grn">
                        <div class="mobile_bold_grn">{grn_mobile_format body=$facilitiesHistory.col_facility_name nolink=true}</div>
                        {if $facilitiesHistory.col_status == 0 || $facilitiesHistory.col_status == 1}
                        <div class="mobile_progress_mark_grn">{$facilitiesHistory.col_status_text}</div>
                        {/if}
                        <div class="mobile_info_grn">
                            <div class="mobile_user_grn">
                                <span class="mobile_icon_user_grn{$user_icon_class}"></span>
                                {grn_user_name uid=$facilitiesHistory.col_user name=$facilitiesHistory.col_user_name users_info=$users_info only_text=true}
                            </div>
                            <div class="mobile_text_grn">{grn_mobile_format body=$facilitiesHistory.col_comment}</div>
                            <div class="mobile_date_grn">{grn_date_format date=$facilitiesHistory.col_approval_time format="DateTimeMiddle_YMDW_HM"}</div>
                        </div>
                    </li>
                {/foreach}
            </ul>
        {/if}
        {if !empty($facilityApprovalData.currentStatus)}
        <div class="mobile-list-todoDetail-grn">
            <div class="mobile-separation-grn"></div>
            <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-1039' replace='true'}</div>
            <div class="mobile_contents_detail_grn">
                {grn_mobile_format body=$facilityApprovalData.usingPurpose}
            </div>
        </div>
        {/if}
    {else}
        <div class="mobile-list-todoDetail-grn">
            <div class="mobile-separation-grn"></div>
            <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-294' replace='true'}</div>
        <!--facilities approval history link-->
        {if !empty($facilityApprovalData.history)}
        </div>
            <ul data-role="listview" data-theme="{$data_theme}" class="mobile-li-PersonInCharge-grn mobile-div-title-grn mobile_facility_process_history_grn">
                <div id="facility_approval_history_link">
                    <a href="#" class="mobile_process_history_link_grn mobile_switch_link_grn ui-link">
                        {if $facilityApprovalData.isExpandedHistory}
                            {assign var='link_icon_class' value='mobile_arrow_inline_up_grn'}
                        {else}
                            {assign var='link_icon_class' value='mobile_arrow_inline_down_grn'}
                        {/if}
                        <span id="facility_approval_history_link_icon" class="{$link_icon_class}"></span><span>{cb_msg module='grn.schedule' key='GRN_SCH-1038' replace='true'}</span>
                    </a>
                </div>
            </ul>
            <ul id="facility_approval_history_list" data-role="listview" data-theme="{$data_theme}"
                class="mobile-ul-top-grn mobile-ul-bottom-grn mobile_process_history_detail_grn"
                    {if !$facilityApprovalData.isExpandedHistory} style="display: none;" {/if}>
                {foreach from=$facilityApprovalData.history item=facilitiesHistory}
                    {if $users_info[$facilitiesHistory.col_user].valid == 'login_user'}
                        {assign var='user_icon_class' value=' mobile_icon_userLogin_grn'}
                    {else}
                        {if $users_info[$facilitiesHistory.col_user].valid == 'invalid_user'}
                            {assign var='user_icon_class' value=' mobile_icon_userInvalid_grn'}
                        {elseif $users_info[$facilitiesHistory.col_user].valid == 'invalidApp_user'}
                            {assign var='user_icon_class' value=' mobile_icon_userInvalidApp_grn'}
                        {else}
                            {assign var='user_icon_class' value=''}
                        {/if}
                    {/if}
                    <li data-icon="false" class="mobile_operation_grn mobile_under_line_grn">
                        <div class="mobile_bold_grn">{grn_mobile_format body=$facilitiesHistory.col_facility_name nolink=true}</div>
                        {if $facilitiesHistory.col_status == 0 || $facilitiesHistory.col_status == 1}
                        <div class="mobile_progress_mark_grn">{$facilitiesHistory.col_status_text}</div>
                        {/if}
                        <div class="mobile_info_grn">
                            <div class="mobile_user_grn">
                                <span class="mobile_icon_user_grn{$user_icon_class}"></span>
                                {grn_user_name uid=$facilitiesHistory.col_user name=$facilitiesHistory.col_user_name users_info=$users_info only_text=true}
                            </div>
                            <div class="mobile_text_grn">{grn_mobile_format body=$facilitiesHistory.col_comment}</div>
                            <div class="mobile_date_grn">{grn_date_format date=$facilitiesHistory.col_approval_time format="DateTimeMiddle_YMDW_HM"}</div>
                        </div>
                    </li>
                {/foreach}
            </ul>
        {else}
            <div class="mobile-contents-todoDetail-grn"></div>
        </div>
        {/if}
    {/if}
    <ul data-role="listview" data-theme="{$data_theme}" class="mobile-li-PersonInCharge-grn mobile-div-title-grn">
    <div class="mobile-separation-grn"></div>
    <!-- End GTM-1684 -->
      <!-- GTM-1630 attendees -->
      {if $is_attendance_check_view}
      <li data-icon="false" class="mobile_attendance_detail_li_grn">
        {if $attendance_details.user_count gt 0 or count($attendance_details.groups_name) gt 0}
            <div class="mobile_attendance_detail_li_title_grn">
            <span class="mobile_attendance_detail_title_left_grn mobile-label-small-grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-27' replace='true'}</span>
            {if $is_attendee}
                {if $attendance_status.unconfirmed}
                    <span class="mobile_event_status_unanswered_grn">{$attendance_status.text}</span>
                {else}
                    {if $attendance_status.value}
                        <span class="mobile_event_status_attendance_grn">{$attendance_status.text}</span>
                    {else}
                        <span class="mobile_event_status_absence_grn">{$attendance_status.text}</span>
                    {/if}
                {/if}
                <span class="mobile_attendance_detail_title_right_grn mobile-label-small-grn">
                    {cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-28' replace='true'}
                    {cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-35' replace='true'}
                </span>
            {/if}
            {if count($attendance_details.groups_name) gt 0}
            <div class="mobile-contents-todoDetail-grn">
                {foreach from=$attendance_details.groups_name item=group_name name=groups_name}
                <span>
                    {if $smarty.foreach.groups_name.last}
                        {$group_name|escape}
                    {else}
                        {$group_name|escape}{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-32' replace='true'}
                    {/if}
                </span>
                {/foreach}
            </div>
            {/if}
        </div>
        {if $attendance_details.user_count gt 0}
        <div class="mobile_line_dashed_grn mobile_clear_grn"></div>
        <a href="{grn_pageurl page=$schedule_prefix|cat:'/attendee_list' event=$event_id bdate=$bdate uid=$user_id gid=$group_id referer_key=$referer_key}">
            <div class="mobile-label-small-grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-30' replace='true'}</div>
            <div class="mobile_for_totalnumber_grn">
                {if $attendance_details.attend_count gt 0}
                    {foreach from=$attendance_details.attends_name item=attend_name}
                        {if in_array('attention', $attend_name)}
                            <div class="mobile-font-warp-grn">{grn_image image="image-mobile/attention_s.png" height="16" width="16"}{$attend_name.name|escape}</div>
                        {else}
                            <div class="mobile-font-warp-grn">{$attend_name.name|escape}</div>
                        {/if}
                    {/foreach}
                {else}
                    <div class="mobile_attendance_none_grn"></div>
                {/if}
                <div class="mobile-font-warp-grn mobile_attendance_detail_numberLine_grn">
                    (<span class="mobile_rblank_s_grn"></span><span class="mobile-label-small-grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-31' replace='true'}</span><span class="mobile_rblank_s_grn"></span><span class="mobile_total_number_sub_grn">{$attendance_details.absent_count}</span><span class="mobile_rblank_l_grn"></span><span class="mobile-label-small-grn">{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-29' replace='true'}</span><span class="mobile_rblank_s_grn"></span><span class="mobile_total_number_sub_grn">{$attendance_details.unconfirmed_count}</span><span class="mobile_rblank_s_grn"></span>)
                </div>
            </div><!--mobile_for_totalnumber_grn-->
            <span class="totalNumber-grn">{$attendance_details.attend_count}</span>
            <span class="mobile-array-todo-grn"></span>
        </a>
        {/if}
        {else}
            <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-303' replace='true'}</div>
        {/if}
      </li>
      {if $attendance_details.user_count gt 0}
      <div class="mobile-separation-grn"></div>
      {/if}
      <!-- End GTM-1630 attendees -->
      {else}
      <li data-icon="false">
        {if $schedule_event.attendees_count gt 0}
        <a href="{grn_pageurl page=$schedule_prefix|cat:'/attendee_list' event=$event_id bdate=$bdate uid=$user_id gid=$group_id referer_key=$referer_key}">
          <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-303' replace='true'}</div>
          <div class="mobile_for_totalnumber_grn">
            {foreach from=$schedule_event.attendees_name item=attendee_name}
            {if is_array($attendee_name)}
                {if in_array('attention', $attendee_name)}
                    <div class="mobile-font-warp-grn">{grn_image image="image-mobile/attention_s.png" height="16" width="16"}{$attendee_name.name|escape}</div>
                {else}
                    <div class="mobile-font-warp-grn">{$attendee_name.name|escape}</div>
                {/if}
            {else}
                <div class="mobile-font-warp-grn">{$attendee_name|escape}</div>
            {/if}
            {/foreach}
          </div><!--mobile_for_totalnumber_grn-->
          <span class="totalNumber-grn">{$schedule_event.attendees_count}</span>
          <span class="mobile-array-todo-grn"></span>
        </a>
        {else}
        <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-303' replace='true'}</div>
        {/if}
      </li>
      {if $schedule_event.attendees_count gt 0}
      <div class="mobile-separation-grn"></div>
      {/if}
      {/if}
      {if $schedule_event.private_users_name}
      <li data-icon="false">
        <a href="{grn_pageurl page=$schedule_prefix|cat:'/public_to_user_list' event=$event_id bdate=$bdate uid=$user_id gid=$group_id referer_key=$referer_key}">
          <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-318' replace='true'}</div>
          <div class="mobile_for_totalnumber_grn">
            {foreach from=$schedule_event.private_users_name item=private_users_name}
            <div class="mobile-font-warp-grn">{$private_users_name|escape}</div>
            {/foreach}
          </div><!--mobile_for_totalnumber_grn-->
          {if $schedule_event.private_users_count gt 0}
          <span class="totalNumber-grn">{$schedule_event.private_users_count}</span>
          {/if}
         <span class="mobile-array-todo-grn"></span>
        </a>
      </li>
      <div class="mobile-separation-grn"></div>
      {/if}
    </ul>

    <!-- notes -->
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-295' replace='true'}</div>
      <div class="mobile-contents-todoDetail-grn">{grn_mobile_format body=$schedule_event.memo}</div>
    </div>
    <div class="mobile-separation-grn"></div>

    <!-- files -->
    {if $allow_attach_files}
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-942' replace='true'}</div>
      <div class="mobile-contents-todoDetail-grn">
      <div class="mobile-attachmentButton-grn">
          {foreach from=$schedule_event.attach_files item=file}
            {grn_mobile_attach_file_link name=$file.name dpage=$file_dpage fid=$file.id event=$schedule_event.event_id}
          {/foreach}
        </div>
      </div>
    </div>
    <div class="mobile-separation-grn"></div>
    {/if}

    <!-- registrant  -->
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-261' replace='true'}</div>
      <div class="mobile-contents-todoDetail-grn mobile_todo_username_grn">{grn_user_name uid=$schedule_event.creator_uid name=$schedule_event.creator_name users_info=$users_info only_text=true}<span class="mobile-date-list-grn">{grn_date_format date=$schedule_event.ctime format="DateTimeMiddle_YMDW_HM"}</span></div>
    </div>

    <!-- updater -->
    {if $schedule_event.modify_name}
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.schedule' key='GRN_SCH-262' replace='true'}</div>
      <div class="mobile-contents-todoDetail-grn mobile_todo_username_grn">{grn_user_name uid=$schedule_event.modify_uid name=$schedule_event.modify_name users_info=$users_info only_text=true}<span class="mobile-date-list-grn">{grn_date_format date=$schedule_event.mtime format="DateTimeMiddle_YMDW_HM"}</span></div>
    </div>
    {/if}
  </div>

  <!-- comment add -->
  {if $schedule_event.access.follow}
  <div class="mobile-separation-grn"></div>
  {if $schedule_event.type == 'repeat' || $schedule_event.type == 'share_repeat'}
  <div class="mobile_detail_information_comment_grn">
    <span class="mobile_icon_information_grn"></span>
    <span class="mobile_text_information_grn">{cb_msg module='grn.schedule' key='GRN_SCH-298' replace='true'}</span>
  </div>
  {/if}
  <div class="mobile-comment-grn mobile-todoAddComment-grn" id="comment_top">
    <input type="text" name="title" value="{cb_msg module='grn.schedule' key='GRN_SCH-981' replace='true'}" readonly="readonly" onclick="javascript:grn.component.mobile_common.toAddComment();"/>
  </div>
  {else}
  <div class="mobile-addCommentDisable-grn" id="comment_top"></div>
  {/if}
  
  <!-- comment list -->
  {if count($follow_list) gt 0}
    <div class="mobile_comment_list_grn">
      <ul data-role="listview" data-theme="{$data_theme}" class="mobile-ul-bottom-grn mobile-padding-leftright-grn" id="comment_list">
        {include file=$schedule_prefix|cat:'/comment_list.tpl'}
      </ul>
    </div>
  {/if}
  
  <!-- more comment -->
  {include file='grn/mobile_list_more_view.tpl' request_page=$schedule_prefix|cat:'/ajax/comment_list' list_id='comment_list' trigger_create=true}
</div>
{if $attendance_status.unconfirmed}
{literal}
<script language="JavaScript" text="text/javascript">
(function(){
    {/literal}
    var place_holder_data = "{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-23' replace='true'}";
    {literal}
    var $commentData = jQuery("#comment_data");
    $commentData.focus( function(){
        $commentData.addClass("mobile-textarea-auto-long-grn");
        $commentData.removeClass("mobile-textarea-auto-short-grn");
        $commentData.attr('placeholder', '');
    });
    
    $commentData.blur( function(){
        if(this.value == ""){
            $commentData.addClass("mobile-textarea-auto-short-grn");
            $commentData.removeClass("mobile-textarea-auto-long-grn");
        }
        $commentData.attr('placeholder', place_holder_data);
    });
    
    var $confirmAttendanceForm = jQuery("#confirm_attendance");
    $confirmAttendanceForm.find(".btn_confirm").on("tap", function(e){
        if(this.name == "btn_absent"){
            jQuery("#attendance_status").val(this.name);
        }
        else{
            jQuery("#attendance_status").val("");
        }
        $confirmAttendanceForm.submit();
        e.preventDefault();
    });
})();
</script>
{/literal}
{/if}
