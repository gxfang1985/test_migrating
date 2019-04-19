{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/login/command_add_environment'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="lmid" value="{$login_method.lmid}">
<input type="hidden" name="display" value="{$display}">

<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_login_GRN_SY_AU_LO_19'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-19' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_19 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_login_GRN_SY_AU_LO_20'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-20' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_20 append="validation_errors"}
       {grn_text name="display_name" class="display_name" necessary=true value="$display_name" size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_login_GRN_SY_AU_LO_21'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-21' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_21 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_login_GRN_SY_AU_LO_22'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-22' replace='true'}{/capture}{validate form=$form_name field="variable_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_22 append="validation_errors"}
       {grn_text name="variable_name" class="variable_name" necessary=true value="$variable_name" size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_login_GRN_SY_AU_LO_23'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-23' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_23}
  </th>
  <td>
      {cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-24' replace='true'}<input type="hidden" name="credential_format" value="account">
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_login_GRN_SY_AU_LO_25'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-25' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_25}
  </th>
  <td>
      {grn_text name="credential_prefix" class="credential_prefix" value="$credential_prefix" size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_login_GRN_SY_AU_LO_26'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-26' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_26}
  </th>
  <td>
      {grn_text name="credential_suffix" class="credential_suffix" value="$credential_suffix" size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_login_GRN_SY_AU_LO_27'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-27' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_27}
  </th>
  <td>
      {grn_select name='rmid' options=$repository_method_options}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_authentication_login_GRN_SY_AU_LO_28'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-28' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_28 page='system/authentication/login_method_add1' sf=1}
       {capture name='grn_system_authentication_login_GRN_SY_AU_LO_29'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-29' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_29}
       {capture name='grn_system_authentication_login_GRN_SY_AU_LO_30'}{cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-30' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_authentication_login_GRN_SY_AU_LO_30 page='system/authentication/login_method_list' sf=1}
  </td>
 </tr>
</table>

</form>
