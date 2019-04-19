{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.portal.personal' key='GRN_POT_PE-131' replace='true'}</div>

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_portal_personal_GRN_POT_PE_132'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-132' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_personal_GRN_POT_PE_132 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_portal_personal_GRN_POT_PE_133'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-133' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_portal_personal_GRN_POT_PE_133 append="validation_errors"}{grn_text necessary=true name="title" value=$title size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_portal_personal_GRN_POT_PE_134'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-134' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_134}
       {grn_button_cancel page='portal/personal/portlet_group_list'}
  </td>
 </tr>
</table>

<input type="hidden" name="plgid" value="{$portlet_group.plgid}">
</form>

{include file='grn/personal_footer.tpl'}
