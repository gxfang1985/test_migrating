{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$title_of_grn_title class=$page_info.parts[0]}
{if $is_sandbox_page}{include file="system/user/sandbox/_sandbox_title_label.tpl"}{/if}

<form name="{$form_name}" method="post" action="{grn_pageurl page="$dir_name/command_"|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="oid" value="{$org_id|escape}">
<input type="hidden" name="uid" value="{$user_id|escape}">

<div class="explanation">
{cb_msg module='grn.system.user' key='GRN_SY_US-681' replace='true'}<span class="bold">{grn_user_name uid=$user_id nolink=TRUE is_sandbox_page=$is_sandbox_page}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-682' replace='true'}
</div>

<p>
<table class="std_form">
<tr valign="top">
<th>{cb_msg module='grn.system.user' key='GRN_SY_US-683' replace='true'}</th>
<td>
{foreach from=$role_list key=key item=item}
{if GRN_UUM_ADMINISTRATION_USER == $user_id}
{if 'Administrators' == $item.foreign_key}
{assign var='disabled' value=1}
{else}
{assign var='disabled' value=0}
{/if}
{/if}
{grn_checkbox name='rid[]' id="rid_`$key`" value=$key caption=$item.foreign_key checked=$item.selected disabled=$disabled}<br>
{/foreach}
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_system_user_GRN_SY_US_684'}{cb_msg module='grn.system.user' key='GRN_SY_US-684' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_684}
{grn_button_cancel class="margin"}
</td>
</tr>
</table>

</form>

{include file="grn/system_footer.tpl"}
