{assign var='form_name' value='rss'}
<form name='{$form_name}' method='post' action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-20' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
{if ! $use_shared}
 <tr>
  <th nowrap>
      {cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-21' replace='true'}
  </th>
  <td>
       {capture name='grn_rss_portlet_GRN_RSS_PO_22'}{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-22' replace='true'}{/capture}{grn_checkbox name='shared' id='shared' value='1' checked=$shared  caption=$smarty.capture.grn_rss_portlet_GRN_RSS_PO_22}
  </td>
 </tr>
{/if}
 <tr>
  <td></td>
  <td>
       {capture name='grn_rss_portlet_GRN_RSS_PO_23'}{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-23' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_rss_portlet_GRN_RSS_PO_23}
{if $display == 'set-system'}
       {capture name='grn_rss_portlet_GRN_RSS_PO_24'}{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-24' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_rss_portlet_GRN_RSS_PO_24 page='portal/system/view' pid=$portlet.pid}
{elseif $display == 'set-operation'}
       {capture name='grn_rss_portlet_GRN_RSS_PO_25'}{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-25' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_rss_portlet_GRN_RSS_PO_25 page='portal/operation/view' pid=$portlet.pid}
{else}
       {capture name='grn_rss_portlet_GRN_RSS_PO_26'}{cb_msg module='grn.rss.portlet' key='GRN_RSS_PO-26' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_rss_portlet_GRN_RSS_PO_26 page='portal/personal/view' pid=$portlet.pid}
{/if}
  </td>
 </tr>
</table>

<input type='hidden' name='pid' value='{$portlet.pid}'>
<input type='hidden' name='plid' value='{$portlet.plid}'>
<input type='hidden' name='ppid' value='{$portlet.ppid}'>
<input type='hidden' name='display' value='{$display}'>
</form>
