{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id='schedule'}<br>
{cb_msg module='grn.schedule.cellular' key="title_look2"}<br>
<hr>
{if $event_follow}
{grn_cellular_link page="$pagepath/follow" eid=`$eid` mid=$mid day=$day accesskey="1" caption_module='grn.schedule.cellular' caption_key="link_follow"}<br>
{/if}
{grn_cellular_pictogram key="follow"}{$title|grn_noescape}<br>
<hr>

{grn_cellular_pictogram key="clock"}{cb_date_format format='DateShort_MD' date=`$follow.ctime`}&nbsp;{cb_date_format format='TimeShort_HM' date=`$follow.ctime`}<br>
{grn_cellular_pictogram key="person"}
{grn_user_name uid=$follow.creator_uid name=$follow.creator_name nolink=true noimage=true}
{*$follow.creator_name|escape*}<br><BR>

{grn_cellular_pictogram key="memo"}
{grn_cellular_string_split string=$follow.data page_paraname="pg"}<BR>



{if $fid_p}<a href="{grn_cellular_pageurl page="$pagepath/look2" fid="$fid_p" mid=$mid day=$day eid=$eid}">{cb_msg module='grn.cellular.common' key="link_back"}</a>&nbsp;{/if}
{if $fid_n}<a href="{grn_cellular_pageurl page="$pagepath/look2" fid="$fid_n" mid=$mid day=$day eid=$eid}">{cb_msg module='grn.cellular.common' key="link_next"}</a>{/if}
<hr>

{/strip}
{grn_cellular_link page="$pagepath/look1" eid=`$eid` mid=$mid day=$day accesskey="2" caption_module='grn.schedule.cellular' caption_key="link_look"}<br>
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}

