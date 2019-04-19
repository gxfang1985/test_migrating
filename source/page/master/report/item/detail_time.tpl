{include file='grn/item/detail_header.tpl'}
<div id="main_menu_part">
{if $modify_page}
<span class="menu_item">{capture name='grn_report_item_GRN_RPRT_ITEM_194'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-194' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_194 page=$modify_page params=$menu_params image='modify20.gif' disabled=$disabled}</span>
{/if}
{if $delete_page}
<span class="menu_item">{capture name='grn_report_item_GRN_RPRT_ITEM_195'}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-195' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_item_GRN_RPRT_ITEM_195 page=$delete_page params=$menu_params image='delete20.gif' disabled=$disabled}</span>
{/if}
</div>

<p>
<table class="view_table">
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-196' replace='true'}</th>
  <td>{$item.display_name|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-197' replace='true'}</th>
  <td>{$item.display_type|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='time_unit' replace='true'}</th>
  <td>
    {if $item.settings.unit==1}{cb_msg module='grn.report.item' key='1_minute_unit' replace='true'}
    {elseif $item.settings.unit==5}{cb_msg module='grn.report.item' key='5_minute_unit' replace='true'}
    {elseif $item.settings.unit==10}{cb_msg module='grn.report.item' key='10_minute_unit' replace='true'}
    {elseif $item.settings.unit==15}{cb_msg module='grn.report.item' key='15_minute_unit' replace='true'}
    {elseif $item.settings.unit==30}{cb_msg module='grn.report.item' key='30_minute_unit' replace='true'}{/if}
  </td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-198' replace='true'}</th>
  <td>
      {if $item.settings.initial_type == 0}
        {cb_msg module='grn.report.item' key='leave_it_blank' replace='true'}
      {elseif $item.settings.initial_type == 2}
        {grn_date_format date=$item.settings.initial_time}
      {else}
        {cb_msg module='grn.report.item' key='default_current_time' replace='true'}
      {/if}
  </td>
 </tr>
{if $item.description_type == 1}
 <tr valign="top">
  <th rowspan="2">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-204' replace='true'}</th>
  <td>
    {include file="grn/item/description_editor.tpl"}
  </td>
 </tr>
 <tr valign="top">
  <td>
      {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-205' replace='true'}
  </td>
 </tr>
{else}
 <tr valign="top">
  <th rowspan="1">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-206' replace='true'}</th>
  <td>
    {include file="grn/item/description_editor.tpl"}
  </td>
 </tr>
{/if}
 <tr valign="top">
  <th>{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-207' replace='true'}</th>
  <td>{if $item.required == 1}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-208' replace='true'}{else}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-209' replace='true'}{/if}</td>
 </tr>
{if $item.option_string_type == 0}
 <tr valign="top">
  <th >{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-210' replace='true'}</th>
  <td>
      {if $item.option_string_type == 0}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-211' replace='true'}
      {elseif $item.option_string_type == 1}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-212' replace='true'}
      {else}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-213' replace='true'}
      {/if}
  </td>
 </tr>
{else}
 <tr valign="top">
  <th rowspan="2">{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-214' replace='true'}</th>
  <td>
      {if $item.option_string_type == 0}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-215' replace='true'}
      {elseif $item.option_string_type == 1}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-216' replace='true'}
      {else}
        {cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-217' replace='true'}
      {/if}
  </td>
 </tr>
 <tr valign="top">
  <td>{grn_format body=$item.option_string}&nbsp;</td>
 </tr>
{/if}
</table>
{include file="grn/item/detail_footer.tpl" config_id=$config_id}
