{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div class="explanation">
{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-56' replace='true'}
{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-57' replace='true'}
</div>

<p>
{include file='schedule/_org_user_facility_select.tpl' form_name=$smarty.template|basename post_page='schedule/personal/statistics2' cancel_page='personal/application_list' cancel_app_id='schedule' without_foreign_key=true}

{include file="grn/personal_footer.tpl"}
