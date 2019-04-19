<table class="std_form" width="100%">
 <colgroup>
  <col width="15%">
  <col width="85%">
 </colgroup>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-9' replace='true'}
  </th>
  <td>
      {if ! $current}{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-10' replace='true'}{/if}
{include file='cabinet/_folder_select.tpl' no_submit_form=1}
  </td>
 </tr>
<form name="settings" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <tr>
  <th nowrap>
      {cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-11' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-12' replace='true'}
  </th>
  <td>
{grn_image image='check20.gif'}{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-13' replace='true'}<input type="hidden" name="show_title" value="1">
{**{grn_checkbox name='show_title'    id='show_title'    value=1 caption="タイトル"   checked=$portlet.settings.show_columns.title}**}
{capture name='grn_cabinet_portlet_GRN_CAB_PO_14'}{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-14' replace='true'}{/capture}{grn_checkbox name='show_filename' id='show_filename' value=1 caption=$smarty.capture.grn_cabinet_portlet_GRN_CAB_PO_14 checked=$portlet.settings.show_columns.filename}
{capture name='grn_cabinet_portlet_GRN_CAB_PO_15'}{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-15' replace='true'}{/capture}{grn_checkbox name='show_modifier' id='show_modifier' value=1 caption=$smarty.capture.grn_cabinet_portlet_GRN_CAB_PO_15     checked=$portlet.settings.show_columns.modifier}
{capture name='grn_cabinet_portlet_GRN_CAB_PO_16'}{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-16' replace='true'}{/capture}{grn_checkbox name='show_mtime'    id='show_mtime'    value=1 caption=$smarty.capture.grn_cabinet_portlet_GRN_CAB_PO_16   checked=$portlet.settings.show_columns.mtime}
{capture name='grn_cabinet_portlet_GRN_CAB_PO_17'}{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-17' replace='true'}{/capture}{grn_checkbox name='show_size'     id='show_size'     value=1 caption=$smarty.capture.grn_cabinet_portlet_GRN_CAB_PO_17     checked=$portlet.settings.show_columns.size}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-18' replace='true'}
  </th>
  <td>
  <select name="rows">
  {foreach from=$select_numbers item=num}
   {if $num == -1}
  <option value="{$num}"{if $portlet.settings.rows == $num} selected{/if}>{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-19' replace='true'}
   {else}
  <option value="{$num}"{if $portlet.settings.rows == $num} selected{/if}>{if $num < 10}&nbsp;{/if}{$num}
   {/if}
  {/foreach}
  </select>&nbsp;{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-20' replace='true'}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       <input class="margin" type="submit" name="apply" value="{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-21' replace='true'}">
       <input type="submit" name="cancel" value="{cb_msg module='grn.cabinet.portlet' key='GRN_CAB_PO-22' replace='true'}">
  </td>
 </tr>
<input type="hidden" name="pid"   value="{$portlet.pid}">
<input type="hidden" name="plid"  value="{$portlet.plid}">
<input type="hidden" name="ppid"  value="{$portlet.ppid}">
<input type="hidden" name="hid"   value="{$portlet.settings.hid}">
<input type="hidden" name="s_hid" value="{$set_folder_id}">
<input type="hidden" name="display" value="{$display}">
</table>

</form>
