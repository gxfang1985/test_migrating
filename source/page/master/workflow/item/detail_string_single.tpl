{include file='grn/item/detail_header.tpl'}
<div id="main_menu_part">
{if $modify_page}
<span class="menu_item">{capture name='grn_workflow_change'}{cb_msg module='grn.workflow' key='change_with_no_cancel' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_change page=$modify_page params=$menu_params image='modify20.gif' disabled=$disabled}</span>
{/if}
{if $delete_page && $item.type != 1}
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
  <th>{cb_msg module='grn.workflow' key='form_width' replace='true'}</th>
  <td>{$item.settings.size|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.workflow' key='maximum_character_number' replace='true'}</th>
  <td>{$item.settings.max_input_size|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.workflow' key='character_limit' replace='true'}</th>
  <td>
      {if $item.settings.input_chars == 0}
        {cb_msg module='grn.workflow' key='unlimited' replace='true'}
      {elseif $item.settings.input_chars == 1}
        {cb_msg module='grn.workflow' key='two_bytes_only' replace='true'}
      {else}
        {cb_msg module='grn.workflow' key='single_byte_only' replace='true'}
      {/if}
  </td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.workflow' key='default_value' replace='true'}</th>
  <td>
      {if $item.settings.initial_type == 0}
        {cb_msg module='grn.workflow' key='direct_entry' replace='true'}{$item.settings.initial_text_value|escape}
      {else}
        {cb_msg module='grn.workflow' key='user_information_colon' replace='true'}{$item.settings.initial_user_value|escape}
      {/if}
  </td>
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
{include file='workflow/item/_detail_item_condition.tpl' required_item=true}
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
{if $item.type != 1}
 <tr valign="top">
  <th>{cb_msg module='grn.workflow' key='allocate_right' replace='true'}</th>
  <td>{if $item.br == 0}{cb_msg module='grn.workflow' key='key_46_1' replace='true'}{$item.separator|escape}{cb_msg module='grn.workflow' key='key_46_2' replace='true'}{else}{cb_msg module='grn.workflow' key='option_string_type_0_sample' replace='true'}{/if}</td>
 </tr>
{/if}
</table>
{include file="grn/item/detail_footer.tpl" config_id=$config_id}
