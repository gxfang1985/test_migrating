{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/login/command_modify_environment'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="lmid" value="{$login_method.lmid}">
<input type="hidden" name="display" value="{$display}">

<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_login_GRN_SY_AU_LO_8'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-8' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_8 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_login_GRN_SY_AU_LO_9'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-9' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_9 append="validation_errors"}
       {grn_text name="display_name" class="display_name" necessary=true value=$login_method.display_name size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_login_GRN_SY_AU_LO_10'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-10' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_10 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_login_GRN_SY_AU_LO_11'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-11' replace='true'}{/capture}{validate form=$form_name field="variable_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_11 append="validation_errors"}
       {grn_text name="variable_name" class="variable_name" necessary=true value=$login_method.driver_settings.variable_name size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_login_GRN_SY_AU_LO_12'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-12' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_12}
  </th>
  <td>
      {cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-13' replace='true'}<input type="hidden" name="credential_format" value="account">
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_login_GRN_SY_AU_LO_14'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-14' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_14}
  </th>
  <td>
      {grn_text name="credential_prefix" class="credential_suffix" value=$login_method.driver_settings.credential_prefix size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_login_GRN_SY_AU_LO_15'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-15' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_15}
  </th>
  <td>
      {grn_text name="credential_suffix" class="credential_suffix" value=$login_method.driver_settings.credential_suffix size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_login_GRN_SY_AU_LO_16'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-16' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_16}
  </th>
  <td>
      {grn_select name='rmid' options=$repository_method_options}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_authentication_login_GRN_SY_AU_LO_17'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-17' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_17}
       {capture name='grn_system_authentication_login_GRN_SY_AU_LO_18'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-18' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_18 page='system/authentication/login_method_view' lmid=$login_method.lmid}
  </td>
 </tr>
</table>

</form>
