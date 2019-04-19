{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div class="explanation">
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-104' replace='true'}
</div>

<p>
{include file='schedule/_org_user_facility_select.tpl' can_select_facility=1 form_name=$smarty.template|basename post_page='schedule/system/export2' cancel_page='schedule/system/export_index'}

{include file="grn/system_footer.tpl"}
