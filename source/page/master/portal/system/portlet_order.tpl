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
 {capture name='grn_portal_system_GRN_POT_SY_448'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-448' replace='true'}{/capture}{assign var='position_name' value=$smarty.capture.grn_portal_system_GRN_POT_SY_448}
{elseif $position == 'left'}
 {capture name='grn_portal_system_GRN_POT_SY_449'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-449' replace='true'}{/capture}{assign var='position_name' value=$smarty.capture.grn_portal_system_GRN_POT_SY_449}
{elseif $position == 'center'}
 {capture name='grn_portal_system_GRN_POT_SY_450'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-450' replace='true'}{/capture}{assign var='position_name' value=$smarty.capture.grn_portal_system_GRN_POT_SY_450}
{elseif $position == 'right'}
 {capture name='grn_portal_system_GRN_POT_SY_451'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-451' replace='true'}{/capture}{assign var='position_name' value=$smarty.capture.grn_portal_system_GRN_POT_SY_451}
{/if}

<div class="sub_title">{grn_image image='portal20.gif'}{$portal.name|escape}&nbsp;{$position_name}{cb_msg module='grn.portal.system' key='GRN_POT_SY-452' replace='true'}</div>
   {grn_change_order form_name=$form_name select_name='plid[]' options=$portlet_options}
  <!----->
 </div>
 <!--action_end--->
</div>
<p>
 {capture name='grn_portal_system_GRN_POT_SY_453'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-453' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_453 onclick="grn_onsubmit_common(this.form);"}
 {grn_button_cancel}
</p>
</form>
{include file='grn/system_footer.tpl'}
