{assign var='form_name' value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="refresh" value="">
<input type="hidden" name="pid" value="{$portlet.pid}">
<input type="hidden" name="plid" value="{$portlet.plid}">
<input type="hidden" name="ppid" value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.portlet' key='GRN_POT_PO-1' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_portal_portlet_GRN_POT_PO_2'}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-2' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_portlet_GRN_POT_PO_2}
  </th>
  <td>
       <select name="system_calendar">
        {foreach from=$calendars key=cid item=calendar}
          <option value="{$cid}" {if $calendar.selected}selected{/if}>{$calendar.name|escape}
        {/foreach}
       </select>
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.portlet' key='GRN_POT_PO-3' replace='true'}
  </th>
  <td>
      {grn_select name='month_type' id='month_type' value='1' options=$month_type_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.portlet' key='GRN_POT_PO-4' replace='true'}
  </th>
  <td>
      {capture name='grn_portal_portlet_GRN_POT_PO_5'}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-5' replace='true'}{/capture}{grn_checkbox name='start_wday' id='start_wday' value='1' caption=$smarty.capture.grn_portal_portlet_GRN_POT_PO_5 checked=$portlet.settings.start_wday}
  </td>
 </tr>

 <tr>
  <td colspan="2"><br>
    <div class="sub_title">{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-6' replace='true'}</div>
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
       {capture name='grn_portal_portlet_GRN_POT_PO_7'}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-7' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_portlet_GRN_POT_PO_7}
       {if $display == 'set-system'}
        {capture name='grn_portal_portlet_GRN_POT_PO_8'}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-8' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_portlet_GRN_POT_PO_8 page='portal/system/view' pid=$portlet.pid}
       {elseif $display == 'set-operation'}
        {capture name='grn_portal_portlet_GRN_POT_PO_9'}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-9' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_portlet_GRN_POT_PO_9 page='portal/operation/view' pid=$portlet.pid}
       {else}
        {capture name='grn_portal_portlet_GRN_POT_PO_10'}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-10' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_portlet_GRN_POT_PO_10 page='portal/personal/view' pid=$portlet.pid}
       {/if}
  </td>
 </tr>
</table>

</form>
