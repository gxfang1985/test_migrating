{assign var='form_name' value=$smarty.template|basename}
<script language="JavaScript" type="text/javascript"><!--{literal}
    function check_ssl()
    {
        var ssl_element = document.forms["{/literal}{$form_name|escape}{literal}"].elements["port"];
        var ssl1_obj = document.getElementById('ldaps1');
        if(ssl1_obj.checked == true)
        {
            ssl_element.value = 389;
            jQuery("#box_port").hide();
        }
        else
        {
            ssl_element.value = 389;
            jQuery("#box_port").show();
        }
    }
    function check_affix_condition()
    {
        var form = document.forms["{/literal}{$form_name|escape}{literal}"];
        var status = form.elements['affix_condition'].checked;
        if (status)
        {
            setDisableById(form,'affix_type:affix_string:affix_strip','off');
        }
        else
        {
            setDisableById(form,'affix_type:affix_string:affix_strip','on');
        }
    }
{/literal} --></script>
<body onload="check_ssl();check_affix_condition();">
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/repository/command_modify_ldap'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="rmid" value="{$repository_method.rmid}">
<input type="hidden" name="display" value="{$display}">

<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_41'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-41' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_41 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_42'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-42' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_42 append="validation_errors"}
       {grn_text name="display_name" class="display_name" necessary=true value=$repository_method.display_name size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-65' replace='true'}</th>
  <td>{capture name='grn_system_authentication_repository_GRN_SY_AU_RE_69'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-69' replace='true'}{/capture}{grn_checkbox name='ssl' id='ldaps1' value='1' checked=$repository_method.driver_settings.ssl
caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_69 onclick="check_ssl()"}
</td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_43'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-43' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_43 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_44'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-44' replace='true'}{/capture}{validate form=$form_name field="server" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_44 append="validation_errors"}
       {grn_text name="server" class="server" necessary=true value=$repository_method.driver_settings.server size="50" disable_return_key=true maxlength="255"}<br>
  </td>
 </tr>
 <tr id="box_port"> 
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_5'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-5' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_5 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_6'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-6' replace='true'}{/capture}{validate form=$form_name field="port" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_6 append="validation_errors"}
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_7'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-7' replace='true'}{/capture}{validate form=$form_name field="port" criteria="isNumber" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_7 append="validation_errors"}
      {grn_text name="port" class="port" value="$port" size="5" disable_return_key=true}&nbsp;<span class="sub_explanation">{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-8' replace='true'}</span>
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_48'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-48' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_48}
  </th>
  <td>
      {if $repository_method.driver_settings.use_anonymous == 1}
       {assign var='use_anonymous' value=1}
       {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_49'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-49' replace='true'}{/capture}{grn_checkbox name="use_anonymous" id="use_anonymous" value="1" caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_49 checked=TRUE onclick="on_click_use_anonymous(this.form);"}
      {else}
       {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_50'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-50' replace='true'}{/capture}{grn_checkbox name="use_anonymous" id="use_anonymous" value="1" caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_50 onclick="on_click_use_anonymous(this.form);"}
      {/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_51'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-51' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_51}<span class='attention' id='account' {if $use_anonymous}style="display:none"{/if}>*</span>
  </th>
  <td>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_52'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-52' replace='true'}{/capture}{validate form=$form_name field="account" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_52 append="validation_errors"}
      {grn_text name="account" id='iaccount' class="account" value=$repository_method.driver_settings.account size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_53'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-53' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_53}<span class='attention' id='password' {if $use_anonymous}style="display:none"{/if}>*</span>
  </th>
  <td>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_54'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-54' replace='true'}{/capture}{validate form=$form_name field="password" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_54 append="validation_errors"}
      {grn_password name='password' id='ipassword' class='password' purpose='modify' size=50}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_55'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-55' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_55}<span class='attention' id='retype' {if $use_anonymous}style="display:none"{/if}>*</span>
  </th>
  <td>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_56'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-56' replace='true'}{/capture}{validate form=$form_name field="retype" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_56 append="validation_errors"}
      {grn_password name='retype' id='iretype' class='password' purpose='retype' size=50}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_57'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-57' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_57 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_58'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-58' replace='true'}{/capture}{validate form=$form_name field="base_dn" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_58 append="validation_errors"}
       {grn_text name="base_dn" class="base_dn" necessary=true value=$repository_method.driver_settings.base_dn size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_60'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-60' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_60 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_61'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-61' replace='true'}{/capture}{validate form=$form_name field="search_filter" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_61 append="validation_errors"}
       {grn_text name="search_filter" class="search_filter" necessary=true value=$repository_method.driver_settings.search_filter size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_62'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-62' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_62}
  </th>
  <td>
      {grn_select name='authenticate_type' class="authenticate_type" options=$authenticate_type_options}
  </td>
 </tr>
    <tr>
        <th nowrap>
            {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_72'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-72' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_72}
        </th>
        <td>
            {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_73'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-73' replace='true'}{/capture}{grn_checkbox name='affix_condition' id='affix_condition' value='1' caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_73 onclick='check_affix_condition();' checked=$repository_method.driver_settings.affix_condition}
            <br>

            {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-74' replace='true'}
            <select name="affix_type" id="affix_type" disabled>
                <option value="prefix" {if $repository_method.driver_settings.affix_type !== 'suffix'}selected{/if}>
                    {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-75' replace='true'}
                </option>
                <option value="suffix" {if $repository_method.driver_settings.affix_type === 'suffix'}selected{/if}>
                    {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-76' replace='true'}
                </option>
            </select>

            {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_77'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-77' replace='true'}{/capture}
            {validate form=$form_name field="affix_string" criteria="notEmpty" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_77 append="validation_errors"}
            {grn_text name="affix_string" id="affix_string" value="" size="50" maxlength="100" disable_return_key=true value=$repository_method.driver_settings.affix_string}
            <br>
            {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_78'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-78' replace='true'}{/capture}{grn_checkbox name='affix_strip' id='affix_strip' value='1' caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_78 checked=$repository_method.driver_settings.affix_strip}
        </td>
    </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_63'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-63' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_63}
       {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_64'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-64' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_64 page='system/authentication/repository_method_view' rmid=$repository_method.rmid}
  </td>
 </tr>
</table>

{grn_load_javascript file="grn/html/form_disable.js"}
{literal}
<script language="JavaScript" type="text/javascript">
<!--
function on_click_use_anonymous(form)
{
  var status = form.elements['use_anonymous'].checked;
  if (status)
  {
    document.getElementById('account').style.display = "none";
    document.getElementById('password').style.display = "none";
    document.getElementById('retype').style.display = "none";
    setDisableById(form,'iaccount:ipassword:iretype','on');
  }
  else
  {
    document.getElementById('account').style.display = "";
    document.getElementById('password').style.display = "";
    document.getElementById('retype').style.display = "";
    setDisableById(form,'iaccount:ipassword:iretype','off');
  }
}
{/literal}
form = document.forms["{$form_name}"];
on_click_use_anonymous(form);
{literal}
//-->
</script>
{/literal}
</form>
</body>
