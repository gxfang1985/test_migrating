{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_load_css file="grn/html/schedule.css"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{assign var='page_name' value=$smarty.template|basename}
<form name="{$form_name}" id="{$form_name}" method="post" action="{grn_pageurl page='personal/user/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="mgid" value="{$mygroup_id|escape}">

<div class="explanation">{cb_msg module='grn.personal.user' key='GRN_PRS_US-1' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
<tr>
<th>{capture name='grn_personal_user_GRN_PRS_US_2'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-2' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_personal_user_GRN_PRS_US_2 necessary=TRUE}</th>
<td>
{capture name='grn_personal_user_GRN_PRS_US_3'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-3' replace='true'}{/capture}{validate form=$form_name field="name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_personal_user_GRN_PRS_US_3 append="validation_errors"}{capture name='grn_personal_user_GRN_PRS_US_4'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-4' replace='true'}{/capture}{grn_text name="name" value=$name size="50" title=$smarty.capture.grn_personal_user_GRN_PRS_US_4 disable_return_key=true}
</td>
</tr>
        <tr valign="top">
            <th nowrap>{cb_msg module='grn.personal.user' key='GRN_PRS_US-82' replace='true'}</th>
            <td>
                {grn_member_add name="member_select" form_name=$form_name sUID='sUID' CGID='CGID' CID='CID' selected_users=$selected_users app_id='grn.common'}
            </td>
        </tr>
        {if $facility_access_right}
            <tr valign="top">
                <th nowrap>{cb_msg module='grn.personal.user' key='GRN_PRS_US-83' replace='true'}</th>
                <td>
                    {include file='schedule/facility_add.tpl' initialize_item=$initialize_item}
                </td>
            </tr>
        {/if}
        <tr valign="top">
            <th>{cb_msg module='grn.personal.user' key='GRN_PRS_US-5' replace='true'}</th>
            <td>{capture name='grn_personal_user_GRN_PRS_US_6'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-6' replace='true'}{/capture}{grn_textarea name="description" value=$description rows="5" title=$smarty.capture.grn_personal_user_GRN_PRS_US_6 disable_return_key=true}</td>
        </tr>
<tr>
<td></td>
<td>
{capture name='grn_personal_user_GRN_PRS_US_9'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-9' replace='true'}{/capture}{grn_button_submit id="my_group_button_save" class="margin" caption=$smarty.capture.grn_personal_user_GRN_PRS_US_9 onclick="return false;"}
{grn_button_cancel page='personal/user/mygroup_list' mgid=$mygroup_id}
</td>
</tr>
</table>

</form>

{grn_load_javascript file="grn/html/personal_mygroup.js"}

{include file='grn/personal_footer.tpl'}
