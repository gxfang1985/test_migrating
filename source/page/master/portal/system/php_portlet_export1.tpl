{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title|cat:' - Step 1/2' class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.portal.system' key='GRN_POT_SY-109' replace='true'}</div>

<p>

<table class="std_form">
 <tr valign="top">
  <th nowrap>
  {cb_msg module='grn.portal.system' key='GRN_POT_SY-111' replace='true'}
  </th>
  <td>
   {capture name='grn_portal_system_GRN_POT_SY_112'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-112' replace='true'}{/capture}{validate form="$form_name" field="sITEM" criteria="notEmpty" message=$smarty.capture.grn_portal_system_GRN_POT_SY_112 append="validation_errors"}
   {include file='grn/item_add.tpl' initialize_item=$initialize_item multiple_str='multiple' item_groupSelect=true select_size=10}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
   {capture name='grn_portal_system_GRN_POT_SY_113'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-113' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_113 onclick="grn_onsubmit_common(this.form);"}
   {capture name='grn_portal_system_GRN_POT_SY_114'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-114' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_system_GRN_POT_SY_114 page='portal/system/portlet_export_index'}
  </td>
 </tr>
</table>

</form>

{include file="grn/system_footer.tpl"}
