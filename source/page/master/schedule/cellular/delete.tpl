{include file="cellular/header.tpl"}
{strip}

{capture name=validate_message_join}
    <font color="#ff0000">{cb_msg module='grn.cellular.common' key="validate_message_join"}</font><br>
{/capture}

{grn_cellular_appname app_id='schedule'}<br>
{cb_msg module='grn.schedule.cellular' key="title_delete"}<br>
<hr>
{$title|grn_noescape}<br>
{cb_msg module='grn.schedule.cellular' key="txt_delete"}<br>
<hr>

{grn_cellular_form name=$form_name method=post page="$pagepath/command_delete" eid="$eid" day="$day"}
{validate form=$form_name field="flag" criteria="notEmpty" message=$smarty.capture.validate_message_join}
{if $joint}
<input type=radio name=flag value="2">{cb_msg module='grn.schedule.cellular' key="delete_type2"}<br>
<input type=radio name=flag value="1">{cb_msg module='grn.schedule.cellular' key="delete_type1"}<br>
{else}
<input type=hidden name=flag value="1">
{/if}
<input type=submit accesskey=1 value="{grn_cellular_pictogram key="num1"}{cb_msg module='grn.schedule.cellular' key="link_delete_submit"}">
</form>

<hr>

{grn_cellular_link page="$pagepath/look1"  mid=$mid day=$day eid=$eid accesskey="2" caption_module='grn.schedule.cellular' caption_key="link_look"}</a><br>


{/strip}
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}
