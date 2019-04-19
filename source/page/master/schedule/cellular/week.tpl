{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id='schedule'}<br>
{if $facility_info}
{cb_msg module='grn.schedule.cellular' key="title_facility_week"}
{else}
{cb_msg module='grn.schedule.cellular' key="title_week"}
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
{grn_cellular_link page="$pagepath/change_object" from="week" day=$day mid=$mid caption_module='grn.schedule.cellular' caption_key="link_day_select"}<br>
{if $event_add}
{grn_cellular_link page="$pagepath/add_01"      day=$day mid=$mid accesskey="1" caption_module='grn.schedule.cellular' caption_key="link_add"}<br>
{/if}
<hr>

{foreach from=$weekdata item=daydata}

    <a href="{grn_cellular_pageurl page="$pagepath/day" day=$daydata.format mid=$mid}">
    {grn_date_format date=$daydata.format format="DateShort_MDW"}</a><br>
    
    {foreach item=one from=$daydata.allday}
        {grn_cellular_pictogram key="weather_1"}
        {cb_msg module='grn.schedule.cellular' key="txt_allday"}
        
        {if $hiddenprivate == '0' && $one.private == 4}
            <br>
            &nbsp;&nbsp;{cb_msg module='grn.schedule.cellular' key="hiddenprivate_schedule_comment"}<br>
        {else}
            {if $one.joint}{grn_cellular_pictogram key="joint"}{/if}
            {if $one.repeat}{grn_cellular_pictogram key="repeat"}{/if}
            <br>
            &nbsp;&nbsp;{$one.title|regex_replace:"/[ \t\r\n]/":""|grn_cellular_truncate:$width|escape}<br>
        {/if}
    {/foreach}
    
    {foreach item=one from=$daydata.normal}
        {grn_cellular_pictogram key="clock"}
        {if $one.sdate && ($one.sdate !=$daydata.day_info)}
            {cb_date_format format='DateShort_MD' date=$one.start}
        {else}
            {cb_date_format format='TimeShort_HM' date=$one.start}
        {/if}
        {if $one.end_time_available}
            -
            {if $one.edate && ($one.edate !=$daydata.day_info)}
                {cb_date_format format='DateShort_MD' date=$one.end}
            {else}
                {cb_date_format format='TimeShort_HM' date=$one.end}
            {/if}
        {/if}
        
        {if $hiddenprivate == '0' && $one.private == 4}
            <br>
            &nbsp;&nbsp;{cb_msg module='grn.schedule.cellular' key="hiddenprivate_schedule_comment"}<br>
        {else}
            {if $one.joint}{grn_cellular_pictogram key="joint"}{/if}
            {if $one.repeat}{grn_cellular_pictogram key="repeat"}{/if}
            {if $one.temp}{cb_msg module='grn.schedule.cellular' key="mark_temp"}{/if}
            <br>
            &nbsp;&nbsp;{$one.title|regex_replace:"/[ \t\r\n]/":""|grn_cellular_truncate:$width|escape}<br>
        {/if}
    {/foreach}
    
    {foreach item=one from=$daydata.banner}
        {grn_cellular_pictogram key="change"}
        {cb_date_format format='DateShort_MD' date=$one.start}
        -
        {cb_date_format format='DateShort_MD' date=$one.end}
        
        {if $hiddenprivate == '0' && $one.private == 4}
            <br>
            &nbsp;&nbsp;{cb_msg module='grn.schedule.cellular' key="hiddenprivate_schedule_comment"}<br>
        {else}
            {if $one.joint}{grn_cellular_pictogram key="joint"}{/if}
            {if $one.repeat}{grn_cellular_pictogram key="repeat"}{/if}
            <br>
            &nbsp;&nbsp;{$one.title|regex_replace:"/[ \t\r\n]/":""|grn_cellular_truncate:$width|escape}<br>
        {/if}

    {/foreach}

{/foreach}

<hr>

{grn_cellular_link page="$pagepath/week" day=$before_week mid=$mid accesskey="3" caption_module='grn.schedule.cellular' caption_key="link_back"}
{grn_cellular_link page="$pagepath/week"                  mid=$mid accesskey="4" caption_module='grn.schedule.cellular' caption_key="link_toweek"}
{grn_cellular_link page="$pagepath/week" day=$after_week  mid=$mid accesskey="5" caption_module='grn.schedule.cellular' caption_key="link_next"}

<hr>

{/strip}
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}
