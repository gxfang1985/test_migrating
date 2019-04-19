{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$title_of_grn_title class=$page_info.parts[0]}
{if $is_sandbox_page}{include file="system/user/sandbox/_sandbox_title_label.tpl"}{/if}

{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page="$dir_name/command_"|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="oid" value="{$org_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.system.user' key='GRN_SY_US-516' replace='true'}<span class="bold">{grn_sentence image='organize20.gif' caption=$org.name}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-517' replace='true'}
{if !$is_admin}
<br>{cb_msg module='grn.system.user' key='GRN_SY_US-518' replace='true'}<span class="bold">{grn_image image='organize20.gif'}{cb_msg module='grn.system.user' key='GRN_SY_US-519' replace='true'}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-520' replace='true'}
{/if}
</div>

<p>
<table class="std_form">
<!--
<tr>
<th>{cb_msg module='grn.system.user' key='GRN_SY_US-521' replace='true'}</th>
<td>{$org.name|escape}</td>
</tr>
-->
<tr valign="top">
<th>{cb_msg module='grn.system.user' key='GRN_SY_US-522' replace='true'}</th>
<td>
<div class="input_box">
{if $parent.oid}
<div class="hilight">
<span class="m_small">
{grn_image image='organize20.gif'}
{capture name='grn_system_user_GRN_SY_US_523'}{cb_msg module='grn.system.user' key='GRN_SY_US-523' replace='true'}{/capture}{grn_link page="$dir_name/org_parent_modify" oid=$org_id poid='0' caption=$smarty.capture.grn_system_user_GRN_SY_US_523} &gt;
 {foreach from=$parent.ancestors item=item}
{grn_link page="$dir_name/org_parent_modify" oid=$org_id poid=$item.oid caption=$item.name} &gt;
 {/foreach}
{$parent.name|escape}
</span>
</div>
<hr size="1">
<div>
<small>
{capture name='grn_system_user_GRN_SY_US_524'}{cb_msg module='grn.system.user' key='GRN_SY_US-524' replace='true'}{/capture}{grn_link image='organize20.gif' page="$dir_name/org_parent_modify" oid=$org_id poid=$parent.parent.oid caption=$smarty.capture.grn_system_user_GRN_SY_US_524}
</small>
</div>
{else}
<div class="hilight">
<span class="m_small">
{grn_image image='organize20.gif'}{cb_msg module='grn.system.user' key='GRN_SY_US-525' replace='true'}
</span>
</div>
<hr size="1">
{/if}
{if $parent.child_count}
<br>
<div class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-526' replace='true'}</div>
<small>
 {foreach from=$parent.children key=key item=item}
  {if $key == $org_id}{assign var='disabled' value=1}{else}{assign var='disabled' value=0}{/if}
{grn_link image='organize20.gif' page="$dir_name/org_parent_modify" oid=$org_id poid=$key caption=$item.name disabled=$disabled}&nbsp;
 {/foreach}
</small>
</div>
{/if}
</td>
</tr>
<tr>
<td></td>
<td>
{if $is_admin || $poid}
{capture name='grn_system_user_GRN_SY_US_527'}{cb_msg module='grn.system.user' key='GRN_SY_US-527' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_527}
{grn_button_cancel page="$dir_name/org_view" oid=$org_id}
{/if}
</td>
</tr>
</table>

</form>

{include file="grn/system_footer.tpl"}
