<table class="std_form">

{* ------------------------------------------------------------------ *}

 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.system' key='w_target_2_y' replace='true'}
  </th>
  <td>
      {capture name='suffix'}
       {if $form_info.deleted == 1}
        {cb_msg module='grn.workflow' key='[deleted]'}
       {elseif $form_info.active == 0}
        {cb_msg module='grn.workflow' key='[deactive]'}
       {/if}
      {/capture}
      {grn_workflow_form_icon_image icon_type=$form_info.icon_type icon_id=$form_info.icon_id icon_url=$form_info.icon_url}
      <span class="bold">{grn_sentence caption=$form_info.name|cat:$smarty.capture.suffix}</span>
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.system' key='petition_csv_no' replace='true'}
  </th>
  <td>
      {grn_text name='petition_number' value=$petition_number size='50' maxlength='100' disable_return_key=true}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.system' key='petition_csv_subject' replace='true'}
  </th>
  <td>
      {grn_text name='subject' value=$petition_subject size='50' maxlength='100' disable_return_key=true}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.system' key='w_applicant_y' replace='true'}
  </th>
  <td>
      {grn_text name='creator_name' value=$creator_name size='50' maxlength='100' disable_return_key=true}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.system' key='w_status_y' replace='true'}
  </th>
  <td>
{capture name='grn_workflow_view_status_0'}{cb_msg module='grn.workflow' key='view_status_0' replace='true'}{/capture}{grn_checkbox name='status[0]' id='status_0' value='1' checked=$status.0 caption=$smarty.capture.grn_workflow_view_status_0}
{capture name='grn_workflow_view_status_1'}{cb_msg module='grn.workflow' key='view_status_1' replace='true'}{/capture}{grn_checkbox name='status[1]' id='status_1' value='1' checked=$status.1 caption=$smarty.capture.grn_workflow_view_status_1}
{capture name='grn_workflow_view_status_2'}{cb_msg module='grn.workflow' key='view_status_2' replace='true'}{/capture}{grn_checkbox name='status[2]' id='status_2' value='1' checked=$status.2 caption=$smarty.capture.grn_workflow_view_status_2}
{capture name='grn_workflow_view_status_3'}{cb_msg module='grn.workflow' key='view_status_3' replace='true'}{/capture}{grn_checkbox name='status[3]' id='status_3' value='1' checked=$status.3 caption=$smarty.capture.grn_workflow_view_status_3}
{capture name='grn_workflow_view_status_4'}{cb_msg module='grn.workflow' key='view_status_4' replace='true'}{/capture}{grn_checkbox name='status[4]' id='status_4' value='1' checked=$status.4 caption=$smarty.capture.grn_workflow_view_status_4}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.system' key='w_application_date_y' replace='true'}{cb_msg module='grn.workflow.system' key='w_period' replace='true'}
  </th>
  <td>
       {grn_select_date form_name=$form_name necessary=false show_wday=true prefix='start_term_' date=$start_date}
     {cb_msg module='grn.workflow.system' key='w_wavy_line ' replace='true'}{grn_select_date form_name=$form_name necessary=false show_wday=true prefix='end_term_'   date=$end_date}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-96' replace='true'}
  </th>
  <td>
      {grn_workflow_form_item_add form_id=$fid form_name=$form_name}
  </td>
 </tr>

<input type="hidden" name="cid" value="{$cid|escape}">
<input type="hidden" name="fid" value="{$fid|escape}">

{* ------------------------------------------------------------------ *}

 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.system' key='w_char_code_y' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" default=$charset bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.system' key='w_export_top_line_y' replace='true'}
  </th>
  <td>
     {if $skip}
      {capture name='grn_workflow_system_w_yes'}{cb_msg module='grn.workflow.system' key='w_yes' replace='true'}{/capture}{grn_radio name="skip" id="yes" value="1" caption=$smarty.capture.grn_workflow_system_w_yes   checked=1}&nbsp;{capture name='grn_workflow_system_w_no'}{cb_msg module='grn.workflow.system' key='w_no' replace='true'}{/capture}{grn_radio name="skip" id="no" value="0" caption=$smarty.capture.grn_workflow_system_w_no checked=0}
     {else}
      {capture name='grn_workflow_system_w_yes'}{cb_msg module='grn.workflow.system' key='w_yes' replace='true'}{/capture}{grn_radio name="skip" id="yes" value="1" caption=$smarty.capture.grn_workflow_system_w_yes   checked=0}&nbsp;{capture name='grn_workflow_system_w_no'}{cb_msg module='grn.workflow.system' key='w_no' replace='true'}{/capture}{grn_radio name="skip" id="no" value="0" caption=$smarty.capture.grn_workflow_system_w_no checked=1}
     {/if}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_workflow_system_w_export_y'}{cb_msg module='grn.workflow.system' key='w_export_y' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_workflow_system_w_export_y onclick='PrepareSubmit(this.form);'}
      {grn_button_cancel page="workflow/system/petition_list" cid=$cid fid=$fid}
  </td>
 </tr>
</table>
