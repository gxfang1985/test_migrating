{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}

{include file='schedule/_title_search.tpl'}
<div class="mainarea">
<div class="mainareaSchedule-grn">
{assign var='form_name' value=$smarty.template|basename}
<div id="one_parts">
 <div id="view">
{include file="schedule/_tab_menu.tpl"}
<form name="{$form_name}" method="post" action="{grn_pageurl page=$page_info.all bdate=$bdate uid=$user_id}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{include file="schedule/_year_navi.tpl"}
 <table width="100%">
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
   {assign var='day_color' value='year_holiday'}
   {assign var='value_color' value='year_holiday'}
  {elseif $year_event.date_type == 's_date_sunday'}
   {assign var='day_color' value='year_sunday'}
   {assign var='value_color' value='year_sunday'}
  {elseif $year_event.date_type == 's_date_saturday'}
   {assign var='day_color' value='year_saturday'}
   {assign var='value_color' value='year_saturday'}
  {elseif $year_event.date_type == 's_date_today'}
   {assign var='day_color' value='s_date_today'}
   {assign var='value_color' value='s_date_today'}
  {else}
   {assign var='day_color' value='year_weekday'}
   {assign var='value_color' value='year_weekday_contents'}
  {/if}
      <td width="20%" align="center" class="{$day_color}" nowrap>
      {grn_link page='schedule/personal_day' bdate=$year_event.date caption=$c_day}
      </td>
      <td width=80% class="{$value_color}">{foreach from=$year_event.calendar item=calendar}{grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon}{/foreach}</td>
     </tr>
 {/foreach}
    </table>
   </td>
{/foreach}
  </tr>
 </table>
  <div class="none">&nbsp;</div>
  <table width="100%">
   <tr>
    <td class="v-allign-middle" align="right">
      <div class="moveButtonBlock-grn">
        {strip}
            <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-668' replace='true'}">
                <a href="{grn_pageurl page=$page_info.all bdate=$bdate_prevyear uid=$schedule.user_id search_text=$search_text}">
                    <span class="moveButtonArrowLeft-grn"></span>
                </a>
            </span>
            <span class="moveButtonBase-grn" title="">
                <a href="{grn_pageurl page=$page_info.all uid=$schedule.user_id search_text=$search_text}">
                    {cb_msg module='grn.schedule' key='GRN_SCH-669' replace='true'}
                </a>
            </span>
            <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-670' replace='true'}">
                <a href="{grn_pageurl page=$page_info.all bdate=$bdate_nextyear uid=$schedule.user_id search_text=$search_text}">
                    <span class="moveButtonArrowRight-grn"></span>
                </a>
            </span>
        {/strip}
      </div>
    </td>
   </tr>
  </table>
 </div>
 <!--view_end--->
</div>
<input type="hidden" name="bdate" value="{$bdate|escape}">
</form>

</div>
{include file='grn/footer.tpl'}
