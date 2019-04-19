{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_load_javascript file="grn/html/component/validator.js"}
{grn_load_javascript file="grn/html/page/personal/user/mygroup_add.js"}
{grn_load_css file="grn/html/schedule.css"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{assign var='page_name' value=$smarty.template|basename}

<form name="{$form_name}" id="{$form_name}" method="post" action="{grn_pageurl page='personal/user/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="mgid" value="{$mygroup_id|escape}">

<div class="explanation">{cb_msg module='grn.personal.user' key='GRN_PRS_US-59' replace='true'}</div>
<div id="errorMessageField"></div>
{include file='grn/indispensable.tpl'}
<table class="std_form">
<tr>
<th>{capture name='grn_personal_user_GRN_PRS_US_60'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-60' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_personal_user_GRN_PRS_US_60 necessary=TRUE}</th>
<td>
{capture name='grn_personal_user_GRN_PRS_US_61'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-61' replace='true'}{/capture}{validate form=$form_name field="name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_personal_user_GRN_PRS_US_61 append="validation_errors"}{capture name='grn_personal_user_GRN_PRS_US_62'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-62' replace='true'}{/capture}{grn_text name="name" value=$name size="50" title=$smarty.capture.grn_personal_user_GRN_PRS_US_62 disable_return_key=true}
</td>
</tr>
        <tr valign="top">
            <th nowrap>{cb_msg module='grn.personal.user' key='GRN_PRS_US-82' replace='true'}</th>
            <td>
                {grn_member_add name='member_select' form_name=$form_name sUID='sUID' CGID='CGID' CID='CID' app_id='grn.common'}
            </td>
        </tr>
        {if $facility_access_right}
            <tr valign="top">
                <th nowrap>{cb_msg module='grn.personal.user' key='GRN_PRS_US-83' replace='true'}</th>
                <td>
                    {include file='schedule/facility_add.tpl'}
                </td>
            </tr>
        {/if}
        <tr valign="top">
            <th>{cb_msg module='grn.personal.user' key='GRN_PRS_US-63' replace='true'}</th>
            <td>{capture name='grn_personal_user_GRN_PRS_US_64'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-64' replace='true'}{/capture}{grn_textarea name="description" value=$description rows="5" title=$smarty.capture.grn_personal_user_GRN_PRS_US_64 disable_return_key=true}</td>
        </tr>
<tr>
<td></td>
<td>
{capture name='grn_personal_user_GRN_PRS_US_67'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-67' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_personal_user_GRN_PRS_US_67 id='mygroup_add_submit' onclick="return false;"}
{grn_button_cancel page='personal/user/mygroup_list' mgid=$mygroup_id id='mygroup_add_cancel'}
</td>
</tr>
</table>

</form>

{literal}
    <script type="text/javascript">
        jQuery(document).ready( function(){
            grn.page.personal.user.mygroup.init();
        });
    </script>
{/literal}

{include file='grn/personal_footer.tpl'}
