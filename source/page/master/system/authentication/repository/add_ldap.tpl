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
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/repository/command_add_ldap'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="rmid" value="{$repository_method.rmid}">
<input type="hidden" name="display" value="{$display}">

<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_1'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-1' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_1 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_2'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-2' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_2 append="validation_errors"}
       {grn_text name="display_name" class="display_name" necessary=true value="$display_name" size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-65' replace='true'}</th>
  <td>{capture name='grn_system_authentication_repository_GRN_SY_AU_RE_69'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-69' replace='true'}{/capture}{grn_checkbox name='ssl' id='ldaps1' value='1' checked=$ssl
caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_69 onclick="check_ssl()"}
</td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_3'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-3' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_3 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_4'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-4' replace='true'}{/capture}{validate form=$form_name field="server" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_4 append="validation_errors"}
       {grn_text name="server" class="server" necessary=true value="$server" size="50" disable_return_key=true maxlength="255"}<br>
       
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
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_9'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-9' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_9}
  </th>
  <td>
      {if $use_anonymous == 1}
       {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_10'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-10' replace='true'}{/capture}{grn_checkbox name="use_anonymous" id="use_anonymous" value="1" caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_10 checked=TRUE onclick='on_click_use_anonymous(this.form);'}
      {else}
       {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_11'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-11' replace='true'}{/capture}{grn_checkbox name="use_anonymous" id="use_anonymous" value="1" caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_11 onclick='on_click_use_anonymous(this.form);'}
      {/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_12'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-12' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_12}<span class='attention' id='account' {if $use_anonymous}style="display:none"{/if}>*</span>
  </th>
  <td>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_13'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-13' replace='true'}{/capture}{validate form=$form_name field="account" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_13 append="validation_errors"}
      {grn_text name="account" id='iaccount' class="account" value="$account" size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_14'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-14' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_14}<span class='attention' id='password' {if $use_anonymous}style="display:none"{/if}>*</span>
  </th>
  <td>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_15'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-15' replace='true'}{/capture}{validate form=$form_name field="password" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_15 append="validation_errors"}
      {grn_password name='password' id='ipassword' class='password' purpose='init' size=50}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_16'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-16' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_16}<span class='attention' id='retype' {if $use_anonymous}style="display:none"{/if}>*</span>
  </th>
  <td>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_17'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-17' replace='true'}{/capture}{validate form=$form_name field="retype" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_17 append="validation_errors"}
      {grn_password name='retype' id='iretype' class='password' purpose='init' size=50}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_18'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-18' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_18 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_19'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-19' replace='true'}{/capture}{validate form=$form_name field="base_dn" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_19 append="validation_errors"}
       {grn_text name="base_dn" class="base_dn" necessary=true value="$base_dn" size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_21'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-21' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_21 necessary=true}
  </th>
  <td>
       {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_22'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-22' replace='true'}{/capture}{validate form=$form_name field="search_filter" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_22 append="validation_errors"}
       {grn_text name="search_filter" class="search_filter" necessary=true value="$search_filter" size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_23'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-23' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_23}
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
         {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_73'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-73' replace='true'}{/capture}{grn_checkbox name='affix_condition' id='affix_condition' value='1' caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_73 onclick='check_affix_condition();' checked=$affix_condition}
         <br>

         {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-74' replace='true'}
         <select name="affix_type" id="affix_type">
             <option value="prefix" {if $affix_type !== 'suffix'}selected{/if}>
                 {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-75' replace='true'}
             </option>
             <option value="suffix" {if $affix_type === 'suffix'}selected{/if}>
                 {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-76' replace='true'}
             </option>
         </select>

         {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_77'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-77' replace='true'}{/capture}
         {validate form=$form_name field="affix_string" criteria="notEmpty" message=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_77 append="validation_errors"}
         {grn_text name="affix_string" id="affix_string" value="" size="50" maxlength="100" disable_return_key=true value=$affix_string}
         <br>
         {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_78'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-78' replace='true'}{/capture}{grn_checkbox name='affix_strip' id='affix_strip' value='1' caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_78 checked=$affix_strip}
     </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_24'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-24' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_24 page='system/authentication/repository_method_add1' sf=1}
       {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_25'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-25' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_25}
       {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_26'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-26' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_26 page='system/authentication/repository_method_list' sf=1}
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
