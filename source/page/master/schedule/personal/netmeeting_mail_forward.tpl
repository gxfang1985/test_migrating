{**
 * @create:
 *    2011/06/08 VCBSCH0010 Sync for V-CUBE
 **}
{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr valign="top">
  <th nowrap>
     {cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_PE-01' replace='true'}
  </th>
  <td>
 {if $set.mail.address}
  {if $set.mail.value == 0}
      {capture name='grn_schedule_netmeeting_GRN_VCB_PE_02'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_PE-02' replace='true'}{/capture}{grn_radio name='mail' id='0' value='0' caption=$smarty.capture.grn_schedule_netmeeting_GRN_VCB_PE_02 checked=true}({$set.mail.address})<br>
      {capture name='grn_schedule_netmeeting_GRN_VCB_PE_03'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_PE-03' replace='true'}{/capture}{grn_radio name='mail' id='1' value='1' caption=$smarty.capture.grn_schedule_netmeeting_GRN_VCB_PE_03}
  {else}
      {capture name='grn_schedule_netmeeting_GRN_VCB_PE_02'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_PE-02' replace='true'}{/capture}{grn_radio name='mail' id='0' value='0' caption=$smarty.capture.grn_schedule_netmeeting_GRN_VCB_PE_02}({$set.mail.address})<br>
      {capture name='grn_schedule_netmeeting_GRN_VCB_PE_03'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_PE-03' replace='true'}{/capture}{grn_radio name='mail' id='1' value='1' caption=$smarty.capture.grn_schedule_netmeeting_GRN_VCB_PE_03 checked=true}
  {/if}
 {else}
      <input type="hidden" name="mail" value="1">
 {/if}
      {grn_text name="other_mail" size="50" value=$set.mail.other}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_schedule_netmeeting_GRN_VCB_PE_04'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_PE-04' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_netmeeting_GRN_VCB_PE_04}
      {grn_button_cancel class='margin' page='personal/application_list' app_id='schedule'}
  </td>
 </tr>
</table>

</form>

{include file='grn/personal_footer.tpl'}
