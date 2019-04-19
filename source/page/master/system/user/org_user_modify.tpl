{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_org_user_modify'}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="poid" value="{$org_id|escape}">
<input type="hidden" name="uid" value="{$user_id|escape}">

{include file="system/user/_user_organization_belong.tpl"}
<div class="explanation"><span class="bold">{grn_user_name uid=$user_id nolink=TRUE}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-653' replace='true'}</div>
<p>
{include file="grn/show_validation_errors.tpl"}
{include file='grn/indispensable.tpl'}
<table class="std_form">
   <!--builtin_items-->
{foreach from=$builtin_items key=item_id item=item}
    {if $item.use && ($item_id == 'display_name' || $item_id == 'foreign_key')}
 <tr valign="top">
  <th nowrap>
        {assign var='necessary' value=$item.necessary}
        {grn_show_input_title title=$item.display_name necessary=$necessary}
  </th>
  <td>
        {assign var='not_modify' value=false}
        {include file='grn/_action_item_modify_contents.tpl'}
        {if $item_id == 'foreign_key'}
        <div class="margin_top"><span class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-654' replace='true'}</span></div>
        {/if}
  </td>
 </tr>
    {/if}
{/foreach}
   <!--builtin_items_end-->
<tr>
<th nowrap>{capture name='grn_system_user_GRN_SY_US_655'}{cb_msg module='grn.system.user' key='GRN_SY_US-655' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_655}</th>
<td>{capture name='grn_system_user_GRN_SY_US_656'}{cb_msg module='grn.system.user' key='GRN_SY_US-656' replace='true'}{/capture}{validate form=$form_name field="password" criteria="grn_isValidPassword" field2="retype" message=$smarty.capture.grn_system_user_GRN_SY_US_656 append="validation_errors"}{grn_password name='password' purpose='modify' size='50' value=$user.password}</td>
</tr>
<tr>
<th nowrap>{capture name='grn_system_user_GRN_SY_US_657'}{cb_msg module='grn.system.user' key='GRN_SY_US-657' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_657}</th>
<td>{grn_password name='retype' purpose='retype' size='50' value=$user.retype}</td>
</tr>

<tr valign="top">
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-691' replace='true'}</th>
  {if $locales_param|@count == 1}{assign var='locales_disabled' value=true}{/if}
  <td>{grn_select name="locale" options=$locales_param disabled=$locales_disabled}</td>
</tr>

<tr valign="top">
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-692' replace='true'}</th>
  {if $bases_param|@count == 1}{assign var='bases_disabled' value=true}{/if}
  <td>{grn_select name="base" options=$bases_param disabled=$bases_disabled}</td>
</tr>

<tr valign="top">
 <th nowrap>{capture name='grn_system_user_GRN_SY_US_658'}{cb_msg module='grn.system.user' key='GRN_SY_US-658' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_658}</th>
 <td>
  <table>
   <tr>
    <td><div id="select_belong_org">
{if $user.group_options}
 {foreach from=$user.groups key=item_id item=item}
     <div>{$item.path|escape}</div>
     <input type="hidden" name="oid[]" value="{$item_id|escape}">
 {/foreach}
{else}
  {cb_msg module='grn.system.user' key='GRN_SY_US-659' replace='true'}
{/if}
    </div></td>
    <td>
     <input type="button" value="{cb_msg module='grn.system.user' key='GRN_SY_US-660' replace='true'}" onclick="popupSelectOrg( this.form );">
    </td>
   </tr>
  </table>
 </td>
</tr>
<tr>
<th nowrap>{capture name='grn_system_user_GRN_SY_US_661'}{cb_msg module='grn.system.user' key='GRN_SY_US-661' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_661}</th>
<td><div id="select_primary_organization">
  <select name="primary_org">
{if $user.group_options}
 {foreach from=$user.group_options key=item_id item=item}
  {if $item.selected}
   <option value="{$item_id|escape}" selected>{$item.label|escape}</option>
  {else}
   <option value="{$item_id|escape}">{$item.label|escape}</option>
  {/if}
 {/foreach}
{else}
   <option value="">{cb_msg module='grn.system.user' key='GRN_SY_US-662' replace='true'}</option>
{/if}
  </select>
 </div>
</td>
</tr>
<tr>
<th nowrap>{capture name='grn_system_user_GRN_SY_US_663'}{cb_msg module='grn.system.user' key='GRN_SY_US-663' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_663}</th>
<td>
{if ! $is_super}
{capture name='grn_system_user_GRN_SY_US_664'}{cb_msg module='grn.system.user' key='GRN_SY_US-664' replace='true'}{/capture}{validate form=$form_name field="position" empty="true" transform="cb_trim" criteria="isInt" message=$smarty.capture.grn_system_user_GRN_SY_US_664 append="validation_errors"}
{capture name='grn_system_user_GRN_SY_US_666'}{cb_msg module='grn.system.user' key='GRN_SY_US-666' replace='true'}{/capture}{validate form=$form_name field="position" empty="true" transform="cb_trim" criteria="isRange" low="0" high=GRN_UUM_USER_MAX_POSITION-1 message=$smarty.capture.grn_system_user_GRN_SY_US_666 append="validation_errors"}
{/if}
{if $user.position < GRN_UUM_USER_MAX_POSITION}
 {capture name='grn_system_user_GRN_SY_US_667'}{cb_msg module='grn.system.user' key='GRN_SY_US-667' replace='true'}{/capture}{grn_text name="position" maxlength="8" size="9" title=$smarty.capture.grn_system_user_GRN_SY_US_667 disable_return_key=true value=$user.position disabled=$is_super}<br>
{else}
 {capture name='grn_system_user_GRN_SY_US_668'}{cb_msg module='grn.system.user' key='GRN_SY_US-668' replace='true'}{/capture}{grn_text name="position" maxlength="8" size="9" title=$smarty.capture.grn_system_user_GRN_SY_US_668 disable_return_key=true}<br>
{/if}
 <div class="br">&nbsp;</div>
 <div class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-669' replace='true'} {cb_msg module='grn.system.user' key='GRN_SY_US-670' replace='true'}..{cb_msg module='grn.system.user' key='GRN_SY_US-671' replace='true'}<br>
{cb_msg module='grn.system.user' key='GRN_SY_US-672' replace='true'}</div>
</td>
</tr>
{if ! $user.valid}{assign var='invalid' value=1}{/if}
<tr>
<th nowrap>{capture name='grn_system_user_GRN_SY_US_673'}{cb_msg module='grn.system.user' key='GRN_SY_US-673' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_673}</th>
<td>
 {capture name='grn_system_user_GRN_SY_US_674'}{cb_msg module='grn.system.user' key='GRN_SY_US-674' replace='true'}{/capture}{grn_checkbox name='invalid' id='invalid_id' value='1' caption=$smarty.capture.grn_system_user_GRN_SY_US_674 checked=$invalid disabled=$is_super}<br>
 <div class="br">&nbsp;</div>
 <div class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-675' replace='true'}</div>
</td>
</tr>
    <!--builtin_items-->
{foreach from=$builtin_items key=item_id item=item}
    {if $item.use &&
        $item_id != 'display_name' &&
        $item_id != 'foreign_key' &&
        $item_id != 'usergroups' &&
        $item_id != 'primary_group' &&
        $item_id != 'attendee' &&
        $item_id != 'locale' &&
        $item_id != 'base' &&
        $item_id != 'display_name_language' &&
        $item_id != 'nickname'}
 <tr valign="top">
  <th nowrap>
        {assign var='necessary' value=$item.necessary}
        {grn_show_input_title title=$item.display_name necessary=$necessary}
  </th>
  <td>
        {assign var='not_modify' value=false}
        {include file='grn/_action_item_modify_contents.tpl'}
  </td>
 </tr>
    {/if}
{/foreach}
   <!--builtin_items_end-->
   <!--exntended_items-->
{foreach from=$extended_items key=item_id item=item}
    {if $item.use}
 <tr valign="top">
  <th nowrap>
        {assign var='necessary' value=$item.necessary}
        {grn_show_input_title title=$item.display_name necessary=$necessary}
  </th>
  <td>
        {assign var='not_modify' value=false}
        {include file='grn/_action_item_modify_contents.tpl'}
  </td>
 </tr>
    {/if}
{/foreach}
   <!--exntended_items_end-->
<tr>
<td></td>
<td>
{capture name='grn_system_user_GRN_SY_US_676'}{cb_msg module='grn.system.user' key='GRN_SY_US-676' replace='true'}{/capture}{grn_button_submit class="margin" button_type="submit" caption=$smarty.capture.grn_system_user_GRN_SY_US_676}
{grn_button_cancel page='system/user/org_user_view' oid=$org_id uid=$user_id}
</td>
</table>

</form>

{include file="grn/system_footer.tpl"}
