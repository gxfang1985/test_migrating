{include file="cellular/header.tpl"}
{strip}

{capture name=validate_schedule_emoji}{cb_msg module='grn.cellular.common' key="validate_message_emoji"}<BR>{/capture}
{capture name=validate_message_memo_length}
    {cb_msg module='grn.cellular.common' key="validate_message_length"}<BR>
{/capture}


{grn_cellular_appname app_id='schedule'}<br>
{cb_msg module='grn.schedule.cellular' key="title_change_body"}<br>
<hr>
{if $schedata.all_day}
    {grn_cellular_pictogram key="clock"}
    {cb_date_format format='DateShort_MD' date=$schedata.start_date}
    {if $schedata.start_date != $schedata.end_date}
        {cb_msg module='grn.schedule.cellular' key="txt_childa"}
        {cb_date_format format='DateShort_MD' date=$schedata.end_date}
    {/if}
    &nbsp;{cb_msg module='grn.schedule.cellular' key="txt_fullday"}
{elseif $schedata.banner_flag}
    {grn_cellular_pictogram key="change"}
    {cb_date_format format='DateShort_MD' date=$schedata.start_date}
    {cb_msg module='grn.schedule.cellular' key="txt_childa"}
    {cb_date_format format='DateShort_MD' date=$schedata.end_date}
{else}
    {grn_cellular_pictogram key="clock"}
    {cb_date_format format='DateShort_MD' date=$schedata.start_date}&nbsp;
    {cb_date_format format='TimeShort_HM' date=$schedata.start_date}
    {if $schedata.end_date}
        {cb_msg module='grn.schedule.cellular' key="txt_childa"}<br>
        &nbsp;&nbsp;
        {cb_date_format format='DateShort_MD' date=$schedata.end_date}&nbsp;
        {cb_date_format format='TimeShort_HM' date=$schedata.end_date}
    {/if}
{/if}
<br>

{grn_cellular_form name=$form_name method=post page="$pagepath/command_change_body" mid="$mid" eid=$schedata.eid}

{validate form=$form_name field="title" criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_schedule_emoji}
{validate form=$form_name field="info"  criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_schedule_emoji}
{validate form=$form_name field="info" criteria="grn_cellular_isLength" min=0 max=1024 message=$smarty.capture.validate_message_memo_length}


{grn_cellular_pictogram key="light"}{cb_msg module='grn.schedule.cellular' key="txt_sche_type"}<br>

<select name=menu>
<option value="">------------</option>
{foreach from=$menu_option item=_menu}
    <option value="{$_menu[0]|escape};#{$_menu[1]|escape}"{if $_menu[2] == true} selected{/if}>{$_menu[0]|escape}</option>
{/foreach}
</select><br>


{grn_cellular_pictogram key="pencil"}{cb_msg module='grn.schedule.cellular' key="txt_sche_title"}<br>
<input type=text name=title value="{$schedata.title|escape}" istyle="1" mode="hiragana"><br>
{grn_cellular_pictogram key="memo"}{cb_msg module='grn.schedule.cellular' key="txt_sche_info"}<br>
{if $schedata.info_edit}
    <textarea name=info cols=16 rows=3 istyle="1" mode="hiragana">{$schedata.info|escape}</textarea>
{else}
    {$schedata.info|grn_cellular_truncate:$width|escape}<BR><BR>
    {cb_msg module='grn.schedule.cellular' key="no_editable_memo"}<BR>
{/if}<br>


{if $schedata.facilities_edit}
    {if $schedata.facility_flag}
        {grn_cellular_pictogram key="building"}{cb_msg module='grn.schedule.cellular' key="txt_facility_add"}
        <input type=submit name=add_fac value="{cb_msg module='grn.schedule.cellular' key="link_facility_add"}">
        <br>
    {/if}
    {foreach from=$schedata.facilities key=_id item=_name}
        {if $conflict[$_id] }
            {cb_msg module='grn.schedule.cellular' key="x_sign"}
        {else}
            &nbsp;&nbsp;
        {/if}
        {$_name|escape}
        <input type=submit name="delete_fac[{$_id}]" value="{cb_msg module='grn.schedule.cellular' key="button_delete"}"><br>
    {/foreach}
{else}
    <BR>
    {cb_msg module='grn.schedule.cellular' key="no_editable_fac"}<BR>
{/if}

{foreach from=$extended_items key=item_id item=item}
    {if $item.use}
        {cb_msg module='grn.schedule.cellular' key='GRN_SCH_CE-3' replace='true'}{grn_show_input_title title=$item.display_name}<br>
        {include file='schedule/cellular/_action_item_contents.tpl'}<br>
    {/if}
{/foreach}

{if $required_facility_using_purpose}
    {grn_cellular_pictogram key="memo"}{cb_msg module='grn.schedule.cellular' key="txt_facility_using_purpose"}{cb_msg module='grn.schedule.cellular' key="sche_essential"}<br>
    <textarea name=using_purpose cols=16 rows=3 istyle="1" mode="hiragana">{$schedata.using_purpose|escape}</textarea><br>
{/if}

{grn_cellular_pictogram key="person"}{cb_msg module='grn.schedule.cellular' key="txt_share_add"}
{if $schedata.joint_edit}
    <input type=submit name=add_joint value="{cb_msg module='grn.schedule.cellular' key="link_share_add"}">
    <br>
    {foreach from=$schedata.joint key=_id item=_name}
        &nbsp;&nbsp;
        {$_name|escape}
        <input type=submit name="delete_joint[{$_id}]" value="{cb_msg module='grn.schedule.cellular' key="button_delete"}"><br>
    {/foreach}
{else}
    <BR>
    {cb_msg module='grn.schedule.cellular' key="no_editable_joint"}<BR>
{/if}
{grn_cellular_submit accesskey=1 caption_module='grn.schedule.cellular' caption_key="link_change_submit"}

</form>
<hr>

{/strip}
{grn_cellular_link page="$pagepath/look1"  eid=$eid day=$day mid=$mid accesskey=2 caption_module='grn.schedule.cellular' caption_key="link_look"}<br>
{include file="schedule/cellular/footer.tpl"}
{include file="cellular/footer.tpl"}

