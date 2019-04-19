{capture name="notime_event"}{* all day events or todo show here *}
 {if $schedule.allday_event || $schedule.todos || ( $login_id === $user_id && ($expiredPersonalTodo || $expiredSharedTodo)) }
   <td colspan="2" class="allday" rel="{grn_pageurl page='schedule/simple_add' bdate=$schedule.date uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" plid="{$plid}" onMouseOver="GRN_ScheduleSimpleAdd.mouseOverHandler(event, this)" onMouseOut="GRN_ScheduleSimpleAdd.mouseOutHandler(event, this)" plid="{$plid}"{if $schedule.user_type == 'facility'} utype="facility"{/if}>
    <ul class="v_day_ul">
 
     {if $today === $schedule.date && $login_id === $user_id }
       {include file="schedule/expired_todo.tpl" }
     {/if}
     {include file='schedule/todo.tpl' event=$schedule}
     {foreach from=$schedule.allday_event item=event}
         <li style="list-style-type:none;"{if $event.id eq $event_id} class="newevent-grn"{/if}>

         {if $event.absent === 1}
            <div class="schedule_absent">
         {/if}
         
         {grn_image image="allday.gif"}
         
         {if ! $event.private}
            <a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$schedule.date uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" title="{$event.data|grn_noescape}">{/if}{$event.data|grn_noescape}{if $event.is_private}{grn_image image="image-common/privateMark_sub16.png"}{/if}{if $event.type == 'share_repeat' || $event.type == 'repeat'}{grn_image image='repeat16.gif'}{/if}{if $event.report}{grn_image image="report16.gif"}{/if}{if ! $event.private}</a>
         {/if}
         
         {if $event.absent === 1}
            </div>
         {/if}
         </li>
  {/foreach}

    </ul>


   </td>
 {/if}
 {/capture}

{capture name="banner_event"}
 {if $schedule.banner_event}
  {foreach from=$schedule.banner_event item=event}
   <td colspan="2" class="banner">
   {if $event.absent === 1}
    <div class="schedule_absent">
   {/if}
    <a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$schedule.date uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" title="{$event.data|grn_noescape}">{grn_image image='banner16.gif'}{$event.data|grn_noescape}{if $event.is_private}{grn_image image="image-common/privateMark_sub16.png"}{/if}{if $event.report}{grn_image image="report16.gif"}{/if}</a>{if $event.absent === 1}</div>{/if}
   </td>
  {/foreach}
 {/if}
 {/capture}
 
{capture name="time_event"}
 {foreach from=$schedule.time_event item=h_event key=hour}
  {if $hour < 12}
   {assign var="hour_bg" value="m"}
  {elseif $hour >= 12 && $hour < 18}
   {assign var="hour_bg" value="e"}
  {else}
   {assign var="hour_bg" value="a"}
  {/if}
 <tr>
  <td class="personal_day_portlet_hour {$hour_bg}" style="{$font_size}" onMouseOver="this.className=&quot;v_day_bg03 personal_day_portlet_hour&quot;" onMouseOut="this.className=&quot;{$hour_bg} personal_day_portlet_hour&quot;" onClick="v_day_add_{$portlet.plid}(&quot;{$hour}&quot;,&quot;{$hour+1}&quot;)">{$hour}</td>
  <td width="95%" class="v_day_border02" rel="{grn_pageurl page='schedule/simple_add' bdate=$schedule.date set_hour=$hour uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" style="{$font_size}" onMouseOver="GRN_ScheduleSimpleAdd.mouseOverHandler(event, this)" onMouseOut="GRN_ScheduleSimpleAdd.mouseOutHandler(event, this)" plid="{$plid}"{if $schedule.user_type == 'facility'} utype="facility"{/if}>
  {if $h_event.event}
   {foreach name="events" from=$h_event.event item=event}
    {if $event.parent}
<div class="v_day" style="margin-left:{$event.parent*12}px;background:#ffffff;">
    {else}
<div class="v_day" style="background:#ffffff;">
    {/if}
    <div class="v_day_column{if $event.id eq $event_id} newevent-grn{/if}">
      <table class="day_value" cellpadding="0" cellspacing="0" border="0">
       <tr><td class="{$event.type} personal_day_portlet_item_text" style="{$font_size}">{if $event.absent === 1}<div class="schedule_absent" style="{$font_size}">{else}<span style="{$font_size}">{/if}{if $event.conflict}<span class="attention">{capture name='grn_schedule_GRN_SCH_914'}{cb_msg module='grn.schedule' key='GRN_SCH-914' replace='true'}{/capture}{grn_image image="attention16.gif" alt=$smarty.capture.grn_schedule_GRN_SCH_914}</span>{/if}{if ! $event.private}<a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$schedule.date uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" title="{$event.data|grn_noescape}">{/if}{$event.data|cb_mb_truncate:30}{if $event.is_private}<span {$icon_view}>{grn_image image="image-common/privateMark_sub16.png"}</span>{/if}{if $event.type == 'share_repeat' || $event.type == 'repeat'}<span {$icon_view}>{grn_image image='repeat16.gif'}</span>{/if}{if $event.report}{grn_image image="report16.gif"}{/if}{if ! $event.private}</a>{/if}{if $event.absent === 1}</div>{else}</span>{/if}&nbsp;<br><td></tr>
       {grn_schedule_vertical_count size='12' rows=$event.num m_type=$event.m_type m_num=$event.m_num}
      </table>
    </div>
</div>
 <table cellpadding="0" cellspacing="0" border="0" style="border-bottom:1px solid #ffffff;" >
  <tr><td style="vertical-align:top;" valign="top">&nbsp;</td></tr>
 </table>
   {/foreach}
  {else}
<div>
 <div>
  <table cellpadding="0" cellspacing="0" border="0"><tr><td>&nbsp;<br></td></tr></table>
 </div>
</div>
  {/if}
  </td>
 </tr>
 {/foreach}
 <tr>
  <td></td>
  <td>
   <nobr><img src="{$app_path}/grn/image/cybozu/spacer1.gif" height="1" width="1"></nobr><br>
  </td>
 </tr>
{/capture}
{ldelim}
"notime_event":"{$smarty.capture.notime_event|escape:javascript}",
"banner_event":"{$smarty.capture.banner_event|escape:javascript}",
"time_event":"{$smarty.capture.time_event|escape:javascript}"
{rdelim}