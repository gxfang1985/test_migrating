{include file="cellular/header.tpl"}
{strip}

{assign var='form_name' value=$smarty.template|basename}

{capture name=validate_schedule_title_emoji}{cb_msg module='grn.schedule.cellular' key="txt_follow"}:{cb_msg module='grn.cellular.common' key="validate_message_emoji"}<BR>{/capture}
{capture name=validate_follow_length}{cb_msg module='grn.cellular.common' key="validate_message_length"}<BR>{/capture}

{grn_cellular_appname app_id='schedule'}<br>
{cb_msg module='grn.schedule.cellular' key="title_follow"}<br>
<hr>

{grn_cellular_form name=$form_name method=post page="$pagepath/command_follow" eid=$eid mid="$mid" day="$day"}

{validate form=$form_name field="follow" criteria="grn_cellular_isLength" min=0 max=1024 message=$smarty.capture.validate_follow_length}
{validate form=$form_name field="follow" criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_schedule_title_emoji}

<textarea name=follow cols=16 rows=3 istyle="1" mode="hiragana">{$follow|escape}</textarea><br>
<input type=submit accesskey=1 value="{grn_cellular_pictogram key="num1"}{cb_msg module='grn.schedule.cellular' key="txt_submit"}">
</form>
<hr>

{/strip}
{grn_cellular_link page="$pagepath/look1" eid=`$eid` mid=$mid day=$day accesskey="2" caption_module='grn.schedule.cellular' caption_key="link_look"}<br>
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}


