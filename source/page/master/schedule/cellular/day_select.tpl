{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id='schedule'}<br>
{cb_msg module='grn.schedule.cellular' key="title_day_select"}<br>
<hr>

{grn_cellular_form method=post page="$pagepath/command_day_select" from=$from day=$day mid=$mid gid=$gid pa=$pa}
{grn_cellular_pictogram key="clock"}
<input type=text name=yy value="{$sche_time.yy}" maxlength=4 size=4 istyle="4" mode="numeric">
<input type=text name=mm value="{$sche_time.mm}" maxlength=2 size=2 istyle="4" mode="numeric">
<input type=text name=dd value="{$sche_time.dd}" maxlength=2 size=2 istyle="4" mode="numeric"><br>
{grn_cellular_submit accesskey=1 caption_module='grn.schedule.cellular' caption_key="link_day_select"}
</form>
<hr>

{/strip}
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}
