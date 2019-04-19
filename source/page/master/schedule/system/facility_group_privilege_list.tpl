{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation">
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-359' replace='true'}<span class="bold">{grn_image image='facilitygroup20.gif'}{$node.name|escape}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-360' replace='true'}
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-361' replace='true'}
</div>

{include file='grn/privilege_list.tpl' page_dir='schedule/system' page_prefix='schedule/system/facility_group_' base_prefix='facility_group_'}

{include file="grn/system_footer.tpl"}
