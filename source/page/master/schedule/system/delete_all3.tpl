{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<div class="explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-468' replace='true'}</div>

<p>{capture name='grn_schedule_system_GRN_SCH_SY_469'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-469' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_469 page='system/application_list' app_id='schedule'}</p>

{include file="grn/system_footer.tpl"}
