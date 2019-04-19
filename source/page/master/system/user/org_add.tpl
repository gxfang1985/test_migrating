{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$title_of_grn_title class=$page_info.parts[0]}
{if $is_sandbox_page}{include file="system/user/sandbox/_sandbox_title_label.tpl"}{/if}

<form name="{$form_name}" method="post" action="{grn_pageurl page="$dir_name/command_"|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-398' replace='true'}</div>

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
<tr>
<th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-399' replace='true'}</th>
<td>{grn_organization_name organization_id=$org_id is_sandbox_page=$is_sandbox_page}</td>
</tr>
<tr>
<th nowrap>{capture name='grn_system_user_GRN_SY_US_400'}{cb_msg module='grn.system.user' key='GRN_SY_US-400' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_400}</th>
<td>
    {capture name='grn_system_user_GRN_SY_US_401'}{cb_msg module='grn.system.user' key='GRN_SY_US-401' replace='true'}{/capture}
    {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_system_user_GRN_SY_US_401 values=$multiLanguageInfoArray.values}
</td>
</tr>
<tr valign="top">
<th nowrap>{capture name='grn_system_user_GRN_SY_US_402'}{cb_msg module='grn.system.user' key='GRN_SY_US-402' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_402 necessary=TRUE}</th>
<td>
{capture name='grn_system_user_GRN_SY_US_403'}{cb_msg module='grn.system.user' key='GRN_SY_US-403' replace='true'}{/capture}{validate form=$form_name field="code" criteria="notEmpty" message=$smarty.capture.grn_system_user_GRN_SY_US_403 append="validation_errors"}
{grn_text necessary=true name="code" value=$code size="50" disable_return_key=true}
<div class="br">&nbsp;</div>
<div class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-404' replace='true'}
<a href="javascript:popupWin('{grn_pageurl page="$dir_name/org_code"}','org_code',800,600,0,0,0,1,0,1.1)">{cb_msg module='grn.system.user' key='GRN_SY_US-405' replace='true'}</a></div>
</td>
</tr>
<tr valign="top">
<th nowrap>{capture name='grn_system_user_GRN_SY_US_406'}{cb_msg module='grn.system.user' key='GRN_SY_US-406' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_406}</th>
<td>{grn_textarea name="memo" value=$memo rows="5"}</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_system_user_GRN_SY_US_407'}{cb_msg module='grn.system.user' key='GRN_SY_US-407' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_407 id='system-org-add-submit'}
{grn_button_cancel page="$dir_name/org_list" oid=$org_id}
</td>
</table>
<input type="hidden" name="oid" value="{$org_id}">
</form>

{include file="grn/system_footer.tpl"}
