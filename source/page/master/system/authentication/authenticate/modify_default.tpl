{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/authenticate/command_modify_default'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="amid" value="{$authenticate_method.amid}">
<input type="hidden" name="display" value="{$display}">

<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_99'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-99' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_99 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_100'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-100' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_100 append="validation_errors"}
       {grn_text name="display_name" class="display_name" necessary=true value=$authenticate_method.display_name size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_101'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-101' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_101}
  </th>
  <td>
      {grn_select name='rmid' options=$repository_method_options}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_102'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-102' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_102}
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_103'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-103' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_103 page='system/authentication/authenticate_method_view' amid=$authenticate_method.amid}
  </td>
 </tr>
</table>

</form>
