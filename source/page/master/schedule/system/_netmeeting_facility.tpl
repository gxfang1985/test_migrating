{**
 * @create:
 *    2011/06/08 VCBSCH0010 Sync for V-CUBE
 **}
{if $netmeeting.system_available}
 <tr>
  <td colspan="2"><br><div class="sub_title">{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-21' replace='true'}</div></td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-22' replace='true'}</th>
  <td>
    {capture name='grn_schedule_system_GRN_VCB_SY_23'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-23' replace='true'}{/capture}
    {if $netmeeting.available}
        {grn_checkbox name="netmeeting_available" id="netmeeting_available" value="1" checked=TURE caption=$smarty.capture.grn_schedule_system_GRN_VCB_SY_23}
    {else}
        {grn_checkbox name="netmeeting_available" id="netmeeting_available" value="1" caption=$smarty.capture.grn_schedule_system_GRN_VCB_SY_23}
    {/if}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-25' replace='true'}
  </th>
  <td>
      {capture name='grn_schedule_system_GRN_VCB_SY_28'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-28' replace='true'}{/capture}
      {validate form=$form_name field="guests_normal_limit" empty="true" criteria="isInt" message=$smarty.capture.grn_schedule_system_GRN_VCB_SY_28 transform="cb_trim" append="validation_errors"}
      {capture name='grn_schedule_system_GRN_VCB_SY_27'}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-27' replace='true'}{/capture}
      {validate form=$form_name field="guests_normal_limit" empty="true" criteria="isRange" low="0" high="999" message=$smarty.capture.grn_schedule_system_GRN_VCB_SY_27 transform="cb_trim" append="validation_errors"}
      {grn_text name="guests_normal_limit" maxlength="3" size="4" value=$netmeeting.guests_normal_limit}
  </td>
 </tr>
{/if}
