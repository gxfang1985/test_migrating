{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/authenticate/command_add_open'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="amid" value="{$authenticate_method.amid}">
<input type="hidden" name="display" value="{$display}">

<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_44'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-44' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_44 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_45'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-45' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_45 append="validation_errors"}
       {grn_text name="display_name" class="display_name" necessary=true value="$display_name" size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_46'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-46' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_46 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_47'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-47' replace='true'}{/capture}{validate form=$form_name field="password" criteria="grn_isValidPassword" field2="retype" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_47 append="validation_errors"}
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_48'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-48' replace='true'}{/capture}{validate form=$form_name field="password" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_48 append="validation_errors"}
       {grn_password name="password" purpose="init" class="password" size="50"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_49'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-49' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_49 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_50'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-50' replace='true'}{/capture}{validate form=$form_name field="retype" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_50 append="validation_errors"}
       {grn_password name="retype" purpose="init" class="retype" size="50"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_51'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-51' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_51}
  </th>
  <td>
      {grn_select name="expire_time" options=$expire_time_options default="$expire_time"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_52'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-52' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_52}
  </th>
  <td>
      {grn_text name="cookie_domain" value="$cookie_domain" size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_53'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-53' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_53}
  </th>
  <td>
      {grn_text name="cookie_path" value="$cookie_path" size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_54'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-54' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_54}
  </th>
  <td>
      {grn_select name='rmid' options=$repository_method_options}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_55'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-55' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_55 page='system/authentication/authenticate_method_add1' sf=1}
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_56'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-56' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_56}
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_57'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-57' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_57 page='system/authentication/authenticate_method_list' sf=1}
  </td>
 </tr>
</table>

</form>
