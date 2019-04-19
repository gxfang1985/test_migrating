<table class="std_form">
 <colgroup>
  <col width="15%">
  <col width="85%">
 </colgroup>
<form name="settings" method="post" action="{grn_pageurl page=$page_info.all}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="pid"   value="{$portlet.pid}">
<input type="hidden" name="plid"  value="{$portlet.plid}">
<input type="hidden" name="ppid"  value="{$portlet.ppid}">
<input type="hidden" name="st" value="1">
 <tr>
  <th nowrap>
      {cb_msg module='grn.link.portlet' key='GRN_LNK_PO-8' replace='true'}
  </th>
  <td>
 {if $portlet.settings.type neq 'personal'}
  {capture name='grn_link_portlet_GRN_LNK_PO_9'}{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-9' replace='true'}{/capture}{grn_radio name='type' id='type1' value='share' caption=$smarty.capture.grn_link_portlet_GRN_LNK_PO_9 checked=1}&nbsp;&nbsp;
  {capture name='grn_link_portlet_GRN_LNK_PO_10'}{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-10' replace='true'}{/capture}{grn_radio name='type' id='type0' value='personal' caption=$smarty.capture.grn_link_portlet_GRN_LNK_PO_10 checked=0 onclick='this.form.submit();'}
 {else}
  {capture name='grn_link_portlet_GRN_LNK_PO_11'}{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-11' replace='true'}{/capture}{grn_radio name='type' id='type1' value='share' caption=$smarty.capture.grn_link_portlet_GRN_LNK_PO_11 checked=0  onclick='this.form.submit();'}&nbsp;&nbsp;
  {capture name='grn_link_portlet_GRN_LNK_PO_12'}{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-12' replace='true'}{/capture}{grn_radio name='type' id='type0' value='personal' caption=$smarty.capture.grn_link_portlet_GRN_LNK_PO_12 checked=1}
 {/if}
  </td>
 </tr>
</form>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.link.portlet' key='GRN_LNK_PO-13' replace='true'}
  </th>
  <td>
      {if ! $current}{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-14' replace='true'}{else}{$current.name|escape}{/if}
{if $portlet.settings.type eq 'personal' && $display neq 'set-personal'}
 {include file="link/portlet/_category_select.tpl" no_submit_form=1 no_search_form=1}
{else}
 {include file="link/portlet/_category_select.tpl" no_submit_form=1 no_search_form=0}
{/if}
  </td>
 </tr>
<form name="settings" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="pid"   value="{$portlet.pid}">
<input type="hidden" name="plid"  value="{$portlet.plid}">
<input type="hidden" name="ppid"  value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">
<input type="hidden" name="type"  value="{$portlet.settings.type}">
<input type="hidden" name="cid"   value="{$portlet.settings.cid}">
 <tr>
  <th nowrap>
      {cb_msg module='grn.link.portlet' key='GRN_LNK_PO-15' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.link.portlet' key='GRN_LNK_PO-16' replace='true'}
  </th>
  <td>
      {grn_select_numbers select_name='col_size' options=$column_options selected=$portlet.settings.col_size}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       <input type="submit" name="apply" value="{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-17' replace='true'}">
       <input type="submit" name="cancel" value="{cb_msg module='grn.link.portlet' key='GRN_LNK_PO-18' replace='true'}">
  </td>
 </tr>
</form>
</table>
