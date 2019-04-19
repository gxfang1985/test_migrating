{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div class="explanation">
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-283' replace='true'}
</div>

<p>
{include file='grn/org_access_index.tpl' tab_facility=1 page_prefix='schedule/system/' app_id='schedule'}

{include file="grn/system_footer.tpl"}
