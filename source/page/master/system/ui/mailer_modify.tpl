{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/ui/command_mailer_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="id" value="{$id}" />
<p>{cb_msg module='grn.system.ui' key='GRN_SY_UI-207' replace='true'}</p>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}</p>
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_system_ui_GRN_SY_UI_208'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-208' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_ui_GRN_SY_UI_208 necessary=1}</th>
  <td>{capture name='grn_system_ui_GRN_SY_UI_209'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-209' replace='true'}{/capture}{validate form=$form_name field="name" criteria="notEmpty" message=$smarty.capture.grn_system_ui_GRN_SY_UI_209 transform="cb_trim" append="validation_errors"}{grn_text name="name" size="70" value=$name}</td>
 </tr>
 <tr>
  <th nowrap>{grn_show_input_title title="URL" necessary=1}</th>
  <td>{capture name='grn_system_ui_GRN_SY_UI_210'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-210' replace='true'}{/capture}{validate form=$form_name field="url" criteria="notEmpty" message=$smarty.capture.grn_system_ui_GRN_SY_UI_210 transform="cb_trim" append="validation_errors"}{grn_text name="url" size="70" maxlength="1024" value=$url}
  <div class="br"></div>
  {cb_msg module='grn.system.ui' key='GRN_SY_UI-225' replace='true'}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_ui_GRN_SY_UI_212'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-212_1' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_ui_GRN_SY_UI_212}
       {grn_button_cancel page='system/ui/mailer_view' id=$id}
  </td>
 </tr>
</table>

</form>
{include file="grn/system_footer.tpl"}