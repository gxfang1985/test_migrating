{include file='grn/item/detail_header.tpl'}
<div id="main_menu_part">
{if $modify_page}
<span class="menu_item">{capture name='grn_workflow_change'}{cb_msg module='grn.workflow' key='change_with_no_cancel' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_change page=$modify_page params=$menu_params image='modify20.gif' disabled=$disabled}</span>
{/if}
{if $delete_page}
<span class="menu_item">{capture name='grn_workflow_delete_2'}{cb_msg module='grn.workflow' key='delete_2' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_delete_2 page=$delete_page params=$menu_params image='delete20.gif' disabled=$disabled}</span>
{/if}
</div>

<p>
<table class="view_table">
 <tr valign="top">
  <th>{cb_msg module='grn.workflow' key='item_name' replace='true'}</th>
  <td>{$item.display_name|escape}</td>
 </tr>
    <tr valign="top">
        <th>{cb_msg module='grn.workflow' key='item_code' replace='true'}</th>
        <td>{$item.code|escape}</td>
    </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.workflow' key='type' replace='true'}</th>
  <td>{$item.display_type|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.workflow' key='valid_digit' replace='true'}</th>
  <td>{$item.settings.effective_figures|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.workflow' key='minus_value_style' replace='true'}</th>
  <td>{$item.settings.minus_type|escape}</td>
 </tr>
{if $item.description_type == 1}
 <tr valign="top">
  <th rowspan="2">{cb_msg module='grn.workflow' key='description' replace='true'}</th>
  {if $item.description && $item.description_editor}
  <td>{$item.description|grn_noescape}</td>
  {else}
  <td>{grn_format body=$item.description}</td>
  {/if}
 </tr>
 <tr valign="top">
  <td>
      {cb_msg module='grn.workflow' key='display_by_icon' replace='true'}
  </td>
 </tr>
{else}
 <tr valign="top">
  <th rowspan="1">{cb_msg module='grn.workflow' key='description' replace='true'}</th>
  {if $item.description && $item.description_editor}
  <td>{$item.description|grn_noescape}</td>
  {else}
  <td>{grn_format body=$item.description}</td>
  {/if}
 </tr>
{/if}
{include file='workflow/item/_detail_item_condition.tpl' required_item=false}
 <tr valign="top">
  <th>{cb_msg module='grn.workflow' key='calculation' replace='true'}</th>
  <td>
      {if $item.settings.calc_type == 0}
        {cb_msg module='grn.workflow' key='four_arithmetic' replace='true'}<br>
        &nbsp;&nbsp;{$item.settings.calc_operator.operand1_value|escape}
        &nbsp;{$item.settings.calc_operator.operator|escape}
        &nbsp;{$item.settings.calc_operator.operand2_value|escape}
      {else}
        {cb_msg module='grn.workflow' key='total_bracket_sum' replace='true'}<br>
        {foreach from=$item.settings.calc_total.values item=value}
          &nbsp;&nbsp;{$value|escape}
        {/foreach}
      {/if}
  </td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.workflow' key='display' replace='true'}</th>
  <td>{if $item.settings.right_align == 1}{cb_msg module='grn.workflow' key='align_right' replace='true'}{/if}
      {if $item.settings.right_align == 1 && $item.settings.split_rank == 1}<br>{/if}
      {if $item.settings.split_rank == 1}{cb_msg module='grn.workflow' key='show_digit_separator' replace='true'}{/if}
      {if $item.settings.split_rank == 1 && $item.settings.not_display == 1}<br>{/if}
      {if $item.settings.not_display == 1}{cb_msg module='grn.workflow' key='donot_show_calculated_result' replace='true'}{/if}
  </td>
 </tr>
{if $item.option_string_type == 0}
 <tr valign="top">
  <th >{cb_msg module='grn.workflow' key='strings_next_to_entry_field' replace='true'}</th>
  <td>
      {if $item.option_string_type == 0}
        {cb_msg module='grn.workflow' key='option_string_type_0_sample' replace='true'}
      {elseif $item.option_string_type == 1}
        {cb_msg module='grn.workflow' key='option_string_type_1_sample' replace='true'}
      {else}
        {cb_msg module='grn.workflow' key='option_string_type_2_sample' replace='true'}
      {/if}
  </td>
 </tr>
{else}
 <tr valign="top">
  <th rowspan="2">{cb_msg module='grn.workflow' key='strings_next_to_entry_field' replace='true'}</th>
  <td>
      {if $item.option_string_type == 0}
        {cb_msg module='grn.workflow' key='option_string_type_0_sample' replace='true'}
      {elseif $item.option_string_type == 1}
        {cb_msg module='grn.workflow' key='option_string_type_1_sample' replace='true'}
      {else}
        {cb_msg module='grn.workflow' key='option_string_type_2_sample' replace='true'}
      {/if}
  </td>
 </tr>
 <tr valign="top">
  <td>{grn_format body=$item.option_string}&nbsp;</td>
 </tr>
{/if}
 <tr valign="top">
  <th>{cb_msg module='grn.workflow' key='allocate_right' replace='true'}</th>
  <td>{if $item.br == 0}{cb_msg module='grn.workflow' key='key_46_1' replace='true'}{$item.separator|escape}{cb_msg module='grn.workflow' key='key_46_2' replace='true'}{else}{cb_msg module='grn.workflow' key='option_string_type_0_sample' replace='true'}{/if}</td>
 </tr>
</table>
{include file="grn/item/detail_footer.tpl" config_id=$config_id}
