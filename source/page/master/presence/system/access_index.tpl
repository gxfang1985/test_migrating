{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div class="explanation">
{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-10' replace='true'}
</div>

<p>
{include file='grn/org_access_index_26.tpl' page_prefix='presence/system/' app_id='presence'}

{include file="grn/system_footer.tpl"}