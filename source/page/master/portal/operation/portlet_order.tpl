{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="pid" value="{$portal_id|escape}">
<input type="hidden" name="position" value="{$position|escape}">
<div id="one_parts">
 <div id="action">
  <!----->
{if $position == 'top'}
 {capture name='grn_portal_operation_GRN_POT_OP_188'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-188' replace='true'}{/capture}{assign var='position_name' value=$smarty.capture.grn_portal_operation_GRN_POT_OP_188}
{elseif $position == 'left'}
 {capture name='grn_portal_operation_GRN_POT_OP_189'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-189' replace='true'}{/capture}{assign var='position_name' value=$smarty.capture.grn_portal_operation_GRN_POT_OP_189}
{elseif $position == 'center'}
 {capture name='grn_portal_operation_GRN_POT_OP_190'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-190' replace='true'}{/capture}{assign var='position_name' value=$smarty.capture.grn_portal_operation_GRN_POT_OP_190}
{elseif $position == 'right'}
 {capture name='grn_portal_operation_GRN_POT_OP_191'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-191' replace='true'}{/capture}{assign var='position_name' value=$smarty.capture.grn_portal_operation_GRN_POT_OP_191}
{/if}

<div class="sub_title">{grn_image image='portal20.gif'}{$portal.name|escape}&nbsp;{$position_name}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-192' replace='true'}</div>

   {grn_change_order form_name=$form_name select_name='plid[]' options=$portlet_options}
  <!----->
 </div>
 <!--action_end--->
</div>
<p>
 {capture name='grn_portal_operation_GRN_POT_OP_193'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-193' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_193 onclick="grn_onsubmit_common(this.form);"}
 {grn_button_cancel}
</p>
</form>
{include file='grn/footer.tpl'}
