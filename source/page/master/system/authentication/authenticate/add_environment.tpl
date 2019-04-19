{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/authenticate/command_add_environment'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="amid" value="{$authenticate_method.amid}">
<input type="hidden" name="display" value="{$display}">

<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_32'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-32' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_32 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_33'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-33' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_33 append="validation_errors"}
       {grn_text name="display_name" class="display_name" necessary=true value="$display_name" size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_34'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-34' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_34 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_35'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-35' replace='true'}{/capture}{validate form=$form_name field="variable_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_35 append="validation_errors"}
       {grn_text name="variable_name" class="variable_name" necessary=true value="$variable_name" size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_36'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-36' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_36}
  </th>
  <td>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-37' replace='true'}<input type="hidden" name="credential_format" value="account">
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_38'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-38' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_38}
  </th>
  <td>
      {grn_text name="credential_prefix" class="credential_prefix" value="$credential_prefix" size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_39'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-39' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_39}
  </th>
  <td>
      {grn_text name="credential_suffix" class="credential_suffix" value="$credential_suffix" size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_40'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-40' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_40}
  </th>
  <td>
      {grn_select name='rmid' options=$repository_method_options}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_41'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-41' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_41 page='system/authentication/authenticate_method_add1' sf=1}
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_42'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-42' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_42}
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_43'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-43' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_43 page='system/authentication/authenticate_method_list' sf=1}
  </td>
 </tr>
</table>

</form>
