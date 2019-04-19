{assign var='form_name' value='message'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.message.portlet' key='GRN_MSG_PO-20' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.message.portlet' key='GRN_MSG_PO-21' replace='true'}
  </th>
  <td>
       {grn_image image='check16.gif'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-22' replace='true'}
       {grn_image image='check16.gif'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-23' replace='true'}
       {capture name='grn_message_portlet_GRN_MSG_PO_24'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-24' replace='true'}{/capture}{grn_checkbox name="time"   id="time"   value="1" checked=$time   caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_24}
       {capture name='grn_message_portlet_GRN_MSG_PO_25'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-25' replace='true'}{/capture}{grn_checkbox name="folder" id="folder" value="1" checked=$folder caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_25}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_message_portlet_GRN_MSG_PO_26'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-26' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_26}
{if $display == 'set-system'}
       {capture name='grn_message_portlet_GRN_MSG_PO_27'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-27' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_27 page='portal/system/view' pid=$portlet.pid}
{elseif $display == 'set-operation'}
       {capture name='grn_message_portlet_GRN_MSG_PO_28'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-28' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_28 page='portal/operation/view' pid=$portlet.pid}
{else}
       {capture name='grn_message_portlet_GRN_MSG_PO_29'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-29' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_29 page='portal/personal/view' pid=$portlet.pid}
{/if}
  </td>
 </tr>
</table>

<input type="hidden" name="pid" value="{$portlet.pid}">
<input type="hidden" name="plid" value="{$portlet.plid}">
<input type="hidden" name="ppid" value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">
</form>
