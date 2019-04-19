{assign var='form_name' value='star'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.star.portlet' key='GRN_STAR_PO-1' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.star.portlet' key='GRN_STAR_PO-12' replace='true'}
  </th>
  <td>
      {grn_select name='app' options=$apps}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.star.portlet' key='GRN_STAR_PO-2' replace='true'}
  </th>
  <td>
       {grn_image image='check16.gif'}{cb_msg module='grn.star.portlet' key='GRN_STAR_PO-3' replace='true'}
       {capture name='grn_star_portlet_GRN_STAR_PO_16'}{cb_msg module='grn.star.portlet' key='GRN_STAR_PO-16' replace='true'}{/capture}{grn_checkbox name="time" id="time" value="1" checked=$time caption=$smarty.capture.grn_star_portlet_GRN_STAR_PO_16}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.star.portlet' key='GRN_STAR_PO-17' replace='true'}
  </th>
  <td>
      {grn_select_numbers select_name=$select1.name options=$select1.options selected=$portlet.settings.rows padding=$select1.padding}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_star_portlet_GRN_STAR_PO_7'}{cb_msg module='grn.star.portlet' key='GRN_STAR_PO-7' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_star_portlet_GRN_STAR_PO_7}
{if $display == 'set-system'}
       {capture name='grn_star_portlet_GRN_STAR_PO_8'}{cb_msg module='grn.star.portlet' key='GRN_STAR_PO-8' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_star_portlet_GRN_STAR_PO_8 page='portal/system/view' pid=$portlet.pid}
{elseif $display == 'set-operation'}
       {capture name='grn_star_portlet_GRN_STAR_PO_8'}{cb_msg module='grn.star.portlet' key='GRN_STAR_PO-8' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_star_portlet_GRN_STAR_PO_8 page='portal/operation/view' pid=$portlet.pid}
{else}
       {capture name='grn_star_portlet_GRN_STAR_PO_8'}{cb_msg module='grn.star.portlet' key='GRN_STAR_PO-8' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_star_portlet_GRN_STAR_PO_8 page='portal/personal/view' pid=$portlet.pid}
{/if}
  </td>
 </tr>
</table>

<input type="hidden" name="pid" value="{$portlet.pid}">
<input type="hidden" name="plid" value="{$portlet.plid}">
<input type="hidden" name="ppid" value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">
</form>
