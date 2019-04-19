{assign var='form_name' value='message'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.message.portlet' key='GRN_MSG_PO-1' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.message.portlet' key='GRN_MSG_PO-2' replace='true'}
  </th>
  <td>
{if $display eq 'set-system'}
       {grn_message_select_folders select_name="folder" selected_folder_id=$folder hide_folders=81} {* 81 = (0x01 << GRN_MESSAGE_ROOTFOLDER)|(0x01 << GRN_MESSAGE_GARBAGEFOLDER)|(0x01 << GRN_MESSAGE_GENERALFOLDER) *}
{elseif $display eq 'set-operation'}
       {grn_message_select_folders select_name="folder" selected_folder_id=$folder hide_folders=81}
{else}
       {grn_message_select_folders select_name="folder" selected_folder_id=$folder hide_folders=80} {* 80 = (0x01 << GRN_MESSAGE_ROOTFOLDER)|(0x01 << GRN_MESSAGE_GARBAGEFOLDER) *}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.message.portlet' key='GRN_MSG_PO-3' replace='true'}
  </th>
  <td>
       {grn_image image='check16.gif'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-4' replace='true'}
       {capture name='grn_message_portlet_GRN_MSG_PO_5'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-5' replace='true'}{/capture}{grn_checkbox name="sender"  id="sender"  value="1" checked=$sender  caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_5}
       {capture name='grn_message_portlet_GRN_MSG_PO_6'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-6' replace='true'}{/capture}{grn_checkbox name="time"    id="time"    value="1" checked=$time    caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_6}
       {capture name='grn_message_portlet_GRN_MSG_PO_7'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-7' replace='true'}{/capture}{grn_checkbox name="remarks" id="remarks" value="1" checked=$remarks caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_7}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.message.portlet' key='GRN_MSG_PO-8' replace='true'}
  </th>
  <td>
       {capture name='grn_message_portlet_GRN_MSG_PO_9'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-9' replace='true'}{/capture}{grn_radio name="order" id="element" value="element"  caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_9 checked=$order.element}
       {capture name='grn_message_portlet_GRN_MSG_PO_10'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-10' replace='true'}{/capture}{grn_radio name="order" id="whatsnew" value="whatsnew" caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_10 checked=$order.whatsnew}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.message.portlet' key='GRN_MSG_PO-11' replace='true'}
  </th>
  <td>
      {grn_select_numbers select_name=$select1.name options=$select1.options selected=$settings.rows padding=$select1.padding}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_message_portlet_GRN_MSG_PO_12'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-12' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_12}
{if $display == 'set-system'}
       {capture name='grn_message_portlet_GRN_MSG_PO_13'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-13' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_13 page='portal/system/view' pid=$portlet.pid}
{elseif $display == 'set-operation'}
       {capture name='grn_message_portlet_GRN_MSG_PO_14'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-14' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_14 page='portal/operation/view' pid=$portlet.pid}
{else}
       {capture name='grn_message_portlet_GRN_MSG_PO_15'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-15' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_15 page='portal/personal/view' pid=$portlet.pid}
{/if}
  </td>
 </tr>
</table>

<input type="hidden" name="pid" value="{$portlet.pid}">
<input type="hidden" name="plid" value="{$portlet.plid}">
<input type="hidden" name="ppid" value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">
</form>
