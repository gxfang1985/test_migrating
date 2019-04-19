{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/wm.js"}
<script language="JavaScript" type="text/javascript"><!--{literal}
        function smtps_port()
        {
            var smtp_port_element = document.forms["{/literal}{$form_name|escape:'javascript'}{literal}"].elements["smtp_port"];
            var encrypted_connection = document.getElementById('encrypted_connection');
            var smtp_auth = document.getElementById('smtp_auth');
            if(encrypted_connection.value == 'SSL')
            {
                smtp_port_element.value = 465;
                smtp_auth.selectedIndex = 0;
            }
            else
            {
                if(encrypted_connection.value == 'TLS')
                {
                    smtp_port_element.value = 587;
                    smtp_auth.selectedIndex = 2;
                }
                else
                {
                    smtp_port_element.value = 25;
                    smtp_auth.selectedIndex = 0;
                }
            }
            changeDisplay(smtp_auth,'display_is_pop_before_smtp','1:0:0:0:0','sm');
            changeDisplay(smtp_auth,'display_smtp_account_set','0:1:1:1:1','sm');
        }
        function pop3s_port()
        {
        	var pop3_port_element = document.forms["{/literal}{$form_name|escape:'javascript'}{literal}"].elements["pop3_port"];
            var pop3s1_obj = document.getElementById('pop3s1');
            if(pop3s1_obj.checked == true)
            {
            	pop3_port_element.value = 995;
            }
            else
            {
            	pop3_port_element.value = 110;
            }
        }
        function toggleDisabled( type, toggle )
        {
            var ids = "";
            var base_ids = "imailaddress:use_builtin1";
            var smtp_ids = "ismtp_server:ismtp_port:ismtp_timeout:smtp_auth:ismtp_user:ismtp_pass:is_pop_before_smtp1:is_pop_before_smtp2:ipop_before_smpt_wait:ipop3_server:ipop3_port:pop3_auth1:pop3_auth2:ipop3_user:ipop3_pass:ipop3_timeout:encrypted_connection";
            var disabled_on_off = toggle ? 'off':'on';

            if( type == "all")
            {
                ids = base_ids;
                if( ! (document.getElementById("use_builtin1") && document.getElementById("use_builtin1").checked && disabled_on_off == "off" ) )
                {
                    ids += ":" + smtp_ids;
                }
            }
            else if( type == "smtp" )
            {
                ids = smtp_ids
            }
            else
            {
                return ;
            }
            setDisableById( window.form, ids, disabled_on_off );
        }
        function toggleSystemMailSetting( toggle )
        {
            toggleDisabled( "all", toggle );
        }
        function toggleSmtpServerSetting( toggle )
        {
            toggleDisabled( "smtp", toggle );
        }
  {/literal} --></script>
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/external/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.system.external' key='GRN_SY_EX-1' replace='true'}</div></p>

{include file="grn/show_validation_errors.tpl"}
{include file="grn/indispensable.tpl"}
<table class="std_form">
 <colgroup>
  <col style="width:18em">
 </colgrop>
 <tr>
  <th nowrap>{cb_msg module='grn.system.external' key='GRN_SY_EX-2' replace='true'}</th>
  <td>
{if $set.available}
  {capture name='grn_system_external_GRN_SY_EX_3'}{cb_msg module='grn.system.external' key='GRN_SY_EX-3' replace='true'}{/capture}{grn_radio name='available' id='available1' value='1' caption=$smarty.capture.grn_system_external_GRN_SY_EX_3 checked=TRUE onclick="toggleSystemMailSetting(true);"}&nbsp;{capture name='grn_system_external_GRN_SY_EX_4'}{cb_msg module='grn.system.external' key='GRN_SY_EX-4' replace='true'}{/capture}{grn_radio name='available' id='available2' value='0' caption=$smarty.capture.grn_system_external_GRN_SY_EX_4 onclick="toggleSystemMailSetting(false);"}
{else}
  {capture name='grn_system_external_GRN_SY_EX_5'}{cb_msg module='grn.system.external' key='GRN_SY_EX-5' replace='true'}{/capture}{grn_radio name='available' id='available1' value='1' caption=$smarty.capture.grn_system_external_GRN_SY_EX_5 onclick="toggleSystemMailSetting(true);"}&nbsp;{capture name='grn_system_external_GRN_SY_EX_6'}{cb_msg module='grn.system.external' key='GRN_SY_EX-6' replace='true'}{/capture}{grn_radio name='available' id='available2' value='0' caption=$smarty.capture.grn_system_external_GRN_SY_EX_6 checked=TRUE onclick="toggleSystemMailSetting(false);"}
{/if}
  </td>
 </tr>

 <tr>
  <th nowrap>{capture name='FROM_EMAIL'}{cb_msg module='grn.system.external' key='FROM_EMAIL' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.FROM_EMAIL necessary=TRUE}</th>
  <td nowrap>
    {capture name='grn_system_external_GRN_SY_EX_15'}{cb_msg module='grn.system.external' key='GRN_SY_EX-15' replace='true'}{/capture}{validate form=$form_name field="mailaddress" criteria="notEmpty" message=$smarty.capture.grn_system_external_GRN_SY_EX_15 append="validation_errors"}
    {capture name='grn_system_external_GRN_SY_EX_16'}{cb_msg module='grn.system.external' key='GRN_SY_EX-16' replace='true'}{/capture}{validate form=$form_name field="mailaddress" criteria="grn_isEmail" message=$smarty.capture.grn_system_external_GRN_SY_EX_16 append="validation_errors"}
    {grn_text necessary=true name="mailaddress" id='imailaddress' value=$set.mailaddress size="50" disable_return_key=true}
    {if $builtin_available}
        {if $domain_country=="CN"}
            <div>{cb_msg module='grn.system.external' key='GRN_SY_EX-70' replace='true'}</div>
        {else}
            <div>{cb_msg module='grn.system.external' key='GRN_SY_EX-69' replace='true'}</div>
        {/if}
    {/if}
  </td>
 </tr>

{if $builtin_available}
 <tr>
  <th nowrap>{cb_msg module='grn.system.external' key='MAILSERVER' replace='true'}</th>
  <td>
   {capture name='USE_BUILTIN_MAILSERVER'}{cb_msg module='grn.system.external' key='USE_BUILTIN_MAILSERVER' replace='true'}{/capture}{grn_checkbox name='use_builtin' id='use_builtin1' value='1' caption=$smarty.capture.USE_BUILTIN_MAILSERVER checked=$set.use_builtin}
   <script  language="JavaScript" type="text/javascript"><!--{literal}
   YAHOO.util.Event.addListener(window, "load", function(){
           var use_mail_builtin = "{/literal}{$set.use_builtin}{literal}";
           if( use_mail_builtin ){
               setSystemMailAddress("none",{/literal}"{$set.built_in_system_mail_address|escape:'javascript'}"{literal});
               toggleSmtpServerSetting(false);
           }
       YAHOO.util.Event.addListener("use_builtin1", "click", function(){
           if(document.getElementById("use_builtin1").checked){
               setSystemMailAddress("none",{/literal}"{$set.built_in_system_mail_address|escape:'javascript'}"{literal});
               toggleSmtpServerSetting(false);
           }else{
               setSystemMailAddress("block",{/literal}"{$set.mailaddress|escape:'javascript'}"{literal});
               toggleSmtpServerSetting(true);
           }
       });
   });
   {/literal} --></script>
  </td>
 </tr>
{/if}
 <tr>
  <td><br></td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_external_GRN_SY_EX_7'}{cb_msg module='grn.system.external' key='GRN_SY_EX-7' replace='true'}{/capture}
      {grn_show_input_title title=$smarty.capture.grn_system_external_GRN_SY_EX_7 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_system_external_GRN_SY_EX_9'}{cb_msg module='grn.system.external' key='GRN_SY_EX-9' replace='true'}{/capture}
      {validate form=$form_name field="smtp_server" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_external_GRN_SY_EX_9 append="validation_errors"}
      {grn_text necessary=true name="smtp_server" id='ismtp_server' value=$set.smtp_server size="50" disable_return_key=true}</td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_external_GRN_SY_EX_11'}{cb_msg module='grn.system.external' key='GRN_SY_EX-11' replace='true'}{/capture}
      {grn_show_input_title title=$smarty.capture.grn_system_external_GRN_SY_EX_11 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_system_external_GRN_SY_EX_12'}{cb_msg module='grn.system.external' key='GRN_SY_EX-12' replace='true'}{/capture}
      {validate form=$form_name field="smtp_port" criteria="notEmpty" message=$smarty.capture.grn_system_external_GRN_SY_EX_12 append="validation_errors"}
      {capture name='grn_system_external_GRN_SY_EX_13'}{cb_msg module='grn.system.external' key='GRN_SY_EX-13' replace='true'}{/capture}
      {validate form=$form_name field="smtp_port" criteria="isRange" low="0" high="65535" message=$smarty.capture.grn_system_external_GRN_SY_EX_13 append="validation_errors"}
      {grn_text necessary=true name="smtp_port" id='ismtp_port' value=$set.smtp_port size="5" disable_return_key=true}&nbsp;
      <span class="sub_explanation">{cb_msg module='grn.system.external' key='GRN_SY_EX-14' replace='true'}</span>
  </td>
 </tr>
 
 <tr>
  <th nowrap>{cb_msg module='grn.system.external' key='GRN_SY_EX-68' replace='true'}</th>
  <td>{grn_select name='encrypted_connection' id='encrypted_connection' options=$encrypted_connection onchange="smtps_port();"}
</td>
 </tr>
 
 <tr>
  <th nowrap>{cb_msg module='grn.system.external' key='GRN_SY_EX-17' replace='true'}</th>
  <td>{grn_select_numbers select_name='smtp_timeout' id='ismtp_timeout' options=$set.smtp_timeout_list padding='&nbsp;' selected=$set.smtp_timeout} {cb_msg module='grn.system.external' key='GRN_SY_EX-18' replace='true'}</td>
 <tr>
  <th nowrap>{cb_msg module='grn.system.external' key='GRN_SY_EX-19' replace='true'}</th>
  <td>{grn_select name='smtp_auth' options=$set.smtp_auth onchange="changeDisplay(this,'display_is_pop_before_smtp','1:0:0:0:0','sm');changeDisplay(this,'display_smtp_account_set','0:1:1:1:1','sm')"}</td>
 </tr>
</table>

{if $set.selected_smtp_auth eq 'NONE'}
<div id="display_smtp_account_set" style="display:none">
{else}
<div id="display_smtp_account_set">
{/if}
<table class="std_form">
 <colgroup>
  <col style="width:18em">
 </colgrop>
 <tr>
  <th nowrap>{capture name='grn_system_external_GRN_SY_EX_20'}{cb_msg module='grn.system.external' key='GRN_SY_EX-20' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_external_GRN_SY_EX_20 necessary=TRUE}</th>
  <td>{capture name='grn_system_external_GRN_SY_EX_21'}{cb_msg module='grn.system.external' key='GRN_SY_EX-21' replace='true'}{/capture}{validate form=$form_name field="smtp_user" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_external_GRN_SY_EX_21 append="validation_errors"}
      {grn_text necessary=true name="smtp_user" id='ismtp_user' value=$set.smtp_user size="50" disable_return_key=true}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.external' key='GRN_SY_EX-22' replace='true'}</th>
  <td>
{if $set.selected_smtp_auth eq 'NONE'}
  {grn_password name='smtp_pass' id='ismtp_pass' purpose='init' value="smtp_pass" size='50'}
{else}
  {grn_password name='smtp_pass' id='ismtp_pass' purpose='modify' value="smtp_pass" size='50'}
{/if}
  </td>
 </tr>
</table>
</div>
<div id="display_is_pop_before_smtp" style="{if $set.selected_smtp_auth neq 'NONE'}display:none{/if}">
    {if $smarty.const.ON_FOREST != 1}
        <table class="std_form">
            <colgroup/>
            <col style="width:18em"/>
            <tr valign="top">
                <th nowrap>{cb_msg module='grn.system.external' key='GRN_SY_EX-23' replace='true'}<br>
                    {cb_msg module='grn.system.external' key='GRN_SY_EX-24' replace='true'} before {cb_msg module='grn.system.external' key='GRN_SY_EX-25' replace='true'}
                </th>
                <td>
                    {if $set.is_pop_before_smtp}
                        {capture name='grn_system_external_GRN_SY_EX_26'}{cb_msg module='grn.system.external' key='GRN_SY_EX-26' replace='true'}{/capture}{grn_radio name='is_pop_before_smtp' id='is_pop_before_smtp1' value='1' caption=$smarty.capture.grn_system_external_GRN_SY_EX_26 checked=true onclick="changeDisplayRadio('display_pop3','')"}&nbsp;{capture name='grn_system_external_GRN_SY_EX_27'}{cb_msg module='grn.system.external' key='GRN_SY_EX-27' replace='true'}{/capture}{grn_radio name='is_pop_before_smtp' id='is_pop_before_smtp2' value='0' caption=$smarty.capture.grn_system_external_GRN_SY_EX_27 onclick="changeDisplayRadio('','display_pop3')"}<br>
                    {else}
                        {capture name='grn_system_external_GRN_SY_EX_28'}{cb_msg module='grn.system.external' key='GRN_SY_EX-28' replace='true'}{/capture}{grn_radio name='is_pop_before_smtp' id='is_pop_before_smtp1' value='1' caption=$smarty.capture.grn_system_external_GRN_SY_EX_28 onclick="changeDisplayRadio('display_pop3','')"}&nbsp;{capture name='grn_system_external_GRN_SY_EX_29'}{cb_msg module='grn.system.external' key='GRN_SY_EX-29' replace='true'}{/capture}{grn_radio name='is_pop_before_smtp' id='is_pop_before_smtp2' value='0' caption=$smarty.capture.grn_system_external_GRN_SY_EX_29 checked=true onclick="changeDisplayRadio('','display_pop3')"}<br>
                    {/if}
                    &nbsp;{cb_msg module='grn.system.external' key='GRN_SY_EX-30' replace='true'}&nbsp{grn_select_numbers select_name='pop_before_smtp_wait' id='ipop_before_smpt_wait' options=$set.pop_before_smtp_wait_list padding='&nbsp;' selected=$set.pop_before_smtp_wait}&nbsp;{cb_msg module='grn.system.external' key='GRN_SY_EX-31' replace='true'}
                </td>
            </tr>
        </table>
    <div id="display_pop3" style="{if !$set.is_pop_before_smtp}display:none{/if}">
        <table class="std_form">
            <colgroup/>
            <col style="width:15em">
            <tr>
                <th nowrap>{capture name='grn_system_external_GRN_SY_EX_32'}{cb_msg module='grn.system.external' key='GRN_SY_EX-32' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_external_GRN_SY_EX_32 necessary=true}</th>
                <td>{capture name='grn_system_external_GRN_SY_EX_33'}{cb_msg module='grn.system.external' key='GRN_SY_EX-33' replace='true'}{/capture}{validate form=$form_name field="pop3_server" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_external_GRN_SY_EX_33 append="validation_errors"}
                    {grn_text necessary=true name="pop3_server" id='ipop3_server' value=$set.pop3_server size="50" disable_return_key=true}</td>
            </tr>
            <tr>
                <th nowrap>{capture name='grn_system_external_GRN_SY_EX_34'}{cb_msg module='grn.system.external' key='GRN_SY_EX-34' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_external_GRN_SY_EX_34 necessary=true}</th>
                <td>
                    {capture name='grn_system_external_GRN_SY_EX_35'}{cb_msg module='grn.system.external' key='GRN_SY_EX-35' replace='true'}{/capture}{validate form=$form_name field="pop3_port" criteria="notEmpty" message=$smarty.capture.grn_system_external_GRN_SY_EX_35 append="validation_errors"}
                    {capture name='grn_system_external_GRN_SY_EX_36'}{cb_msg module='grn.system.external' key='GRN_SY_EX-36' replace='true'}{/capture}{validate form=$form_name field="pop3_port" criteria="isRange" low="0" high="65535" message=$smarty.capture.grn_system_external_GRN_SY_EX_36 append="validation_errors"}
                    {grn_text necessary=true name="pop3_port" id='ipop3_port' value=$set.pop3_port size="5" disable_return_key=true}&nbsp;<span class="sub_explanation">{cb_msg module='grn.system.external' key='GRN_SY_EX-37' replace='true'}</span>
                </td>
            </tr>
            <tr>
                <th nowrap>{cb_msg module='grn.system.external' key='GRN_SY_EX-65' replace='true'}</th>
                <td>{capture name='grn_system_external_GRN_SY_EX_66'}{cb_msg module='grn.system.external' key='GRN_SY_EX-66' replace='true'}{/capture}{grn_checkbox name='pop3s' id='pop3s1' value='1' caption=$smarty.capture.grn_system_external_GRN_SY_EX_66 checked=$set.pop3_ssl onclick="pop3s_port()"}
                </td>
            </tr>
            <tr>
                <th nowrap>{cb_msg module='grn.system.external' key='GRN_SY_EX-38' replace='true'}</th>
                <td>
                    {if $set.pop3_auth eq 'APOP'}
                        {capture name='grn_system_external_GRN_SY_EX_39'}{cb_msg module='grn.system.external' key='GRN_SY_EX-39' replace='true'}{/capture}{grn_radio name='pop3_auth' id='pop3_auth1' value='APOP' caption=$smarty.capture.grn_system_external_GRN_SY_EX_39 checked=true}&nbsp;{capture name='grn_system_external_GRN_SY_EX_40'}{cb_msg module='grn.system.external' key='GRN_SY_EX-40' replace='true'}{/capture}{grn_radio name='pop3_auth' id='pop3_auth2' value='USER' caption=$smarty.capture.grn_system_external_GRN_SY_EX_40}<br>
                    {else}
                        {capture name='grn_system_external_GRN_SY_EX_41'}{cb_msg module='grn.system.external' key='GRN_SY_EX-41' replace='true'}{/capture}{grn_radio name='pop3_auth' id='pop3_auth1' value='APOP' caption=$smarty.capture.grn_system_external_GRN_SY_EX_41}&nbsp;{capture name='grn_system_external_GRN_SY_EX_42'}{cb_msg module='grn.system.external' key='GRN_SY_EX-42' replace='true'}{/capture}{grn_radio name='pop3_auth' id='pop3_auth2' value='USER' caption=$smarty.capture.grn_system_external_GRN_SY_EX_42 checked=true}<br>
                    {/if}
                </td>
            </tr>
            <tr>
                <th nowrap>{capture name='grn_system_external_GRN_SY_EX_43'}{cb_msg module='grn.system.external' key='GRN_SY_EX-43' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_external_GRN_SY_EX_43 necessary=TRUE}</th>
                <td>{capture name='grn_system_external_GRN_SY_EX_44'}{cb_msg module='grn.system.external' key='GRN_SY_EX-44' replace='true'}{/capture}{validate form=$form_name field="pop3_user" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_external_GRN_SY_EX_44 append="validation_errors"}{grn_text necessary=true name="pop3_user" id='ipop3_user' value=$set.pop3_user size="50" disable_return_key=true}</td>
            </tr>
            <tr>
                <th nowrap>{cb_msg module='grn.system.external' key='GRN_SY_EX-45' replace='true'}</th>
                <td>
                    {if !$set.is_pop_before_smtp }
                        {grn_password name='pop3_pass' id='ipop3_pass' purpose='init' value="pop3_pass" size='50'}
                    {else}
                        {grn_password name='pop3_pass' id='ipop3_pass' purpose='modify' value="pop3_pass" size='50'}
                    {/if}
                </td>
            </tr>
            <tr>
                <th nowrap>{cb_msg module='grn.system.external' key='GRN_SY_EX-46' replace='true'}</th>
                <td>{grn_select_numbers select_name='pop3_timeout' id='ipop3_timeout' options=$set.pop3_timeout_list padding='&nbsp;' selected=$set.pop3_timeout} {cb_msg module='grn.system.external' key='GRN_SY_EX-47' replace='true'}</td>
            </tr>
        </table>
    </div>
    {/if}{* end if of $smarty.const.ON_FOREST != 1*}
</div>

<table class="std_form">
 <colgroup>
  <col style="width:15em">
 </colgrop>
 <tr>
  <td></td>
  <td>
  {capture name='grn_system_external_GRN_SY_EX_48'}{cb_msg module='grn.system.external' key='GRN_SY_EX-48' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_system_external_GRN_SY_EX_48}
  {grn_button_cancel page='system/common_list' id='external'}
  </td>
 </tr>
</table>

</form>

<script language="JavaScript">
<!--
    window.onload = function(){literal}{{/literal}typeChangeSM("{$form_name|escape:'javascript'}","available:smtp_auth{if $smarty.const.ON_FOREST != 1}:is_pop_before_smtp{/if}{if $builtin_available}:use_builtin{/if}");{literal}}{/literal}
//-->
</script>

{include file="grn/system_footer.tpl"}
