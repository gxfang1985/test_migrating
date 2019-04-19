{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_user_column_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="clid" value="{$column.clid}">

<div class="explanation">
{cb_msg module='grn.system.user' key='GRN_SY_US-71' replace='true'}
</div>

<p>
{include file="grn/show_validation_errors.tpl"}
{include file="grn/indispensable.tpl"}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_system_user_GRN_SY_US_72'}{cb_msg module='grn.system.user' key='GRN_SY_US-72' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_72 necessary=$column.is_extension}</th>
{if $column.is_extension}
  <td>{capture name='grn_system_user_GRN_SY_US_73'}{cb_msg module='grn.system.user' key='GRN_SY_US-73' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" message=$smarty.capture.grn_system_user_GRN_SY_US_73 transform="cb_trim" append="validation_errors"}{grn_text name="display_name" size="50" value=$column.display_name}</td>
{else}
  <td>{capture name='grn_system_user_GRN_SY_US_74'}{cb_msg module='grn.system.user' key='GRN_SY_US-74' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" message=$smarty.capture.grn_system_user_GRN_SY_US_74 append="validation_errors"}<input type="hidden" name="display_name" value="{$column.display_name}">{$column.display_name|escape}</td>
{/if}
 </tr>
{if $column.is_extension}
 <tr>
  <th nowrap>{capture name='grn_system_user_GRN_SY_US_75'}{cb_msg module='grn.system.user' key='GRN_SY_US-75' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_75}</th>
  <td>{$column.type|escape}</td>
 </tr>
{/if}
 <tr>
  <th nowrap>{capture name='grn_system_user_GRN_SY_US_76'}{cb_msg module='grn.system.user' key='GRN_SY_US-76' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_76 necessary=$column.is_extension}</th>
{if $column.is_extension}
  <td>{capture name='grn_system_user_GRN_SY_US_77'}{cb_msg module='grn.system.user' key='GRN_SY_US-77' replace='true'}{/capture}{validate form=$form_name field="id" criteria="notEmpty" message=$smarty.capture.grn_system_user_GRN_SY_US_77 transform="cb_trim" append="validation_errors"}{capture name='grn_system_user_GRN_SY_US_78'}{cb_msg module='grn.system.user' key='GRN_SY_US-78' replace='true'}{/capture}{validate form=$form_name field="id" criteria="isRegExp" expression="/^[\da-zA-Z_]+$/" message=$smarty.capture.grn_system_user_GRN_SY_US_78 transform="cb_trim" append="validation_errors"}{grn_text name="id" size="50" value=$column.id}</td>
{else}
  <td>{capture name='grn_system_user_GRN_SY_US_80'}{cb_msg module='grn.system.user' key='GRN_SY_US-80' replace='true'}{/capture}{validate form=$form_name field="id" criteria="notEmpty" message=$smarty.capture.grn_system_user_GRN_SY_US_80 transform="cb_trim" append="validation_errors"}<input type="hidden" name="id" value="{$column.id}">{$column.id|escape}</td>
{/if}
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_system_user_GRN_SY_US_81'}{cb_msg module='grn.system.user' key='GRN_SY_US-81' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_81}</th>
  <td>
  {if $column.use_disabled}{if $column.use}{cb_msg module='grn.system.user' key='GRN_SY_US-82' replace='true'}{else}{cb_msg module='grn.system.user' key='GRN_SY_US-83' replace='true'}{/if}{else}{capture name='grn_system_user_GRN_SY_US_84'}{cb_msg module='grn.system.user' key='GRN_SY_US-84' replace='true'}{/capture}{grn_checkbox name="use" id="use" value="1" caption=$smarty.capture.grn_system_user_GRN_SY_US_84 checked=$column.use}{/if}<br>
  <div class="br">&nbsp;</div>
  <div class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-85' replace='true'}</div>
  </td>
 </tr>
{if $current_type == 'password'}
{assign var='disabled' value=true}
{else}
{assign var='disabled' value=false}
{/if}
 <tr>
  <th nowrap>{capture name='grn_system_user_GRN_SY_US_86'}{cb_msg module='grn.system.user' key='GRN_SY_US-86' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_86}</th>
  <td>{if $column.show_disabled && ! $column.is_extension}
  {if $column.show}{cb_msg module='grn.system.user' key='GRN_SY_US-87' replace='true'}{else}{cb_msg module='grn.system.user' key='GRN_SY_US-88' replace='true'}{/if}
  {else}{capture name='grn_system_user_GRN_SY_US_89'}{cb_msg module='grn.system.user' key='GRN_SY_US-89' replace='true'}{/capture}{grn_checkbox name='show' id='show' value='1' caption=$smarty.capture.grn_system_user_GRN_SY_US_89 checked=$column.show disabled=$column.show_disabled}{/if}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_system_user_GRN_SY_US_90'}{cb_msg module='grn.system.user' key='GRN_SY_US-90' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_90}</th>
  <td>
  {if $column.display_disabled && ! $column.is_extension}
    {if $column.display}{cb_msg module='grn.system.user' key='GRN_SY_US-91' replace='true'}{else}{cb_msg module='grn.system.user' key='GRN_SY_US-92' replace='true'}{/if}
  {else}{capture name='grn_system_user_GRN_SY_US_93'}{cb_msg module='grn.system.user' key='GRN_SY_US-93' replace='true'}{/capture}{grn_checkbox name='display' id='display' value='1' caption=$smarty.capture.grn_system_user_GRN_SY_US_93 checked=$column.display disabled=$column.display_disabled}{/if}<br>
  <div class="br">&nbsp;</div>
  <div class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-94' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_system_user_GRN_SY_US_95'}{cb_msg module='grn.system.user' key='GRN_SY_US-95' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_95}</th>
  <td>{if $column.necessary_disabled && ! $column.is_extension}
  {if $column.necessary}{cb_msg module='grn.system.user' key='GRN_SY_US-96' replace='true'}{else}{cb_msg module='grn.system.user' key='GRN_SY_US-97' replace='true'}{/if}
  {else}{capture name='grn_system_user_GRN_SY_US_98'}{cb_msg module='grn.system.user' key='GRN_SY_US-98' replace='true'}{/capture}{grn_checkbox name="necessary" id="necessary" value="1" caption=$smarty.capture.grn_system_user_GRN_SY_US_98 checked=$column.necessary disabled=$column.necessary_disabled}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_system_user_GRN_SY_US_99'}{cb_msg module='grn.system.user' key='GRN_SY_US-99' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_99}</th>
  <td>{if $column.not_modify_disabled && ! $column.is_extension}
  {if $column.not_modify}{cb_msg module='grn.system.user' key='GRN_SY_US-100' replace='true'}{else}{cb_msg module='grn.system.user' key='GRN_SY_US-101' replace='true'}{/if}
  {else}{capture name='grn_system_user_GRN_SY_US_102'}{cb_msg module='grn.system.user' key='GRN_SY_US-102' replace='true'}{/capture}{grn_checkbox name="not_modify" id="not_modify" value="1" caption=$smarty.capture.grn_system_user_GRN_SY_US_102 checked=$column.not_modify disabled=$column.not_modify_disabled}{/if}</td>
 </tr>

{if $cellular_licensed}
 <tr valign="top">
  <th nowrap>{capture name='grn_system_user_GRN_SY_US_103'}{cb_msg module='grn.system.user' key='GRN_SY_US-103' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_103}</th>
  <td>
  {if $column.cellular_disabled && ! $column.is_extension}
  {if $column.cellular}{cb_msg module='grn.system.user' key='GRN_SY_US-104' replace='true'}{else}{cb_msg module='grn.system.user' key='GRN_SY_US-105' replace='true'}{/if}
  {else}{capture name='grn_system_user_GRN_SY_US_106'}{cb_msg module='grn.system.user' key='GRN_SY_US-106' replace='true'}{/capture}{grn_checkbox name="cellular" id="cellular" value="1" caption=$smarty.capture.grn_system_user_GRN_SY_US_106 checked=$column.cellular disabled=$column.cellular_disabled}{/if}<br>
  <div class="br">&nbsp;</div>
  <div class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-107' replace='true'}</div>
  </td>
 </tr>
{/if}
 <tr>
  <th nowrap>{capture name='grn_system_user_GRN_SY_US_701'}{cb_msg module='grn.system.user' key='GRN_SY_US-701' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_701}</th>
  <td>
   {if $column.search_disabled && ! $column.is_extension}
    {if $column.search}{cb_msg module='grn.system.user' key='GRN_SY_US-702' replace='true'}{else}{cb_msg module='grn.system.user' key='GRN_SY_US-703' replace='true'}{/if}
   {else}
    {capture name='grn_system_user_GRN_SY_US_702'}{cb_msg module='grn.system.user' key='GRN_SY_US-702' replace='true'}{/capture}{grn_checkbox name='search' id='search' value='1' caption=$smarty.capture.grn_system_user_GRN_SY_US_702 checked=$column.search disabled=$column.search_disabled}
   {/if}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_system_user_GRN_SY_US_108'}{cb_msg module='grn.system.user' key='GRN_SY_US-108' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_108 necessary=false}</th>
   <td>
{if $issso}
   {grn_select name='sso' options=$sso_options}
{else}
   {cb_msg module='grn.system.user' key='GRN_SY_US-109' replace='true'}<input type="hidden" name="sso" value="0">
{/if}<br>
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-110' replace='true'}</div>
   </td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_system_user_GRN_SY_US_111'}{cb_msg module='grn.system.user' key='GRN_SY_US-111' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_111}
  {grn_button_cancel page='system/user/user_column_view' clid=$column.clid}
  </td>
 </tr>
</table>

</form>

{include file="grn/system_footer.tpl"}
