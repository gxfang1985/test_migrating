{include file='grn/item/detail_header.tpl'}
<div id="main_menu_part">
{if $modify_page}
<span class="menu_item">{capture name='grn_report_item_GRN_RPRT_ITEM_44'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-44' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_44 page=$modify_page params=$menu_params image='modify20.gif' disabled=$disabled}</span>
{/if}
{if $delete_page && $item.type != 1}
<span class="menu_item">{capture name='grn_report_item_GRN_RPRT_ITEM_45'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-45' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_45 page=$delete_page params=$menu_params image='delete20.gif' disabled=$disabled}</span>
{/if}
</div>

<p>
<table class="view_table">
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-46' replace='true'}</th>
  <td>{$item.display_name|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-47' replace='true'}</th>
  <td>{$item.display_type|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-48' replace='true'}</th>
  <td>{$item.settings.size|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-49' replace='true'}</th>
  <td>{$item.settings.max_input_size|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-50' replace='true'}</th>
  <td>
      {if $item.settings.input_chars == 0}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-51' replace='true'}
      {elseif $item.settings.input_chars == 1}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-52' replace='true'}
      {else}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-53' replace='true'}
      {/if}
  </td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-54' replace='true'}</th>
  <td>
      {if $item.settings.initial_type == 0}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-55' replace='true'}{$item.settings.initial_text_value|escape}
      {else}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-56' replace='true'}{$item.settings.initial_user_value|escape}
      {/if}
  </td>
 </tr>
{if $item.description_type == 1}
 <tr valign="top">
  <th rowspan="2">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-57' replace='true'}</th>
  <td>
    {include file="grn/item/description_editor.tpl"}
  </td>
 </tr>
 <tr valign="top">
  <td>
      {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-58' replace='true'}
  </td>
 </tr>
{else}
 <tr valign="top">
  <th rowspan="1">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-59' replace='true'}</th>
  <td>
    {include file="grn/item/description_editor.tpl"}
  </td>
 </tr>
{/if}
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-60' replace='true'}</th>
  <td>{if $item.required == 1}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-61' replace='true'}{else}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-62' replace='true'}{/if}</td>
 </tr>
{if $item.option_string_type == 0}
 <tr valign="top">
  <th >{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-63' replace='true'}</th>
  <td>
      {if $item.option_string_type == 0}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-64' replace='true'}
      {elseif $item.option_string_type == 1}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-65' replace='true'}
      {else}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-66' replace='true'}
      {/if}
  </td>
 </tr>
{else}
 <tr valign="top">
  <th rowspan="2">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-67' replace='true'}</th>
  <td>
      {if $item.option_string_type == 0}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-68' replace='true'}
      {elseif $item.option_string_type == 1}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-69' replace='true'}
      {else}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-70' replace='true'}
      {/if}
  </td>
 </tr>
 <tr valign="top">
  <td>{grn_format body=$item.option_string}&nbsp;</td>
 </tr>
{/if}
</table>
{include file="grn/item/detail_footer.tpl" config_id=$config_id}
