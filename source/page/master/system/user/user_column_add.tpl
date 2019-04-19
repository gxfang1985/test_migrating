{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_user_column_add'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">
{cb_msg module='grn.system.user' key='GRN_SY_US-26' replace='true'}<br>
{cb_msg module='grn.system.user' key='GRN_SY_US-27' replace='true'}
</div>

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
<tr>
<th nowrap>{capture name='grn_system_user_GRN_SY_US_28'}{cb_msg module='grn.system.user' key='GRN_SY_US-28' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_28 necessary=TRUE}</th>
<td>{capture name='grn_system_user_GRN_SY_US_29'}{cb_msg module='grn.system.user' key='GRN_SY_US-29' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" message=$smarty.capture.grn_system_user_GRN_SY_US_29 transform="cb_trim" append="validation_errors"}{grn_text necessary=true name="display_name" size="50" value=$display_name disable_return_key=true}</td>
</tr>
<tr>
<th nowrap>{capture name='grn_system_user_GRN_SY_US_30'}{cb_msg module='grn.system.user' key='GRN_SY_US-30' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_30}</th>
<td>
{capture name='page_path'}{grn_pageurl page='system/user/user_column_add'}{/capture}
{assign var='page_path' value=$smarty.capture.page_path}
{grn_select name='type' options=$types onchange="form.action='$page_path';form.submit();"}
</td>
</tr>
<tr>
<th nowrap>{capture name='grn_system_user_GRN_SY_US_31'}{cb_msg module='grn.system.user' key='GRN_SY_US-31' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_31 necessary=TRUE}</th>
<td>{capture name='grn_system_user_GRN_SY_US_32'}{cb_msg module='grn.system.user' key='GRN_SY_US-32' replace='true'}{/capture}{validate form=$form_name field="id" criteria="notEmpty" message=$smarty.capture.grn_system_user_GRN_SY_US_32 transform="cb_trim" append="validation_errors"}{capture name='grn_system_user_GRN_SY_US_33'}{cb_msg module='grn.system.user' key='GRN_SY_US-33' replace='true'}{/capture}{validate form=$form_name field="id" criteria="isRegExp" expression="/^[\da-zA-Z_]+$/" message=$smarty.capture.grn_system_user_GRN_SY_US_33 transform="cb_trim" append="validation_errors"}{grn_text name="id" size="50" value=$id disable_return_key=true}</td>
</tr>
<tr valign="top">
<th nowrap>{capture name='grn_system_user_GRN_SY_US_35'}{cb_msg module='grn.system.user' key='GRN_SY_US-35' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_35}</th>
<td>
{if 1 == $use}{assign var='checked' value=true}{else}{assign var='checked' value=false}{/if}{capture name='grn_system_user_GRN_SY_US_36'}{cb_msg module='grn.system.user' key='GRN_SY_US-36' replace='true'}{/capture}{grn_checkbox name="use" id="use" value="1" caption=$smarty.capture.grn_system_user_GRN_SY_US_36 checked=$checked}<br>
<div class="br">&nbsp;</div>
<div class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-37' replace='true'}</div>
</td>
</tr>
{if $current_type == 'password'}
{* {assign var='disabled' value=true} *}
{else}
{assign var='disabled' value=false}
{/if}
<tr>
<th nowrap>{capture name='grn_system_user_GRN_SY_US_38'}{cb_msg module='grn.system.user' key='GRN_SY_US-38' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_38}</th>
<td>{if 1 == $show && !$show_disabled}{assign var='checked' value=true}{else}{assign var='checked' value=false}{/if}{capture name='grn_system_user_GRN_SY_US_39'}{cb_msg module='grn.system.user' key='GRN_SY_US-39' replace='true'}{/capture}{grn_checkbox name="show" id="show" value="1" caption=$smarty.capture.grn_system_user_GRN_SY_US_39 checked=$checked disabled=$show_disabled}</td>
</tr>
<tr valign="top">
<th nowrap>{capture name='grn_system_user_GRN_SY_US_40'}{cb_msg module='grn.system.user' key='GRN_SY_US-40' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_40}</th>
<td>
{if 1 == $display && !$display_disabled}{assign var='checked' value=true}{else}{assign var='checked' value=false}{/if}{capture name='grn_system_user_GRN_SY_US_41'}{cb_msg module='grn.system.user' key='GRN_SY_US-41' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_system_user_GRN_SY_US_41 name='display' id='display' value='1' checked=$checked disabled=$display_disabled}<br>
<div class="br">&nbsp;</div>
<div class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-42' replace='true'}</div>
</td>
</tr>
<tr>
<th nowrap>{capture name='grn_system_user_GRN_SY_US_43'}{cb_msg module='grn.system.user' key='GRN_SY_US-43' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_43}</th>
<td>{if 1 == $necessary}{assign var='checked' value=true}{else}{assign var='checked' value=false}{/if}{capture name='grn_system_user_GRN_SY_US_44'}{cb_msg module='grn.system.user' key='GRN_SY_US-44' replace='true'}{/capture}{grn_checkbox name="necessary" id="necessary" value="1" caption=$smarty.capture.grn_system_user_GRN_SY_US_44 checked=$checked disabled=$necessary_disabled}</td>
</tr>
<tr>
<th nowrap>{capture name='grn_system_user_GRN_SY_US_45'}{cb_msg module='grn.system.user' key='GRN_SY_US-45' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_45}</th>
<td>{if 1 == $not_modify}{assign var='checked' value=true}{else}{assign var='checked' value=false}{/if}{capture name='grn_system_user_GRN_SY_US_46'}{cb_msg module='grn.system.user' key='GRN_SY_US-46' replace='true'}{/capture}{grn_checkbox name="not_modify" id="not_modify" value="1" caption=$smarty.capture.grn_system_user_GRN_SY_US_46 checked=$checked disabled=$not_modify_disabled}</td>
</tr>
{if $cellular_license}
<tr valign="top">
<th nowrap>{capture name='grn_system_user_GRN_SY_US_47'}{cb_msg module='grn.system.user' key='GRN_SY_US-47' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_47}</th>
<td>{if 1 == $cellular}{assign var='checked' value=true}{else}{assign var='checked' value=false}{/if}{capture name='grn_system_user_GRN_SY_US_48'}{cb_msg module='grn.system.user' key='GRN_SY_US-48' replace='true'}{/capture}{grn_checkbox name="cellular" id="cellular" value="1" caption=$smarty.capture.grn_system_user_GRN_SY_US_48 checked=$checked disabled=$cellular_disabled}<br>
  <div class="br">&nbsp;</div>
  <div class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-49' replace='true'}</div></td>
</tr>
{/if}
<tr valign="top">
 <th nowrap>{capture name='grn_system_user_GRN_SY_US_701'}{cb_msg module='grn.system.user' key='GRN_SY_US-701' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_701}</th>
 <td>{if 1 == $search}{assign var='checked' value=true}{else}{assign var='checked' value=false}{/if}{capture name='grn_system_user_GRN_SY_US_702'}{cb_msg module='grn.system.user' key='GRN_SY_US-702' replace='true'}{/capture}{grn_checkbox name="search" id="search" value="1" caption=$smarty.capture.grn_system_user_GRN_SY_US_702 checked=$checked disabled=$search_disabled}<br>
 </td>
</tr>
<tr valign="top">
<th nowrap>{capture name='grn_system_user_GRN_SY_US_50'}{cb_msg module='grn.system.user' key='GRN_SY_US-50' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_50 necessary=false}</th>
<td>
{if $issso}
 {grn_select name='sso' options=$sso_options}
{else}
 {cb_msg module='grn.system.user' key='GRN_SY_US-51' replace='true'}<input type="hidden" name="sso" value="0">
{/if}<br>
<div class="br">&nbsp;</div>
<div class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-52' replace='true'}</div>
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_system_user_GRN_SY_US_53'}{cb_msg module='grn.system.user' key='GRN_SY_US-53' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_53}
{grn_button_cancel page='system/user/user_column_list'}
</td>
</tr>
</table>

</form>

{include file="grn/system_footer.tpl"}
