{assign var='form_name' value='message'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.message.portlet' key='GRN_MSG_PO-44' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.message.portlet' key='GRN_MSG_PO-45' replace='true'}
  </th>
  <td>
       {grn_image image='check16.gif'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-46' replace='true'}
       {capture name='grn_message_portlet_GRN_MSG_PO_47'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-47' replace='true'}{/capture}{grn_checkbox name="sender" id="sender" value="1" checked=$sender caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_47}
       {capture name='grn_message_portlet_GRN_MSG_PO_48'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-48' replace='true'}{/capture}{grn_checkbox name="time"   id="time"   value="1" checked=$time   caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_48}
       {capture name='grn_message_portlet_GRN_MSG_PO_49'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-49' replace='true'}{/capture}{grn_checkbox name="folder" id="folder" value="1" checked=$folder caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_49}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.message.portlet' key='GRN_MSG_PO-50' replace='true'}
  </th>
  <td>
       {grn_select_numbers select_name=$select1.name options=$select1.options selected=$settings.rows padding=$select1.padding}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_message_portlet_GRN_MSG_PO_51'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-51' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_51}
{if $display == 'set-system'}
       {capture name='grn_message_portlet_GRN_MSG_PO_52'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-52' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_52 page='portal/system/view' pid=$portlet.pid}
{elseif $display == 'set-operation'}
       {capture name='grn_message_portlet_GRN_MSG_PO_53'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-53' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_53 page='portal/operation/view' pid=$portlet.pid}
{else}
       {capture name='grn_message_portlet_GRN_MSG_PO_54'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-54' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_54 page='portal/personal/view' pid=$portlet.pid}
{/if}
  </td>
 </tr>
</table>

<input type="hidden" name="pid" value="{$portlet.pid}">
<input type="hidden" name="plid" value="{$portlet.plid}">
<input type="hidden" name="ppid" value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">
</form>
