{* Because Threre is a comment out area where $access_page is used,
 * I also comment out as to definition of $access_page.
 * So, If you need $access_page, Please remove comment out below if statement
 * And mainteinance grn/item/detail_header.tpl.
 *}
{*
{if $display == 'detail-system'}
    {assign var='access_page' value='report/system/change_access_list'}
{elseif $display == 'detail-operation'}
    {assign var='access_page' value='report/operation/change_access_list'}
{else}
    {assign var='access_page' value='report/change_access_list'}
{/if}
*}
{include file='grn/item/detail_header.tpl'}
<div id="main_menu_part">
{if $modify_page}
<span class="menu_item">{capture name='grn_report_item_GRN_RPRT_ITEM_237'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-237' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_237 page=$modify_page params=$menu_params image='modify20.gif' disabled=$disabled}</span>
{/if}
{if $delete_page}
<span class="menu_item">{capture name='grn_report_item_GRN_RPRT_ITEM_238'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-238' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_238 page=$delete_page params=$menu_params image='delete20.gif' disabled=$disabled}</span>
{/if}
{*
{if $access_page}
<span class="menu_item">{capture name='grn_report_item_GRN_RPRT_ITEM_239'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-239' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_239 page=$access_page params=$menu_params image='access20.gif' disabled=$disabled}</span>
{/if}
*}
</div>

<p>
<table class="view_table">
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-240' replace='true'}</th>
  <td>{$item.display_name|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-241' replace='true'}</th>
  <td>{$item.display_type|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-242' replace='true'}</th>
  <td>{$item.settings.max_files|escape}</td>
 </tr>
{if $item.description_type == 1}
 <tr valign="top">
  <th rowspan="2">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-243' replace='true'}</th>
  <td> 
    {include file="grn/item/description_editor.tpl"}
  </td>
 </tr>
 <tr valign="top">
  <td>
      {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-244' replace='true'}
  </td>
 </tr>
{else}
 <tr valign="top">
  <th rowspan="1">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-245' replace='true'}</th>
   <td>
     {include file="grn/item/description_editor.tpl"}
   </td>
 </tr>
{/if}
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-246' replace='true'}</th>
  <td>{if $item.required == 1}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-247' replace='true'}{else}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-248' replace='true'}{/if}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-249' replace='true'}</th>
  <td>
      {if $item.settings.inline == 1}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-250' replace='true'} {/if}
      {if $item.settings.inline == 1 && $item.settings.thumbnail == 1}<br>{/if}
      {if $item.settings.thumbnail == 1}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-251' replace='true'}{$item.settings.thumbnail_xsize}px/{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-252' replace='true'}{$item.settings.thumbnail_ysize}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-253' replace='true'}{/if}
  </td>
 </tr>
{if $item.option_string_type == 0}
 <tr valign="top">
  <th >{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-254' replace='true'}</th>
  <td>
      {if $item.option_string_type == 0}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-255' replace='true'}
      {elseif $item.option_string_type == 1}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-256' replace='true'}
      {else}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-257' replace='true'}
      {/if}
  </td>
 </tr>
{else}
 <tr valign="top">
  <th rowspan="2">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-258' replace='true'}</th>
  <td>
      {if $item.option_string_type == 0}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-259' replace='true'}
      {elseif $item.option_string_type == 1}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-260' replace='true'}
      {else}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-261' replace='true'}
      {/if}
  </td>
 </tr>
 <tr valign="top">
  <td>{grn_format body=$item.option_string}&nbsp;</td>
 </tr>
{/if}
</table>
{include file="grn/item/detail_footer.tpl" config_id=$config_id}
