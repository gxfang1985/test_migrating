{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-1' replace='true'}</div>

<p>
{capture name='grn_schedule_personal_GRN_SCH_PE_2'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-2' replace='true'}{/capture}{grn_textarea name='menu' class='schedule_menu' value="$menus" title=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_2 cols="50" rows="15"}<br>

{capture name='grn_schedule_personal_GRN_SCH_PE_3'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-3' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_3}
{grn_button_cancel}

</form>

{include file='grn/personal_footer.tpl'}
