{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{include file="grn/error_handler.tpl"}
{grn_load_javascript file="grn/html/component/pulldown_menu/pulldown_menu.js"}
{grn_load_css file="grn/html/component/pulldown_menu/pulldown_menu.css"}


<div class="mainareaSchedule-grn">
  <div class="detail_title_grn">
    <div id="event_list">
      <span class="title_mark_schedule_grn"></span><h2 class="schedule" style="display: inline;">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-190' replace='true'}</h2>
    </div
  </div>

  {include file="grn/smart_word_navi_attendance.tpl" navi=$view_set.navi start_num=$view_set.start_count end_num=$view_set.end_count}

  <table class="list_column list_column_grn list_column_change_h_grn">
    <tbody>
      <tr>
        <th>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-191' replace='true'}</th>
        <th>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-192' replace='true'}</th>
        <th style="width:5%;">
          <div id="approval_status_filter">
            {strip}
            <dl id="" class="selectmenu_grn selectmenu_base_grn">
              <dt>
                <a href="javascript:void(0);" class="nowrap-grn">
                    {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-193' replace='true'}
                  <span class="pulldownbutton_arrow_down_grn mLeft3"></span>
                  <input id="approval_filter_status" type="hidden" name="pulldown_head" value="{$view_set.navi.params.status}">
                </a>
              </dt>
              <dd>
                <div class="pulldown_menu_grn" style="display:none;">
                  <ul>
                    <li>
                      <a href="javascript:void(0);">
                        <span name="filter_mark" class="{if $view_set.navi.params.status eq 0}pulldown_menu_select_mark_grn{else}pulldown_menu_select_mark_none_grn{/if}"></span>
                        <span class="vAlignMiddle-grn">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-194' replace='true'}</span>
                        <input name="filter_options" type="hidden" value="0">
                      </a>
                    </li>
                    <li>
                      <a href="javascript:void(0);">
                        <span name="filter_mark" class="{if $view_set.navi.params.status eq 1}pulldown_menu_select_mark_grn{else}pulldown_menu_select_mark_none_grn{/if}"></span>
                        <span class="vAlignMiddle-grn">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-195' replace='true'}</span>
                        <input name="filter_options" type="hidden" value="1">
                      </a>
                    </li>
                    <li>
                      <a href="javascript:void(0);">
                        <span name="filter_mark" class="{if $view_set.navi.params.status eq 2}pulldown_menu_select_mark_grn{else}pulldown_menu_select_mark_none_grn{/if}"></span>
                        <span class="vAlignMiddle-grn">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-196' replace='true'}</span>
                        <input name="filter_options" type="hidden" value="2">
                      </a>
                    </li>
                  </ul>
                </div>
              </dd>
            </dl>
            {/strip}
          </div>
        </th>
        <th></th>
        <th style="min-width: 50px;">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-198' replace='true'}</th>
        <th>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-225' replace='true'}</th>
        <th>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-199' replace='true'}</th>
      </tr>
      {if $data_for_view|@count > 0}
      {foreach from=$data_for_view key=event_key item=event}
        <tr class="{cycle values='linetwo,lineone'}" id="approval_record_{$event.id}_{$event.facility}">
          <td>
            <a name="using_time_{$event.id}" href="{grn_pageurl page='schedule/operation/facility_approve' event=$event.id faid=$event.facility}">
              {$event.time_schedule}
            </a>
            <div style="display:none;">
              {$event.start_date}<span class="mLeft15">{$event.start_time}{if $event.end_time}&nbsp;{cb_msg module='grn.schedule' key='GRN_SCH-281' replace='true'}&nbsp;{$event.end_date}&nbsp;{$event.end_time}{/if}</span>
            </div>
          </td>
          <td>
            <span class="mRight5">
             {grn_schedule_members_name members=$event.facility_array member_type='facility' nobr=true}
            </span>
          </td>
          <td>
            {if $event.result_approval_status eq '1'}
              <span id="approval_status_{$event.id}_{$event.facility}" class="facility_status_approval_grn">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-196' replace='true'}</span>
            {elseif $event.result_approval_status eq '-1'}
              <span id="approval_status_{$event.id}_{$event.facility}" class="facility_status_unanswered_grn">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-195' replace='true'}</span>
            {/if}
          </td>
          <td>
            {if $event.result_approval_status eq '-1'}
            <span id="approval_handle_btn_{$event.id}_{$event.facility}" style="margin-right: 15px;">
              <a class="icon_edit_grn" href="javascript:void(0);" data-event="{$event.id}" data-facility="{$event.facility}" data-facility_name="{$event.facility_name}" data-applying_time="{$event.applying_time}">
                  {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-200' replace='true'}
              </a>
            </span>
            {/if}
          </td>
          <td class="foldback_grn textSub-grn">
              {strip}
              <pre  class="format_contents" style="white-space:-moz-pre-wrap; white-space:pre-wrap;display:inline;">
              {if strlen($event.using_purpose) > 0}
                  {$event.using_purpose|escape}
              {else}
                  <span class="text_color_sub_grn">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-197' replace='true'}</span>
              {/if}
              </pre>
              {/strip}
          </td>
          <td>
            {if $event.applying_user}{grn_user_name uid=$event.applying_user users_info=$users_info name=$event.applying_user_name truncated=$name_width}{else}{grn_user_name uid=$event.creator users_info=$users_info name=$event.creator_name truncated=$name_width}{/if}
            <div style="display:none;">
              {if $event.applying_user}{grn_user_name uid=$event.applying_user users_info=$users_info name=$event.applying_user_name}{else}{grn_user_name uid=$event.creator users_info=$users_info name=$event.creator_name}{/if}
            </div>
          </td>
          <td>{$event.applying_time}</td>
        </tr>
      {/foreach}
      {/if}
    </tbody>
  </table>
  {if $data_for_view|@count eq 0}
  <div class="list_message_grn">
    <div class="list_message_balloon_grn">
      <span class="bold_grn">
        {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-201' replace='true'}
      </span>
    </div>
    <div class="balloon_arrow_down_grn"></div>
    <div class="list_message_icon_grn">
      <span class="message_middle_icon_size_grn schedule_message_middle_icon_grn"></span>
    </div>
  </div>
  {/if}
  {include file="grn/smart_word_navi_attendance.tpl" navi=$view_set.navi start_num=$view_set.start_count end_num=$view_set.end_count}

</div>
<script>
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

                if(url.length == url_length)
                {
                    url = url + tmp[i];
                }
                else
                {
                    url = url + "&" + tmp[i];
                }
            }
            url = url + "&status=" + status;
            location.href = url;
        }
    }{/literal}

    grn.component.pulldown_menu.pulldown_menu.init( jQuery("#approval_status_filter"), handlePullDown);

    jQuery(document).ready(function (){literal}{
        var filterObj   = jQuery("#approval_status_filter").children("dl");
        var pullDownObj = filterObj.find("div.pulldown_menu_grn");
        jQuery(document).bind("click", function(e)
        {
            var target = e.target;
            if (!jQuery(target).parents().is(".pulldown_menu_grn") && !jQuery(target).is(".pulldown_menu_grn")&&!jQuery(target).parents().is("#approval_status_filter") && !jQuery(target).is("#approval_status_filter"))
            {
                grn.component.pulldown_menu.pulldown_menu.closePullDownMenu(filterObj.find("dt"),pullDownObj);
            }
        });
        jQuery("a.icon_edit_grn").click(function (e) {
            var fn = jQuery(this);
            GRN_ApprovalFacilityStatusDialog.openDialog(fn.data("event"), fn.data("facility"), fn.data("facility_name"), fn.data("applying_time"), fn);
            e.preventDefault();
        });

    }{/literal});
</script>
{include file="schedule/operation/_change_approval_facility_status_dialog.tpl"}
{include file="grn/footer.tpl"}
