{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
<div class="mainareaSchedule-grn">
{grn_load_javascript file="grn/html/schedule.js"}
<div><span class="bold">{grn_date_format format='DateFull_YMDW' date=$bdate}</span><a href="javascript:void(0);display_on_off('display_day_open:display_swith_image_open:display_swith_image_close')"><span id="display_swith_image_open" class="mLeft10">{cb_msg module='grn.schedule' key='GRN_SCH-728' replace='true'}{capture name='grn_schedule_GRN_SCH_729'}{cb_msg module='grn.schedule' key='GRN_SCH-729' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_730'}{cb_msg module='grn.schedule' key='GRN_SCH-730' replace='true'}{/capture}{grn_image image='addressee_on20.gif' alt=$smarty.capture.grn_schedule_GRN_SCH_729 title=$smarty.capture.grn_schedule_GRN_SCH_730}</span><span id="display_swith_image_close" class="mLeft10" style="display:none;">{cb_msg module='grn.schedule' key='GRN_SCH-731' replace='true'}{capture name='grn_schedule_GRN_SCH_732'}{cb_msg module='grn.schedule' key='GRN_SCH-732' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_733'}{cb_msg module='grn.schedule' key='GRN_SCH-733' replace='true'}{/capture}{grn_image image='addressee_off20.gif' alt=$smarty.capture.grn_schedule_GRN_SCH_732 title=$smarty.capture.grn_schedule_GRN_SCH_733}</span></a></div>
<div id="display_day_open" style="display:none;">
{include file='schedule/_member_day.tpl'}
</div>

{grn_title title=$page_title class=$page_info.parts[0] style="display:inline-block;"}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" id="{$form_name}" method="post" action="{grn_pageurl page='schedule/adjust_constraint'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="uid" value="{$user_id|escape|escape:"javascript"}">
<input type="hidden" name="gid" value="{$group_id|escape}">
<input type="hidden" name="eid" value="{$event_id|escape}">
<input type="hidden" name="bdate" value="{$bdate|escape}">
<input type="hidden" name="referer_key" value="{$referer_key|escape}">
<div class="explanation mTop3 mBottom5">
{cb_msg module='grn.schedule' key='GRN_SCH-734' replace='true'}<br>
{cb_msg module='grn.schedule' key='GRN_SCH-735' replace='true'}
</div>
 <table class="std_form">
  <tr valign="top">
   <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-736' replace='true'}</th>
   <td>
    {grn_member_add name='member_select' form_name=$form_name selected_users=$selected_users app_id='schedule' access_plugin=$view_plugin include_org=$show_organize popup_include_org=$show_organize org_direct=TRUE is_calendar=TRUE}
   </td>
  </tr>
  <tr valign="top">
   <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-737' replace='true'}</th>
   <td>
       {include file='schedule/facility_add.tpl' initialize_item=$selected_facilities all_facilities=$all_facilities}
   </td>
  </tr>
  <tr>
   <td></td>
   <td>
      {literal}
      <script language="JavaScript" type="text/javascript">
      <!--
      var check_add = false;
      function schedule_submit(f)
      {
          if(check_add)
          {
              return;
          }
          check_add = true;
          grn.component.member_add.get_instance("member_select").prepareSubmit();
          grn.component.facility_add.get_instance("facility_select").prepareSubmit();
          f.target = '_self';
          f.action = '{/literal}{grn_pageurl page='schedule/adjust_constraint'}{literal}';
          f.submit();
      }
      {/literal}{if $form_name}{literal}
      var form_name = document.getElementById('{/literal}{$form_name}{literal}');
      {/literal}{/if}{literal}
     //-->
     </script>
     {/literal}

    <div class="mTop10 buttonArea-grn">
        {strip}
            {capture name='grn_schedule_GRN_SCH_738'}{cb_msg module='grn.schedule' key='GRN_SCH-738' replace='true'}{/capture}
            {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_schedule_GRN_SCH_738 onclick="schedule_submit(form_name);return false;" id="schedule_submit_button"}

            {capture name='grn_schedule_GRN_SCH_739'}{cb_msg module='grn.schedule' key='GRN_SCH-739' replace='true'}{/capture}
            {capture name='schedule_button_cancel_onclick'}
                adjust_cancel('{$backlink}');return false;
            {/capture}
            {grn_button action="cancel" caption=$smarty.capture.grn_schedule_GRN_SCH_739 onclick=$smarty.capture.schedule_button_cancel_onclick id="schedule_button_cancel"}
        {/strip}
    </div>
   </td>
  </tr>
 </table>
</form>
{literal}
<script language="JavaScript" type="text/javascript">
<!--
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

//-->
</script>
{/literal}
</div>
{include file='grn/footer.tpl'}
