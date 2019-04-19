{include file='grn/item/detail_header.tpl'}
<div id="main_menu_part">
{if $modify_page}
<span class="menu_item">{capture name='grn_report_item_GRN_RPRT_ITEM_264'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-264' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_264 page=$modify_page params=$menu_params image='modify20.gif' disabled=$disabled}</span>
{/if}
{if $delete_page}
<span class="menu_item">{capture name='grn_report_item_GRN_RPRT_ITEM_265'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-265' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_265 page=$delete_page params=$menu_params image='delete20.gif' disabled=$disabled}</span>
{/if}
</div>

<p>
<table class="view_table">
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-266' replace='true'}</th>
  <td>{$item.display_name|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-267' replace='true'}</th>
  <td>{$item.display_type|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-268' replace='true'}</th>
  <td>{grn_format body=$item.settings.radio_items}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-269' replace='true'}</th>
  <td>{$item.settings.initial_value|escape}</td>
 </tr>
{if $item.description_type == 1}
 <tr valign="top">
  <th rowspan="2">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-270' replace='true'}</th>
  <td>
    {include file="grn/item/description_editor.tpl"}
  </td>
 </tr>
 <tr valign="top">
  <td>
      {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-271' replace='true'}
  </td>
 </tr>
{else}
 <tr valign="top">
  <th rowspan="1">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-272' replace='true'}</th>
  <td>
    {include file="grn/item/description_editor.tpl"}
  </td>
 </tr>
{/if}
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-273' replace='true'}</th>
  <td>{if $item.required == 1}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-274' replace='true'}{else}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-275' replace='true'}{/if}</td>
 </tr>
{if $item.option_string_type == 0}
 <tr valign="top">
  <th >{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-276' replace='true'}</th>
  <td>
      {if $item.option_string_type == 0}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-277' replace='true'}
      {elseif $item.option_string_type == 1}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-278' replace='true'}
      {else}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-279' replace='true'}
      {/if}
  </td>
 </tr>
{else}
 <tr valign="top">
  <th rowspan="2">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-280' replace='true'}</th>
  <td>
      {if $item.option_string_type == 0}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-281' replace='true'}
      {elseif $item.option_string_type == 1}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-282' replace='true'}
      {else}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-283' replace='true'}
      {/if}
  </td>
 </tr>
 <tr valign="top">
  <td>{grn_format body=$item.option_string}&nbsp;</td>
 </tr>
{/if}
</table>
{include file="grn/item/detail_footer.tpl" config_id=$config_id}
