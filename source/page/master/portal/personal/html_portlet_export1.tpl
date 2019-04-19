{include file="grn/personal_head.tpl"}
{include file="grn/personal_header.tpl"}
{grn_title title=$page_title|cat:' - Step 1/2' class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.portal.personal' key='GRN_POT_PE-113' replace='true'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-114' replace='true'}</div>

<p>

<table class="std_form">
 <tr valign="top">
  <th nowrap>
  {cb_msg module='grn.portal.personal' key='GRN_POT_PE-115' replace='true'}
  </th>
  <td>
   {capture name='grn_portal_personal_GRN_POT_PE_116'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-116' replace='true'}{/capture}{validate form="$form_name" field="sITEM" criteria="notEmpty" message=$smarty.capture.grn_portal_personal_GRN_POT_PE_116 append="validation_errors"}
   {include file='grn/item_add.tpl' initialize_item=$initialize_item multiple_str='multiple' item_groupSelect=true select_size=10}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
   {capture name='grn_portal_personal_GRN_POT_PE_117'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-117' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_117 onclick="grn_onsubmit_common(this.form);"}
   {capture name='grn_portal_personal_GRN_POT_PE_118'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-118' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_118 page='personal/application_list' app_id='portal'}
  </td>
 </tr>
</table>

</form>

{include file="grn/personal_footer.tpl"}
