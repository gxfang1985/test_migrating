{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">
{cb_msg module='grn.portal.system' key='GRN_POT_SY-197' replace='true'}<span class="bold">{grn_image image='portlet20.gif'}{if $portlet.name}{$portlet.name|escape}{else}{$portlet.title|escape}{/if}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-198' replace='true'}
</div>

<p>
<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-199' replace='true'}
  </th>
  <td>
{assign var="selected_`$position`" value='selected'}
       <select name="position">
{if $position_info.top}
       <option value="top" {$selected_top}>{cb_msg module='grn.portal.system' key='GRN_POT_SY-200' replace='true'}</option>
{/if}
{if $position_info.left}
       <option value="left" {$selected_left}>{cb_msg module='grn.portal.system' key='GRN_POT_SY-201' replace='true'}</option>
{/if}
{if $position_info.center}
       <option value="center" {$selected_center}>{cb_msg module='grn.portal.system' key='GRN_POT_SY-202' replace='true'}</option>
{/if}
{if $position_info.right}
       <option value="right" {$selected_right}>{cb_msg module='grn.portal.system' key='GRN_POT_SY-203' replace='true'}</option>
{/if}
       </select>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_portal_system_GRN_POT_SY_204'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-204' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_204}
       {grn_button_cancel}
  </td>
 </tr>
</table>

 <input type="hidden" name="pid" value="{$portlet.pid}">
 <input type="hidden" name="plid" value="{$portlet.plid}">
 <input type="hidden" name="ppid" value="{$portlet.ppid}">
</form>

{include file='grn/system_footer.tpl'}
