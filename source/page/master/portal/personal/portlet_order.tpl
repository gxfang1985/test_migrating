{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="pid" value="{$portal_id|escape}">
<input type="hidden" name="position" value="{$position|escape}">
<div id="one_parts">
 <div id="action">
  <!----->
{if $position == 'top'}
 {capture name='grn_portal_personal_GRN_POT_PE_135'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-135' replace='true'}{/capture}{assign var='position_name' value=$smarty.capture.grn_portal_personal_GRN_POT_PE_135}
{elseif $position == 'left'}
 {capture name='grn_portal_personal_GRN_POT_PE_136'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-136' replace='true'}{/capture}{assign var='position_name' value=$smarty.capture.grn_portal_personal_GRN_POT_PE_136}
{elseif $position == 'center'}
 {capture name='grn_portal_personal_GRN_POT_PE_137'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-137' replace='true'}{/capture}{assign var='position_name' value=$smarty.capture.grn_portal_personal_GRN_POT_PE_137}
{elseif $position == 'right'}
 {capture name='grn_portal_personal_GRN_POT_PE_138'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-138' replace='true'}{/capture}{assign var='position_name' value=$smarty.capture.grn_portal_personal_GRN_POT_PE_138}
{/if}

<div class="sub_title">{grn_image image='portal20.gif'}{$portal.name|escape}&nbsp;{$position_name}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-139' replace='true'}</div>
   {grn_change_order form_name=$form_name select_name='plid[]' options=$portlet_options}
  <!----->
 </div>
 <!--action_end--->
</div>
<p>
 {capture name='grn_portal_personal_GRN_POT_PE_140'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-140' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_140 onclick="grn_onsubmit_common(this.form);"}
 {grn_button_cancel}
</p>
</form>
{include file='grn/personal_footer.tpl'}
