{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='presence/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">
{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-54' replace='true'} 
</div>

<p>
{grn_textarea name="items" value=$items cols="50" rows="15"}<br>

{capture name='grn_presence_system_GRN_PRSC_SY_55'}{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-55' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_presence_system_GRN_PRSC_SY_55}
{grn_button_cancel}
</form>

{include file='grn/system_footer.tpl'}