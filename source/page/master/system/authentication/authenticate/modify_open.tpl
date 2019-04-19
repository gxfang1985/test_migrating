{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/authenticate/command_modify_open'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="amid" value="{$authenticate_method.amid}">
<input type="hidden" name="display" value="{$display}">

<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_19'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-19' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_19 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_20'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-20' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_20 append="validation_errors"}
       {grn_text name="display_name" class="display_name" necessary=true value=$authenticate_method.display_name size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_21'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-21' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_21 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_22'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-22' replace='true'}{/capture}{validate form=$form_name field="password" criteria="grn_isValidPassword" field2="retype" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_22 append="validation_errors"}
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_23'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-23' replace='true'}{/capture}{validate form=$form_name field="password" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_23 append="validation_errors"}
       {grn_password name="password" purpose="modify" class="password" size="50"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_24'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-24' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_24 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_25'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-25' replace='true'}{/capture}{validate form=$form_name field="retype" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_25 append="validation_errors"}
       {grn_password name="retype" purpose="retype" class="retype" size="50"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_26'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-26' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_26}
  </th>
  <td>
      {grn_select name="expire_time" options=$expire_time_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_27'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-27' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_27}
  </th>
  <td>
      {grn_text name="cookie_domain" value=$authenticate_method.driver_settings.cookie_domain size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_28'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-28' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_28}
  </th>
  <td>
      {grn_text name="cookie_path" value=$authenticate_method.driver_settings.cookie_path size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_29'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-29' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_29}
  </th>
  <td>
      {grn_select name='rmid' options=$repository_method_options}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_30'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-30' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_30}
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_31'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-31' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_31 page='system/authentication/authenticate_method_view' amid=$authenticate_method.amid}
  </td>
 </tr>
</table>

</form>
