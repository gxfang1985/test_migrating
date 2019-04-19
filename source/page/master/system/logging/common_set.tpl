{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=""}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='system/logging/command_common_set'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.system.logging' key='GRN_SY_LO-130' replace='true'}</div></p>

<table class="std_form">
<tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-131' replace='true'}</th>
  <td>{grn_select name=$config.retention_period.name options=$config.retention_period.options selected=$config.retention_period.selected}</td>
 </tr>
<tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-132' replace='true'}</th>
  <td>{grn_select name=$config.export_format.name options=$config.export_format.options selected=$config.export_format.selected}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-133' replace='true'}</th>
  <td>{grn_select name=$config.export_day.name options=$config.export_day.options selected=$config.export_day.selected}
{grn_select name=$config.export_hour.name options=$config.export_hour.options selected=$config.export_hour.selected}
{grn_select name=$config.export_minute.name options=$config.export_minute.options selected=$config.export_minute.selected}
&nbsp&nbsp<span class="bold"> UTC : ({$config.UTC_day} {$config.UTC_hour} : {$config.UTC_minute})</span>
</td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_system_logging_GRN_SY_LO_134'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-134' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_logging_GRN_SY_LO_134}
  {grn_button_cancel}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
