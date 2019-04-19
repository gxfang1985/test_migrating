{grn_load_javascript file="grn/html/schedule.js"}
<!--menubar-->
<div id="menu_part">
  <div id="smart_main_menu_part">
    {if $schedule.access.add}
      <span class="menu_item">
        <a href="{grn_pageurl page='schedule/add' bdate=$bdate uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" {if $ajax_flag}onclick="{$bd_func}{$rd_func}"{/if}>
          {grn_image image='image-common/write20.png'}{cb_msg module='grn.schedule' key='GRN_SCH-657' replace='true'}</a>
      </span>
    {/if}
    {if $page_info.last != 'personal_year'}
      <span class="menu_item">
        <a href="{grn_pageurl page='schedule/adjust_search' event=$event_id bdate=$bdate uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" {if $ajax_flag}onclick="{$bd_func}{$rd_func}"{/if}>
          {grn_image image='adjust20.gif'}{cb_msg module='grn.schedule' key='GRN_SCH-658' replace='true'}</a>
      </span>
    {/if}
    {if $isEnableAttendanceStatus}
       <span class="menu_item">
       {capture name='grn_schedule_GRN_SCH_1035'}{cb_msg module='grn.schedule' key='GRN_SCH-1035' replace='true'}{/capture}
       {grn_link page='schedule/attendance_list' referer_key=$referer_key caption=$smarty.capture.grn_schedule_GRN_SCH_1035 image='image-common/list20.png' }
       </span>
    {/if}
    {if $enable_print}
      <span class="menu_item">
        {capture name='grn_schedule_GRN_SCH_259'}{cb_msg module='grn.schedule' key='GRN_SCH-259' replace='true'}{/capture}
        {grn_link page='schedule/print_personal_month' class='schedule_print_personal_month' caption=$smarty.capture.grn_schedule_GRN_SCH_259 image='print20.gif' event=$event uid=$schedule.user_id gid=$group_id bdate=$bdate}
      </span>
    {/if}
    <!-- GRN2-1956 -->
    {if $enable_print_week}
      <span class="menu_item">
        {capture name='grn_schedule_GRN_SCH_259'}{cb_msg module='grn.schedule' key='GRN_SCH-259' replace='true'}{/capture}
        {grn_link page='schedule/print_personal_week' class='schedule_print_personal_week' caption=$smarty.capture.grn_schedule_GRN_SCH_259 image='print20.gif' event=$event uid=$schedule.user_id gid=$group_id search_text=$search_text bdate=$bdate}
      </span>
    {/if}
    <!-- GRN2-1956 -->
    {if $enable_ical_export}
      <span class="menu_item">
        {capture name='grn_schedule_GRN_SCH_852'}{cb_msg module='grn.schedule' key='GRN_SCH-852' replace='true'}{/capture}
        {grn_link page='schedule/command_personal_month_icalexport' class='schedule_print_personal_month' caption=$smarty.capture.grn_schedule_GRN_SCH_852 image='export20.gif' uid=$uid gid=$gid bdate=$bdate}
      </span>
    {/if}
    {if $management}
        {include file="schedule/_facility_options.tpl"}
    {/if}
    &nbsp;

  </div>
  {grn_load_javascript file="grn/html/schedule.js"}
  <div id="smart_rare_menu_part" style="white-space:nowrap;">
    {assign var=search_form_name value='search'}
    {if $page_info.last == 'group_day' || $page_info.last == 'index'}
      {literal}
      <script language="JavaScript" type="text/javascript">
      <!--
      function search_submit(search_target)
      {
          var f = document.forms["{/literal}{$search_form_name}{literal}"];
          f.target = '_self';
          if(search_target == 'user')
          {
              var gid = document.createElement( "input" );
              gid.type = "hidden";
              gid.name = "gid";
              gid.value = "search";
              f.appendChild(gid);
              f.action = "{/literal}{grn_pageurl page=$page_info.all}{literal}";
          }
          else
          {
              var uid = document.createElement( "input" );
              uid.type = "hidden";
              uid.name = "uid";
              uid.value = "{/literal}{$user_id|escape:'javascript'}{literal}";
              f.appendChild(uid);

              var referer_key = document.createElement( "input" );
              referer_key.type = "hidden";
              referer_key.name = "referer_key";
              referer_key.value = "{/literal}{$referer_key|escape:'javascript'}{literal}";
              f.appendChild(referer_key);

              var referer_bdate_value = __get_referer_bdate();
              if ( referer_bdate_value.length > 0 )
              {
                  var referer_bdate = document.createElement( "input" );
                  referer_bdate.type = "hidden";
                  referer_bdate.name = "referer_bdate";
                  referer_bdate.value = referer_bdate_value;
                  f.appendChild(referer_bdate);
              }
              f.action = "{/literal}{grn_pageurl page='schedule/search'}{literal}";
          }
          f.submit();
      }
      
      var user_search = "{/literal}{cb_msg module='grn.schedule' key='GRN_SCH-192' replace='true'}{literal}";
      var schedule_search = "{/literal}{cb_msg module='grn.schedule' key='GRN_SCH-920' replace='true'}{literal}";
      var type_search = 'schedule';
      
      function change_type_search()
      {
          document.getElementById('type_search').value=type_search;
          if(type_search == 'user')
          {
              type_search = 'schedule';
              document.getElementById('type_search_schedule').innerHTML = user_search + '<span class="schedule-ButtonTypeArrowDown-grn"></span>';
              document.getElementById('choose_type_search').innerHTML = schedule_search;
          }
          else
          {
              type_search = 'user';
              document.getElementById('type_search_schedule').innerHTML = schedule_search + '<span class="schedule-ButtonTypeArrowDown-grn"></span>';
              document.getElementById('choose_type_search').innerHTML = user_search;
          }
      }
      -->
      </script>
      {/literal}
      <div class="search_navi">
        <form name="{$search_form_name}" action="{grn_pageurl page=$page_info.all}" onsubmit="search_submit(document.getElementById('type_search').value);">
          <input id="type_search" type="hidden" name="type_search" value="user">
          <span class="search-schedule-ButtonType-grn">
            <a id="type_search_schedule" href='javascript:'>{cb_msg module='grn.schedule' key='GRN_SCH-192' replace='true'}<span class='search-schedule-ButtonTypeArrowDown-grn'></span></a>
            <div class='search-schedule-dropdownContents'>
                <ul>
                    <li>
                        <a id="choose_type_search" href="javascript:void(0);" onclick="change_type_search();">{cb_msg module='grn.schedule' key='GRN_SCH-920' replace='true'}</a>
                    </li>
                </ul>
            </div>
          </span>
          <div class="searchboxChangeTarget-grn">
          <div class="searchbox-grn">
            <div id="searchbox-schedule" class="input-text-outer-cybozu">
                <input class="input-text-cybozu" type="text" name="search_text" autocomplete="off" value="{$search_text|escape}" onKeyPress="if(event.keyCode == 13) search_submit(document.getElementById('type_search').value); return event.keyCode != 13;">
                <button class="searchbox-submit-cybozu" type="submit"></button>
           </div>
          </div>
          </div>
          <span class="searchboxSub-grn"><a href="{grn_pageurl page='schedule/search' uid=$user_id referer_key=$referer_key}"{if $ajax_flag} onclick="{$rd_func}"{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-194' replace='true'}</a></span>
        </form>
      </div>
    {else}
      {literal}
      <script language="JavaScript" type="text/javascript">
      <!--
      function search_submit()
      {
          var f = document.forms["{/literal}{$search_form_name}{literal}"];
          if(!f)
          {
              return;
          }
          if(arrSearch['schedules'].firstFlag)
          {
              var input_search = document.getElementById( 'schedules_search_text' );
              input_search.value = '';
          }
          var referer_bdate_value = __get_referer_bdate();
          if ( referer_bdate_value.length > 0 )
          {
              var referer_bdate = document.createElement( "input" );
              referer_bdate.type = "hidden";
              referer_bdate.name = "referer_bdate";
              referer_bdate.value = referer_bdate_value;
              f.appendChild(referer_bdate);
          }
          f.submit();
      }
      -->
      </script>
      {/literal}
      <div class="search_navi">
        <form name="{$search_form_name}" action="{grn_pageurl page='schedule/search'}" onsubmit="search_submit();">
          <input type="hidden" name="uid" value="{$user_id|escape}">
          <input type="hidden" name="referer_key" value="{$referer_key|escape}">
          <div class="searchboxChangeTarget-grn">
          <div class="searchbox-grn">
            <div class="searchbox-select-schedule"></div>
              <div id="searchbox-schedule-schedules" class="input-text-outer-schedule searchbox-keyword-schedule">
                  <input id="schedules_search_text" class="input-text-schedule prefix-grn" type="text" name="search_text" autocomplete="off" value="{cb_msg module='grn.schedule' key='GRN_SCH-921' replace='true'}">
                  <input id="searchbox-submit-schedules" class="searchbox-submit-schedule" type="button" onclick="javascript:search_submit();">
              </div>
            <div class="clear_both_0px"></div>
          </div>
          </div>
          <span class="searchboxSub-grn"><a href="{grn_pageurl page='schedule/search' uid=$user_id referer_key=$referer_key}"{if $ajax_flag} onclick="{$rd_func}"{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-194' replace='true'}</a></span>
        </form>
      </div>
    {/if}
  </div>
<div class="clear_both_0px"></div>
</div>
<!--menubar_end-->
{literal}
<script language="JavaScript" type="text/javascript">
<!--
function __get_referer_bdate()
{
    var referer_bdate = '';
    var param_elements = document.getElementsByName('bdate');
    for( var i = 0; i < param_elements.length; i++ )
    {
        if (param_elements[i].getAttribute('value'))
        {
            referer_bdate = param_elements[i].getAttribute('value');
            break;
        }
    }
    return referer_bdate;
}
-->
</script>
{/literal}