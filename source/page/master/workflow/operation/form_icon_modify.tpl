{if $form.icon_type == 0}
 {if $form.icon_id == 0}
  {assign var=form_icon_id_0 value=TRUE}
 {elseif $form.icon_id == 1}
  {assign var=form_icon_id_1 value=TRUE}
 {elseif $form.icon_id == 2}
  {assign var=form_icon_id_2 value=TRUE}
 {elseif $form.icon_id == 3}
  {assign var=form_icon_id_3 value=TRUE}
 {elseif $form.icon_id == 4}
  {assign var=form_icon_id_4 value=TRUE}
 {elseif $form.icon_id == 5}
  {assign var=form_icon_id_5 value=TRUE}
 {elseif $form.icon_id == 6}
  {assign var=form_icon_id_6 value=TRUE}
 {elseif $form.icon_id == 7}
  {assign var=form_icon_id_7 value=TRUE}
 {elseif $form.icon_id == 8}
  {assign var=form_icon_id_8 value=TRUE}
 {elseif $form.icon_id == 9}
  {assign var=form_icon_id_9 value=TRUE}
 {elseif $form.icon_id == 10}
  {assign var=form_icon_id_10 value=TRUE}
 {elseif $form.icon_id == 11}
  {assign var=form_icon_id_11 value=TRUE}
 {/if}
{else}
 {assign var='form_icon_url' value=TRUE}
{/if}
{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{assign var="form_name" value=$smarty.template|basename}
{grn_title title=$page_title class=$page_info.parts[0]}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>
{cb_msg module='grn.workflow.system' key='w_select_icon_for_app_form_y' replace='true'}

<p>
<table class="borderTable" width="80%">
 <colgroup>
  <col width="1%">
  <col width="10%">
  <col width="70%">
 </colgroup>
 <tr valign="center">
  <td nowrap align="center">{grn_radio name='icon_id' id='form_icon_id_0' value='0' caption='' checked=$form_icon_id_0}</td>
  <td nowrap align="center">{grn_workflow_form_icon_image icon_type='0' icon_id='0'}</td>
  <td nowrap align="left">{cb_msg module='grn.workflow.system' key='w_standard_y' replace='true'}</td>
 </tr>
 <tr valign="center">
  <td nowrap align="center">{grn_radio name='icon_id' id='form_icon_id_1' value='1' caption='' checked=$form_icon_id_1}</td>
  <td nowrap align="center">{grn_workflow_form_icon_image icon_type='0' icon_id='1'}</td>
  <td nowrap align="left">{cb_msg module='grn.workflow.system' key='w_cost' replace='true'}</td>
 </tr>
 <tr valign="center">
  <td nowrap align="center">{grn_radio name='icon_id' id='form_icon_id_2' value='2' caption='' checked=$form_icon_id_2}</td>
  <td nowrap align="center">{grn_workflow_form_icon_image icon_type='0' icon_id='2'}</td>
  <td nowrap align="left">{cb_msg module='grn.workflow.system' key='w_travel_expense_y' replace='true'}</td>
 </tr>
 <tr valign="center">
  <td nowrap align="center">{grn_radio name='icon_id' id='form_icon_id_3' value='3' caption='' checked=$form_icon_id_3}</td>
  <td nowrap align="center">{grn_workflow_form_icon_image icon_type='0' icon_id='3'}</td>
  <td nowrap align="left">{cb_msg module='grn.workflow.system' key='w_reservation_y' replace='true'}</td>
 </tr>
 <tr valign="center">
  <td nowrap align="center">{grn_radio name='icon_id' id='form_icon_id_4' value='4' caption='' checked=$form_icon_id_4}</td>
  <td nowrap align="center">{grn_workflow_form_icon_image icon_type='0' icon_id='4'}</td>
  <td nowrap align="left">{cb_msg module='grn.workflow.system' key='w_report_y' replace='true'}</td>
 </tr>
 <tr valign="center">
  <td nowrap align="center">{grn_radio name='icon_id' id='form_icon_id_5' value='5' caption='' checked=$form_icon_id_5}</td>
  <td nowrap align="center">{grn_workflow_form_icon_image icon_type='0' icon_id='5'}</td>
  <td nowrap align="left">{cb_msg module='grn.workflow.system' key='w_personel_y' replace='true'}</td>
 </tr>
 <tr valign="center">
  <td nowrap align="center">{grn_radio name='icon_id' id='form_icon_id_6' value='6' caption='' checked=$form_icon_id_6}</td>
  <td nowrap align="center">{grn_workflow_form_icon_image icon_type='0' icon_id='6'}</td>
  <td nowrap align="left">{cb_msg module='grn.workflow.system' key='w_receipt_y' replace='true'}</td>
 </tr>
 <tr valign="center">
  <td nowrap align="center">{grn_radio name='icon_id' id='form_icon_id_7' value='7' caption='' checked=$form_icon_id_7}</td>
  <td nowrap align="center">{grn_workflow_form_icon_image icon_type='0' icon_id='7'}</td>
  <td nowrap align="left">{cb_msg module='grn.workflow.system' key='w_circular_board' replace='true'}</td>
 </tr>
 <tr valign="center">
  <td nowrap align="center">{grn_radio name='icon_id' id='form_icon_id_8' value='8' caption='' checked=$form_icon_id_8}</td>
  <td nowrap align="center">{grn_workflow_form_icon_image icon_type='0' icon_id='8'}</td>
  <td nowrap align="left">{cb_msg module='grn.workflow.system' key='w_attendance' replace='true'}</td>
 </tr>
 <tr valign="center">
  <td nowrap align="center">{grn_radio name='icon_id' id='form_icon_id_9' value='9' caption='' checked=$form_icon_id_9}</td>
  <td nowrap align="center">{grn_workflow_form_icon_image icon_type='0' icon_id='9'}</td>
  <td nowrap align="left">{cb_msg module='grn.workflow.system' key='w_important_y' replace='true'}</td>
 </tr>
 <tr valign="center">
  <td nowrap align="center">{grn_radio name='icon_id' id='form_icon_id_10' value='10' caption='' checked=$form_icon_id_10}</td>
  <td nowrap align="center">{grn_workflow_form_icon_image icon_type='0' icon_id='10'}</td>
  <td nowrap align="left">{cb_msg module='grn.workflow.system' key='w_related_IT' replace='true'}</td>
 </tr>
 <tr valign="center">
  <td nowrap align="center">{grn_radio name='icon_id' id='form_icon_id_11' value='11' caption='' checked=$form_icon_id_11}</td>
  <td nowrap align="center">{grn_workflow_form_icon_image icon_type='0' icon_id='11'}</td>
  <td nowrap align="left">{cb_msg module='grn.workflow.system' key='w_other' replace='true'}</td>
 </tr>
 <tr valign="center">
  <td nowrap align="center">{grn_radio name='icon_id' id='form_icon_url' value='url' caption='' checked=$form_icon_url}</td>
  <td nowrap align="center">{cb_msg module='grn.workflow.system' key='W_URL' replace='true'}</td>
  <td nowrap align="left">
      {grn_text name="icon_url" size="100" value=$form.icon_url maxlength="255"}
  </td>
 </tr>
</table>
<p>
 {capture name='grn_workflow_system_w_do_set_y'}{cb_msg module='grn.workflow.lang' key='form_icon_modify_w_do_set_y' replace='true'}{/capture}{grn_button_submit class="line" caption=$smarty.capture.grn_workflow_system_w_do_set_y}
 {grn_button_cancel class="line"}
</p>
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
</form>
{include file="grn/footer.tpl"}
