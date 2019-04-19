{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id='schedule'}<br>
{cb_msg module='grn.schedule.cellular' key="title_look"}<br>
<hr>
{if $event_deleted_flag}
    {cb_msg module='grn.schedule.cellular' key="event_deleted_txt"}
{else}
{if $event_follow}
{grn_cellular_link page="$pagepath/follow" day=$day mid=$mid eid=$eid accesskey="1" caption_module='grn.schedule.cellular' caption_key="link_follow"}<br>
<hr>
{/if}

{cb_date_format format='DateShort_MDW' date=`$day`}<br>
{$target_name|escape}<br>
<hr>
{if $count_list}
{grn_cellular_link page="$pagepath/report_list" eid=$eid day=$day mid=$mid caption_module='grn.schedule.cellular' caption_key="link_show_report"}<br>
{/if}
{grn_cellular_pictogram key="clock"}
{cb_msg module='grn.schedule.cellular' key="txt_sche_day"}<br>
{$schedata.repeat_data}
{if $schedata.type =="share_banner" || $schedata.type =="banner"}
    {grn_cellular_pictogram key="change"}
    {cb_date_format format='DateShort_MD' date=$schedata.start_date}
    -
    {cb_date_format format='DateShort_MD' date=$schedata.end_date}
{elseif $schedata.type == 'temporary' || $schedata.type == 'share_temporary'}
    {if $schedata.temporary_type == 'or'}
        {foreach from=$schedata.temporary item=facility_data}
            {grn_cellular_pictogram key="building"}{$facility_data.facility_name|escape}<br>
            {foreach from=$facility_data.dates item=temporary}
                {grn_date_format date=$temporary.setdatetime format="DateTimeShort_YMD_HM"}
                -
                {grn_date_format date=$temporary.enddatetime format="DateTimeShort_YMD_HM"}<br>
            {/foreach}
        {/foreach}
    {else}
        {foreach from=$schedata.temporary item=temporary}
            {grn_date_format date=$temporary.setdatetime format="DateTimeShort_YMD_HM"}
            -
            {grn_date_format date=$temporary.enddatetime format="DateTimeShort_YMD_HM"}<br>
        {/foreach}
    {/if}
{elseif $schedata.allday}
    {cb_date_format format='TimeShort_HM' date=$schedata.start_time}
    {if isset($schedata.end_time)}
        -
        {cb_date_format format='TimeShort_HM' date=$schedata.end_time}
    {/if}
    {cb_msg module='grn.schedule.cellular' key="txt_allday"}
{elseif $schedata.start_time}
    {cb_date_format format='TimeShort_HM' date=$schedata.start_time}
    {if isset($schedata.end_time)}
    -
        {cb_date_format format='TimeShort_HM' date=$schedata.end_time}
    {/if}
{else}
    {if $schedata.sdate && ($schedata.sdate != $day_ex)}
        {cb_date_format format='DateShort_MD' date=$schedata.sdate}
    {else}
        {cb_date_format format='TimeShort_HM' date=$schedata.start_date}
    {/if}
    {if $schedata.end_date}
        -
        {if $schedata.edate && ($schedata.edate != $day_ex)}
            {cb_date_format format='DateShort_MD' date=$schedata.edate}
        {else}
            {cb_date_format format='TimeShort_HM' date=$schedata.end_date}
        {/if}
    {/if}
{/if}

{if $schedata.type == "share" || $schedata.type == "share_banner" || $schedata.type == "share_repeat"}
    {grn_cellular_pictogram key="joint"}
{/if}
{if $schedata.type == "repeat" || $schedata.type == "share_repeat"}
    {grn_cellular_pictogram key="repeat"}
{/if}
<br>

{if $event_modify}
    {grn_cellular_link page="$pagepath/change_time" day=$day mid=$mid eid=$eid caption_module='grn.schedule.cellular' caption_key="link_change_time"}<br>
{/if}


{grn_cellular_pictogram key="light"}{cb_msg module='grn.schedule.cellular' key="txt_sche_type"}<br>
{$schedata.title|escape}
<br>

<a name = "body"></a>
{grn_cellular_pictogram key="memo"}{cb_msg module='grn.schedule.cellular' key="txt_sche_info"}<br>


{grn_cellular_string_split string=$schedata.memo page_paraname="pg"}<BR>

{* GTM-1136 *}
{if $allow_file_attachment}
[{grn_cellular_pictogram key="clip"}{cb_msg module='grn.schedule.cellular' key="txt_attach_file"}]<br>
{/if}
{* End GTM-1136 *}

<br>

{* creator *}
{if $schedata.creator_uid}
{if !$schedata.view_creator}
    {grn_cellular_pictogram key="person"}{cb_msg module='grn.schedule.cellular' key="txt_create_name"}<br>
    &nbsp;&nbsp;{$schedata.creator_name|escape}<br>
    &nbsp;&nbsp;{cb_date_format format='DateTimeCompact' date=$schedata.ctime}<br>
{/if}
{/if}

{* facility *}
{if count($schedata.facilities)}
    {grn_cellular_pictogram key="building"}{cb_msg module='grn.schedule.cellular' key="txt_sche_facility"}<br>
    {foreach from=$schedata.facilities key=facility_id item=facility_name}
        &nbsp;&nbsp;{$facility_name|escape}<br>
    {/foreach}
    {if $schedata.facilities_more}
        &nbsp;&nbsp;{grn_cellular_link page="$pagepath/look3" day=$day mid=$mid eid=$eid mode=f caption_module='grn.schedule.cellular' caption_key="link_more"}<br>
    {/if}
{/if}

{* facility extended item *}
{if $extended_items|@count > 0}
    {foreach from=$extended_items key=item_id item=item}
        {if $item.use}
            {cb_msg module='grn.schedule.cellular' key='GRN_SCH_CE-4' replace='true'}{grn_show_input_title title=$item.display_name}<br>
            {if $item.type == GRN_SCHEDULE_ITEM_MENU}
                &nbsp;&nbsp;{$item.value|escape}<br>
            {elseif $item.type == GRN_SCHEDULE_ITEM_MULTIPLE_STRING}
                &nbsp;&nbsp;{grn_cellular_string_split string=$item.value page_paraname="pg"}<br>
            {else}
                &nbsp;&nbsp;{$item.value|escape}<br>
            {/if}
        {/if}
    {/foreach}
{/if}

{* facility using purpose *}
{if $schedata.has_required_approval_facility}
    {grn_cellular_pictogram key="memo"}{cb_msg module='grn.schedule.cellular' key="txt_facility_using_purpose"}<br>
    {grn_cellular_string_split string=$schedata.facility_using_purpose page_paraname="pg"}<br>

    <br>
{/if}

{* users *}
{if count($schedata.users)}
    {grn_cellular_pictogram key="joint"}{cb_msg module='grn.schedule.cellular' key="txt_sche_share"}<br>
    {foreach from=$schedata.users key=user_id item=user_name}
        &nbsp;&nbsp;{$user_name|escape}<br>
    {/foreach}
    {if $schedata.users_more}
        &nbsp;&nbsp;{grn_cellular_link page="$pagepath/look3" day=$day mid=$mid eid=$eid mode=u caption_module='grn.schedule.cellular' caption_key="link_more"}<br>
    {/if}
{/if}

{if $event_modify || $event_delete}
    <br>
    {if $event_modify}
        {grn_cellular_link page="$pagepath/change_body" cs="1" day=$day mid=$mid eid=$eid accesskey="2" caption_module='grn.schedule.cellular' caption_key="link_change_body"}
    {/if}
    {if $event_delete}
        {grn_cellular_link page="$pagepath/delete" day=$day mid=$mid eid=$eid accesskey="3" caption_module='grn.schedule.cellular' caption_key="link_delete"}<br>
    {/if}
{/if}

{if count($schedata.follow)>0}
    <hr>
    <a name = "follow"></a>
    {foreach from=$schedata.follow item=follow}
        {grn_cellular_pictogram key="follow"}
        {grn_cellular_link page="$pagepath/look2" fid=$follow.follow_id day=$day mid=$mid eid=$eid caption=$follow.data|regex_replace:"/[ \t\r\n]/":""|default:"."|grn_cellular_truncate:$width}<br>
        &nbsp;&nbsp;{cb_date_format format='DateTimeCompact' date=$follow.ctime}&nbsp;
        {grn_user_name uid=$follow.creator_uid name=$follow.creator_name nolink=true noimage=true}
        {*$follow.creator_name|escape*}<br>
    {/foreach}
    <br>
    {if $follow_prev}
        {grn_cellular_link page="$pagepath/look1" fp=$follow_prev_p mid=$mid eid=$eid day=$day fragment="follow" caption_module='grn.cellular.common' caption_key="link_back"}&nbsp;
    {/if}
    {if $follow_next}
        {grn_cellular_link page="$pagepath/look1" fp=$follow_next_p mid=$mid eid=$eid day=$day fragment="follow" caption_module='grn.cellular.common' caption_key="link_next"}
    {/if}
{/if}

{/if}
<hr>

{/strip}
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}

