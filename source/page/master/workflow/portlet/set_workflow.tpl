{assign var='form_name' value='data_list'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form" width="100%">
 <colgroup>
  <col width="15%">
  <col width="85%">
 </colgroup>

 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_1' replace='true'}
  </th>
  <td>
   <select name="folder_type" id="folder_list">
{foreach name=folder_list from=$folder_list item=folder}
    <option value="{$folder.type}" {if $folder.selected}selected{/if}>{$folder.name}</option>
{/foreach}
   </select>
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_2' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_3' replace='true'}
  </th>
  <td>
       {capture name='grn_workflow_portlet_GRN_WKF_PO_4'}{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_4' replace='true'}{/capture}{grn_checkbox name="number"     id="number"     value="1" checked=$number     caption=$smarty.capture.grn_workflow_portlet_GRN_WKF_PO_4}
       {capture name='grn_workflow_portlet_GRN_WKF_PO_5'}{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_5' replace='true'}{/capture}{grn_checkbox name="priority"   id="priority"   value="1" checked=$priority   caption=$smarty.capture.grn_workflow_portlet_GRN_WKF_PO_5}
       {grn_image image='check16.gif'}{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_6' replace='true'}{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_7' replace='true'}
       {capture name='grn_workflow_portlet_GRN_WKF_PO_8'}{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_8' replace='true'}{/capture}{grn_checkbox name="status"     id="status"     value="1" checked=$status     caption=$smarty.capture.grn_workflow_portlet_GRN_WKF_PO_8}
       {capture name='grn_workflow_portlet_GRN_WKF_PO_9'}{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_9' replace='true'}{/capture}{grn_checkbox name="transactor" id="transactor" value="1" checked=$transactor caption=$smarty.capture.grn_workflow_portlet_GRN_WKF_PO_9}
       {capture name='grn_workflow_portlet_GRN_WKF_PO_10'}{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_10' replace='true'}{/capture}{grn_checkbox name="time"       id="time"       value="1" checked=$time       caption=$smarty.capture.grn_workflow_portlet_GRN_WKF_PO_10}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_11' replace='true'}
  </th>
  <td>
      {grn_select_numbers select_name=$select1.name options=$select1.options selected=$settings.rows padding=$select1.padding}
  </td>
 </tr>
 <tr>
  <td><br></td>
  <td></td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_workflow_portlet_GRN_WKF_PO_12'}{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_12' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_portlet_GRN_WKF_PO_12}
{if $display == 'set-system'}
       {capture name='grn_workflow_portlet_GRN_WKF_PO_13'}{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_13' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_workflow_portlet_GRN_WKF_PO_13 page='portal/system/view' pid=$portlet.pid}
{elseif $display == 'set-operation'}
       {capture name='grn_workflow_portlet_GRN_WKF_PO_14'}{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_14' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_workflow_portlet_GRN_WKF_PO_14 page='portal/operation/view' pid=$portlet.pid}
{else}
       {capture name='grn_workflow_portlet_GRN_WKF_PO_15'}{cb_msg module='grn.workflow.portlet' key='GRN_WKF_PO_15' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_workflow_portlet_GRN_WKF_PO_15 page='portal/personal/view' pid=$portlet.pid}
{/if}
  </td>
 </tr>
</table>

<input type="hidden" name="pid" value="{$portlet.pid}">
<input type="hidden" name="plid" value="{$portlet.plid}">
<input type="hidden" name="ppid" value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">
</form>
