{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
<div class="mainareaSchedule-grn">
{grn_title title=$page_title class=$page_info.parts[0] style="display:inline-block;"}

<form name="{$form_name}" id="{$form_name}" method="post" action="{grn_pageurl page='schedule/adjust_result'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="uid" value="{$user_id|escape}">
<input type="hidden" name="gid" value="{$group_id|escape}">
<input type="hidden" name="eid" value="{$event_id|escape}">
<input type="hidden" name="bdate" value="{$bdate|escape}">
<input type="hidden" name="referer_key" value="{$referer_key|escape}">

<input type="hidden" name="selected_users_sUID[]" value="{$selected_members_ids|@implode:':'}">
<input type="hidden" name="selected_users_sITEM[]" value="{$selected_facilities|@implode:':'}">

<input type="hidden" name="term_" value="">

<div class="explanation mTop5 mBottom5">
{cb_msg module='grn.schedule' key='GRN_SCH-625' replace='true'}<br>
{cb_msg module='grn.schedule' key='GRN_SCH-626' replace='true'}
</div>

{include file="grn/show_validation_errors.tpl"}
{include file='grn/indispensable.tpl'}
  <table class="std_form">

    <tr valign="top">
      <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-627' replace='true'}({$members_count|escape}{cb_msg module='grn.schedule' key='GRN_SCH-628' replace='true'}</th>
      <td>{include file="schedule/_adjust_members.tpl"}</td>
    </tr>

    <tr valign="top">
      <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-631' replace='true'}</th>
      <td>
      {foreach name='facility' from=$selected_facilities item=fid}
        <span class="inline_block_grn">{grn_image image="facility20.gif"}{$facilities_info.$fid.col_name|escape}{if $facility_access_list.$fid.add == GRN_SCHD_ACCESS_DENY}<span class="small"><span class="font_red">{cb_msg module='grn.schedule' key='GRN_SCH-632' replace='true'}</span></span>{/if}</span>
      {/foreach}
      </td>
      </tr>
      <tr valign="top">
      <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-633' replace='true'}</th>
      <td>
        {include file='schedule/_adjust_date.tpl'}
      </td>
    </tr>

    <tr valign="top">
      <th nowrap>{capture name='grn_schedule_GRN_SCH_634'}{cb_msg module='grn.schedule' key='GRN_SCH-634' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_GRN_SCH_634 necessary=TRUE}
      </th>
      <td>
      <div class="sub_title">{cb_msg module='grn.schedule' key='GRN_SCH-865' replace='true'}</div>
      <div>
        {capture name='grn_schedule_GRN_SCH_635'}{cb_msg module='grn.schedule' key='GRN_SCH-635' replace='true'}{/capture}{validate form=$form_name field="term_" criteria="grn_schedule_timeNotEmpty" message=$smarty.capture.grn_schedule_GRN_SCH_635 transform="cb_trim" append="validation_errors"}{grn_select_time prefix='target_start_' display_minute=FALSE necessary=TRUE time=$set_time}{include file='grn/time_selector.tpl' start_hour='target_start_hour' end_hour='target_end_hour' target_form=$form_name}{cb_msg module='grn.schedule' key='GRN_SCH-636' replace='true'}{grn_select_time prefix='target_end_' display_minute=FALSE necessary=TRUE time=$end_time}
      </div>
      <div class="br">&nbsp;</div>
      <div class="sub_title">{cb_msg module='grn.schedule' key='GRN_SCH-866' replace='true'}</div>
      <div>
      <select name="term_hour">
        <option value="" {if is_null( $term_hour ) || $term_hour === ''}selected{/if}>--{cb_msg module='grn.schedule' key='GRN_SCH-638' replace='true'}</option>
      {section name=hour loop=10 step=1}
        <option value="{$smarty.section.hour.iteration}" {if ! is_null( $term_hour ) && $smarty.section.hour.iteration === $term_hour}selected{/if}>{$smarty.section.hour.iteration}{cb_msg module='grn.schedule' key='GRN_SCH-639' replace='true'}
      {/section}
      </select>
        <select name="term_minute"><option value="" {if is_null( $term_minute ) || $term_minute === ''}selected{/if}>--{cb_msg module='grn.schedule' key='GRN_SCH-640' replace='true'}
        </option>
        {section name=minute loop=60 step=$minute_interval}
          <option value="{$smarty.section.minute.index}" {if ! is_null( $term_minute ) && $smarty.section.minute.index === $term_minute}selected{/if}>
          {if $smarty.section.minute.index < 10}0{/if}{$smarty.section.minute.index}{cb_msg module='grn.schedule' key='GRN_SCH-641' replace='true'}
          </option>
        {/section}
      </select></div>
      </td>
    </tr>
    <tr valign="top">
      <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-642' replace='true'}</th>
      <td>
      {if is_null( $searchMethod ) || $searchMethod !== 'AND'}
        {capture name='grn_schedule_GRN_SCH_643'}{cb_msg module='grn.schedule' key='GRN_SCH-643' replace='true'}{/capture}{grn_radio name='searchMethod' id='or' value='OR' caption=$smarty.capture.grn_schedule_GRN_SCH_643 checked=TRUE}
      {else}{capture name='grn_schedule_GRN_SCH_644'}{cb_msg module='grn.schedule' key='GRN_SCH-644' replace='true'}{/capture}{grn_radio name='searchMethod' id='or' value='OR' caption=$smarty.capture.grn_schedule_GRN_SCH_644}
      {/if}&nbsp;
      {if ! is_null( $searchMethod ) && $searchMethod === 'AND'}
        {capture name='grn_schedule_GRN_SCH_645'}{cb_msg module='grn.schedule' key='GRN_SCH-645' replace='true'}{/capture}{grn_radio name='searchMethod' id='and' value='AND' caption=$smarty.capture.grn_schedule_GRN_SCH_645 checked=TRUE}
      {else}{capture name='grn_schedule_GRN_SCH_646'}{cb_msg module='grn.schedule' key='GRN_SCH-646' replace='true'}{/capture}{grn_radio name='searchMethod' id='and' value='AND' caption=$smarty.capture.grn_schedule_GRN_SCH_646}
      {/if}
      </td>
    </tr>

   <tr>
     <td></td>
     <td>
         {strip}
             <div class="mTop10">
             {capture name='grn_schedule_GRN_SCH_647'}{cb_msg module='grn.schedule' key='GRN_SCH-647' replace='true'}{/capture}
             {grn_button action="submit" spacing="tight" caption=$smarty.capture.grn_schedule_GRN_SCH_647 onclick="adjust_submit('back');return false;" id="schedule_button_back"}

             {capture name='grn_schedule_GRN_SCH_648'}{cb_msg module='grn.schedule' key='GRN_SCH-648' replace='true'}{/capture}
             {grn_button ui="main" spacing="loose" action="submit" caption=$smarty.capture.grn_schedule_GRN_SCH_648 onclick="adjust_submit('search');return false;" id="schedule_button_save"}

             {grn_button action="cancel" onclick="adjust_cancel('$backlink');" id="schedule_button_cancel"}
             </div>
         {/strip}
    </td>
  </tr>
  </table>

</form>
{literal}
<script language="JavaScript" type="text/javascript">
var check_add = false;
function adjust_submit(action)
{
    if(check_add)
    {
        return;
    }
    check_add = true;
    f = document.forms["{/literal}{$form_name|escape:'javascript'}{literal}"];
    f.target = '_self';

    if (action == 'search')
    {
        f.action = '{/literal}{grn_pageurl page="schedule/adjust_result"}{literal}';
    }
    else if (action == 'back')
    {
        f.action = '{/literal}{grn_pageurl page="schedule/adjust_search"}{literal}';
    }
    f.submit();
}
var check_cancel = false;
function adjust_cancel(url)
{
    if(check_cancel)
    {
        return;
    }
    check_cancel = true;
    url = url + 'event={/literal}{$event_id|escape:"javascript"}{literal}';
    url = url + '&bdate={/literal}{$bdate|escape:"javascript"}{literal}';

    var page = '{/literal}{$page|escape:"javascript"}{literal}';
    if (page === "schedule/personal_month") {
        url = url + '&uid={/literal}{$user_id|escape:"javascript"}{literal}';
    } else {
        url = url + '&uid=';
    }

    url = url + '&gid={/literal}{$group_id|escape:"javascript"}{literal}';
    location.href = url;
}
</script>
{/literal}
</div>
{include file='grn/footer.tpl'}
