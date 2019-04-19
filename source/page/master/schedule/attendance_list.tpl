{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{include file="grn/error_handler.tpl"}
{grn_load_javascript file="grn/html/component/pulldown_menu/pulldown_menu.js"}
{grn_load_css file="grn/html/component/pulldown_menu/pulldown_menu.css"}
<script type="text/javascript" language="javascript">
    var __attendance_status_message = {ldelim}
                                            attend: {ldelim}message:"{cb_msg module='grn.schedule' key='GRN_SCH-1022' replace='true'}" {rdelim},
                                            absent: {ldelim}message:"{cb_msg module='grn.schedule' key='GRN_SCH-1023' replace='true'}" {rdelim}
                                      {rdelim};
    var filter_status = {$attend_status};
</script>

  <div class="mainareaSchedule-grn">
  {include file="schedule/_attendance_list_tab_menu.tpl" bid="attendees"}

  {include file="grn/smart_word_navi_attendance.tpl" navi=$view_set.navi start_num=$view_set.start_count end_num=$view_set.end_count}
  <table class="list_column list_column_grn">
    <tbody>
      <tr>
        <th style="width:25%;">{cb_msg module="grn.schedule" key="GRN_SCH-133" replace='true'}</th>
        <th style="width:25%;">{cb_msg module="grn.schedule" key="GRN_SCH-42" replace='true'}</th>
        <th style="width:5%;">
          <div id="attend_status_filter">
            <dl id="" class="selectmenu_grn selectmenu_base_grn">
              <dt>{strip}
                <a id="" href="javascript:void(0)" class="nowrap-grn">
                  {cb_msg module='grn.schedule' key='GRN_SCH-1018' replace='true'}
                  <span class="pulldownbutton_arrow_down_grn mLeft3"></span>
                  <input type="hidden" name="pulldown_head" value="{$attend_status}">
                </a>
              </dt>{/strip}
              <dd>
                <div class="pulldown_menu_grn" style="display:none;">
                  <ul>
                    <li>
                      <a href="javascript:void(0);">
                        {if $attend_status eq '0'}<span class="pulldown_menu_select_mark_grn"></span>{else}<span class="pulldown_menu_select_mark_none_grn"></span>{/if}<span class="vAlignMiddle-grn">{cb_msg module='grn.schedule' key='GRN_SCH-1019' replace='true'}</span>
                        <input name="filter_options" type="hidden" value="0">
                      </a>
                    </li>
                    <li>
                      <a href="javascript:void(0);">
                        {if $attend_status eq '1'}<span class="pulldown_menu_select_mark_grn"></span>{else}<span class="pulldown_menu_select_mark_none_grn"></span>{/if}<span class="vAlignMiddle-grn">{cb_msg module='grn.schedule' key='GRN_SCH-1020' replace='true'}</span>
                        <input name="filter_options" type="hidden" value="1">
                      </a>
                    </li>
                    <li>
                      <a href="javascript:void(0);">
                        {if $attend_status eq '2'}<span class="pulldown_menu_select_mark_grn"></span>{else}<span class="pulldown_menu_select_mark_none_grn"></span>{/if}<span class="vAlignMiddle-grn">{cb_msg module='grn.schedule' key='GRN_SCH-1022' replace='true'}</span>
                        <input name="filter_options" type="hidden" value="2">
                      </a>
                    </li>
                    <li>
                      <a href="javascript:void(0);">
                        {if $attend_status eq '3'}<span class="pulldown_menu_select_mark_grn"></span>{else}<span class="pulldown_menu_select_mark_none_grn"></span>{/if}<span class="vAlignMiddle-grn">{cb_msg module='grn.schedule' key='GRN_SCH-1023' replace='true'}</span>
                        <input name="filter_options" type="hidden" value="3">
                      </a>
                    </li>
                  </ul>
                </div>
              </dd>
            </dl>
          </div>
        </th>
        <th style="width:12%;"></th>
        <th>{cb_msg module="grn.schedule" key="GRN_SCH-261" replace='true'}</th>
      </tr>
      {if $data_for_view|@count > 0}
      {foreach from=$data_for_view key=event_key item=event}
      <tr class="{cycle values='linetwo,lineone'}">
          <td>{$event.time_schedule|grn_noescape}{if $event.allday}{cb_msg module='grn.schedule' key='GRN_SCH-280' replace='true'}{/if}</td>
          <td>
          {strip}
            <span class="mRight5">
              <a href="{grn_pageurl page='schedule/view' event=$event.id}">
                {if $event.conflict }
                  {capture name='grn_schedule_GRN_SCH_914'}{cb_msg module='grn.schedule' key='GRN_SCH-914' replace='true'}{/capture}
                  <span class="attention_icon_grn v-allign-middle mRight2" title="{$smarty.capture.grn_schedule_GRN_SCH_914}"></span>
                {/if}
                {if $event.event_menu_color eq 0 || $event.event_menu_color eq null}
                    {$event.title|grn_noescape}
                {elseif $event.event_menu }
                    <span class="event_color_base_grn event_color{$event.event_menu_color}_grn">{$event.event_menu|grn_noescape}</span>
                    {$event.data|grn_noescape}
                {else}
                    {$event.data|grn_noescape}
                {/if}
              </a>
            </span>
          {/strip}
          </td>
          <td>
              {if $event.attendance_status eq '1'}
              <span id="attendance_list_status_{$event.id}" class="event_status_attendance_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1022' replace='true'}</span>
              {elseif $event.attendance_status eq '0'}
              <span id="attendance_list_status_{$event.id}" class="event_status_absence_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1023' replace='true'}</span>
              {else}
              <span id="attendance_list_status_{$event.id}" class="event_status_unanswered_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1020' replace='true'}</span>
              {/if}
          </td>
          <td>
            <span style="margin-right: 40px;">
              <a class="icon_edit_grn" href="javascript:void(0);" onclick="javascript:GRN_ScheduleAttendanceStatus.getScheduleAttendanceStatus({$event.id});">{cb_msg module='grn.schedule' key='GRN_SCH-1012' replace='true'}</a>
            </span>
          </td>
          <td>
            <span class="nowrap-grn">
              {grn_user_name uid=$event.creator users_info=$users_info name=$event.creator_name truncated=$name_width}
            </span>
          </td>
      </tr>
      {/foreach}
      {/if}
    </tbody>
  </table>
    <div class="list_message_grn" {if $data_for_view|@count neq 0}style="display:none"{/if}>
      <div class="list_message_balloon_grn">
        <span class="bold_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1030' replace='true'}</span>
      </div>
      <div class="balloon_arrow_down_grn"></div>
      <div class="list_message_icon_grn">
        <span class="message_middle_icon_size_grn schedule_message_middle_icon_grn"></span>
      </div>
    </div>
  {include file="grn/smart_word_navi_attendance.tpl" navi=$view_set.navi start_num=$view_set.start_count end_num=$view_set.end_count}
  </div>

<script type="text/javascript" language="javascript">
    function handlePullDown( element ){literal}{
        var selected = jQuery(element);
        var status = selected.find("input[name='filter_options']").val();

        var arr = location.href.split("?");
        if( arr.length < 2)
        {
            location.href = arr + "?status="+ status;
        }
        else
        {
            var url = arr[0] + "?";
            var url_length = url.length;
            var tmp = arr[1].split("&");
            var tmp_length = tmp.length;
            for(var i=0; i < tmp_length; i++)
            {
                if(tmp[i].match(/status=/gi))
                {
                    continue;
                }

                if(tmp[i].match(/sp=/gi))
                {
                    url = url.length == url_length ? url + "sp=0" : url + "&" + "sp=0";
                    continue;
                }

                if(url.length == url_length )
                {
                    url = url + tmp[i];
                }
                else
                {
                    url = url + "&" + tmp[i];
                }
            }
            url = url + "&status="+ status;
            location.href = url;
        }
    }{/literal}

    grn.component.pulldown_menu.pulldown_menu.init( jQuery("#attend_status_filter"), handlePullDown);

    jQuery(document).ready(function (){literal}{
        var filterObj = jQuery("#attend_status_filter").children("dl");
        var pullDownObj = filterObj.find("div.pulldown_menu_grn");
        jQuery(document).bind("click", function (e)
        {
            var target = e.target;
            if (!jQuery(target).parents().is(".pulldown_menu_grn") && !jQuery(target).is(".pulldown_menu_grn")&&!jQuery(target).parents().is("#attend_status_filter") && !jQuery(target).is("#attend_status_filter"))
            {
                grn.component.pulldown_menu.pulldown_menu.closePullDownMenu(filterObj.find("dt"),pullDownObj);
            }
        });
    }{/literal});

    function updateHtmlFn(json_obj)
    {literal}{
        var status_element = jQuery("#attendance_list_status_"+json_obj.event_id);
        if (json_obj.status === 0)
        {
            if (filter_status === 1 || filter_status === 2)
            {
                status_element.parents("tr").hide("slow");
            }
            else
            {
                status_element.html(__attendance_status_message.absent.message);
                status_element.removeClass();
                status_element.addClass("event_status_absence_grn");
            }
        }
        else
        {
            if (filter_status === 1 || filter_status === 3)
            {
                status_element.parents("tr").hide("slow");
            }
            else
            {
                status_element.html(__attendance_status_message.attend.message);
                status_element.removeClass();
                status_element.addClass("event_status_attendance_grn");
            }
        }
        setTimeout(function(){
            if( ( json_obj.status === 0 && (filter_status === 1 || filter_status === 2) ) ||
                ( json_obj.status !== 0 && (filter_status === 1 || filter_status === 3) ) )
            {
                status_element.parents("tr").remove();
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
        },1000);
    }{/literal}
</script>
{include file="schedule/_change_attendance_status.tpl"}
{include file="grn/footer.tpl"}


