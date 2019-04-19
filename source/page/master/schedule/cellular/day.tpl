{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id='schedule'}<br>
{if $facility_info}
{cb_msg module='grn.schedule.cellular' key="title_facility_day"}
{else}
{cb_msg module='grn.schedule.cellular' key="title_day"}
{/if}<br>
<hr>

{if ! strncmp($mid,"f",1)}
    {grn_cellular_pictogram key="building"}
{elseif ! strncmp($mid,"g",1)}
    {grn_cellular_pictogram key="organization"}
{else}
    {grn_cellular_pictogram key="person"}
{/if}
{$member_name|escape}
{grn_cellular_link page="$pagepath/change_object" from='day' day=$day mid=$mid caption_module='grn.schedule.cellular' caption_key="link_day_select"}<br>
{if $event_add}
{grn_cellular_link page="$pagepath/add_01"       day=$day mid=$mid accesskey="1" caption_module='grn.schedule.cellular' caption_key="link_add"}<br>
{/if}
<hr>

{cb_date_format format='DateShort_MDW' date=$day}
{grn_cellular_link page="$pagepath/day_select" day=$day mid=$mid from="day" caption_module='grn.schedule.cellular' caption_key="link_day_select"}<br>
<br>

{foreach item=one from=$sche}
    {if $hiddenprivate == '0' && $one.private == 4}
    {else}
        <a href="{grn_cellular_pageurl page="$pagepath/look1" eid=$one.eid day=$day mid=$mid}">
    {/if}
    
    {if $one.type == 'allday'}
        {grn_cellular_pictogram key="weather_1"}
        {cb_msg module='grn.schedule.cellular' key="txt_allday"}
    {/if}
    
    
    {if $one.type == 'normal'}
        {grn_cellular_pictogram key="clock"}
        {if $one.sdate &&  $day_ex != $one.sdate}
            {cb_date_format format='DateShort_MD' date=$one.start}
        {else}
            {cb_date_format format='TimeShort_HM' date=$one.start}
        {/if}
        {if $one.end_time_available}
            {if $one.sdate && $day_ex != $one.edate}
                -{cb_date_format format='DateShort_MD' date=$one.end}
            {else}
                -{cb_date_format format='TimeShort_HM' date=$one.end}
            {/if}
        {/if}
    {/if}
    
    {if $one.type == 'banner'}
        {grn_cellular_pictogram key="change"}
        {cb_date_format format='DateShort_MD' date=$one.start}
        -
        {cb_date_format format='DateShort_MD' date=$one.end}
    {/if}
    
    {if $hiddenprivate == '0' && $one.private == 4}
        <br>
        &nbsp;&nbsp;{cb_msg module='grn.schedule.cellular' key="hiddenprivate_schedule_comment"}<br>
    {else}
        {if $one.joint}{grn_cellular_pictogram key="joint"}{/if}
        {if $one.repeat}{grn_cellular_pictogram key="repeat"}{/if}
        {if $one.temp}{cb_msg module='grn.schedule.cellular' key="mark_temp"}{/if}
        <br>
        &nbsp;&nbsp;{$one.title|regex_replace:"/[ \t\r\n]/":""|grn_cellular_truncate:$width|escape}<br></a>
    {/if}
    
{/foreach}

<br>
{if $prev}
    {grn_cellular_link page="$pagepath/day" pg=$prev_pg mid=$mid day=$day caption_module='grn.cellular.common' caption_key="link_back"}&nbsp;
{/if}
{if $next}
    {grn_cellular_link page="$pagepath/day" pg=$next_pg mid=$mid day=$day caption_module='grn.cellular.common' caption_key="link_next"}
{/if}

<hr>

{grn_cellular_link page="$pagepath/day" day=$before_day mid=$mid accesskey="3" caption_module='grn.schedule.cellular' caption_key="link_back"}
{grn_cellular_link page="$pagepath/day"                 mid=$mid accesskey="4" caption_module='grn.schedule.cellular' caption_key="link_today"}
{grn_cellular_link page="$pagepath/day" day=$after_day  mid=$mid accesskey="5" caption_module='grn.schedule.cellular' caption_key="link_next"}

<hr>

{/strip}
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}
