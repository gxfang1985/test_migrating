<table width="100%">
 <tr>
 <td nowrap class="v-allign-middle" width="40%">
  <form name="{$form_name}" method="GET" action="{grn_pageurl page=$page_info.all bdate=$bdate uid=$user_id gid=$group_id}">
 {strip}
 {if $member}
  <select name="uid" onChange="this.form.submit()">
{foreach from=$member key=uid item=member}
 {if (string)$user_id === (string)$uid}
   <option value="{$uid}" selected>{$member|grn_noescape}</option>
 {else}
   <option value="{$uid}">{$member|grn_noescape}</option>
 {/if}
{/foreach}
  </select>
{/if}
{capture name='grn_schedule_GRN_SCH_775'}{cb_msg module='grn.schedule' key='GRN_SCH-775' replace='true'}{/capture}{grn_popup_user_select_link_schedule caption=$smarty.capture.grn_schedule_GRN_SCH_775 app_id=$schedule_app_id send_cgi_parameter=true include_org=$include_org system=false system_display=false access_plugin=$access_plugin extension_items=$extension_items}
{/strip}
    <input type="hidden" name="gid" value="{$group_id|escape}">
    <input type="hidden" name="bdate" value="{$bdate|escape}">
    {if $search_text}
        <input type="hidden" name="search_text" value="{$search_text|escape}">
    {/if}
  </form>
 </td>
 <td align="center" class="v-allign-middle nowrap-grn" width="20%">
   <span id="schedule_um__date_title" class="displaydate">{grn_date_format date=$bdate format="DateFull_YM"}</span>
   <span class="viewSubCalendar-grn">
   <span id="showIcon-grn" class="{if $navi_cal_display_flag}showIconOn-grn{else}showIconOff-grn{/if}" title="{if $navi_cal_display_flag}{cb_msg module='grn.schedule' key='GRN_SCH-916' replace='true'}{else}{cb_msg module='grn.schedule' key='GRN_SCH-915' replace='true'}{/if}">
        <span class="subCalendar-grn"></span>
        <img src="{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}" id="wait_image" name="wait_image" style="display:none">
    </span>
  </span>
 </td>
 <td class="v-allign-middle" align="right" nowrap width="40%">
 {strip}
  <div class="moveButtonBlock-grn">
    {if $uid_is_empty}
      {assign var='user_id' value=''}
    {/if}
    <span class="moveButtonBaseDisable-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-781' replace='true'}">
      <a href="javascript:void(0);" id="onloadAble0" name="onloadAble" class="scheduleMove" onclick="if(check_disable(this))CyScheduleUm.ctrl('month_prev',0);return false;" {if $user_agent.app == 'ie'}ondblclick="CyScheduleUm.ctrl('month_prev',0);return false;"{/if} title="{cb_msg module='grn.schedule' key='GRN_SCH-781' replace='true'}"><span class="moveButtonArrowLeftDisable-grn"></span></a>
    </span>
    <span class="moveButtonBaseDisable-grn">
      <a href="javascript:void(0);" id="onloadAble2" name="onloadAble" class="scheduleMove" onclick="if(check_disable(this))location.href='{grn_pageurl page=$page_info.all bdate=$date uid=$user_id gid=$group_id search_text=$search_text}';return false;"> {cb_msg module='grn.schedule' key='GRN_SCH-782' replace='true'} </a>
    </span>
    <span class="moveButtonBaseDisable-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-783' replace='true'}">
      <a href="javascript:void(0);" id="onloadAble4" name="onloadAble" class="scheduleMove" onclick="if(check_disable(this))CyScheduleUm.ctrl('month_next',0);return false;" {if $user_agent.app == 'ie'}ondblclick="CyScheduleUm.ctrl('month_next',0);return false;"{/if}><span class="moveButtonArrowRightDisable-grn"></span></a>
    </span>
  </div>
{/strip}
{include file="schedule/_show_full_short_title.tpl" function_click="showFullShortTitle('show_full_titlepersonal_month','personal_month_calendar','personal_month',true);" schedule_id='personal_month_calendar'}
{include file='schedule/_display_options.tpl' page_key='personal_month' schedule_id='personal_month_calendar' plid='personal_month' show_full_title_option=true show_todos_option=true}
 </td>
 </tr>
</table>
{include file="schedule/_schedule_navi_calendar_js.tpl"}