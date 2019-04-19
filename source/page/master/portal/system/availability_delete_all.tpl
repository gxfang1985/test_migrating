{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.portal.system' key='GRN_POT_SY-350' replace='true'}
</div>

{capture name='grn_portal_system_GRN_POT_SY_351'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-351' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_351}
{capture name='grn_portal_system_GRN_POT_SY_352'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-352' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_system_GRN_POT_SY_352}

</form>

{include file='grn/system_footer.tpl'}
