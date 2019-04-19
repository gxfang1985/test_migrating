{assign var='form_name' value='rss'}
<form name='{$form_name}' method='post' action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-10' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-11' replace='true'}
  </th>
  <td>
{if $has_channel}
       {grn_select name='channel' options=$channel_list selected=$channel onchange='document.getElementById("modify_submit").disabled=(this.selectedIndex==0) ? true : false;'}
{else}
       {cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-12' replace='true'}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-13' replace='true'}
  </th>
  <td>
       {capture name='grn_rss_portlet_GRN_RSS_PO_14'}{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-14' replace='true'}{/capture}{grn_checkbox name='blank' id='blank' value='1' checked=$blank  caption=$smarty.capture.grn_rss_portlet_GRN_RSS_PO_14}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-15' replace='true'}
  </th>
  <td>
      {grn_select_numbers select_name='rows' padding='&nbsp;' options=$rows_numbers selected=$rows}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_rss_portlet_GRN_RSS_PO_16'}{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-16' replace='true'}{/capture}{if $channel_list.$channel == 0}{assign var='disabled' value=true}{/if}{grn_button_submit id='modify_submit' class='margin' caption=$smarty.capture.grn_rss_portlet_GRN_RSS_PO_16 disabled=$disabled}
{if $display == 'set-system'}
       {capture name='grn_rss_portlet_GRN_RSS_PO_17'}{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-17' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_rss_portlet_GRN_RSS_PO_17 page='portal/system/view' pid=$portlet.pid}
{elseif $display == 'set-operation'}
       {capture name='grn_rss_portlet_GRN_RSS_PO_18'}{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-18' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_rss_portlet_GRN_RSS_PO_18 page='portal/operation/view' pid=$portlet.pid}
{else}
       {capture name='grn_rss_portlet_GRN_RSS_PO_19'}{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-19' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_rss_portlet_GRN_RSS_PO_19 page='portal/personal/view' pid=$portlet.pid}
{/if}
  </td>
 </tr>
</table>

<input type='hidden' name='pid' value='{$portlet.pid}'>
<input type='hidden' name='plid' value='{$portlet.plid}'>
<input type='hidden' name='ppid' value='{$portlet.ppid}'>
<input type='hidden' name='display' value='{$display}'>
</form>
