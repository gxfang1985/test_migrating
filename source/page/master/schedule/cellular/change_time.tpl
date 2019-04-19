{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id='schedule'}<br>
{cb_msg module='grn.schedule.cellular' key="title_change_time"}<br>
<hr>

{if $schedule_event.allday_type}
    {cb_date_format format='DateShort_MDW' date=$schedule_event.start_date}
    {if $schedule_event.start_date != $schedule_event.end_date}
    {cb_msg module='grn.schedule.cellular' key="txt_childa"}
    {cb_date_format format='DateShort_MDW' date=$schedule_event.end_date}
    {/if}
    {cb_msg module='grn.schedule.cellular' key="txt_allday"}
{/if}

{grn_cellular_form method=post page="$pagepath/command_change_time" mid="$mid" day="$day" eid=$schedule_event.eid}
<input type=text name=syy maxlength=4 size=4 value="{$syy}" istyle="4" mode="numeric">
<input type=text name=smm maxlength=2 size=2 value="{$smm}" istyle="4" mode="numeric">
<input type=text name=sdd maxlength=2 size=2 value="{$sdd}" istyle="4" mode="numeric"><br>
{if $schedule_event.banner_type}
    <input type=hidden name=BN value="banner_type" >
{else}
    <input type=hidden name=schedule_type value="normal_type" >
{/if}
{if !$schedule_event.banner_type}
    {grn_select_time prefix='start_' minute_interval=$schedule_event.minute_interval time=$schedule_event.start_time}
{/if}

{cb_msg module='grn.schedule.cellular' key="txt_childa"}<br>

<input type=text name=eyy maxlength=4 size=4 value="{$eyy}" istyle="4" mode="numeric">
<input type=text name=emm maxlength=2 size=2 value="{$emm}" istyle="4" mode="numeric">
<input type=text name=edd maxlength=2 size=2 value="{$edd}" istyle="4" mode="numeric"><br>

{if !$schedule_event.banner_type}
    {grn_select_time prefix='end_' minute_interval=$schedule_event.minute_interval time=$schedule_event.end_time}<br>
{/if}

{grn_cellular_submit accesskey=1 caption_module='grn.schedule.cellular' caption_key="link_change_submit"}

</form>
<hr>

{/strip}

{grn_cellular_link page="$pagepath/look1"  eid=$schedule_event.eid day=$day mid=$mid accesskey=2 caption_module='grn.schedule.cellular' caption_key="link_look"}<br>
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}


