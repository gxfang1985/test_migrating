{if $portlet.settings.font_size == "large"}
 {assign var="font_size" value='font-size:140%;'}
{elseif $portlet.settings.font_size == "normal"}
 {assign var="font_size" value=''}
{elseif $portlet.settings.font_size == "small"}
 {assign var="font_size" value='font-size:70%;'}
{/if}
<div style="{$font_size}">
<form name="personal_year{$portlet.ppid}" method="post" action="{grn_pageurl page='schedule/personal_year'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <table class="top_title">{strip}
        <tbody>
        <tr>
            <td>
                <span class="portlet_title_grn">
                    {grn_link page='schedule/personal_year' caption=$page_title}
                </span>
            </td>
        </tr>
        </tbody>
    </table>{/strip}

<div class="portal_frame portal_frame_schedule_year_grn">
 <table class="year_table">
  <tr>
   <td colspan="6">
{include file="schedule/_year_navi.tpl" year_navi_class='personalYearPortletUpper-grn'}
   </td>
  </tr>
  <tr>
{foreach from=$schedule.year key=c_month item=year}
 {if $c_month == '7'}
  </tr>
  <tr>
 {/if}
   <td width="16%" valign="top">
    <table class="year_month_table">
     <tr><th colspan="2" nowrap>{cb_msg module='fw.date' key='MonthFull'|cat:$c_month|escape}</th></tr>
 {foreach from=$year.schedule_event key=c_day item=year_event}
     <tr>
  {if $year_event.date_type == 's_date_holiday'}
   {assign var='day_color' value='#FFDBDE'}
   {assign var='value_color' value='#FFDBDE'}
  {elseif $year_event.date_type == 's_date_sunday'}
   {assign var='day_color' value='#FFDBDE'}
   {assign var='value_color' value='#FFDBDE'}
  {elseif $year_event.date_type == 's_date_saturday'}
   {assign var='day_color' value='#D6EFFF'}
   {assign var='value_color' value='#D6EFFF'}
  {elseif $year_event.date_type == 's_date_today'}
   {assign var='day_color' value='#D6F6D9'}
   {assign var='value_color' value='#D6F6D9'}
  {else}
   {assign var='day_color' value='#EEEEEE'}
   {assign var='value_color' value='#ffffff'}
  {/if}
      <td width="20%" align="center" bgcolor="{$day_color}" nowrap>
       {grn_link page='schedule/personal_day' bdate=$year_event.date caption=$c_day}
      </td>
      <td width=80% bgcolor="{$value_color}">{foreach from=$year_event.calendar item=calendar}{grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon}{/foreach}</td>
     </tr>
 {/foreach}
    </table>
   </td>
{/foreach}
  </tr>
 </table>
<input type="hidden" name="bdate" value="{$bdate}">
</form>
</div> <!--end of portal_frame -->

</div>