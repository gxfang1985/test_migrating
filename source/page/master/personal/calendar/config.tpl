{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/calendar/command_config'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
   {capture name='grn_personal_calendar_GRN_PRS_CA_74'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-74' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_74}
  </th>
  <td>
   {include file='personal/calendar/shared_calendar.tpl' initialize_item=$shared_calendars select_size=10}
  </td>
 </tr>

 <tr>
  <td colspan="2"><br>
      <div class="sub_title">{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-32' replace='true'}
  </td>
 </tr>
{foreach from=$extensions key=key item=value}
    {if $key == 'weather'}
        {include file='grn/_calendar_extension_modify_weather.tpl' disable=$value.disable location_list=$value.location_list}
    {/if}
    {if $key == 'six_kinds_of_day'}
        {include file='grn/_calendar_extension_modify_six_kinds_of_day.tpl' field_name=$key|cat:'_visible[]' checked=$value.visible disable=$value.disable is_event_receive=$value.is_event_receive}
    {/if}
{/foreach}
 <tr>
  <td></td>
  <td>
       {capture name='grn_personal_calendar_GRN_PRS_CA_33'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-33' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_33 onclick="grn_onsubmit_common(this.form);"}
       {grn_button_cancel}
  </td>
 </tr>
</table>

</form>
{include file='grn/personal_footer.tpl'}
