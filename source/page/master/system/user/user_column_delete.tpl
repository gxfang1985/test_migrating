{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value="user_modify"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_user_column_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
  {cb_msg module='grn.system.user' key='GRN_SY_US-645' replace='true'}<span class="bold">{$clname|escape}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-646' replace='true'}<br>
  {cb_msg module='grn.system.user' key='GRN_SY_US-647' replace='true'}
 </p>
 <p>
  {capture name='grn_system_user_GRN_SY_US_648'}{cb_msg module='grn.system.user' key='GRN_SY_US-648' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_648}
  {capture name='grn_system_user_GRN_SY_US_649'}{cb_msg module='grn.system.user' key='GRN_SY_US-649' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_649}
 </p>
<input type="hidden" name="clid" value="{$clid}">
</form>
{include file="grn/system_footer.tpl"}
