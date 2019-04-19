{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.portal.system' key='GRN_POT_SY-308' replace='true'}</div>

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_portal_system_GRN_POT_SY_309'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-309' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_system_GRN_POT_SY_309 necessary=false}
  </th>
  <td>
      {capture name='grn_portal_system_GRN_POT_SY_310'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-310' replace='true'}{/capture}
      {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_portal_system_GRN_POT_SY_310 values=$multiLanguageInfoArray.values}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_portal_system_GRN_POT_SY_311'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-311' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_311}
       {grn_button_cancel page='portal/system/portlet_group_view' plgid=$portlet_group.plgid}
  </td>
 </tr>
</table>

<input type="hidden" name="plgid" value="{$portlet_group.plgid}">
</form>
{include file='grn/system_footer.tpl'}
