{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id='schedule'}<br>
{if $facility_page}
{cb_msg module='grn.schedule.cellular' key="title_facility_gr"}<br>
{else}
{cb_msg module='grn.schedule.cellular' key="title_day_gr"}<br>
{/if}

{include file="cellular/group_tab.tpl"}
{if $tab.mode == 'f'}
    {cb_msg module='grn.schedule.cellular' key="tab2_facility"}<br>
    {grn_cellular_group_form method=get page=$tab.page selected=$gid params=$tab.params accesskey=1 access_plugin=$access_plugin option_list=$option_list}
{/if}

<hr>

{cb_date_format format='DateShort_MDW' date=$day}
{grn_cellular_link page="$pagepath/day_select" day=$day gid=$gid pa=$pa from="gr" caption_module='grn.schedule.cellular' caption_key="link_day_select"}<br>
<br>

{foreach item=sche_data from=$group_sche_data}

    {if ! strncmp($sche_data.mid,"f",1)}
        {grn_cellular_link page="$pagepath/day" day=$day mid=$sche_data.mid icon='building'     caption=$sche_data.name}
    {elseif ! strncmp($sche_data.mid,"g",1)}
        {grn_cellular_link page="$pagepath/day" day=$day mid=$sche_data.mid icon='organization' caption=$sche_data.name}
    {else}
        {grn_cellular_link page="$pagepath/day" day=$day mid=$sche_data.mid icon='person'       caption=$sche_data.name}
    {/if}
    <br>
    
    {foreach item=one from=$sche_data.allday}
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
    
    {foreach item=one from=$sche_data.normal}
        {grn_cellular_pictogram key="clock"}
        {if $one.sdate &&  $day_ex != $one.sdate}
            {cb_date_format format='DateShort_MD' date=$one.start}
        {else}
            {cb_date_format format='TimeShort_HM' date=$one.start}
        {/if}
        
        {if $one.start !=$one.end}
            {if $one.sdate && $day_ex != $one.edate}
                -{cb_date_format format='DateShort_MD' date=$one.end}
            {else}
                -{cb_date_format format='TimeShort_HM' date=$one.end}
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
    
    {foreach item=one from=$sche_data.banner}
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

{if $prev}
    {grn_cellular_link page="$pagepath/day_gr" day=$day gid=$gid pa=$prev_p caption_module='grn.cellular.common' caption_key="link_back"}
    &nbsp;
{/if}

{if $next}
    {grn_cellular_link page="$pagepath/day_gr" day=$day gid=$gid pa=$next_p caption_module='grn.cellular.common' caption_key="link_next"}
{/if}

<hr>

{grn_cellular_link page="$pagepath/day_gr" day=$before_day gid=$gid pa=$pa accesskey=3 caption_module='grn.schedule.cellular' caption_key="link_back"}
{grn_cellular_link page="$pagepath/day_gr"                 gid=$gid pa=$pa accesskey=4 caption_module='grn.schedule.cellular' caption_key="link_today"}
{grn_cellular_link page="$pagepath/day_gr" day=$after_day  gid=$gid pa=$pa accesskey=5 caption_module='grn.schedule.cellular' caption_key="link_next"}

<hr>

{/strip}
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}
