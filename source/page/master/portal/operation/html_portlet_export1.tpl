{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title|cat:' - Step 1/2' class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.portal.operation' key='GRN_POT_OP-156' replace='true'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-157' replace='true'}</div>

<p>

<table class="std_form">
 <tr valign="top">
  <th nowrap>
  {cb_msg module='grn.portal.operation' key='GRN_POT_OP-158' replace='true'}
  </th>
  <td>
   {capture name='grn_portal_operation_GRN_POT_OP_159'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-159' replace='true'}{/capture}{validate form="$form_name" field="sITEM" criteria="notEmpty" message=$smarty.capture.grn_portal_operation_GRN_POT_OP_159 append="validation_errors"}
   {include file='grn/item_add.tpl' initialize_item=$initialize_item multiple_str='multiple' item_groupSelect=true select_size=10}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
   {capture name='grn_portal_operation_GRN_POT_OP_160'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-160' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_160 onclick="grn_onsubmit_common(this.form);"}
   {capture name='grn_portal_operation_GRN_POT_OP_161'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-161' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_161 page='portal/operation/html_portlet_list' sf=1}
  </td>
 </tr>
</table>

</form>

{include file="grn/footer.tpl"}
