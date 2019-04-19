{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/form_disable.js"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/authenticate/command_modify_cybozu'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="amid" value="{$authenticate_method.amid}">
<input type="hidden" name="display" value="{$display}">

{if !$authenticate_method.driver_settings.raw_password }
  <div class="attention">{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-68' replace='true'}</div>
{/if}

<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_69'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-69' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_69 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_70'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-70' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_70 append="validation_errors"}
       {grn_text name="display_name" class="display_name" necessary=true value=$authenticate_method.display_name size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_71'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-71' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_71 necessary=true}
  </th>
  <td>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_72'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-72' replace='true'}{/capture}{validate form=$form_name field="cookie_mode" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_72 append="validation_errors"}
{if $authenticate_method.driver_settings.cookie_mode eq '2' || $isV2Disable }
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_73'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-73' replace='true'}{/capture}{grn_radio name='cookie_mode' id='open2' value='1' caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_73 onclick="setDisableById(this.form, 'cookie_name', 'off');" }&nbsp;
	  {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_74'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-74' replace='true'}{/capture}{grn_radio name='cookie_mode' id='cybozu' value='2' caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_74 onclick="setDisableById(this.form, 'cookie_name', 'on');" checked=TRUE }
{else}
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_75'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-75' replace='true'}{/capture}{grn_radio name='cookie_mode' id='open2' value='1' caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_75 onclick="setDisableById(this.form, 'cookie_name', 'off');" checked=TRUE }&nbsp;
	  {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_76'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-76' replace='true'}{/capture}{grn_radio name='cookie_mode' id='cybozu' value='2' caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_76 onclick="setDisableById(this.form, 'cookie_name', 'on');" }
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_77'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-77' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_77}
  </th>
  <td>
{if $authenticate_method.driver_settings.cookie_mode eq '2' || $isV2Disable}
      {grn_text name="cookie_name" id="cookie_name" value=$authenticate_method.driver_settings.cookie_name size="50" disable_return_key=true disabled=true}<br/>
{else}
      {grn_text name="cookie_name" id="cookie_name" value=$authenticate_method.driver_settings.cookie_name size="50" disable_return_key=true}<br/>
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_78'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-78' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_78 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_79'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-79' replace='true'}{/capture}{validate form=$form_name field="password" criteria="grn_isValidPassword" field2="retype" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_79 append="validation_errors"}
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_80'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-80' replace='true'}{/capture}{validate form=$form_name field="password" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_80 append="validation_errors"}
       {grn_password name="password" purpose="modify" class="password" size="50" maxlength=64 disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_81'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-81' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_81 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_82'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-82' replace='true'}{/capture}{validate form=$form_name field="retype" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_82 append="validation_errors"}
       {grn_password name="retype" purpose="retype" class="retype" size="50" maxlength=64 disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_83'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-83' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_83 necessary=true}
  </th>
  <td>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_84'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-84' replace='true'}{/capture}{validate form=$form_name field="expire_time" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_84 append="validation_errors"}
      {grn_select name="expire_time" options=$expire_time_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_85'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-85' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_85}
  </th>
  <td>
      {grn_text name="cookie_domain" value=$authenticate_method.driver_settings.cookie_domain size="50" disable_return_key=true}<br/>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-86' replace='true'}&nbsp;xxx.cybozu.co.jp
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_87'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-87' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_87}
  </th>
  <td>
      {grn_select name='rmid' options=$repository_method_options}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_88'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-88' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_88}
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_89'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-89' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_89 page='system/authentication/authenticate_method_view' amid=$authenticate_method.amid}
  </td>
 </tr>
</table>

</form>

{if $isV2Disable }
{literal}
<script language="JavaScript" type="text/javascript"><!--
  document.getElementById( 'open2' ).disabled = true;
//--></script>
{/literal}
{else}
{literal}
<script language="JavaScript" type="text/javascript"><!--
  document.getElementById( 'open2' ).disabled = false;
//--></script>
{/literal}
{/if}
