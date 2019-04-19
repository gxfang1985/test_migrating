{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">{cb_msg module='grn.workflow' key='enter_item_information' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}

{if $display == 'add-system' || $display == 'modify-system'}
  {assign var='page_prefix' value='workflow/system/'}
{elseif $display == 'add-operation' || $display == 'modify-operation'}
  {assign var='page_prefix' value='workflow/operation/'}
{else}
  {assign var='page_prefix' value='workflow/'}
{/if}

{assign var="data_type_class" value="foreign_key_change"}
{include file="workflow/item/_set_type.tpl"}

{if $display == 'add-system' || $display == 'modify-system'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/item/command_set_calc_numeric'}" enctype="multipart/form-data">
    {else}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/item/command_set_calc_numeric'}" enctype="multipart/form-data">
{/if}
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_workflow_type'}{cb_msg module='grn.workflow' key='type' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_type}</th>
  <td>
      {grn_select name='foreign_key' size='1' options=$item_options class=$data_type_class}
  </td>
 </tr>
  <tr>
  <th nowrap>{capture name='grn_workflow_item_name'}{cb_msg module='grn.workflow' key='item_name' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_item_name necessary=true}</th>
  <td>
      {capture name='grn_workflow_item_name_required'}{cb_msg module='grn.workflow' key='item_name_required' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" message=$smarty.capture.grn_workflow_item_name_required transform="cb_trim" append="validation_errors"}{grn_text name='display_name' size='50' disable_return_key=true value=$item.display_name}
  </td>
 </tr>
    <tr>
        <th nowrap>{capture name='grn_workflow_item_code'}{cb_msg module='grn.workflow' key='item_code' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_item_code}</th>
        <td>
            {capture name='grn_workflow_item_code_value_validate_message'}{cb_msg module='grn.workflow' key='item_code_value_validate_message' replace='true'}{/capture}{validate form=$form_name field="code" empty="true" criteria="isRegExp" message=$smarty.capture.grn_workflow_item_code_value_validate_message expression="/^[\da-zA-Z_\-]+$/" transform="cb_trim" append="validation_errors"}
            {grn_text name='code' size='50' disable_return_key=true value=$item.code}
        </td>
    </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_valid_digit'}{cb_msg module='grn.workflow' key='valid_digit' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_valid_digit}</th>
  <td>
      {grn_select_numbers select_name='effective_figures' size='1' options=$effective_figures_options selected=$settings.effective_figures}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_minus_value_style'}{cb_msg module='grn.workflow' key='minus_value_style' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_minus_value_style}</th>
  <td>
      {grn_select name='minus_type' size='1' options=$minus_type_options}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_workflow_description'}{cb_msg module='grn.workflow' key='description' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_description}</th>
  <td>
      {include file="grn/richeditor.tpl" name="description" html=$item.description_html text=$item.description_text cols=$richeditor.cols rows=$richeditor.rows enable=1 class="form_textarea_grn"}<br>
      {capture name='grn_workflow_display_by_icon'}{cb_msg module='grn.workflow' key='display_by_icon' replace='true'}{/capture}{grn_checkbox name='description_type' id='description_type' value='1' caption=$smarty.capture.grn_workflow_display_by_icon checked=$item.description_type}
  </td>
 </tr>
 {include file='workflow/item/_set_item_condition.tpl' required_item=false}
 <tr>
  <th nowrap>{capture name='grn_workflow_calculation'}{cb_msg module='grn.workflow' key='calculation' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_calculation}</th>
  <td>
      {cb_msg module='grn.workflow' key='calculation_round_invalid_digit' replace='true'}<br>
      {cb_msg module='grn.workflow' key='calculates_items_preceding_this_item' replace='true'}<br>
      {if $settings.calc_type == 0}{assign var='calc_type_0' value='1'}{else}{assign var='calc_type_1' value='1'}{/if}
      {capture name='grn_workflow_four_arithmetic'}{cb_msg module='grn.workflow' key='four_arithmetic' replace='true'}{/capture}{grn_radio name='calc_type' id='0' value='0' caption=$smarty.capture.grn_workflow_four_arithmetic checked=$calc_type_0}<br>
   <blockquote>
    <table>
     <tr>
      <td>{grn_select name='operand1_type' size='1' options=$operand1_options}</td>
      <td>{grn_select name='operator' size='1' options=$operator_options}</td>
      <td>{grn_select name='operand2_type' size='1' options=$operand2_options}</td>
     </tr>
     <tr>
      {capture name='grn_workflow_constant_is_numeral_item'}{cb_msg module='grn.workflow' key='constant_is_numeral_item' replace='true'}{/capture}{validate form=$form_name field="operand1_value" criteria="grn_workflow_isNumber" message=$smarty.capture.grn_workflow_constant_is_numeral_item append="validation_errors" empty=true}
      <td>{cb_msg module='grn.workflow' key='key_45_1' replace='true'}{grn_text name='operand1_value' size='8' disable_return_key=true value=$settings.calc_operator.operand1_value}<font color="#0000ff">#</font>{cb_msg module='grn.workflow' key='key_45_2' replace='true'}</td>
      <td></td>
      {capture name='grn_workflow_constant_is_numeral_item'}{cb_msg module='grn.workflow' key='constant_is_numeral_item' replace='true'}{/capture}{validate form=$form_name field="operand2_value" criteria="grn_workflow_isNumber" message=$smarty.capture.grn_workflow_constant_is_numeral_item append="validation_errors" empty=true}
      <td>{cb_msg module='grn.workflow' key='key_45_1' replace='true'}{grn_text name='operand2_value' size='8' disable_return_key=true value=$settings.calc_operator.operand2_value}<font color="#0000ff">#</font>{cb_msg module='grn.workflow' key='key_45_2' replace='true'}</td>
     </tr>
    </table>
   </blockquote>
      {capture name='grn_workflow_total_bracket_sum'}{cb_msg module='grn.workflow' key='total_bracket_sum' replace='true'}{/capture}{grn_radio name='calc_type' id='1' value='1' caption=$smarty.capture.grn_workflow_total_bracket_sum checked=$calc_type_1}<br>
   <blockquote>
      {include file='grn/item_add.tpl' initialize_item=$selected_total_options item_group=$total_options multiple_str='multiple' select_size=10 no_pulldown=1 no_order=1}
   </blockquote>
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_display'}{cb_msg module='grn.workflow' key='display' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_display}</th>
  <td>
      {capture name='grn_workflow_align_right'}{cb_msg module='grn.workflow' key='align_right' replace='true'}{/capture}{grn_checkbox name='right_align' id='right_align' value='1' caption=$smarty.capture.grn_workflow_align_right checked=$settings.right_align}<br>
      {capture name='grn_workflow_show_digit_separator'}{cb_msg module='grn.workflow' key='show_digit_separator' replace='true'}{/capture}{grn_checkbox name='split_rank' id='split_rank' value='1' caption=$smarty.capture.grn_workflow_show_digit_separator  checked=$settings.split_rank}<br>
      {capture name='grn_workflow_donot_show_calculated_result'}{cb_msg module='grn.workflow' key='donot_show_calculated_result' replace='true'}{/capture}{grn_checkbox name='not_display' id='not_display' value='1' caption=$smarty.capture.grn_workflow_donot_show_calculated_result checked=$settings.not_display}
      <div class="br">&nbsp;</div>
      <div class="sub_explanation">{cb_msg module='grn.workflow' key='right_allocation_invalid_if_hiding_calculated_result' replace='true'}<div>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_workflow_strings_next_to_entry_field'}{cb_msg module='grn.workflow' key='strings_next_to_entry_field' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_strings_next_to_entry_field}</th>
  <td>
    {capture name='grn_workflow_option_string_type_order'}{cb_msg module='grn.workflow' key='option_string_type_order' replace='true'}{/capture}
      {grn_text name='option_string' size='50' disable_return_key=true value=$item.option_string}{cb_msg module='grn.workflow' key='option_string_type_bridge' replace='true'}
      {grn_select name='option_string_type' size='1' options=$option_string_type_options}
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.workflow' key='display_added_strings_next_to_entry_field' replace='true'}</div>
    <div class="br">&nbsp;</div>
     <div class="sub_explanation">{cb_msg module='grn.workflow' key='key_47' replace='true'}</div>
      <table border=1 cellspacing=0 cellpadding=10 style="border-collapse:collapse;" bordercolor=#999999>
       <tr>
        <td>{cb_msg module='grn.workflow' key='key_48' replace='true'}<input type=text value="{cb_msg module='grn.workflow' key='bracket_this_item' replace='true'}" size=15></td>
       </tr>
      </table>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_workflow_allocate_right'}{cb_msg module='grn.workflow' key='allocate_right' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_allocate_right}</th>
  <td>
      {capture name='grn_workflow_allocate_item_right'}{cb_msg module='grn.workflow' key='allocate_item_right' replace='true'}{/capture}{grn_checkbox name='reverse_br' id='reverse_br' value=1 caption=$smarty.capture.grn_workflow_allocate_item_right checked=$item.reverse_br}
   <div class="br">&nbsp;</div>
    <div class="sub_explanation">{cb_msg module='grn.workflow' key='deselect_to_allocate_below' replace='true'}</div>
   <div class="br">&nbsp;</div>
    <div class="sub_explanation">{cb_msg module='grn.workflow' key='select_show_separator' replace='true'}{grn_text name='separator' size='5' disable_return_key=true value=$item.separator}</div>
     <div class="br">&nbsp;</div>
      <div class="sub_explanation">{cb_msg module='grn.workflow' key='key_20_1' replace='true'}{cb_msg module='grn.workflow' key='key_20_2' replace='true'}{cb_msg module='grn.workflow' key='key_20_3' replace='true'}</div>
      <table border=1 cellspacing=0 cellpadding=10 style="border-collapse:collapse;" bordercolor=#999999>
       <tr>
        <td>{cb_msg module='grn.workflow' key='key_20_4' replace='true'} <input type=text value="{cb_msg module='grn.workflow' key='bracket_previous_item' replace='true'}" size=20>{cb_msg module='grn.workflow' key='key_20_2' replace='true'}<input type=text value="{cb_msg module='grn.workflow' key='bracket_this_item' replace='true'}" size=15></td>
       </tr>
      </table>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {if $display == 'add-system'}
        <input class="margin" type="submit" value="{cb_msg module='grn.workflow' key='add_1' replace='true'}" onclick='grn_onsubmit_common(this.form);' id="{$page_info.last}_submit">
        {grn_button_cancel page='workflow/system/form_view' cid=$category_id fid=$form_id onclick='grn_onsubmit_common(this.fotm)'}
      {elseif $display == 'add-operation'}
        <input class="margin" type="submit" value="{cb_msg module='grn.workflow' key='add_1' replace='true'}" onclick='grn_onsubmit_common(this.form);' id="{$page_info.last}_submit">
        {grn_button_cancel page='workflow/operation/form_view' cid=$category_id fid=$form_id}
      {elseif $display == 'add'}
        <input class="margin" type="submit" value="{cb_msg module='grn.workflow' key='add_1' replace='true'}" onclick='grn_onsubmit_common(this.form);' id="{$page_info.last}_submit">
        {grn_button_cancel page='workflow/form_view' fid=$folder_id pid=$petition_id}
      {elseif $display == 'modify-system'}
        <input class="margin" type="submit" value="{cb_msg module='grn.workflow' key='change' replace='true'}" onclick='grn_onsubmit_common(this.form);' id="{$page_info.last}_submit">
        {grn_button_cancel page='workflow/system/formlayout_view' cid=$category_id fid=$form_id iid=$item.iid}
      {elseif $display == 'modify-operation'}
        <input class="margin" type="submit" value="{cb_msg module='grn.workflow' key='change' replace='true'}" onclick='grn_onsubmit_common(this.form);' id="{$page_info.last}_submit">
        {grn_button_cancel page='workflow/operation/formlayout_view' cid=$category_id fid=$form_id iid=$item.iid}
      {elseif $display == 'modify'}
        <input class="margin" type="submit" value="{cb_msg module='grn.workflow' key='change' replace='true'}" onclick='grn_onsubmit_common(this.form);' id="{$page_info.last}_submit">
        {grn_button_cancel page='workflow/formlayout_view' fid=$folder_id pid=$petition_id iid=$item.iid}
      {/if}
  </td>
 </tr>
</table>

{if $display != 'add' && $display != 'modify'}
<input type="hidden" name="cid" value="{$category_id}">
<input type="hidden" name="fid" value="{$form_id}">
{else}
<input type="hidden" name="fid" value="{$folder_id}">
<input type="hidden" name="pid" value="{$petition_id}">
{/if}
<input type="hidden" name="iid" value="{$item.iid}">
<input type="hidden" name="type" value="{$item.type}">
<input type="hidden" name="display" value="{$display}">
</form>

