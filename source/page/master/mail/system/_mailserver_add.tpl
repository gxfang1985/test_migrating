<script language="JavaScript" type="text/javascript"><!--{literal}
        function smtps_port()
        {
            var smtp_port_element = document.forms["{/literal}{$form_name|escape}{literal}"].elements["smtp_port"];
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
            {/literal}
            {if $smarty.const.ON_FOREST != 1}
              changeDisplay(smtp_auth,'display_is_pop_before_smtp','1:0:0:0:0','sm');
            {/if}
            {literal}
            changeDisplay(smtp_auth,'display_smtp_account_set','0:1:1:1:1','sm');
        }
        function receives_ssl_port()
        {
        	var receive_protocol = document.forms["{/literal}{$form_name|escape}{literal}"].elements["received_protocol"].options;
        	for( i = 0 ; i < receive_protocol.length ; i ++ )
            {
        		var protocol = receive_protocol[i];
    			protocol_value = protocol.value;
    			if(protocol_value == 'POP3')
    			{
    				if(protocol.selected == true)
                    {
        				var received_port = document.forms["{/literal}{$form_name|escape}{literal}"].elements["received_port"];
        	            var pop3s1_obj = document.getElementById('pop3s1');
        	            if(pop3s1_obj.checked == true)
        	            {
        	            	received_port.value = 995;
        	            }
        	            else
        	            {
        	            	received_port.value = 110;
        	            }
        	            return;
                    }
    		    }
    			if(protocol_value == 'IMAP4')
                {
    				if(protocol.selected == true)
                    {
                        var received_port = document.forms["{/literal}{$form_name|escape}{literal}"].elements["received_port"];
                        var pop3s1_obj = document.getElementById('pop3s1');
                        if(pop3s1_obj.checked == true)
                        {
                            received_port.value = 993;
                        }
                        else
                        {
                            received_port.value = 143;
                        }
                        return;
                    }
                }      		    
        		
            }
        }
        
        function changeValue(i,form,ename,status,ssl_status,type)
        {
            if(type == 'sm' || type == null)
            {
            	var pop3s1_obj = document.getElementById('pop3s1');
            	if(pop3s1_obj.checked == true)
                {
            		inValue = new Array();
                    inValue = ssl_status.split(':');
                    form.elements[ename].value = inValue[i.selectedIndex];
                }
            	else
            	{
                    inValue = new Array();
                    inValue = status.split(':');
                    form.elements[ename].value = inValue[i.selectedIndex];
            	}
            }
            
            return;
        }
        
       
  {/literal} --></script>
<table class="std_form">
 <tr valign="top">
  <th style="width:15em" nowrap>
      {capture name='grn_mail_system_GRN_MAIL_SY_1'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-1' replace='true'}{/capture}
      {grn_show_input_title title=$smarty.capture.grn_mail_system_GRN_MAIL_SY_1 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_mail_system_GRN_MAIL_SY_2'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-2' replace='true'}{/capture}
      {validate form=$page_info.all field="foreign_key" criteria="notEmpty" message=$smarty.capture.grn_mail_system_GRN_MAIL_SY_2 transform="cb_trim" append="validation_errors"}
      {grn_text name="foreign_key" size="30" value=$set.foreign_key}<br>
      <div class="br">&nbsp;</div>
      <div class="sub_explanation">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-3' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_mail_system_GRN_MAIL_SY_4'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-4' replace='true'}{/capture}
      {grn_show_input_title title=$smarty.capture.grn_mail_system_GRN_MAIL_SY_4 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_mail_system_GRN_MAIL_SY_5'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-5' replace='true'}{/capture}
      {validate form=$page_info.all field="title" criteria="notEmpty" message=$smarty.capture.grn_mail_system_GRN_MAIL_SY_5 transform="cb_trim" append="validation_errors"}
      {grn_text name='title' size='50' value=$set.title}
  </td>
 </tr>
 <tr>
  <td colspan="2"><br><div class="sub_title">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-6' replace='true'}</div></td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_mail_system_GRN_MAIL_SY_7'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-7' replace='true'}{/capture}
      {grn_show_input_title title=$smarty.capture.grn_mail_system_GRN_MAIL_SY_7 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_mail_system_GRN_MAIL_SY_9'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-9' replace='true'}{/capture}
      {validate form=$page_info.all field="smtp_server" criteria="notEmpty" message=$smarty.capture.grn_mail_system_GRN_MAIL_SY_9 transform="cb_trim" append="validation_errors"}
      {grn_text name='smtp_server' size='50' value=$set.smtp_server}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_mail_system_GRN_MAIL_SY_10'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-10' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_mail_system_GRN_MAIL_SY_10 necessary=TRUE}</th>
  <td>
      {capture name='grn_mail_system_GRN_MAIL_SY_11'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-11' replace='true'}{/capture}
      {validate form=$page_info.all field="smtp_port" criteria="notEmpty" message=$smarty.capture.grn_mail_system_GRN_MAIL_SY_11 transform="cb_trim" append="validation_errors"}
      {capture name='grn_mail_system_GRN_MAIL_SY_12'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-12' replace='true'}{/capture}
      {validate form=$page_info.all field="smtp_port" criteria="isRange" low="1" high="65535" message=$smarty.capture.grn_mail_system_GRN_MAIL_SY_12 transform="cb_trim" append="validation_errors"}
      {grn_text name='smtp_port' size='5' value=$set.smtp_port}&nbsp;
      <span class="sub_explanation">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-13' replace='true'}</span>
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-503' replace='true'}</th>
  <td>{grn_select name='encrypted_connection' options=$encrypted_connection onchange="smtps_port()"}
</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-14' replace='true'}</th>
  <td>
      {capture assign="smtp_auto_onchange"}{if $smarty.const.ON_FOREST != 1}changeDisplay(this,'display_is_pop_before_smtp','1:0:0:0:0','sm');{/if}changeDisplay(this,'display_smtp_account_set','0:1:1:1:1','sm'){/capture}
      {grn_select name='smtp_auth' options=$smtp_auth onchange="$smtp_auto_onchange"}
  </td>
 </tr>
</table>

<div id="display_is_pop_before_smtp" style="{if $set.smtp_auth neq 'NONE'}display:none{/if}">
{if $smarty.const.ON_FOREST != 1}
    <table class="std_form">
        <tr valign="top">
            <th style="width:15em" nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-15' replace='true'}<br>
                {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-16' replace='true'}
            </th>
            <td>
                {if $set.is_pop_before_smtp}
                    {capture name='grn_mail_system_GRN_MAIL_SY_18'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-18' replace='true'}{/capture}{grn_radio name='is_pop_before_smtp' id='is_pop_before_smtp1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_18 checked=TRUE}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_19'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-19' replace='true'}{/capture}{grn_radio name='is_pop_before_smtp' id='is_pop_before_smtp2' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_19}<br>
                {else}
                    {capture name='grn_mail_system_GRN_MAIL_SY_20'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-20' replace='true'}{/capture}{grn_radio name='is_pop_before_smtp' id='is_pop_before_smtp1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_20}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_21'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-21' replace='true'}{/capture}{grn_radio name='is_pop_before_smtp' id='is_pop_before_smtp2' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_21 checked=TRUE}<br>
                {/if}
                &nbsp;{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-22' replace='true'}&nbsp;{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-23' replace='true'}&nbsp;{grn_select_numbers select_name=$select1.name options=$select1.options padding='&nbsp;' selected=$select1.selected}&nbsp;{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-24' replace='true'}
            </td>
        </tr>
    </table>
{/if}
</div>

<div id="display_smtp_account_set" style="{if $set.smtp_auth eq 'NONE'}display:none{/if}">
<table class="std_form">
 <tr valign="top">
  <th style="width:15em" nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-25' replace='true'}</th>
  <td>
{if $set.smtp_account_set}
       {capture name='grn_mail_system_GRN_MAIL_SY_26'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-26' replace='true'}{/capture}{grn_radio name='smtp_account_set' id='smtp_account_set1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_26 checked=TRUE}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_27'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-27' replace='true'}{/capture}{grn_radio name='smtp_account_set' id='smtp_account_set2' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_27}<br>
{else}
       {capture name='grn_mail_system_GRN_MAIL_SY_28'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-28' replace='true'}{/capture}{grn_radio name='smtp_account_set' id='smtp_account_set1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_28}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_29'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-29' replace='true'}{/capture}{grn_radio name='smtp_account_set' id='smtp_account_set2' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_29 checked=TRUE}<br>
{/if}
       {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-30' replace='true'}
  </td>
 </tr>
</table>
</div>

<table class="std_form">
 <tr>
  <th style="width:15em" nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-31' replace='true'}</th>
  <td>{grn_select_numbers select_name=$select2.name options=$select2.options padding='&nbsp;' selected=$select2.selected}&nbsp;{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-32' replace='true'}</td>
 </tr>
 <tr>
  <td colspan="2"><br><div class="sub_title">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-33' replace='true'}</div></td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-34' replace='true'}</th>
  <td>
       {grn_select name='received_protocol' options=$received_protocol onchange="changeDisplay(this,'display_apop','1:0','sm');changeValue(this,this.form,'received_port','110:143','995:993','sm')"}<br>
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_mail_system_GRN_MAIL_SY_35'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-35' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_mail_system_GRN_MAIL_SY_35 necessary=TRUE}</th>
  <td>
       {capture name='grn_mail_system_GRN_MAIL_SY_36'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-36' replace='true'}{/capture}{validate form=$page_info.all field="received_server" criteria="notEmpty" message=$smarty.capture.grn_mail_system_GRN_MAIL_SY_36 transform="cb_trim" append="validation_errors"}{grn_text name='received_server' size='50' value=$set.received_server}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_mail_system_GRN_MAIL_SY_37'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-37' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_mail_system_GRN_MAIL_SY_37 necessary=TRUE}</th>
  <td>
   {capture name='grn_mail_system_GRN_MAIL_SY_38'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-38' replace='true'}{/capture}{validate form=$page_info.all field="received_port" criteria="notEmpty" message=$smarty.capture.grn_mail_system_GRN_MAIL_SY_38 transform="cb_trim" append="validation_errors"}
   {capture name='grn_mail_system_GRN_MAIL_SY_39'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-39' replace='true'}{/capture}{validate form=$page_info.all field="received_port" criteria="isRange" low="1" high="65535" message=$smarty.capture.grn_mail_system_GRN_MAIL_SY_39 transform="cb_trim" append="validation_errors"}
   {grn_text name='received_port' size='10' value=$set.received_port}&nbsp;<span class="sub_explanation">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-40' replace='true'}</span></td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-490' replace='true'}</th>
  <td>{capture name='grn_mail_system_GRN_MAIL_SY_491'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-491' replace='true'}{/capture}{grn_checkbox name='pop3s' id='pop3s1' value='1' checked=$set.received_ssl caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_491 onclick="receives_ssl_port()"}
  </td>
 </tr>
</table>

{if $set.received_protocol eq 'POP3'}
<div id="display_apop">
{else}
<div id="display_apop" style="display:none">
{/if}
<table class="std_form">
 <tr>
  <th style="width:15em" nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-41' replace='true'}</th>
  <td>
{if $set.apop}
       {capture name='grn_mail_system_GRN_MAIL_SY_42'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-42' replace='true'}{/capture}{grn_radio name='apop' id='apop1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_42 checked=TRUE}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_43'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-43' replace='true'}{/capture}{grn_radio name='apop' id='apop2' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_43}
{else}
       {capture name='grn_mail_system_GRN_MAIL_SY_44'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-44' replace='true'}{/capture}{grn_radio name='apop' id='apop1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_44}&nbsp;{capture name='grn_mail_system_GRN_MAIL_SY_45'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-45' replace='true'}{/capture}{grn_radio name='apop' id='apop2' value='0' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_45 checked=TRUE}
{/if}
  </td>
 </tr>
</table>
</div>

<table class="std_form">
 <tr>
  <th style="width:15em" nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-46' replace='true'}</th>
  <td>{grn_select_numbers select_name=$select3.name options=$select3.options padding='&nbsp;' selected=$select3.selected}&nbsp;{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-47' replace='true'}</td>
 </tr>
 <tr>
  <td></td>
  <td>
{include file="$button_file"}
  </td>
 </tr>
</table>
</div>
