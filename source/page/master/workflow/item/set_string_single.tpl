{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">{cb_msg module='grn.workflow' key='enter_item_information' replace='true'}</div>
<p>
{assign var='half_width_number' value='1'}
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}

{if $display == 'add-system' || $display == 'modify-system'}
  {assign var='page_prefix' value='workflow/system/'}
{elseif $display == 'add-operation' || $display == 'modify-operation'}
  {assign var='page_prefix' value='workflow/operation/'}
{else}
  {assign var='page_prefix' value='workflow/'}
{/if}

{if $item.type != 1}
    {assign var="data_type_class" value="foreign_key_change"}
    {include file="workflow/item/_set_type.tpl"}
{/if}

{if $display == 'add-system' || $display == 'modify-system'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/item/command_set_string_single'}" enctype="multipart/form-data">
    {else}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/item/command_set_string_single'}" enctype="multipart/form-data">
{/if}
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_workflow_type'}{cb_msg module='grn.workflow' key='type' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_type}</th>
  <td>
      {if $item.type == 1}
        {$item.display_type|escape}
        <input type="hidden" name="foreign_key" value="{$selected_foreign_key}">
      {else}
        {grn_select name='foreign_key' size='1' options=$item_options class=$data_type_class}
      {/if}
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
  <th nowrap>{capture name='grn_workflow_form_width'}{cb_msg module='grn.workflow' key='form_width' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_form_width necessary=true}</th>
  <td>
        {capture name='grn_workflow_entry_width_required'}{cb_msg module='grn.workflow' key='entry_width_required' replace='true'}{/capture}{validate form=$form_name field="size" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_workflow_entry_width_required append="validation_errors"}
        {capture name='grn_workflow_entry_width_numeral'}{cb_msg module='grn.workflow' key='entry_width_numeral' replace='true'}{/capture}{validate form=$form_name field="size" criteria="isNumber" message=$smarty.capture.grn_workflow_entry_width_numeral append="validation_errors" empty=true}
        {capture name='grn_workflow_entry_width_below_minimum'}{cb_msg module='grn.workflow' key='entry_width_below_minimum' replace='true'}{/capture}{validate form=$form_name field="size" criteria="grn_workflow_isRangeMin" min='1' message=$smarty.capture.grn_workflow_entry_width_below_minimum append="validation_errors" empty=true}
        {grn_text name='size' size='5' value=$settings.size}<font color="#0000ff">#</font><div class="sub_explanation">{cb_msg module='grn.workflow' key='character_number_single_byte' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_maximum_character_number'}{cb_msg module='grn.workflow' key='maximum_character_number' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_maximum_character_number}</th>
  <td>
        {capture name='grn_workflow_maximum_character_numeral'}{cb_msg module='grn.workflow' key='maximum_character_numeral' replace='true'}{/capture}{validate form=$form_name field="max_input_size" criteria="isNumber" message=$smarty.capture.grn_workflow_maximum_character_numeral append="validation_errors" empty=true}
        {capture name='grn_workflow_maximum_character_below_minimum'}{cb_msg module='grn.workflow' key='maximum_character_below_minimum' replace='true'}{/capture}{validate form=$form_name field="max_input_size" criteria="grn_workflow_isRangeMin" min='1' message=$smarty.capture.grn_workflow_maximum_character_below_minimum append="validation_errors" empty=true}
        {grn_text name='max_input_size' size='5' value=$settings.max_input_size}<font color="#0000ff">#</font>
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_character_limit'}{cb_msg module='grn.workflow' key='character_limit' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_character_limit}</th>
  <td>
        {if $settings.input_chars == 0}
          {assign var='input_chars_0' value='1'}
        {elseif  $settings.input_chars == 1}
          {assign var='input_chars_1' value='1'}
        {else}
          {assign var='input_chars_2' value='1'}
        {/if}
        {capture name='grn_workflow_unlimited'}{cb_msg module='grn.workflow' key='unlimited' replace='true'}{/capture}{grn_radio name='input_chars' id='input_chars_0' value='0' caption=$smarty.capture.grn_workflow_unlimited checked=$input_chars_0}
        {capture name='grn_workflow_two_bytes_only'}{cb_msg module='grn.workflow' key='two_bytes_only' replace='true'}{/capture}{grn_radio name='input_chars' id='input_chars_1' value='1' caption=$smarty.capture.grn_workflow_two_bytes_only checked=$input_chars_1}
        {capture name='grn_workflow_single_byte_only'}{cb_msg module='grn.workflow' key='single_byte_only' replace='true'}{/capture}{grn_radio name='input_chars' id='input_chars_2' value='2' caption=$smarty.capture.grn_workflow_single_byte_only checked=$input_chars_2}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_workflow_default_value'}{cb_msg module='grn.workflow' key='default_value' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_default_value}</th>
  <td>
        {if $settings.initial_type == 0}{assign var='initial_type_0' value='1'}{else}{assign var='initial_type_1' value='1'}{/if}
        {capture name='grn_workflow_direct_entry'}{cb_msg module='grn.workflow' key='direct_entry' replace='true'}{/capture}{grn_radio name='initial_type' id='initial_type_0' value='0' caption=$smarty.capture.grn_workflow_direct_entry checked=$initial_type_0}
        {grn_text name='initial_text_value' size='50' disable_return_key=true value=$settings.initial_text_value}<br>
        {capture name='grn_workflow_user_information_colon'}{cb_msg module='grn.workflow' key='user_information_colon' replace='true'}{/capture}{grn_radio name='initial_type' id='initial_type_1' value='1' caption=$smarty.capture.grn_workflow_user_information_colon checked=$initial_type_1}
        {grn_select name='initial_user_value' size='1' options=$user_options}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_workflow_description'}{cb_msg module='grn.workflow' key='description' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_description}</th>
  <td>
      {include file="grn/richeditor.tpl" name="description" data=$item.description html=$item.description_html text=$item.description_text cols=$richeditor.cols rows=$richeditor.rows enable=1 class="form_textarea_grn"}<br>
      {capture name='grn_workflow_display_by_icon'}{cb_msg module='grn.workflow' key='display_by_icon' replace='true'}{/capture}{grn_checkbox name='description_type' id='description_type' value='1' caption=$smarty.capture.grn_workflow_display_by_icon checked=$item.description_type}
  </td>
 </tr>
 {include file='workflow/item/_set_item_condition.tpl' required_item=true}
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
      {if $item.type != 1}
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
      {else}
        <input type="hidden" name="reverse_br" value="0">
        <input type="hidden" name="separator" value="">
      {/if}
 <tr>
  <td></td>
  <td>
      {if $display == 'add-system'}
        <input class="margin" type="submit" value="{cb_msg module='grn.workflow' key='add_1' replace='true'}" id="{$page_info.last}_submit">
        {grn_button_cancel page='workflow/system/form_view' cid=$category_id fid=$form_id}
      {elseif $display == 'add-operation'}
        <input class="margin" type="submit" value="{cb_msg module='grn.workflow' key='add_1' replace='true'}" id="{$page_info.last}_submit">
        {grn_button_cancel page='workflow/operation/form_view' cid=$category_id fid=$form_id}
      {elseif $display == 'add'}
        <input class="margin" type="submit" value="{cb_msg module='grn.workflow' key='add_1' replace='true'}" id="{$page_info.last}_submit">
        {grn_button_cancel page='workflow/form_view' fid=$folder_id pid=$petition_id}
      {elseif $display == 'modify-system'}
        <input class="margin" type="submit" value="{cb_msg module='grn.workflow' key='change' replace='true'}" id="{$page_info.last}_submit">
        {grn_button_cancel page='workflow/system/formlayout_view' cid=$category_id fid=$form_id iid=$item.iid}
      {elseif $display == 'modify-operation'}
        <input class="margin" type="submit" value="{cb_msg module='grn.workflow' key='change' replace='true'}" id="{$page_info.last}_submit">
        {grn_button_cancel page='workflow/operation/formlayout_view' cid=$category_id fid=$form_id iid=$item.iid}
      {elseif $display == 'modify'}
        <input class="margin" type="submit" value="{cb_msg module='grn.workflow' key='change' replace='true'}" id="{$page_info.last}_submit">
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

