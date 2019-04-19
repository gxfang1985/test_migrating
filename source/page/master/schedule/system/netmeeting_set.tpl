{**
 * @create:
 *    2011/06/08 VCBSCH0010 Sync for V-CUBE
 **}
{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{include file="grn/show_validation_errors.tpl"}
<font color="red">
{validate form=$form_name field="outside_member_input_rows" empty="true" criteria="isInt" message=$outside_member_input_int_error_msg append="validation_errors"}
{validate form=$form_name field="outside_member_input_rows" empty="true" criteria="isRange" low=$outside_member_input_rows_min high=$outside_member_input_rows_max message=$outside_member_input_error_msg append="validation_errors"}
</font>
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-01' replace='true'}</th>
  <td>
    {capture name='grn_schedule_system_GRN_VCB_SY_02'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-02' replace='true'}{/capture}
    {if $available}
        {grn_checkbox name="available" id="available" value="1" checked=TURE caption=$smarty.capture.grn_schedule_system_GRN_VCB_SY_02}
    {else}
        {grn_checkbox name="available" id="available" value="1" caption=$smarty.capture.grn_schedule_system_GRN_VCB_SY_02}
    {/if}
  </td>
 </tr>
    <tr>
        <th>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-32' replace='true'}</th>
        <td>
            {capture name='grn_schedule_system_GRN_VCB_SY_33'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-33' replace='true'}{/capture}
            {capture name='grn_schedule_system_GRN_VCB_SY_34'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-34' replace='true'}{/capture}
            {grn_radio name='netmeeting_vcube_version' id='netmeeting_vcube_v5' value='5' caption=$smarty.capture.grn_schedule_system_GRN_VCB_SY_33 checked=$is_vcube_version5}<br>
            {grn_radio name='netmeeting_vcube_version' id='netmeeting_vcube_v4' value='4' caption=$smarty.capture.grn_schedule_system_GRN_VCB_SY_34 checked=$is_vcube_version4}
        </td>
    </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-03' replace='true'}</th>
  <td>
    {capture name='grn_schedule_system_GRN_VCB_SY_04'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-04' replace='true'}{/capture}
    {if $invite_url_schedule_display}
        {grn_checkbox name="invite_url_schedule_display" id="invite_url_schedule_display" value="1" checked=TURE caption=$smarty.capture.grn_schedule_system_GRN_VCB_SY_04}
    {else}
        {grn_checkbox name="invite_url_schedule_display" id="invite_url_schedule_display" value="1" caption=$smarty.capture.grn_schedule_system_GRN_VCB_SY_04}
    {/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-05' replace='true'}</th>
  <td>
    {capture name='grn_schedule_system_GRN_VCB_SY_06'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-06' replace='true'}{/capture}
    {if $invite_url_email_notification}
        {grn_checkbox name="invite_url_email_notification" id="invite_url_email_notification" value="1" checked=TURE caption=$smarty.capture.grn_schedule_system_GRN_VCB_SY_06}
    {else}
        {grn_checkbox name="invite_url_email_notification" id="invite_url_email_notification" value="1" caption=$smarty.capture.grn_schedule_system_GRN_VCB_SY_06}
    {/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-07' replace='true'}</th>
  <td>
      {grn_text name="outside_member_input_rows" maxlength="3" size="4" value=$outside_member_input_rows}
  </td>
 </tr>
 <tr>
  <td colspan="2"><br><div class="sub_title">{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-10' replace='true'}</div></td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-11' replace='true'}</th>
  <td>
      {grn_text name="netmeeting_meeting_system_url" maxlength="255" size="80" value=$netmeeting_meeting_system_url}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-12' replace='true'}</th>
  <td>
      {grn_text name="netmeeting_login_id" maxlength="100" size="50" value=$netmeeting_login_id}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-13' replace='true'}</th>
  <td>
      {grn_password name="netmeeting_login_password" size="50" purpose='modify' value=$netmeeting_login_password}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_system_GRN_VCB_SY_16'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-16' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_VCB_SY_16}
       {grn_button_cancel}
  </td>
 </tr>
</table>

</form>
{include file='grn/system_footer.tpl'}
