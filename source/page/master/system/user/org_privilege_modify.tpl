{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="oid" value="{$node.id|escape}">
<input type="hidden" name="itype" value="{$item.type|escape}">
<input type="hidden" name="itid" value="{$item.tid|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<div class="explanation">
{cb_msg module='grn.system.user' key='GRN_SY_US-305' replace='true'}<span class="bold">{grn_image image='organize20.gif'}{$node.name|escape}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-306' replace='true'}
{cb_msg module='grn.system.user' key='GRN_SY_US-307' replace='true'}
</div>

<p>
<table class="std_form">
<tr>
<th>{cb_msg module='grn.system.user' key='GRN_SY_US-308' replace='true'}</th>
<td>
{if $item.type == 'user'}
 {grn_user_name uid=$item.tid}
{elseif $item.type == 'group'}
 {grn_organize_name gid=$item.tid}
{elseif $item.type == 'static_role'}
 {grn_image image='role20.gif'}{grn_role_name rid=$item.tid}
{elseif $item.type == 'dynamic_role'}
 {grn_image image='role20.gif'}{$item.tid|escape}
{/if}
</td>
</tr>
<tr>
<th>{cb_msg module='grn.system.user' key='GRN_SY_US-309' replace='true'}</th>
<td>
{capture name='grn_system_user_GRN_SY_US_310'}{cb_msg module='grn.system.user' key='GRN_SY_US-310' replace='true'}{/capture}{grn_checkbox name='authority_transferable'    id='authority_transferable'    value='1' checked=$item.transferable caption=$smarty.capture.grn_system_user_GRN_SY_US_310}
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_system_user_GRN_SY_US_311'}{cb_msg module='grn.system.user' key='GRN_SY_US-311' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_311}
{grn_button_cancel}
</td>
</tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
