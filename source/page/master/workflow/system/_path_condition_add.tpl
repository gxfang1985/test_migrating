{include file='grn/show_validation_errors.tpl'}
{if $item == $GRN_WORKFLOW_CONDITION_ITEM_NUMERIC || $item == $GRN_WORKFLOW_CONDITION_ITEM_CALC_NUMERIC}
 {assign var='half_width_number' value='1'}
{/if}
{include file='grn/indispensable.tpl'}
{capture name='grn_workflow_system_w_route_split_name_required_y'}{cb_msg module='grn.workflow.system' key='w_route_split_name_required_y' replace='true'}{/capture}{validate form=$form_name field="name" criteria="notEmpty" message=$smarty.capture.grn_workflow_system_w_route_split_name_required_y transform="cb_trim" append="validation_errors"}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_route_split_name_y'}{cb_msg module='grn.workflow.system' key='w_route_split_name_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_route_split_name_y necessary=true}</th>
  <td>{grn_text necessary=true name="name" value=$name size="50" disable_return_key=true}</td>
 </tr>
<tr>
  <th nowrap>{capture name='grn_workflow_system_w_split_condition_y'}{cb_msg module='grn.workflow.system' key='w_split_condition_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_split_condition_y necessary=true}</th>
  <td>
     {cb_msg module='grn.workflow.system' key='w_enable_pathway_when_1' replace='true'}<span class="bold">{$display_name|escape}</span>&nbsp;
<select name="operator">
    {html_options options=$operators selected=$operator}
</select>
{if $item == $GRN_WORKFLOW_CONDITION_ITEM_RADIO || $item == $GRN_WORKFLOW_CONDITION_ITEM_MENU_STRING}
<select name="option">
    {html_options options=$options selected=$option}
</select>
{elseif $item == $GRN_WORKFLOW_CONDITION_ITEM_NUMERIC || $item == $GRN_WORKFLOW_CONDITION_ITEM_CALC_NUMERIC}
  {capture name='grn_workflow_system_w_split_condition_required_y'}{cb_msg module='grn.workflow.system' key='w_split_condition_required_y' replace='true'}{/capture}{validate form=$form_name field="number" criteria="notEmpty" message=$smarty.capture.grn_workflow_system_w_split_condition_required_y transform="cb_trim" append="validation_errors"}
  {capture name='grn_workflow_system_w_split_condition_numeral_y'}{cb_msg module='grn.workflow.system' key='w_split_condition_numeral_y' replace='true'}{/capture}{validate form=$form_name field="number" criteria="grn_workflow_isNumber" message=$smarty.capture.grn_workflow_system_w_split_condition_numeral_y transform="cb_trim" append="validation_errors"}
  {grn_text necessary=true name="number" value=$number disable_return_key=true}&nbsp;<font color="blue">#</font>&nbsp;
{/if}
{cb_msg module='grn.workflow.system' key='w_enable_pathway_when_3' replace='true'}
 </td>
</tr>

<tr>
<th valign="top">{cb_msg module='grn.workflow.system' key='w_pathway' replace='true'}</th>
<td>
  <table class="list_column" width="80%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
  <col width="1%">
  <col width="1%">
  <col width="15%">
  <col width="15%">
  <col width="15%">
  <col width="40%">
  <col width="15%">
    </colgroup>
  <th nowrap></th>
  <th nowrap>{include file='workflow/checkall.tpl' form_name="`$form_name`" elem_name='psids[]'}</th>
  </th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_pathway_step' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_route_type_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_allow_change_route_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='key_84' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_do_allow_change_initial_value_by_applicant_y' replace='true'}</th>
 </tr>

{assign var=not_first value=true}
{foreach name=path_steps from=$path_steps item=path_step}
 <tr>
{if $not_first}
{assign var=not_first value=false}
  <td class="wf_route_arrow_area_grn" rowspan="{$path_step_count}" style="text-align: center;"><span class="wf_route_arrow_grn">{cb_msg module='grn.workflow.system' key='w_arrow_downward' replace='true'}</span></td>
{/if}
  <td>{grn_checkbox name='psids[]' id="psids_`$path_step._id`" value=$path_step._id checked="`$path_steps_checkeds[$path_step._id]`"}</td>
  <td nowrap>
   {$path_step.col_role|escape}
  </td>
  <td nowrap>{if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}{cb_msg module='grn.workflow.system' key='w_circular' replace='true'}{else}{cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}{/if}</td>
  <td nowrap>
{if $path_step.col_change_path}
   {grn_image image='check20.gif'}
{else}
    &nbsp;
{/if}
  </td>
  <td nowrap>
{assign var='path_step_id' value=$path_step._id}
{if 0 == $member_total.$path_step_id}
   {cb_msg module='grn.workflow.system' key='w_default_set' replace='true'}
{else}
{foreach name=members from=$members.$path_step_id item=member}
   <span class="voice">{grn_workflow_member_name infos=$member}</span><br>
{/foreach}
{if 10 < $member_total.$path_step_id}
   {cb_msg module='grn.workflow.system' key='petition_csv_dash' replace='true'}<small>{cb_msg module='grn.workflow.system' key='w_member_total_count_1' replace='true'}{$member_total.$path_step_id}{cb_msg module='grn.workflow.system' key='w_member_total_count_2' replace='true'}</small>
{/if}
{/if}
  </td>
  <td nowrap>
{if $path_step.col_deny_change_path}
    &nbsp;
{else}
   {grn_image image='check20.gif'}
{/if}
  </td>
</tr>
{/foreach}
</table>
</td>
</tr>

 <tr>
  <td></td>
  <td>
   {grn_button_submit class='margin' caption="$btn_name"}
{if $condition_id}
   {grn_button_cancel page='workflow/system/path_condition_view' cid=$category_id fid=$form_id sid=$skip_id  pcid=$condition_id'}
{else}
   {grn_button_cancel page='workflow/system/form_view' cid=$category_id fid=$form_id'}
{/if}
  </td>
 </tr>
</table><input type="hidden" name="aid" value="184">

