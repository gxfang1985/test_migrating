{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{include file="schedule/_change_attendance_status.tpl"}
{literal}
<script language="JavaScript" text="text/javascript">{/literal}
var __attendance_status_message = {ldelim}"attendance" : "{cb_msg module='grn.schedule' key='GRN_SCH-1006' replace='true'}",
                                          "absence" : "{cb_msg module='grn.schedule' key='GRN_SCH-1007' replace='true'}",
                                          "unanswered" : "{cb_msg module='grn.schedule' key='GRN_SCH-1020' replace='true'}"
                                  {rdelim};
var __attendance_status_list_message = {ldelim}"attendance" : "{cb_msg module='grn.schedule' key='GRN_SCH-1022' replace='true'}",
                                               "absence" : "{cb_msg module='grn.schedule' key='GRN_SCH-1023' replace='true'}",
                                               "unanswered" : "{cb_msg module='grn.schedule' key='GRN_SCH-1020' replace='true'}"
                                       {rdelim};
var filter_status = {$filter};

var sort = '{$sort}';

var f_status = {ldelim}"2" : "attendance",
                       "3" : "absence",
                       "1" : "unanswered"
               {rdelim};

var status_class = {ldelim}"attendance" : "event_status_attendance_grn",
                           "absence" : "event_status_absence_grn",
                           "unanswered" : "event_status_unanswered_grn",
                   {rdelim};

{literal}

function getpostion(user_id, list_sort, flip_user_sort)
{
    for (var index in list_sort)
    {
        var y = flip_user_sort[list_sort[index]];
        if (flip_user_sort[user_id] < y)
        {
            return list_sort[index];
        }
    }
    return false;
}

function updateHtmlFn(json_obj)
{
    //own status
    var status = jQuery("#status");
    var message = jQuery("#message");

    var html_status_class = "event_status_" + json_obj.status_style + "_grn";
    var html_status_key = json_obj.status_style;
    var html_status_msg = __attendance_status_message[html_status_key];
    var html_status_list_msg = __attendance_status_list_message[html_status_key];
    var html_status_comment = json_obj.message;

    status.removeClass().addClass(html_status_class).html(html_status_msg);
    message.empty().append(html_status_comment);

    //update record list
    var status_mtime_list = jQuery("#status_time_" + json_obj.user_id);
    var status_message_list = jQuery("#status_message_" + json_obj.user_id);
    var status_list = jQuery("#status_" + json_obj.user_id);
    var html_status_mtime = json_obj.status_time;

    status_mtime_list.html(html_status_mtime);
    status_message_list.empty().append(html_status_comment);
    status_list.removeClass().addClass(html_status_class).html(html_status_list_msg);
    for (var status_list_index in __attendance_status_list_message)
    {
        if (__attendance_status_list_message[status_list_index] == status_list.html())
        {
            break;
        }
    }
    if (html_status_key === f_status[filter_status] && status_list_index != f_status[filter_status])
    {
        var user_own = jQuery("#user_own").html();
        var html_line;
        {/literal}
        html_line = "<tr><td>" + user_own + "</td>";
        html_line += "<td><span id='status_{$user}' class='"+ status_class[html_status_key] + "'>" + html_status_list_msg +"</span></td>";
        html_line += "<td id='status_time_{$user}'>" + html_status_mtime + "</td>";
        html_line += "<td id='status_message_{$user}' class='foldback_grn textSub-grn'>" + html_status_comment + "</td>";
        html_line += "</tr>";
        {literal}
        if (sort === 'rtd')
        {
            jQuery(html_line).insertAfter(".list_column tr:first").hide().show("slow");
        }
        else if (sort === 'rtu')
        {
            jQuery(html_line).appendTo(".list_column").hide().show("slow");
        }
        else
        {
            var list_sort=[];
            jQuery(".list_column tr").not(":first").each(function(){
                list_sort.push( jQuery(this).attr("id")) ;
            });

            if (list_sort.length == 0)
            {
                jQuery(html_line).appendTo(".list_column").hide().show("slow");
            }
            else
            {
                var flip_user_sort = {/literal}{$flip_user_sort|@json_encode}{literal};
                var user_id ={/literal}{$user}{literal};
                var p_id = getpostion(user_id, list_sort, flip_user_sort);
                if (p_id === false)
                {
                    jQuery(html_line).appendTo(".list_column").hide().show("slow");
                }
                else
                {
                    jQuery(html_line).insertBefore("#" + p_id).hide().show("slow");
                }
             }
        }
        jQuery(".list_message_grn").hide();
    }
    if (html_status_key === "absence")
    {
        if (filter_status === 1 || filter_status === 2)
        {
            status_list.parents('tr').hide("slow");
        }
    }
    else
    {
        if (filter_status === 1 || filter_status === 3)
        {
            status_list.parents('tr').hide("slow");
        }
    }

    setTimeout(function(){
        if ( ( html_status_key === "absence" && (filter_status === 1 || filter_status === 2) ) ||
             ( html_status_key !== "absence" && (filter_status === 1 || filter_status === 3) ) )
        {
            status_list.parents('tr').remove();
        }
        if (jQuery(".list_column tr").length <= 1)
        {
            jQuery(".list_message_grn").show("slow");
        }
        else
        {
            jQuery(".list_message_grn").hide("slow");
            jQuery(".list_column tr").removeClass();
            jQuery(".list_column tr:even").not(":first").addClass("lineone");
            jQuery(".list_column tr:odd").addClass("linetwo");
        }
    }, 1000);

    //reply count num
    var reply = jQuery("#reply_count");
    var html_reply = json_obj.reply_count
    reply.html(html_reply);
}

jQuery(document).click(function(e)
{
    var filterObj = jQuery("#attend_status_filter").children("dl");
    var pullDownObj = filterObj.find("div.pulldown_menu_grn");

    var isExist = function()
    {
        return filterObj.length !== 0 && pullDownObj.length !== 0;
    };

    var isOpenedPullDown = function()
    {
        return pullDownObj.is(":visible");
    };

    var isClickOther = function(e)
    {
        return filterObj.has(e.target).length === 0;
    };

    if (isExist() && isOpenedPullDown() && isClickOther(e))
    {
        grn.component.pulldown_menu.pulldown_menu.closePullDownMenu(filterObj.find("dt"), pullDownObj);
    }
});
</script>
{/literal}
{if $is_same_day}
  {assign var='string_format_datetime' value='TimeShort_HM'}
{else}
  {assign var='string_format_datetime' value='DateTimeLong_YMDW_HM'}
{/if}
<div class="mainareaSchedule-grn">
  <div>
    <div id="event_list">
      {strip}
      <span class="title_mark_schedule_grn"></span>
      {grn_title title=$schedule_event.title event_detail=$schedule_event.event_detail event_menu=$schedule_event.event_menu event_menu_color=$schedule_event.event_menu_color class='schedule mRight15 inline_block_grn mBottom10' is_private=$schedule_event.is_private no_style=1}
      <span class="nowrap-grn">
      <span class="">
        {if $schedule_event.allday}
          {grn_date_format date=$schedule_event.start_date format="DateLong_YMDW"}
          <span class="mLeft15">{grn_date_format date=$schedule_event.start_date format="TimeLong_HM"}
            <span class="mLeft15 mRight15">{cb_msg module='grn.schedule' key='GRN_SCH-279' replace='true'}</span>
            {grn_date_format date=$schedule_event.end_date format=$string_format_datetime}
            {cb_msg module='grn.schedule' key='GRN_SCH-280' replace='true'}
          </span>
        {else}
          {grn_date_format date=$schedule_event.start_date format="DateLong_YMDW"}
          <span class="mLeft15">{grn_date_format date=$schedule_event.start_date format="TimeLong_HM"}
            {if $schedule_event.end_date}&nbsp;{cb_msg module='grn.schedule' key='GRN_SCH-281' replace='true'}&nbsp;{grn_date_format date=$schedule_event.end_date format=$string_format_datetime}{/if}
          </span>
        {/if}
      </span>
      </span>
      {/strip}
    </div>
  </div>
  {if $no_status_list}
  <div class="list_message_grn">
    <div class="list_message_balloon_grn"><span class="bold_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1037' replace='true'}</span></div>
    <div class="balloon_arrow_down_grn"></div>
    <div class="list_message_icon_grn"><span class="message_middle_icon_size_grn schedule_message_middle_icon_grn"></span></div>
  </div>
  {else}
  {if !$no_status}
  <div>
    <div class="border-partition-common-grn"></div>
    <div class="content_info_base_grn">
      <table class="table_plain_grn">
        <tbody>
          <tr>
            <td class="text_color_sub_grn nowrap-grn vAlignTop-grn">{cb_msg module='grn.schedule' key='GRN_SCH-1011' replace='true'}</td>
            <td class="content_info_separator_grn vAlignTop-grn">&nbsp;</td>
            <td>
              {if $schedule_event.own_status.status eq '1'}
                <span id="status" class="event_status_attendance_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1006' replace='true'}</span>
              {elseif $schedule_event.own_status.status eq '0'}
                <span id="status" class="event_status_absence_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1007' replace='true'}</span>
              {else}
                <span id="status" class="event_status_unanswered_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1020' replace='true'}</span>
              {/if}
              <span class="mLeft15">
                <a href="javascript:GRN_ScheduleAttendanceStatus.getScheduleAttendanceStatus('{$schedule_event.event_id}', 'div.content_info_base_grn')" class="icon_edit_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1012' replace='true'}</a>
              </span>
              <div id="message" class="mTop5">{grn_format body=$schedule_event.own_status.message}</div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="border-partition-common-grn"></div>
  </div>
  {/if}
  <div class="navi mTop10 mBottom3">
    {strip}
    <span class="text_color_sub_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1026' replace='true'}</span>&nbsp;{cb_msg module='grn.grn' key='GRN_GRN-426' replace='true'}&nbsp;
    <span id="reply_count">{$schedule_event.reply_count}</span>
    {cb_msg module='grn.schedule' key='GRN_SCH-1028' replace='true'}/{$schedule_event.users_count}{cb_msg module='grn.schedule' key='GRN_SCH-1028' replace='true'}
    {/strip}
  </div>
  <table class="list_column list_column_grn list_column_style1_grn mBottom20">
    <colgroup>
      <col width="20%">
      <col width="12%">
      <col width="18%">
      <col width="50%">
    </colgroup>
    <tbody><tr valign="top">
      <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-43' replace='true'}</th>
      <th nowrap>
          {grn_load_javascript file="grn/html/component/pulldown_menu/pulldown_menu.js"}
          {grn_load_css file="grn/html/component/pulldown_menu/pulldown_menu.css"}
          <div id="attend_status_filter">
              <dl id="" class="selectmenu_grn selectmenu_base_grn">
                  <dt>{strip}
                      <a id="status_filter" href="javascript:void(0)" class="nowrap-grn">
                          {cb_msg module='grn.schedule' key='GRN_SCH-1018' replace='true'}
                          <span class="pulldownbutton_arrow_down_grn mLeft3"></span>
                          <input type="hidden" name="pulldown_head" value="{$filter}">
                      </a>
                  </dt>{/strip}
                  <dd>
                      <div class="pulldown_menu_grn" style="display:none;">
                          <ul>
                              <li>
                                  <a href="{grn_pageurl page=$page_info.all event=$schedule_event.event_id referer_key=$referer_key bdate=$bdate sort=$sort}">
                                      {if $filter ne '1' && $filter ne '2' && $filter ne '3'}<span class="pulldown_menu_select_mark_grn"></span>{else}<span class="pulldown_menu_select_mark_none_grn"></span>{/if}<span class="vAlignMiddle-grn">{cb_msg module='grn.schedule' key='GRN_SCH-1019' replace='true'}</span>
                                      <input name="filter_options" type="hidden" value="">
                                  </a>
                              </li>
                              <li>
                                  <a href="{grn_pageurl page=$page_info.all event=$schedule_event.event_id referer_key=$referer_key bdate=$bdate sort=$sort filter=1}">
                                      {if $filter eq '1'}<span class="pulldown_menu_select_mark_grn"></span>{else}<span class="pulldown_menu_select_mark_none_grn"></span>{/if}<span class="vAlignMiddle-grn">{cb_msg module='grn.schedule' key='GRN_SCH-1020' replace='true'}</span>
                                      <input name="filter_options" type="hidden" value="1">
                                  </a>
                              </li>
                              <li>
                                  <a href="{grn_pageurl page=$page_info.all event=$schedule_event.event_id referer_key=$referer_key bdate=$bdate sort=$sort filter=2}">
                                      {if $filter eq '2'}<span class="pulldown_menu_select_mark_grn"></span>{else}<span class="pulldown_menu_select_mark_none_grn"></span>{/if}<span class="vAlignMiddle-grn">{cb_msg module='grn.schedule' key='GRN_SCH-1022' replace='true'}</span>
                                      <input name="filter_options" type="hidden" value="2">
                                  </a>
                              </li>
                              <li>
                                  <a href="{grn_pageurl page=$page_info.all event=$schedule_event.event_id referer_key=$referer_key bdate=$bdate sort=$sort filter=3}">
                                      {if $filter eq '3'}<span class="pulldown_menu_select_mark_grn"></span>{else}<span class="pulldown_menu_select_mark_none_grn"></span>{/if}<span class="vAlignMiddle-grn">{cb_msg module='grn.schedule' key='GRN_SCH-1023' replace='true'}</span>
                                      <input name="filter_options" type="hidden" value="3">
                                  </a>
                              </li>
                          </ul>
                      </div>
                  </dd>
              </dl>
          </div>
          <script type="text/javascript" language="javascript">
              grn.component.pulldown_menu.pulldown_menu.init( jQuery("#attend_status_filter") );
          </script>
      </th>
      <th nowrap>
        {capture name='grn_schedule_GRN_SCH_996'}{cb_msg module='grn.schedule' key='GRN_SCH-1029' replace='true'}{/capture}
        {if $sort == 'rtu'}
          {grn_title_sort title=$smarty.capture.grn_schedule_GRN_SCH_996 page=$page_info.all event=$schedule_event.event_id referer_key=$referer_key bdate=$bdate filter=$filter sort='rtd' reverse=1}
        {elseif $sort == 'rtd'}
          {grn_title_sort title=$smarty.capture.grn_schedule_GRN_SCH_996 page=$page_info.all event=$schedule_event.event_id referer_key=$referer_key bdate=$bdate filter=$filter sort='rtu'}
        {else}
          {grn_title_sort title=$smarty.capture.grn_schedule_GRN_SCH_996 page=$page_info.all event=$schedule_event.event_id referer_key=$referer_key bdate=$bdate filter=$filter sort='rtu' reverse=1 disable=1}
        {/if}
      </th>
      <th>{cb_msg module='grn.schedule' key='GRN_SCH-1031' replace='true'}</th>
    </tr>
    <div id ="user_own" style="display:none">{grn_user_name uid=$user}</div>
    {foreach from=$schedule_event.status_list item=status}
      <tr id="{$status.user}" class="{cycle values='linetwo,lineone'}">
        <td>{grn_user_name uid=$status.user}</td>
        <td>
          {if $status.status eq '1'}
                <span id="status_{$status.user}" class="event_status_attendance_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1022' replace='true'}</span>
          {elseif $status.status eq '0'}
                <span id="status_{$status.user}" class="event_status_absence_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1023' replace='true'}</span>
          {else}
                <span id="status_{$status.user}" class="event_status_unanswered_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1020' replace='true'}</span>
          {/if}
        </td>
        <td id="status_time_{$status.user}">{if $status.time}{grn_date_format date=$status.time format="DateShort_MD"}&nbsp;{grn_date_format date=$status.time format="TimeShort_HM"}{/if}</td>
        <td id="status_message_{$status.user}" class="foldback_grn textSub-grn">{grn_format body=$status.message}</td>
        </tr>
    {/foreach}
    </tbody>
  </table>
      <div class="list_message_grn" {if !$no_filter_status_list}style="display:none"{/if}>
        <div class="list_message_balloon_grn"><span class="bold_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1037' replace='true'}</span></div>
          <div class="balloon_arrow_down_grn"></div>
          <div class="list_message_icon_grn"><span class="message_middle_icon_size_grn schedule_message_middle_icon_grn"></span></div>
      </div>
  {/if}
</div>
{include file="grn/error_handler.tpl"}
{include file='grn/footer.tpl'}
