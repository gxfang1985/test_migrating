{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="pid" value="{$portal_id|escape}">
<input type="hidden" name="position" value="{$position|escape}">
<div id="one_parts">
 <div id="action">
  <!----->
{if $position == 'top'}
 {capture name='grn_portal_system_GRN_POT_SY_44'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-44' replace='true'}{/capture}{assign var='position_name' value=$smarty.capture.grn_portal_system_GRN_POT_SY_44}
{elseif $position == 'left'}
 {capture name='grn_portal_system_GRN_POT_SY_45'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-45' replace='true'}{/capture}{assign var='position_name' value=$smarty.capture.grn_portal_system_GRN_POT_SY_45}
{elseif $position == 'center'}
 {capture name='grn_portal_system_GRN_POT_SY_46'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-46' replace='true'}{/capture}{assign var='position_name' value=$smarty.capture.grn_portal_system_GRN_POT_SY_46}
{elseif $position == 'right'}
 {capture name='grn_portal_system_GRN_POT_SY_47'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-47' replace='true'}{/capture}{assign var='position_name' value=$smarty.capture.grn_portal_system_GRN_POT_SY_47}
{/if}

<div class="sub_title">{$position_name}{cb_msg module='grn.portal.system' key='GRN_POT_SY-48' replace='true'}</div>
   {grn_change_order form_name=$form_name select_name='plid[]' options=$portlet_options}
  <!----->
 </div>
 <!--action_end--->
</div>
<p>
 {capture name='grn_portal_system_GRN_POT_SY_49'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-49' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_49 onclick="grn_onsubmit_common(this.form);"}
 {grn_button_cancel}
</p>
</form>
{include file='grn/system_footer.tpl'}
