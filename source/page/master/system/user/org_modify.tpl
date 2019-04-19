{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$title_of_grn_title class=$page_info.parts[0]}
{if $is_sandbox_page}{include file="system/user/sandbox/_sandbox_title_label.tpl"}{/if}

<form name="{$form_name}" method="post" action="{grn_pageurl page="$dir_name/command_"|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="oid" value="{$org_id|escape}">

<p><div class="explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-633' replace='true'}</div></p>

{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
<tr>
<th>{capture name='grn_system_user_GRN_SY_US_634'}{cb_msg module='grn.system.user' key='GRN_SY_US-634' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_634}</th>
<td>
{capture name='grn_system_user_GRN_SY_US_635'}{cb_msg module='grn.system.user' key='GRN_SY_US-635' replace='true'}{/capture}
{grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_system_user_GRN_SY_US_635 values=$multiLanguageInfoArray.values}
</td>
</tr>
<tr valign="top">
<th>{capture name='grn_system_user_GRN_SY_US_636'}{cb_msg module='grn.system.user' key='GRN_SY_US-636' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_636 necessary=TRUE}</th>
<td>
{capture name='grn_system_user_GRN_SY_US_637'}{cb_msg module='grn.system.user' key='GRN_SY_US-637' replace='true'}{/capture}{validate form=$form_name field="code" criteria="notEmpty" message=$smarty.capture.grn_system_user_GRN_SY_US_637 append="validation_errors"}
{grn_text necessary=true name="code" value=$org.foreign_key size="50"  disable_return_key=true}
<div class="br">&nbsp;</div>
<div class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-638' replace='true'}<a href="javascript:popupWin('{grn_pageurl page="$dir_name/org_code"}','org_code',800,600,0,0,0,1,0,1.1)">{cb_msg module='grn.system.user' key='GRN_SY_US-639' replace='true'}</a></div>
</td>
</tr>
<tr valign="top">
<th>{cb_msg module='grn.system.user' key='GRN_SY_US-640' replace='true'}</th>
<td>
{cb_msg module='grn.system.user' key='GRN_SY_US-641' replace='true'}{if $org.parent} > {/if}{$org.parent.path|replace:'>':' > '|escape}<br>
<div class="br">&nbsp;</div>
<div class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-642' replace='true'}</div>
</td>
</tr>
<tr valign="top">
<th>{capture name='grn_system_user_GRN_SY_US_643'}{cb_msg module='grn.system.user' key='GRN_SY_US-643' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_643}</th>
<td>{grn_textarea name="memo" value=$org.description rows="5"}</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_system_user_GRN_SY_US_644'}{cb_msg module='grn.system.user' key='GRN_SY_US-644' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_644}
{grn_button_cancel page="$dir_name/org_view" oid=$org_id}
</td>
</tr>
</table>

</form>

{include file="grn/system_footer.tpl"}
