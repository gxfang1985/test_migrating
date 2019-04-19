{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id='schedule'}<br>
{cb_msg module='grn.schedule.cellular' key="title_add_01"}<br>
<hr>
{if $error_facility_input_flag}
{cb_msg module='grn.schedule.cellular' key="error_facility_input_comment"}
{/if}
{grn_cellular_form method=post page="$pagepath/command_add_01" mid="$mid" day="$day"}
<input type=text name=syy maxlength=4 size=4 value="{$schedule_event.start_yy}" istyle="4" mode="numeric">
<input type=text name=smm maxlength=2 size=2 value="{$schedule_event.start_mm}" istyle="4" mode="numeric">
<input type=text name=sdd maxlength=2 size=2 value="{$schedule_event.start_dd}" istyle="4" mode="numeric"><br>
{grn_select_time prefix='start_' minute_interval=$schedule_event.minute_interval time=$schedule_event.start_time}
{cb_msg module='grn.schedule.cellular' key="txt_childa"}<br>
<input type=text name=eyy maxlength=4 size=4 value="{$schedule_event.end_yy}" istyle="4" mode="numeric">
<input type=text name=emm maxlength=2 size=2 value="{$schedule_event.end_mm}" istyle="4" mode="numeric">
<input type=text name=edd maxlength=2 size=2 value="{$schedule_event.end_dd}" istyle="4" mode="numeric"><br>
{grn_select_time prefix='end_' minute_interval=$schedule_event.minute_interval time=$schedule_event.end_time}
<br>
{grn_cellular_submit name=normal_submit accesskey=1 caption_module='grn.schedule.cellular' caption_key="link_add_01_normal_submit"}
{if !$schedule_event.facility_flag}<BR>
{grn_cellular_submit name=banner_submit accesskey=2 caption_module='grn.schedule.cellular' caption_key="link_add_01_banner_submit"}
{/if}
</form>
<hr>

{/strip}
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}
