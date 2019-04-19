{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<p>{cb_msg module='grn.system.license' key='GRN_SY_LI-1' replace='true'}</p>

<form name="{$form_name}" method="post" action="{cb_pageurl page='system/license/command_register'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="key" value="{$key}">

<table class="view_table">
 {foreach from=$license item=data}
 <tr>
  <th nowrap>
     {$data.title|escape}
  </th>
  <td>
     {$data.value|escape}
  </td>
 </tr>
 {/foreach}
</table>
      {capture name='grn_system_license_GRN_SY_LI_2'}{cb_msg module='grn.system.license' key='GRN_SY_LI-2' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_license_GRN_SY_LI_2}
      {grn_button_cancel page='system/license/register'}

</form>
{include file="grn/system_footer.tpl"}
