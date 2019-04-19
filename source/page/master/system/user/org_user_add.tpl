{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_org_user_add'}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="poid" value="{$org_id|escape}">
<div class="explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-115' replace='true'}</div>

{include file="system/user/_user_organization_belong.tpl"}
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
        <div class="margin_top"><span class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-116' replace='true'}</span></div>
        {/if}
  </td>
 </tr>
    {/if}
{/foreach}

<tr>
<th nowrap>{capture name='grn_system_user_GRN_SY_US_117'}{cb_msg module='grn.system.user' key='GRN_SY_US-117' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_117}</th>
<td>{capture name='grn_system_user_GRN_SY_US_118'}{cb_msg module='grn.system.user' key='GRN_SY_US-118' replace='true'}{/capture}{validate form=$form_name field="password" criteria="grn_isValidPassword" field2="retype" message=$smarty.capture.grn_system_user_GRN_SY_US_118 append="validation_errors"}{grn_password name='password' purpose='init' size='50' value=$user.password disable_return_key=true}</td>
</tr>
<tr>
<th nowrap>{capture name='grn_system_user_GRN_SY_US_119'}{cb_msg module='grn.system.user' key='GRN_SY_US-119' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_119}</th>
<td>{grn_password name='retype' purpose='init' size='50' disable_return_key=true}</td>
</tr>

<tr valign="top">
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-691' replace='true'}</th>
  {if $locales_param|@count == 1}{assign var='locales_disabled' value=true}<input type="hidden" name="locale" value="">{/if}
  <td>{grn_select name="locale" options=$locales_param disabled=$locales_disabled}</td>
</tr>

<tr valign="top">
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-692' replace='true'}</th>
  {if $bases_param|@count == 1}{assign var='bases_disabled' value=true}{/if}
  <td>{grn_select name="base" options=$bases_param disabled=$bases_disabled}</td>
</tr>

<tr valign="top">
 <th nowrap>{capture name='grn_system_user_GRN_SY_US_120'}{cb_msg module='grn.system.user' key='GRN_SY_US-120' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_120}</th>
 <td>
  <table>
   <tr>
    <td><div id="select_belong_org">
{if $current_org}
 {foreach from=$current_org key=item_id item=item}
     <div>{$item.fullpath|escape}</div>
     <input type="hidden" name="oid[]" value="{$item_id|escape}">
 {/foreach}
{elseif $org_id == -1 or $org_id == -2}
  {cb_msg module='grn.system.user' key='GRN_SY_US-121' replace='true'}
{elseif $org_id}
     <div>{$org_fullpath|escape}</div>
     <input type="hidden" name="oid[]" value="{$org_id|escape}">
{/if}
    </div></td>
    <td>
     <input type="button" value="{cb_msg module='grn.system.user' key='GRN_SY_US-122' replace='true'}" onclick="popupSelectOrg( this.form );">
    </td>
   </tr>
  </table>
 </td>
</tr>
<tr valign="top">
 <th nowrap>{capture name='grn_system_user_GRN_SY_US_123'}{cb_msg module='grn.system.user' key='GRN_SY_US-123' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_123}</th>
 <td><div id="select_primary_organization">
  <select name="primary_org">
{if $current_org}
 {foreach from=$current_org key=item_id item=item}
  {if $primary_group == $item_id}
   <option value="{$item_id|escape}" selected>{grn_organize_name gid=$item_id noimage=1}&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-124' replace='true'}{$item.fullpath|escape}{cb_msg module='grn.system.user' key='GRN_SY_US-125' replace='true'}</option>
  {else}
   <option value="{$item_id|escape}">{grn_organize_name gid=$item_id noimage=1}&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-126' replace='true'}{$item.fullpath|escape}{cb_msg module='grn.system.user' key='GRN_SY_US-127' replace='true'}</option>
  {/if}
 {/foreach}
{elseif $org_id == -1 or $org_id == -2}
   <option value="">{cb_msg module='grn.system.user' key='GRN_SY_US-128' replace='true'}</option>
{elseif $org_id}
   <option value="{$org_id|escape}">{grn_organize_name gid=$org_id noimage=1}&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-129' replace='true'}{$org_fullpath|escape}{cb_msg module='grn.system.user' key='GRN_SY_US-130' replace='true'}</option>
{else}
   <option value="">{cb_msg module='grn.system.user' key='GRN_SY_US-131' replace='true'}</option>
{/if}
  </select>
 </div></td>
</tr>

<tr>
<th nowrap>{capture name='grn_system_user_GRN_SY_US_132'}{cb_msg module='grn.system.user' key='GRN_SY_US-132' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_132}</th>
<td>
{if ! $is_super}
{capture name='grn_system_user_GRN_SY_US_133'}{cb_msg module='grn.system.user' key='GRN_SY_US-133' replace='true'}{/capture}{validate form=$form_name field="position" empty="true" transform="cb_trim" criteria="isInt" message=$smarty.capture.grn_system_user_GRN_SY_US_133 append="validation_errors"}
{capture name='grn_system_user_GRN_SY_US_135'}{cb_msg module='grn.system.user' key='GRN_SY_US-135' replace='true'}{/capture}{validate form=$form_name field="position" empty="true" transform="cb_trim" criteria="isRange" low="0" high=GRN_UUM_USER_MAX_POSITION-1 message=$smarty.capture.grn_system_user_GRN_SY_US_135 append="validation_errors"}
{/if}
{if $position < GRN_UUM_USER_MAX_POSITION}
 {capture name='grn_system_user_GRN_SY_US_136'}{cb_msg module='grn.system.user' key='GRN_SY_US-136' replace='true'}{/capture}{grn_text name="position" maxlength="8" size="9" title=$smarty.capture.grn_system_user_GRN_SY_US_136 disable_return_key=true value=$user.position disabled=$is_super}<br>
{else}
 {capture name='grn_system_user_GRN_SY_US_137'}{cb_msg module='grn.system.user' key='GRN_SY_US-137' replace='true'}{/capture}{grn_text name="position" maxlength="8" size="9" title=$smarty.capture.grn_system_user_GRN_SY_US_137 disable_return_key=true}<br>
{/if}
 <div class="br">&nbsp;</div>
 <div class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-138' replace='true'} {cb_msg module='grn.system.user' key='GRN_SY_US-139' replace='true'}..{cb_msg module='grn.system.user' key='GRN_SY_US-140' replace='true'}<br>
{cb_msg module='grn.system.user' key='GRN_SY_US-141' replace='true'}</div>
</td>
</tr>
{if ! $user.valid}{assign var='invalid' value=1}{/if}
<tr>
<th nowrap>{capture name='grn_system_user_GRN_SY_US_142'}{cb_msg module='grn.system.user' key='GRN_SY_US-142' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_142}</th>
<td>
 {capture name='grn_system_user_GRN_SY_US_143'}{cb_msg module='grn.system.user' key='GRN_SY_US-143' replace='true'}{/capture}{grn_checkbox name='invalid' id='invalid_id' value='1' caption=$smarty.capture.grn_system_user_GRN_SY_US_143 checked=$invalid disabled=$is_super}<br>
 <div class="br">&nbsp;</div>
 <div class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-144' replace='true'}</div>
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
{capture name='grn_system_user_GRN_SY_US_145'}{cb_msg module='grn.system.user' key='GRN_SY_US-145' replace='true'}{/capture}{grn_button_submit class="margin" button_type="submit" caption=$smarty.capture.grn_system_user_GRN_SY_US_145 id="system-add-user-submit"}
{grn_button_cancel page='system/user/org_list' oid=$org_id id='system-user-add-cancel'}
</td>
</table>

</form>

{include file="grn/system_footer.tpl"}
