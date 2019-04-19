{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/wm.js"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/external/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" id="csrf_ticket" value="{$csrf_ticket}">

{include file="grn/show_validation_errors.tpl"}
{include file="grn/indispensable.tpl" half_width_number=1}
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.system.external' key='GRN_SY_EX-49' replace='true'}</th>
  <td>
{if $set.available}
  {capture name='grn_system_external_GRN_SY_EX_50'}{cb_msg module='grn.system.external' key='GRN_SY_EX-50' replace='true'}{/capture}{grn_radio name='available' id='available1' value='1' caption=$smarty.capture.grn_system_external_GRN_SY_EX_50 checked=TRUE onclick="setDisableById(this.form,'server:port:exception_address','off')"}&nbsp;{capture name='grn_system_external_GRN_SY_EX_51'}{cb_msg module='grn.system.external' key='GRN_SY_EX-51' replace='true'}{/capture}{grn_radio name='available' id='available2' value='0' caption=$smarty.capture.grn_system_external_GRN_SY_EX_51 onclick="setDisableById(this.form,'server:port:exception_address','on')"}
{else}
  {capture name='grn_system_external_GRN_SY_EX_52'}{cb_msg module='grn.system.external' key='GRN_SY_EX-52' replace='true'}{/capture}{grn_radio name='available' id='available1' value='1' caption=$smarty.capture.grn_system_external_GRN_SY_EX_52 onclick="setDisableById(this.form,'server:port:exception_address','off')"}&nbsp;{capture name='grn_system_external_GRN_SY_EX_53'}{cb_msg module='grn.system.external' key='GRN_SY_EX-53' replace='true'}{/capture}{grn_radio name='available' id='available2' value='0' caption=$smarty.capture.grn_system_external_GRN_SY_EX_53 checked=TRUE onclick="setDisableById(this.form,'server:port:exception_address','on')"}
{/if}
  </td>
 </tr>
 <tr>
  <td><br></td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_system_external_GRN_SY_EX_54'}{cb_msg module='grn.system.external' key='GRN_SY_EX-54' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_external_GRN_SY_EX_54 necessary=true}</th>
  <td>{capture name='grn_system_external_GRN_SY_EX_55'}{cb_msg module='grn.system.external' key='GRN_SY_EX-55' replace='true'}{/capture}{validate form=$form_name field="server" criteria="notEmpty" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_external_GRN_SY_EX_55 append="validation_errors"}{grn_text necessary=true name="server" id='server' value=$set.server size="50" disable_return_key=true}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_system_external_GRN_SY_EX_56'}{cb_msg module='grn.system.external' key='GRN_SY_EX-56' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_external_GRN_SY_EX_56 necessary=true number=true}</th>
  <td>
  {capture name='grn_system_external_GRN_SY_EX_57'}{cb_msg module='grn.system.external' key='GRN_SY_EX-57' replace='true'}{/capture}{validate form=$form_name field="port" criteria="notEmpty" message=$smarty.capture.grn_system_external_GRN_SY_EX_57 append="validation_errors"}
  {capture name='grn_system_external_GRN_SY_EX_58'}{cb_msg module='grn.system.external' key='GRN_SY_EX-58' replace='true'}{/capture}{validate form=$form_name field="port" criteria="isRange" low="0" high="65535" message=$smarty.capture.grn_system_external_GRN_SY_EX_58 append="validation_errors"}
  {grn_text necessary=true name="port" id='port' value=$set.port size="5" disable_return_key=true}&nbsp;<span class="sub_explanation">{cb_msg module='grn.system.external' key='GRN_SY_EX-59' replace='true'}</span>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.system.external' key='GRN_SY_EX-60' replace='true'}</th>
  <td>
  {grn_textarea name="exception_address" id='exception_address' value=$set.exception_address cols="50" rows="5" title=""}<br>
  <div class="sub_explanation">
   {cb_msg module='grn.system.external' key='GRN_SY_EX-61' replace='true'}(;){cb_msg module='grn.system.external' key='GRN_SY_EX-62' replace='true'}<br>
   {cb_msg module='grn.system.external' key='GRN_SY_EX-63' replace='true'}
  </div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_system_external_GRN_SY_EX_64'}{cb_msg module='grn.system.external' key='GRN_SY_EX-64' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_external_GRN_SY_EX_64}
  {grn_button_cancel page='system/common_list' id='external'}
  </td>
 </tr>
</table>

</form>

<script language="JavaScript">
<!--
    window.onload = function(){literal}{{/literal}typeChangeSM("{$form_name}","available");{literal}}{/literal}
//-->
</script>

{include file="grn/system_footer.tpl"}
