{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-219' replace='true'}</th>
   <td>
   {if $organization_id == 0}
   {cb_msg module='grn.portal.system' key='GRN_POT_SY-220' replace='true'}
   {else}
    {grn_organize_name gid=$organization_id}
   {/if}
   </td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-221' replace='true'}</th>
  <td>
     <select name="s_pid" size="10" class="select_multiple_display_grn">
{foreach from=$portal item=portal}
      <option value="{$portal.pid}"{if $portal.pid == $set_portal.pid} selected{/if}>{$portal.title|escape}</option>
{/foreach}
      <option value=""{if ! $set_portal.pid} selected{/if}>{cb_msg module='grn.portal.system' key='GRN_POT_SY-222' replace='true'}</option>
     </select>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
 {capture name='grn_portal_system_GRN_POT_SY_223'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-223' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_223 onclick="grn_onsubmit_common(this.form);"}
 {grn_button_cancel}
  </td>
 </tr>
</table>

<input type="hidden" name="oid" value="{$organization_id}">
</form>
{include file='grn/system_footer.tpl'}
