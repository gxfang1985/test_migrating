{include file="cellular/header.tpl"}
{strip}

{grn_cellular_pictogram key="sche"}{$appname}<br>
{cb_msg module='grn.schedule.cellular' key="title_new"}<br>
<hr>

{foreach item=one from=$schedata}
<a href="{grn_cellular_pageurl page="$pagepath/look1" sid=`$one.sid`}">
{grn_cellular_pictogram key="sche_time"}
{cb_date_format format='DateShort_MDW' date=`$one.day`}
{if     $one.type == 1}{grn_cellular_pictogram key="sche_new"}
{elseif $one.type == 2}{grn_cellular_pictogram key="sche_change"}
{elseif $one.type == 3}{grn_cellular_pictogram key="sche_follow"}
{/if}

<br>
{$one.start_time}-{$one.end_time}<br>
{$one.event_title}<br>
{$one.change_pname}<br>
</a>
<br>
{/foreach}

<hr>

<a href="{grn_cellular_pageurl page="$pagepath/day" day=$day_disp}" accesskey="7" directkey="7">{grn_cellular_pictogram key="num7"}{cb_msg module='grn.schedule.cellular' key="link_day"}</a><br>
<a href="{grn_cellular_pageurl page="$pagepath/week" day=$day_disp}" accesskey="8" directkey="8">{grn_cellular_pictogram key="num8"}{cb_msg module='grn.schedule.cellular' key="link_week"}</a><br>
<a href="{grn_cellular_pageurl page="$pagepath/day_gr" day=$day_disp}" accesskey="9" directkey="9">{grn_cellular_pictogram key="num9"}{cb_msg module='grn.schedule.cellular' key="link_day_gr"}</a><br>
{/strip}
{include file="cellular/footer.tpl"}


