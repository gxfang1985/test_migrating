<center>
<div id="schedule_calendar"{if $navi_cal_display_flag == FALSE} style="display:none"{/if}>
  {include file="schedule/_select_calendar_month.tpl" location=$location}
</div>
</center>
<script language="javascript" type="text/javascript">
{if $uid_is_empty}
    {assign var='user_id' value=''}
{/if}
{if $gid_is_empty}
    {assign var='group_id' value=''}
{/if}
{literal}
<!--
function doMoveCalednar( move_date )
{

    var url = "{/literal}{grn_pageurl page='schedule/schedule_navi_calendar_month' location=$location}{literal}&uid={/literal}{$user_id|escape}{literal}&gid={/literal}{$group_id|escape}{literal}&vwdate={/literal}{$view_date|escape}{literal}"+'&cndate='+move_date;
    ajax = new Ajax.Updater( "schedule_calendar", url, { method:'get', asynchronous: true } );
}

//-->
{/literal}
</script>

