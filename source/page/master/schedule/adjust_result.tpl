{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{include file="grn/user_add_js.tpl"}
<div class="mainareaSchedule-grn">
{grn_load_javascript file="grn/html/schedule.js"}
{grn_title title=$page_title class=$page_info.parts[0] style="display:inline-block;"}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" id="{$form_name}" method="post" action="{grn_pageurl page='schedule/command_adjust_add'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="uid" value="{$user_id|escape}">
<input type="hidden" name="gid" value="{$group_id|escape}">
<input type="hidden" name="eid" value="{$event_id|escape}">
<input type="hidden" name="bdate" value="{$bdate|escape}">
<input type="hidden" name="referer_key" value="{$referer_key|escape}">
<input type="hidden" name="set_hour" value="{$set_hour|escape}">
<input type="hidden" name="end_hour" value="{$end_hour|escape}">
<input type="hidden" name="term_hour" value="{$term_hour|escape}">
<input type="hidden" name="term_minute" value="{$term_minute|escape}">
<input type="hidden" name="event_around" value="{$event_around|escape}">
<input type="hidden" name="around_time" value="{$around_time|escape}">
<input type="hidden" name="searchMethod" value="{$searchMethod|escape}">
<input type="hidden" name="is_result" value="1">
{foreach from=$except_hours item=except_hour key=key}
<input type="hidden" name="except_hours_{$key|escape}" value="1" />
<input type="hidden" name="except_start_{$key|escape}_hour" value="{$except_hour.start_time->hour|escape}" />
<input type="hidden" name="except_end_{$key|escape}_hour" value="{$except_hour.end_time->hour|escape}" />
{/foreach}

{foreach from=$selected_date_list item=sdate}
<input type="hidden" name="sdate_list[]" value="{$sdate->format()|escape}">
{/foreach}
<input type="hidden" name="selected_users_sUID[]" value="{$selected_members_ids|@implode:':'}">
<input type="hidden" name="selected_users_sITEM[]" value="{$selected_facilities|@implode:':'}">

{literal}
<script language="JavaScript" type="text/javascript">
<!--
function grn_get_selected_facilities_form()
{
    var form_string = '';
    {/literal}
    {foreach from=$selected_facilities item=fid}
    form_string += '<input type="hidden" name="sITEM[{$fid|escape}]" value="{$fid|escape}">';
    {/foreach}
    {literal}
    return form_string;
}

{/literal}{if $form_name}{literal}
var form_name = document.getElementById('{/literal}{$form_name}{literal}');
{/literal}{/if}{literal}
//-->
</script>
{/literal}

<p>
<div class="explanation mTop5 mBottom5">
{if $candidates_count > 0}
  {if $add_permitted === TRUE && $add_permitted_facilities === TRUE}{cb_msg module='grn.schedule' key='GRN_SCH-501' replace='true'}
  {else}<span class="font_red">{cb_msg module='grn.schedule' key='GRN_SCH-502' replace='true'}</span>
  {/if}
{else}{cb_msg module='grn.schedule' key='GRN_SCH-503' replace='true'}
{/if}
</div>
</p>

<p>
  <table class="std_form">
  {if $candidates_count > 0 }
    <tr valign="top">
      <th>{cb_msg module='grn.schedule' key='GRN_SCH-504' replace='true'}</th>
      <td>
          {foreach name="candidates" from=$candidates key=faid item=candidate}
          {if $faid != GRN_SCHD_ADJUST_NO_FACILITY && count( $candidate ) > 0}
            {grn_image image="facility20.gif"}{$facilities_info.$faid.col_name|escape}
            {if $facilities_info.$faid.approval_facility == TRUE}{if !isset($hasUsingPurpose)}{assign var='hasUsingPurpose' value=true}{/if}{/if}
          {elseif $faid == GRN_SCHD_ADJUST_NO_FACILITY && count( $candidate ) > 0 && $add_permitted_facilities === TRUE && $approvalFacilityIds }
              {assign var='hasUsingPurpose' value=true}
          {/if}
          <table class="std_form">
          {foreach name="candidate" from=$candidate item=datetime}
            <tr>
              <td>
               {* 以下の条件を満たす時に、チェックボックスをdisableにする
                  1. 登録権限のないユーザー・組織がいる ||
                  2. OR検索で該当の施設に登録権限が無い ||
                  3. AND検索で施設に登録権限がない
                *}
               {if ( $add_permitted === FALSE ) ||
                   ( $faid !== GRN_SCHD_ADJUST_NO_FACILITY && 
                     $facility_access_list.$faid.add === GRN_SCHD_ACCESS_DENY ) ||
                   ( $searchMethod == 'AND' && $add_permitted_facilities === FALSE )
               }
                 <input type="checkbox" name="datetimes[{$faid}][]" value="{$datetime.date->format()} {$datetime.set_time->format()}{$delimiter}{$datetime.date->format()} {$datetime.end_time->format()}" disabled>
               {else}
                 <input type="checkbox" name="datetimes[{$faid}][]" value="{$datetime.date->format()} {$datetime.set_time->format()}{$delimiter}{$datetime.date->format()} {$datetime.end_time->format()}" {if $facilities_info.$faid.approval_facility == TRUE || $faid == GRN_SCHD_ADJUST_NO_FACILITY && $approvalFacilityIds } class="require_approval" {/if}>
               {/if}
               {grn_date_format date=$datetime.date format="DateLong_YMDW"}&nbsp;
               {grn_date_format date=$datetime.set_time format="TimeLong_HM"}&nbsp;-&nbsp;
               {grn_date_format date=$datetime.end_time format="TimeLong_HM"}
               {if $searchMethod == 'AND'}
               {include file="schedule/_confirmview_adjust_search.tpl" index=$smarty.foreach.candidate.iteration date=$datetime.date start_hour=$set_hour end_hour=$end_hour}
{else}
               {include file="schedule/_confirmview_adjust_search.tpl" index=$smarty.foreach.candidate.iteration date=$datetime.date start_hour=$set_hour end_hour=$end_hour}
{/if}
              </td>
            </tr>
          {/foreach}

          </table>
          {/foreach}
            <font size="-1">
            {cb_msg module='grn.schedule' key='GRN_SCH-510' replace='true'}<br>
            {cb_msg module='grn.schedule' key='GRN_SCH-512' replace='true'}
            </font>
      </td>
    </tr>
  {if $add_permitted === TRUE && $add_permitted_facilities === TRUE}

    {** -------------- GTM-1676 START ----------------- **}
    {if $hasUsingPurpose}
      {include file="schedule/_using_purpose.tpl" form_name=$form_name usingPurposeValue='' usingApprovalFacility=false}
      {literal}
      <script language="JavaScript" type="text/javascript">
        jQuery(document).ready(function(){
            var usingPurposeElement = jQuery( "#using_purpose_element" );
            var usingPurpose = jQuery( "#using_purpose" );
            jQuery('.require_approval').click(function(event)
            {
                if(jQuery(document).find('input[type=checkbox][class*=require_approval]:checked').length > 0)
                {
                    usingPurposeElement.show();
                }
                else
                {
                    usingPurpose.val('');
                    usingPurposeElement.hide();
                }
            });
        });
      </script>
      {/literal}
    {/if}
    {** -------------- GTM-1676 END   ----------------- **}

    <tr valign="top">
      <th>{cb_msg module='grn.schedule' key='GRN_SCH-513' replace='true'}</th>
      <td><select menu="scuedule_menu" name="menu" class="hidden">
      {if $schedule_event.selectmenu !== FALSE && $schedule_event.selectmenu !== '' && ! is_null( $schedule_event.selectmenu )}
      <option value="{$schedule_event.selectmenu|escape}">{$schedule_event.selectmenu|escape}</option>
     {/if}
      <option value="">-----</option>
     {foreach from=$menus key=menu_id item=menu}
      <option value="{$menu[0]|escape};#{$menu[1]|escape}">{$menu[0]|escape}</option>
     {/foreach}
    </select>&nbsp;{grn_text name="title" value=$schedule_event.title size="80" disable_return_key=true}</td>
    </tr>

    {if $use_private}
      {include file="schedule/_private_menu.tpl"}
    {/if}

    {include file="schedule/_address_menu.tpl"}

    <tr valign="top">
      <th>{cb_msg module='grn.schedule' key='GRN_SCH-514' replace='true'}</th>
      <td>{grn_textarea name="memo" value=$schedule_event.memo rows="5" cols="65"}</td>
    </tr>

    <tr valign="top">
      <th>{cb_msg module='grn.schedule' key='GRN_SCH-515' replace='true'}</th>
      <td>
      {capture name='grn_schedule_GRN_SCH_516'}{cb_msg module='grn.schedule' key='GRN_SCH-516' replace='true'}{/capture}{grn_checkbox name="temporary_adjust_search" id="temporary_adjust_search" value="1" caption=$smarty.capture.grn_schedule_GRN_SCH_516}<br>
      <font size="-1">{cb_msg module='grn.schedule' key='GRN_SCH-517' replace='true'}</font>
      </td>
    </tr>

  {/if}

    <tr valign="top">
      <th>{cb_msg module='grn.schedule' key='GRN_SCH-519' replace='true'}({$members_count|escape}{cb_msg module='grn.schedule' key='GRN_SCH-520' replace='true'}</th>
      <td>{include file="schedule/_adjust_members.tpl"}</td>
    </tr>

    <tr valign="top">
      <th>{cb_msg module='grn.schedule' key='GRN_SCH-523' replace='true'}</th>
      <td>{foreach name='facility' from=$selected_facilities item=fid}
        <span class="inline_block_grn">{grn_image image="facility20.gif"}{$facilities_info.$fid.col_name|escape}{if $facility_access_list.$fid.add == GRN_SCHD_ACCESS_DENY}<span class="small"><span class="font_red">{cb_msg module='grn.schedule' key='GRN_SCH-524' replace='true'}</span></span>{/if}</span>
      {/foreach}</td>
    </tr>

<!--extended_items-->
{if $add_permitted_facilities === TRUE && $selected_facilities|@count > 0}
    {include file='schedule/_action_item_contents.tpl' extended_items=$extended_items}
{/if}
<!--extended_items_end-->

  {/if}
    <tr valign="top">
      <td></td>
      <td>
          {strip}
              <div class="mTop10">
              {capture name='grn_schedule_GRN_SCH_525'}{cb_msg module='grn.schedule' key='GRN_SCH-525' replace='true'}{/capture}
              {grn_button action="submit" spacing="tight" caption=$smarty.capture.grn_schedule_GRN_SCH_525 onclick="adjust_submit('back');return false;" id="schedule_button_back"}

              {if $candidates_count > 0}
                  {if $add_permitted === TRUE && $add_permitted_facilities === TRUE}
                      {capture name='grn_schedule_GRN_SCH_526'}{cb_msg module='grn.schedule' key='GRN_SCH-526' replace='true'}{/capture}
                      {capture name='schedule_submit_button_onclick'}
                          grn.page.schedule.add.schedule_submit(form_name, '{grn_pageurl page='schedule/command_adjust_add'}');return false;
                      {/capture}
                      {grn_button ui="main" spacing="loose" caption=$smarty.capture.grn_schedule_GRN_SCH_526 onclick=$smarty.capture.schedule_submit_button_onclick id="schedule_submit_button"}
                  {/if}
              {/if}

              {capture name='grn_schedule_GRN_SCH_527'}{cb_msg module='grn.schedule' key='GRN_SCH-527' replace='true'}{/capture}
              {capture name='schedule_button_cancel_onclick'}
                  adjust_cancel('{$backlink}');return false;
              {/capture}
              {grn_button action="cancel" caption=$smarty.capture.grn_schedule_GRN_SCH_527 onclick=$smarty.capture.schedule_button_cancel_onclick id="schedule_button_cancel"}
              </div>
          {/strip}
      </td>
    </tr>
  </table>
</p>

</form>
{include file='schedule/_check_error_add_modify_schedule.tpl'}
{literal}
<script language="JavaScript" type="text/javascript">
<!--

var check_submit = false;
function adjust_submit(action)
{
    if(check_submit)
    {
        return;
    }
    check_submit = true;
    f = document.forms["{/literal}{$form_name|escape:'javascript'}{literal}"];
    f.target = '_self';

    if (action == 'add')
    {
        f.action = '{/literal}{grn_pageurl page="schedule/command_asjust_add"}{literal}';
    }
    else if (action == 'back')
    {
        f.action = '{/literal}{grn_pageurl page="schedule/adjust_constraint"}{literal}';
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
    url = url + 'eid={/literal}{$event_id|escape:"javascript"}{literal}';
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

//-->
</script>
{/literal}
</div>
{include file='grn/footer.tpl'}
