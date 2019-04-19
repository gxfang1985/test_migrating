{assign var='form_name' value='data_list'}
{grn_load_javascript file="grn/html/wm.js"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-36' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-37' replace='true'}
  </th>
  <td>
{if $display eq 'set-system' || $display eq 'set-operation'}
{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-38' replace='true'}
  {grn_mail_select_folders select_name="dcid" selected_folder_id=$folder hide_root_folder=1 hide_garbage_folder=1 hide_normal_folder=1}
  {*include file='mail/_change_folder.tpl' checkon=0 hide_root_folder=1 hide_garbage_folder=1 hide_normal_folder=1 a_name='daccount' c_name='dcid'*}
  {*grn_mail_select_folders select_name="folder" account_id=$account selected_folder_id=$folder hide_root_folder=1 hide_garbage_folder=1*}
{else}
 {if ! $account}
{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-39' replace='true'}
 {else}
  {include file='mail/_change_folder.tpl' checkon=0 hide_root_folder=1 hide_garbage_folder=1 a_name='daccount' c_name='dcid'}
  {*grn_mail_select_folders select_name="folder" account_id=$account selected_folder_id=$folder hide_root_folder=1 hide_garbage_folder=1 hide_normal_folder=1*}
 {/if}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-40' replace='true'}
  </th>
  <td>
       {grn_image image='check16.gif'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-41' replace='true'}
       {capture name='grn_mail_portlet_GRN_MAIL_PO_42'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-42' replace='true'}{/capture}{grn_checkbox name="status"  id="status"  value="1" checked=$status  caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_42}
       {capture name='grn_mail_portlet_GRN_MAIL_PO_43'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-43' replace='true'}{/capture}{grn_checkbox name="sender"  id="sender"  value="1" checked=$sender  caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_43}
       {capture name='grn_mail_portlet_GRN_MAIL_PO_44'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-44' replace='true'}{/capture}{grn_checkbox name="time"    id="time"    value="1" checked=$time    caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_44}
       {capture name='grn_mail_portlet_GRN_MAIL_PO_45'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-45' replace='true'}{/capture}{grn_checkbox name="remarks" id="remarks" value="1" checked=$remarks caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_45}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-46' replace='true'}
  </th>
  <td>
       {capture name='grn_mail_portlet_GRN_MAIL_PO_47'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-47' replace='true'}{/capture}{grn_radio name="order" id="order_sent" value="sent"  caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_47 checked=$order.sent}
       {capture name='grn_mail_portlet_GRN_MAIL_PO_48'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-48' replace='true'}{/capture}{grn_radio name="order" id="order_recept" value="recept" caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_48 checked=$order.recept}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-49' replace='true'}
  </th>
  <td>
      {grn_select_numbers select_name=$select1.name options=$select1.options selected=$settings.rows padding=$select1.padding}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_mail_portlet_GRN_MAIL_PO_50'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-50' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_50}
{if $display == 'set-system'}
       {capture name='grn_mail_portlet_GRN_MAIL_PO_51'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-51' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_51 page='portal/system/view' pid=$portlet.pid}
{elseif $display == 'set-operation'}
       {capture name='grn_mail_portlet_GRN_MAIL_PO_52'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-52' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_52 page='portal/operation/view' pid=$portlet.pid}
{else}
       {capture name='grn_mail_portlet_GRN_MAIL_PO_53'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-53' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_53 page='portal/personal/view' pid=$portlet.pid}
{/if}
  </td>
 </tr>
</table>

<input type="hidden" name="pid" value="{$portlet.pid}">
<input type="hidden" name="plid" value="{$portlet.plid}">
<input type="hidden" name="ppid" value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">
</form>
