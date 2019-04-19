{include file='grn/item/detail_header.tpl'}
<div id="main_menu_part">
{if $modify_page}
<span class="menu_item">{capture name='grn_report_item_GRN_RPRT_ITEM_218'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-218' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_218 page=$modify_page params=$menu_params image='modify20.gif' disabled=$disabled}</span>
{/if}
{if $delete_page}
<span class="menu_item">{capture name='grn_report_item_GRN_RPRT_ITEM_219'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-219' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_219 page=$delete_page params=$menu_params image='delete20.gif' disabled=$disabled}</span>
{/if}
</div>

<p>
<table class="view_table">
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-220' replace='true'}</th>
  <td>{$item.display_name|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-221' replace='true'}</th>
  <td>{$item.display_type|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-222' replace='true'}</th>
  <td>{if $item.settings.initial_value == 1}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-223' replace='true'}{else}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-224' replace='true'}{/if}</td>
 </tr>
{if $item.description_type == 1}
 <tr valign="top">
  <th rowspan="2">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-225' replace='true'}</th>
  <td>
    {include file="grn/item/description_editor.tpl"}
  </td>
 </tr>
 <tr valign="top">
  <td>
      {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-226' replace='true'}
  </td>
 </tr>
{else}
 <tr valign="top">
  <th rowspan="1">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-227' replace='true'}</th>
  <td>
    {include file="grn/item/description_editor.tpl"}
  </td>
 </tr>
{/if}
{if $item.option_string_type == 0}
 <tr valign="top">
  <th >{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-228' replace='true'}</th>
  <td>
      {if $item.option_string_type == 0}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-229' replace='true'}
      {elseif $item.option_string_type == 1}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-230' replace='true'}
      {else}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-231' replace='true'}
      {/if}
  </td>
 </tr>
{else}
 <tr valign="top">
  <th rowspan="2">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-232' replace='true'}</th>
  <td>
      {if $item.option_string_type == 0}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-233' replace='true'}
      {elseif $item.option_string_type == 1}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-234' replace='true'}
      {else}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-235' replace='true'}
      {/if}
  </td>
 </tr>
 <tr valign="top">
  <td>{grn_format body=$item.option_string}&nbsp;</td>
 </tr>
{/if}
</table>
{include file="grn/item/detail_footer.tpl" config_id=$config_id}
