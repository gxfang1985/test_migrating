<center><img src="{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}" id="wait_image" name="wait_image" style="display:none">

<div id="schedule_calendar"{if $navi_cal_display_flag == FALSE} style="display:none"{/if}>
  {include file="schedule/_select_calendar.tpl" location=$location}
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
function doMoveCalednar( move_date, onComplete )
{
    var url = "{/literal}{grn_pageurl page='schedule/schedule_navi_calendar' location=$location}&p={$selected_group_type}{literal}&search_text={/literal}{$search_text|escape|urlencode}{literal}&uid={/literal}{$user_id|escape}{literal}&gid={/literal}{$group_id|escape}{literal}&event={/literal}{$event_id|escape}{literal}&event_date={/literal}{$event_date|escape}{literal}&vwdate={/literal}{$view_date|escape}{literal}"+'&cndate='+move_date;
    ajax = new Ajax.Updater( "schedule_calendar", url, { method:'get', asynchronous: true, onComplete: onComplete } );
}

//-->
{/literal}
</script>
