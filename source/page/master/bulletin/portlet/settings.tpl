<table class="std_form" width="100%">
 <colgroup>
  <col width="15%">
  <col width="85%">
 </colgroup>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-9' replace='true'}
  </th>
  <td>
      {if ! $current}{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-10' replace='true'}{/if}
{include file="bulletin/_category_select.tpl" no_submit_form=1}
  </td>
 </tr>
<form name="settings" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="pid"   value="{$portlet.pid}">
<input type="hidden" name="plid"  value="{$portlet.plid}">
<input type="hidden" name="ppid"  value="{$portlet.ppid}">
<input type="hidden" name="cid"   value="{$portlet.settings.cid}">
<input type="hidden" name="s_cid" value="{$set_category_id}">
<input type="hidden" name="display" value="{$display}">
 <tr>
  <th nowrap>
      {cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-11' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-12' replace='true'}
  </th>
  <td>
  <a name="#">{grn_image image='check20.gif'}{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-13' replace='true'}</a><input type="hidden" name="hide_title" value="0">
{if $portlet.settings.hide_columns.abstract}
{capture name='grn_bulletin_portlet_GRN_BLLT_PTLT_14'}{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-14' replace='true'}{/capture}{grn_checkbox name='show_abstract' id='show_abstract' value=1 caption=$smarty.capture.grn_bulletin_portlet_GRN_BLLT_PTLT_14     checked=0}
{else}
{capture name='grn_bulletin_portlet_GRN_BLLT_PTLT_15'}{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-15' replace='true'}{/capture}{grn_checkbox name='show_abstract' id='show_abstract' value=1 caption=$smarty.capture.grn_bulletin_portlet_GRN_BLLT_PTLT_15     checked=1}
{/if}
{if $portlet.settings.hide_columns.creator}
{capture name='grn_bulletin_portlet_GRN_BLLT_PTLT_16'}{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-16' replace='true'}{/capture}{grn_checkbox name='show_creator'  id='show_creator'  value=1 caption=$smarty.capture.grn_bulletin_portlet_GRN_BLLT_PTLT_16   checked=0}
{else}
{capture name='grn_bulletin_portlet_GRN_BLLT_PTLT_17'}{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-17' replace='true'}{/capture}{grn_checkbox name='show_creator'  id='show_creator'  value=1 caption=$smarty.capture.grn_bulletin_portlet_GRN_BLLT_PTLT_17   checked=1}
{/if}
{if $portlet.settings.hide_columns.mtime}
{capture name='grn_bulletin_portlet_GRN_BLLT_PTLT_18'}{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-18' replace='true'}{/capture}{grn_checkbox name='show_mtime'    id='show_mtime'    value=1 caption=$smarty.capture.grn_bulletin_portlet_GRN_BLLT_PTLT_18 checked=0}
{else}
{capture name='grn_bulletin_portlet_GRN_BLLT_PTLT_19'}{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-19' replace='true'}{/capture}{grn_checkbox name='show_mtime'    id='show_mtime'    value=1 caption=$smarty.capture.grn_bulletin_portlet_GRN_BLLT_PTLT_19 checked=1}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-20' replace='true'}
  </th>
  <td>
  <select name="rows">
  {foreach from=$select_numbers item=num}
   {if $num == -1}
  <option value="{$num}"{if $portlet.settings.rows == $num} selected{/if}>{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-21' replace='true'}
   {else}
  <option value="{$num}"{if $portlet.settings.rows == $num} selected{/if}>{if $num < 10}&nbsp;{/if}{$num}
   {/if}
  {/foreach}
  </select>&nbsp;{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-22' replace='true'}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       <input class="margin" type="submit" name="apply" value="{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-23' replace='true'}">
       <input type="submit" name="cancel" value="{cb_msg module='grn.bulletin.portlet' key='GRN_BLLT_PTLT-24' replace='true'}">
  </td>
 </tr>
</table>

</form>
