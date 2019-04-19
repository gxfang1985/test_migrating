{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/form_disable.js"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/authenticate/command_add_cybozu'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="amid" value="{$authenticate_method.amid}">
<input type="hidden" name="display" value="{$display}">

<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_104'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-104' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_104 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_105'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-105' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_105 append="validation_errors"}
       {grn_text name="display_name" class="display_name" necessary=true value="$display_name" size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_106'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-106' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_106 necessary=true}
  </th>
  <td>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_107'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-107' replace='true'}{/capture}{validate form=$form_name field="cookie_mode" criteria="isNumber" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_107 append="validation_errors"}
{if $cookie_mode eq '2' || $isV2Disable }
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_108'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-108' replace='true'}{/capture}{grn_radio name='cookie_mode' id='open2' value='1' caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_108 onclick="setDisableById(this.form, 'cookie_name', 'off');" }&nbsp;
	  {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_109'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-109' replace='true'}{/capture}{grn_radio name='cookie_mode' id='cybozu' value='2' caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_109 onclick="setDisableById(this.form, 'cookie_name', 'on');" checked=TRUE }
{else}
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_110'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-110' replace='true'}{/capture}{grn_radio name='cookie_mode' id='open2' value='1' caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_110 onclick="setDisableById(this.form, 'cookie_name', 'off');" checked=TRUE}&nbsp;
	  {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_111'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-111' replace='true'}{/capture}{grn_radio name='cookie_mode' id='cybozu' value='2' caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_111 onclick="setDisableById(this.form, 'cookie_name', 'on');" }
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_112'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-112' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_112}
  </th>
  <td>
{if $cookie_mode eq '2' || $isV2Disable }
      {grn_text name="cookie_name" id="cookie_name" value="$cookie_name" size="50" disable_return_key=true disabled=true}<br/>
{else}
      {grn_text name="cookie_name" id="cookie_name" value="$cookie_name" size="50" disable_return_key=true}<br/>
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_113'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-113' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_113 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_114'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-114' replace='true'}{/capture}{validate form=$form_name field="password" criteria="grn_isValidPassword" field2="retype" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_114 append="validation_errors"}
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_115'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-115' replace='true'}{/capture}{validate form=$form_name field="password" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_115 append="validation_errors"}
       {grn_password name="password" purpose="init" class="password" size="50"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_116'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-116' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_116 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_117'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-117' replace='true'}{/capture}{validate form=$form_name field="retype" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_117 append="validation_errors"}
       {grn_password name="retype" purpose="init" class="retype" size="50"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_118'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-118' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_118 necessary=true}
  </th>
  <td>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_119'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-119' replace='true'}{/capture}{validate form=$form_name field="expire_time" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_119 append="validation_errors"}
      {grn_select name="expire_time" options=$expire_time_options default="$expire_time"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_120'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-120' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_120}
  </th>
  <td>
      {grn_text name="cookie_domain" class="cookie_domain" value="$cookie_domain" size="50" disable_return_key=true}<br/>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-121' replace='true'}&nbsp;xxx.cybozu.co.jp
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_122'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-122' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_122}
  </th>
  <td>
      {grn_select name='rmid' options=$repository_method_options}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_123'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-123' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_123 page='system/authentication/authenticate_method_add1' sf=1}
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_124'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-124' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_124}
       {capture name='grn_system_authentication_authenticate_GRN_SY_AU_AU_125'}{cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-125' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_authentication_authenticate_GRN_SY_AU_AU_125 page='system/authentication/authenticate_method_list' sf=1}
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
