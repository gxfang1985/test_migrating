{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/authenticate/command_modify_environment'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="amid" value="{$authenticate_method.amid}">
<input type="hidden" name="display" value="{$display}">

<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_8'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-8' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_8 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_9'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-9' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_9 append="validation_errors"}
       {grn_text name="display_name" class="display_name" necessary=true value=$authenticate_method.display_name size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_10'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-10' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_10 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_11'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-11' replace='true'}{/capture}{validate form=$form_name field="variable_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_11 append="validation_errors"}
       {grn_text name="variable_name" class="variable_name" necessary=true value=$authenticate_method.driver_settings.variable_name size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_12'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-12' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_12}
  </th>
  <td>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-13' replace='true'}<input type="hidden" name="credential_format" value="account">
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_14'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-14' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_14}
  </th>
  <td>
      {grn_text name="credential_prefix" value=$authenticate_method.driver_settings.credential_prefix size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_15'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-15' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_15}
  </th>
  <td>
      {grn_text name="credential_suffix" value=$authenticate_method.driver_settings.credential_suffix size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_16'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-16' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_16}
  </th>
  <td>
      {grn_select name='rmid' options=$repository_method_options}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_17'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-17' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_17}
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_18'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-18' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_18 page='system/authentication/authenticate_method_view' amid=$authenticate_method.amid}
  </td>
 </tr>
</table>

</form>
